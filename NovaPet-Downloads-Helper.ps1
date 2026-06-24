param(
    [string]$DownloadsPath = (Join-Path $env:USERPROFILE 'Downloads'),
    [int]$Port = 9237
)

$ErrorActionPreference = 'Stop'

function Get-UnixMilliseconds {
    param([datetime]$Date)
    return ([DateTimeOffset]::new($Date.ToUniversalTime())).ToUnixTimeMilliseconds()
}

function Get-LatestExcelFile {
    if (-not (Test-Path -LiteralPath $DownloadsPath)) {
        return $null
    }

    Get-ChildItem -LiteralPath $DownloadsPath -File -Filter '*.xlsx' |
        Where-Object {
            $_.Name -like 'GridViewSolicitudDespacho - *.xlsx' -and
            -not $_.Name.StartsWith('~$') -and
            $_.Length -gt 0
        } |
        Sort-Object LastWriteTimeUtc, Length |
        Select-Object -Last 1
}

function Get-FileKey {
    param([System.IO.FileInfo]$File)
    $modified = Get-UnixMilliseconds -Date $File.LastWriteTimeUtc
    return "$($File.Name)|$($File.Length)|$modified"
}

function ConvertTo-QueryMap {
    param([string]$Query)
    $map = @{}
    if ([string]::IsNullOrWhiteSpace($Query)) {
        return $map
    }

    $clean = $Query.TrimStart('?')
    foreach ($pair in $clean.Split('&')) {
        if ([string]::IsNullOrWhiteSpace($pair)) { continue }
        $parts = $pair.Split('=', 2)
        $key = [uri]::UnescapeDataString($parts[0])
        $value = ''
        if ($parts.Length -gt 1) {
            $value = [uri]::UnescapeDataString($parts[1])
        }
        $map[$key] = $value
    }
    return $map
}

function Write-HttpResponse {
    param(
        [System.Net.Sockets.NetworkStream]$Stream,
        [int]$StatusCode,
        [string]$Reason,
        [byte[]]$Body = [byte[]]::new(0),
        [string]$ContentType = 'text/plain; charset=utf-8',
        [hashtable]$Headers = @{}
    )

    $defaultHeaders = [ordered]@{
        'Access-Control-Allow-Origin' = '*'
        'Access-Control-Allow-Methods' = 'GET, OPTIONS'
        'Access-Control-Allow-Headers' = 'Content-Type'
        'Access-Control-Expose-Headers' = 'X-NovaPet-File-Name, X-NovaPet-File-Key, X-NovaPet-File-Modified, X-NovaPet-File-Size'
        'Cache-Control' = 'no-store'
        'Content-Type' = $ContentType
        'Content-Length' = $Body.Length
        'Connection' = 'close'
    }

    foreach ($key in $Headers.Keys) {
        $defaultHeaders[$key] = $Headers[$key]
    }

    $headerText = "HTTP/1.1 $StatusCode $Reason`r`n"
    foreach ($entry in $defaultHeaders.GetEnumerator()) {
        $headerText += "$($entry.Key): $($entry.Value)`r`n"
    }
    $headerText += "`r`n"

    $headerBytes = [Text.Encoding]::UTF8.GetBytes($headerText)
    $Stream.Write($headerBytes, 0, $headerBytes.Length)
    if ($Body.Length -gt 0) {
        $Stream.Write($Body, 0, $Body.Length)
    }
}

function Read-HttpRequest {
    param([System.Net.Sockets.NetworkStream]$Stream)

    $buffer = [byte[]]::new(8192)
    $memory = [System.IO.MemoryStream]::new()
    do {
        $read = $Stream.Read($buffer, 0, $buffer.Length)
        if ($read -le 0) { break }
        $memory.Write($buffer, 0, $read)
        $text = [Text.Encoding]::ASCII.GetString($memory.ToArray())
    } while ($text -notmatch "`r`n`r`n" -and $memory.Length -lt 65536)

    return [Text.Encoding]::ASCII.GetString($memory.ToArray())
}

