@echo off
title NovaPet - Vigilancia de Descargas
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0NovaPet-Downloads-Helper.ps1"
pause