function Write-Json {
    param(
        [System.Net.Sockets.NetworkStream]$Stream,
        [hashtable]$Payload,
        [int]$StatusCode = 200,
        [string]$Reason = 'OK'
    )

    $json = $Payload | ConvertTo-Json -Compress
    $body = [Text.Encoding]::UTF8.GetBytes($json)
    Write-HttpResponse -Stream $Stream -StatusCode $StatusCode -Reason $Reason -Body $body -ContentType 'application/json; charset=utf-8'
}

$address = [System.Net.IPAddress]::Parse('127.0.0.1')
$listener = [System.Net.Sockets.TcpListener]::new($address, $Port)
$listener.Start()

Write-Host ''
Write-Host 'NovaPet - Vigilancia de Descargas'
Write-Host "Carpeta: $DownloadsPath"
Write-Host "Servicio: http://127.0.0.1:$Port"
Write-Host 'Deja esta ventana abierta mientras uses la app.'
Write-Host ''

try {
    while ($true) {
        $client = $listener.AcceptTcpClient()
        try {
            $stream = $client.GetStream()
            $requestText = Read-HttpRequest -Stream $stream
            $requestLine = ($requestText -split "`r`n")[0]
            $parts = $requestLine -split ' '
            if ($parts.Length -lt 2) {
                Write-HttpResponse -Stream $stream -StatusCode 400 -Reason 'Bad Request'
                continue
            }

            $method = $parts[0].ToUpperInvariant()
            $target = $parts[1]

            if ($method -eq 'OPTIONS') {
                Write-HttpResponse -Stream $stream -StatusCode 204 -Reason 'No Content'
                continue
            }

            if ($method -ne 'GET') {
                Write-HttpResponse -Stream $stream -StatusCode 405 -Reason 'Method Not Allowed'
                continue
            }

            $uri = [uri]::new("http://127.0.0.1:$Port$target")
            $path = $uri.AbsolutePath
            $query = ConvertTo-QueryMap -Query $uri.Query
            $latest = Get-LatestExcelFile

            if ($path -eq '/status' -or $path -eq '/') {
                $payload = @{
                    ok = $true
                    downloadsPath = $DownloadsPath
                    latestName = if ($latest) { $latest.Name } else { '' }
                    latestKey = if ($latest) { Get-FileKey -File $latest } else { '' }
                    time = (Get-Date).ToString('s')
                }
                Write-Json -Stream $stream -Payload $payload
                continue
            }

            if ($path -eq '/latest-excel') {
                if (-not $latest) {
                    Write-HttpResponse -Stream $stream -StatusCode 204 -Reason 'No Content'
                    continue
                }

                $key = Get-FileKey -File $latest
                if ($query.ContainsKey('since') -and $query['since'] -eq $key) {
                    Write-HttpResponse -Stream $stream -StatusCode 204 -Reason 'No Content'
                    continue
                }

                $body = [System.IO.File]::ReadAllBytes($latest.FullName)
                $modified = Get-UnixMilliseconds -Date $latest.LastWriteTimeUtc
                $headers = @{
                    'X-NovaPet-File-Name' = [uri]::EscapeDataString($latest.Name)
                    'X-NovaPet-File-Key' = [uri]::EscapeDataString($key)
                    'X-NovaPet-File-Modified' = $modified
                    'X-NovaPet-File-Size' = $latest.Length
                }
                Write-HttpResponse -Stream $stream -StatusCode 200 -Reason 'OK' -Body $body -ContentType 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' -Headers $headers
                continue
            }

            Write-HttpResponse -Stream $stream -StatusCode 404 -Reason 'Not Found'
        } catch {
            try {
                $message = [Text.Encoding]::UTF8.GetBytes($_.Exception.Message)
                Write-HttpResponse -Stream $stream -StatusCode 500 -Reason 'Internal Server Error' -Body $message
            } catch {}
        } finally {
            $client.Close()
        }
    }
} finally {
    $listener.Stop()
}
