<!DOCTYPE html>

<html lang="es">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Extraccion Etiquetas MercadoLibre</title>
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link data-app-stylesheet="" href="styles.css" rel="stylesheet"/>
<style>

/* ── Reset del grid que impone styles.css en .panel-left ── */
.panel-left,
.panel-left.panel {
  display: flex !important;
  flex-direction: column !important;
  grid-template-columns: none !important;
  grid-template-areas: none !important;
  grid-template-rows: none !important;
  gap: 10px !important;
  padding: 12px !important;
  overflow-y: auto !important;
  align-items: stretch !important;
  align-content: start !important;
}
/* Anular grid-area que styles.css asigna a hijos */
.panel-left .input-group,
.panel-left .input-methods,
.panel-left .storage-card,
.panel-left .left-panel-top {
  grid-area: unset !important;
  display: none !important;
}

/* ── Status bar ── */
.lp-statusbar {
  background: #E1F5EE !important;
  border: 0.5px solid #9FE1CB !important;
  border-radius: 10px !important;
  padding: 9px 12px !important;
  display: flex !important;
  align-items: center !important;
  gap: 7px !important;
  flex-shrink: 0 !important;
}
.lp-statusbar-dot {
  width: 7px !important;
  height: 7px !important;
  border-radius: 50% !important;
  background: #1D9E75 !important;
  flex-shrink: 0 !important;
}
.lp-statusbar-label {
  font-size: 11px !important;
  font-weight: 500 !important;
  color: #0F6E56 !important;
}
.lp-statusbar #storageStatus {
  flex: 1 !important;
  min-width: 0 !important;
  background: transparent !important;
  border: none !important;
  padding: 0 !important;
  border-radius: 0 !important;
  font-size: 11px !important;
  display: flex !important;
  align-items: center !important;
  gap: 5px !important;
}
/* Ocultar "ACTIVO/Cerrado/24h" — la barra verde ya indica el estado */
.lp-statusbar .status-pill-label {
  display: none !important;
}
/* Ajustar el content para que no quede espacio vacío */
.lp-statusbar .status-pill-content {
  display: flex !important;
  align-items: center !important;
  gap: 5px !important;
  grid-template-columns: none !important;
  min-width: 0 !important;
  overflow: hidden !important;
}
.lp-statusbar .status-pill-time {
  font-size: 12px !important;
  font-weight: 700 !important;
  color: #0F6E56 !important;
  font-family: monospace !important;
  letter-spacing: -0.02em !important;
}
.lp-statusbar .status-pill-meta {
  font-size: 10px !important;
  color: #0F6E56 !important;
  opacity: 0.8 !important;
  white-space: nowrap !important;
  overflow: hidden !important;
  text-overflow: ellipsis !important;
}
.lp-statusbar .status-pill-dot {
  width: 7px !important;
  height: 7px !important;
  border-radius: 50% !important;
  background: #1D9E75 !important;
  flex-shrink: 0 !important;
}
#outsideHoursToggleBtn {
  display: flex !important;
  align-items: center !important;
  gap: 4px !important;
  padding: 3px 9px !important;
  border-radius: 10px !important;
  border: 0.5px solid #9FE1CB !important;
  background: transparent !important;
  cursor: pointer !important;
  font-size: 10px !important;
  font-weight: 600 !important;
  color: #0F6E56 !important;
  white-space: nowrap !important;
  transition: all 0.2s !important;
  line-height: 1 !important;
  min-width: 0 !important;
  height: auto !important;
  letter-spacing: normal !important;
}
#outsideHoursToggleBtn[aria-pressed="true"] {
  background: #1D9E75 !important;
  border-color: #1D9E75 !important;
  color: #fff !important;
}

/* ── Cards base ── */
.lp-card,
.lp-picker-card,
.lp-tabs-card {
  background: rgba(255,255,255,0.92) !important;
  border: 1px solid rgba(15,23,42,0.10) !important;
  border-radius: 12px !important;
  padding: 12px !important;
  display: flex !important;
  flex-direction: column !important;
  gap: 0 !important;
  flex-shrink: 0 !important;
  box-shadow: inset 0 1px 0 rgba(255,255,255,0.7) !important;
}
.lp-section-label {
  font-size: 10px !important;
  font-weight: 700 !important;
  color: #5C6F63 !important;
  text-transform: uppercase !important;
  letter-spacing: 0.6px !important;
  margin-bottom: 7px !important;
  display: block !important;
}
.lp-collapsible-head {
  display: flex !important;
  align-items: center !important;
  justify-content: space-between !important;
  gap: 8px !important;
  margin-bottom: 7px !important;
}
.lp-collapsible-head .lp-section-label {
  margin-bottom: 0 !important;
}
.lp-collapse-btn {
  width: 24px;
  min-width: 24px;
  height: 24px;
  display: grid;
  place-items: center;
  border: 1px solid rgba(15,23,42,0.12);
  border-radius: 7px;
  background: rgba(255,255,255,0.96);
  color: var(--text-muted);
  cursor: pointer;
}
.lp-collapse-btn svg {
  transition: transform .18s ease;
}
.lp-picker-card.is-collapsed {
  gap: 0 !important;
}
.lp-picker-card.is-collapsed .lp-picker-body {
  display: none;
}
.lp-picker-card.is-collapsed .lp-collapse-btn svg {
  transform: rotate(-90deg);
}
.lp-divider {
  border: none !important;
  border-top: 1px solid rgba(15,23,42,0.08) !important;
  margin: 11px 0 !important;
}

/* ── Google Drive card ── */
#drive-sync-panel {
    display: flex;
    flex-direction: column;
    gap: 10px;
    padding: 14px;
    background: var(--surface-base, #fff);
    border: 1px solid var(--border);
    border-radius: var(--radius-md);
    box-shadow: 0 1px 4px rgba(15,23,42,0.07);
}
.lp-drive-header {
    display: flex;
    align-items: center;
    gap: 10px;
    padding-bottom: 10px;
    border-bottom: 1px solid var(--border);
}
#drive-sync-status {
    font-size: 11px;
    color: var(--text-muted);
}
#drive-file-count {
    display: none;
    flex-direction: column;
    align-items: center;
    background: rgba(0,172,71,0.1);
    border-radius: 10px;
    padding: 5px 12px;
    cursor: pointer;
    transition: background .15s;
}
.lp-drive-modes {
    display: flex;
    background: #F3F6F4;
    border: 1px solid rgba(15,23,42,0.08);
    border-radius: 10px;
    padding: 2px;
    gap: 2px;
}
#drive-mode-auto,
#drive-mode-manual {
    flex: 1;
    height: 28px;
    padding: 0 10px;
    font-size: 11px;
    font-weight: 800;
    border: none;
    cursor: pointer;
    border-radius: 8px;
    color: #6B7A72;
    background: transparent;
    box-shadow: none;
    transition: background .18s ease, color .18s ease, box-shadow .18s ease;
}
#drive-mode-auto.is-active,
#drive-mode-manual.is-active {
    background: #FFFFFF;
    color: #0F6E56;
    box-shadow: 0 1px 3px rgba(15,23,42,0.10), inset 0 0 0 1px rgba(15,23,42,0.05);
}
#drive-mode-manual.is-active { color: #1F5FAE; }
#drive-mode-auto:hover:not(.is-active),
#drive-mode-manual:hover:not(.is-active) {
    background: rgba(255,255,255,0.58);
    color: #1F3328;
}
#drive-mode-desc {
    font-size: 11px;
    color: var(--text-muted);
    text-align: center;
}
.lp-drive-btns-row {
    display: flex;
    gap: 8px;
    position: relative;
}
.lp-drive-sound-trigger {
    width: 38px;
    min-width: 38px;
    padding: 0;
    display: grid;
    place-items: center;
}
.lp-drive-sound-popover {
    position: absolute;
    top: calc(100% + 8px);
    left: 0;
    right: 0;
    z-index: 20;
    display: grid;
    gap: 10px;
    padding: 10px;
    border: 1px solid var(--border);
    border-radius: 10px;
    background: rgba(255,255,255,0.98);
    box-shadow: 0 16px 30px rgba(15,23,42,0.14);
}
.lp-drive-sound-popover[hidden] {
    display: none;
}
.lp-drive-sound-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 8px;
}
.lp-drive-sound-grid {
    display: grid;
    gap: 8px;
}
.lp-drive-sound-field {
    display: grid;
    gap: 4px;
}
.lp-drive-sound-field > span {
    color: var(--text-muted);
    font-size: 10px;
    font-weight: 700;
    letter-spacing: .04em;
    text-transform: uppercase;
}
.lp-drive-sound-control {
    display: grid;
    grid-template-columns: minmax(0, 1fr) 30px;
    gap: 6px;
}
.lp-drive-sound-select {
    width: 100%;
    min-width: 0;
    min-height: 30px;
    border: 1px solid var(--border);
    border-radius: 7px;
    background: #fff;
    color: var(--text);
    font-size: 11px;
    padding: 0 8px;
}
.lp-drive-sound-preview {
    display: grid;
    place-items: center;
    width: 30px;
    min-height: 30px;
    border: 1px solid var(--border);
    border-radius: 7px;
    background: #fff;
    color: var(--text-muted);
    cursor: pointer;
}
.lp-drive-sound-preview:hover {
    color: var(--text);
    border-color: rgba(15,110,86,0.26);
}
#drive-sound-test-btn {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    border: none;
    background: transparent;
    color: var(--text-muted);
    font-size: 11px;
    padding: 0;
    cursor: pointer;
    transition: color 0.15s ease;
}
#drive-sound-test-btn:hover {
    color: var(--text);
}
#drive-sound-test-label {
    color: var(--text-muted);
    font-size: 10px;
    font-style: italic;
}
#drive-day-status {
    display: none;
    align-items: center;
    gap: 8px;
    padding: 8px 10px;
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 8px;
    font-size: 12px;
}
#drive-pending-section {
    display: flex;
    flex-direction: column;
    gap: 6px;
}
.lp-pending-label {
    font-size: 10px;
    font-weight: 700;
    letter-spacing: .07em;
    text-transform: uppercase;
    color: var(--text-muted);
}
#drive-pending-list {
    display: flex;
    flex-direction: column;
    gap: 6px;
    max-height: 240px;
    overflow-y: auto;
}
#drive-no-pending {
    font-size: 12px;
    color: var(--text-muted);
    text-align: center;
    padding: 10px 0;
}
#drive-sync-toast {
    padding: 8px 12px;
    border-left: 3px solid #00ac47;
    border-radius: 4px;
    font-size: 12px;
    color: var(--text-muted);
    background: rgba(0,172,71,0.06);
}

/* ── Picker card ── */

lp-picker-card label[for="picker"] { display: none !important; }
.lp-picker-card .input-group { display: contents !important; }
.lp-picker-card .form-control { display: contents !important; }
.panel-left .picker-select-row {
  display: flex !important;
  gap: 6px !important;
  align-items: center !important;
  margin-bottom: 0 !important;
}
.panel-left #picker {
  flex: 1 !important;
  padding: 7px 9px !important;
  border: 1px solid rgba(15,23,42,0.10) !important;
  border-radius: 8px !important;
  font-size: 13px !important;
  background: rgba(255,255,255,0.96) !important;
  color: #17301F !important;
}
.panel-left .picker-manage-btn {
  width: 32px !important;
  height: 32px !important;
  min-width: 32px !important;
  max-width: 32px !important;
  flex: 0 0 32px !important;
  padding: 0 !important;
  border-radius: 8px !important;
  background: #1D9E75 !important;
  color: #fff !important;
  border: none !important;
  font-size: 20px !important;
  font-weight: 700 !important;
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  cursor: pointer !important;
  transform: none !important;
}
.panel-left .picker-manage-btn:hover {
  background: #0F6E56 !important;
}
.panel-left .picker-meta {
  font-size: 10px !important;
  color: #5C6F63 !important;
  margin-top: 5px !important;
  display: block !important;
  text-align: left !important;
}
#storageSummary { display: none !important; }

/* Picker manager: [hidden] debe seguir ocultando el panel cuando JS lo cierra */
.panel-left .picker-manager[hidden] { display: none !important; }
.panel-left .picker-manager:not([hidden]) {
  margin-top: 10px !important;
  border: 1px solid rgba(67,190,116,0.14) !important;
  border-radius: 12px !important;
  padding: 10px !important;
  background: rgba(250,253,250,0.98) !important;
  display: grid !important;
  gap: 10px !important;
}

/* Subheader texto */
.lp-text-subheader {
  display: flex !important;
  align-items: center !important;
  justify-content: space-between !important;
  margin-bottom: 7px !important;
}
.lp-file-label {
  width: 28px !important;
  height: 28px !important;
  border-radius: 8px !important;
  background: #1D9E75 !important;
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
  cursor: pointer !important;
  flex-shrink: 0 !important;
}
.lp-file-label:hover { background: #0F6E56 !important; }
.panel-left #textInput {
  width: 100% !important;
  min-height: 80px !important;
  padding: 8px 10px !important;
  border: 1px solid rgba(15,23,42,0.10) !important;
  border-radius: 8px !important;
  font-size: 13px !important;
  resize: vertical !important;
  background: rgba(255,255,255,0.97) !important;
  color: #17301F !important;
  line-height: 1.5 !important;
  font-family: monospace !important;
}
.lp-text-actions {
  display: flex !important;
  gap: 6px !important;
  margin-top: 8px !important;
}
.lp-picker-card #processTextBtn { flex: 2 !important; }
.lp-picker-card #clearBtn       { flex: 1 !important; }

/* ── Tabs ── */
.lp-tabs {
  display: none !important;
  gap: 4px !important;
  padding: 3px !important;
  border: 1px solid rgba(15,23,42,0.08) !important;
  border-radius: 9px !important;
  background: rgba(15,23,42,0.035) !important;
  margin-bottom: 10px !important;
}
.lp-tab {
  flex: 1 !important;
  padding: 7px 4px !important;
  font-size: 11px !important;
  font-weight: 600 !important;
  text-align: center !important;
  cursor: pointer !important;
  color: #5C6F63 !important;
  border: none !important;
  background: transparent !important;
  border-radius: 7px !important;
  transition: all 0.15s !important;
  text-transform: none !important;
  letter-spacing: normal !important;
}
.lp-tab.lp-tab--active {
  color: #0F6E56 !important;
  background: #fff !important;
  box-shadow: 0 1px 2px rgba(15,23,42,0.08) !important;
}
.lp-tab-badge {
  display: inline-block !important;
  font-size: 9px !important;
  font-weight: 700 !important;
  background: #EAF3DE !important;
  color: #3B6D11 !important;
  padding: 1px 5px !important;
  border-radius: 8px !important;
  margin-left: 3px !important;
}
.lp-tab-panel          { display: none !important; }
.lp-tab-panel--active  { display: block !important; }

.lp-history-card {
  gap: 10px !important;
}
.lp-history-head {
  display: grid !important;
  gap: 2px !important;
}
.lp-history-title {
  color: #17301F !important;
  font-size: 12px !important;
  font-weight: 700 !important;
}
.lp-history-caption {
  color: #5C6F63 !important;
  font-size: 10px !important;
}
.lp-history-status {
  display: grid !important;
  gap: 4px !important;
  margin-bottom: 8px !important;
}
.lp-history-status-label {
  color: #5C6F63 !important;
  font-size: 9px !important;
  font-weight: 700 !important;
  text-transform: uppercase !important;
  letter-spacing: 0.06em !important;
}
#storageNote {
  font-size: 10px !important;
  color: #5C6F63 !important;
  margin-bottom: 0 !important;
  line-height: 1.4 !important;
}
.panel-left .history-list {
  max-height: 145px !important;
  overflow-y: auto !important;
  margin-bottom: 0 !important;
  border-top: 1px solid rgba(15,23,42,0.06) !important;
  padding-top: 8px !important;
}
.panel-left .history-empty {
  font-size: 11px !important;
  color: #5C6F63 !important;
  text-align: left !important;
  padding: 4px 0 2px !important;
}
#savePortableBtn { display: none !important; }
.lp-procesados-empty {
  font-size: 11px !important;
  color: #5C6F63 !important;
  text-align: center !important;
  padding: 14px 0 !important;
}


/* ══════════════════════════════════════════
   PANEL DERECHO — Consulta Estado Pedido
   Fix layout + rediseño visual
══════════════════════════════════════════ */

.panel-right.order-lookup-card {
  display: flex !important;
  flex-direction: column !important;
  gap: 12px !important;
  padding: 14px !important;
  overflow-y: auto !important;
}

/* ── Head ── */
.order-lookup-head {
  display: flex !important;
  align-items: center !important;
  justify-content: space-between !important;
  gap: 10px !important;
  padding-bottom: 12px !important;
  border-bottom: 1px solid rgba(15,23,42,0.08) !important;
}
.order-lookup-head h3 {
  font-size: 13px !important;
  font-weight: 700 !important;
  color: #17301F !important;
  margin: 0 !important;
  letter-spacing: 0.02em !important;
}
.order-lookup-channel {
  flex-shrink: 0 !important;
  padding: 4px 10px !important;
  border-radius: 999px !important;
  border: 1px solid rgba(0,179,77,0.25) !important;
  background: rgba(0,179,77,0.08) !important;
  color: #0B7A3D !important;
  font-size: 11px !important;
  font-weight: 700 !important;
}

/* ── Controls box ── */
.order-lookup-controls {
  display: grid !important;
  gap: 11px !important;
  padding: 12px !important;
  border: 1px solid rgba(15,23,42,0.08) !important;
  border-radius: 12px !important;
  background: rgba(255,255,255,0.68) !important;
}
.ol-controls-section {
  display: grid !important;
  gap: 8px !important;
  min-width: 0 !important;
}
.ol-controls-section + .ol-controls-section {
  padding-top: 11px !important;
  border-top: 1px solid rgba(15,23,42,0.08) !important;
}
.ol-section-label {
  margin: 0 !important;
  color: #5C6F63 !important;
  font-size: 10px !important;
  font-weight: 700 !important;
  line-height: 1 !important;
  text-transform: uppercase !important;
  letter-spacing: 0.06em !important;
}

/* Upload row */
.order-lookup-upload-row {
  display: grid !important;
  grid-template-columns: minmax(108px, 118px) minmax(0, 1fr) !important;
  gap: 8px !important;
  align-items: center !important;
}
.order-lookup-upload-row .btn {
  width: 100% !important;
  min-width: 0 !important;
  min-height: 36px !important;
  padding: 8px 10px !important;
  font-size: 12px !important;
  border-radius: 8px !important;
}
.order-lookup-file {
  min-width: 0 !important;
  min-height: 36px !important;
  display: flex !important;
  align-items: center !important;
  padding: 8px 10px !important;
  border: 1px solid rgba(15,23,42,0.10) !important;
  border-radius: 8px !important;
  background: rgba(255,255,255,0.96) !important;
  color: #5C6F63 !important;
  font-size: 12px !important;
  white-space: nowrap !important;
  overflow: hidden !important;
  text-overflow: ellipsis !important;
}

/* Filter row — fix layout de estado/rutas */
.order-lookup-filter-row {
  display: grid !important;
  grid-template-columns: 1fr !important;
  gap: 8px !important;
  width: 100% !important;
  min-width: 0 !important;
}
.order-lookup-search-field,
.order-lookup-filter-field {
  display: grid !important;
  gap: 4px !important;
  grid-area: auto !important;
  align-content: start !important;
  justify-self: stretch !important;
  min-width: 0 !important;
}
.ol-filters-row {
  display: grid !important;
  grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
  gap: 8px !important;
  width: 100% !important;
}

.order-lookup-search-field span,
.order-lookup-filter-field span {
  font-size: 10px !important;
  font-weight: 700 !important;
  color: #5C6F63 !important;
  text-transform: uppercase !important;
  letter-spacing: 0.05em !important;
  display: block !important;
}
.order-lookup-search-input,
.order-lookup-filter-field select {
  border: 1px solid rgba(15,23,42,0.10) !important;
  border-radius: 8px !important;
  background: rgba(255,255,255,0.98) !important;
  color: #17301F !important;
  font-size: 12px !important;
  width: 100% !important;
  min-width: 0 !important;
  min-height: 36px !important;
  height: 36px !important;
  box-sizing: border-box !important;
}
.ol-search-wrapper {
  position: relative !important;
}
.ol-search-icon {
  position: absolute !important;
  top: 50% !important;
  left: 10px !important;
  color: #6B7B72 !important;
  transform: translateY(-50%) !important;
  pointer-events: none !important;
}
.order-lookup-search-input {
  padding: 8px 10px 8px 32px !important;
}
.order-lookup-filter-field select {
  padding: 0 10px !important;
}
.order-lookup-search-input:focus,
.order-lookup-filter-field select:focus {
  outline: none !important;
  border-color: #00B34D !important;
  box-shadow: 0 0 0 2px rgba(0,179,77,0.18) !important;
}

/* Botones filtrar/limpiar */
.order-lookup-actions {
  display: grid !important;
  grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
  gap: 8px !important;
  grid-area: auto !important;
  align-self: auto !important;
  justify-content: stretch !important;
}
.order-lookup-actions .btn {
  width: 100% !important;
  min-width: 0 !important;
  min-height: 38px !important;
  padding: 9px 14px !important;
  font-size: 13px !important;
  border-radius: 8px !important;
}

/* ── Output ── */
.order-lookup-output {
  display: flex !important;
  flex-direction: column !important;
  gap: 8px !important;
  flex: 1 !important;
  min-height: 0 !important;
}
.order-lookup-summary {
  border-radius: 8px !important;
  border: 1px solid rgba(15,23,42,0.08) !important;
  background: rgba(255,255,255,0.9) !important;
  padding: 9px 12px !important;
  display: flex !important;
  flex-direction: row !important;
  align-items: center !important;
  justify-content: space-between !important;
  gap: 8px !important;
  flex-shrink: 0 !important;
}
.order-lookup-summary strong {
  font-size: 12px !important;
  font-weight: 600 !important;
  color: #17301F !important;
  white-space: nowrap !important;
}
.order-lookup-summary span {
  font-size: 11px !important;
  color: #5C6F63 !important;
  line-height: 1.4 !important;
}
.order-lookup-table-wrap {
  border: 1px solid rgba(15,23,42,0.08) !important;
  border-radius: 10px !important;
  background: rgba(255,255,255,0.94) !important;
  overflow: auto !important;
  flex: 1 !important;
  min-height: 0 !important;
  max-height: none !important;
}
.order-lookup-table th {
  font-size: 11px !important;
  padding: 8px 12px !important;
  background: rgba(244,247,244,0.98) !important;
  color: #5C6F63 !important;
  font-weight: 700 !important;
  text-transform: uppercase !important;
  letter-spacing: 0.05em !important;
}
.order-lookup-table td {
  font-size: 12px !important;
  padding: 8px 12px !important;
}
.order-lookup-empty-row {
  font-size: 12px !important;
  color: #5C6F63 !important;
  text-align: center !important;
  padding: 16px !important;
}

/* Dashboard completo inspirado en el mockup 2026 */
html,
body {
  width: 100% !important;
  min-height: 100% !important;
  overflow: hidden !important;
}

body {
  align-items: stretch !important;
  justify-content: stretch !important;
  padding: 0 !important;
  background: #F7FAF8 !important;
  background-image: none !important;
  color: #17231D !important;
}

.container {
  width: 100% !important;
  max-width: none !important;
  height: 100vh !important;
  margin: 0 !important;
  display: grid !important;
  grid-template-rows: 86px minmax(0, 1fr) !important;
  gap: 0 !important;
  padding: 0 !important;
  background: linear-gradient(180deg, #FFFFFF 0%, #F7FAF8 100%) !important;
}

header {
  width: 100% !important;
  max-width: none !important;
  min-height: 86px !important;
  margin: 0 !important;
  padding: 0 26px 0 34px !important;
  display: grid !important;
  grid-template-columns: 252px minmax(0, 1fr) auto !important;
  grid-template-rows: 1fr 1fr !important;
  column-gap: 20px !important;
  align-items: center !important;
  justify-items: stretch !important;
  text-align: left !important;
  background: rgba(255,255,255,0.94) !important;
  border-bottom: 1px solid rgba(15, 23, 42, 0.08) !important;
  box-shadow: 0 8px 24px rgba(15, 23, 42, 0.035) !important;
}

header .app-logo {
  grid-column: 1 !important;
  grid-row: 1 / 3 !important;
  width: 188px !important;
  max-width: 188px !important;
  max-height: 64px !important;
  justify-self: start !important;
  object-fit: contain !important;
}

header h1 {
  grid-column: 2 !important;
  grid-row: 1 !important;
  align-self: end !important;
  justify-self: center !important;
  width: fit-content !important;
  max-width: 560px !important;
  text-align: center !important;
  color: #00A847 !important;
  font-size: 22px !important;
  line-height: 1.05 !important;
  font-weight: 800 !important;
  letter-spacing: 0 !important;
}

header p {
  grid-column: 2 !important;
  grid-row: 2 !important;
  align-self: start !important;
  justify-self: center !important;
  width: fit-content !important;
  max-width: 560px !important;
  text-align: center !important;
  color: #66756D !important;
  font-size: 13px !important;
  line-height: 1.4 !important;
}

.app-top-actions {
  grid-column: 3 !important;
  grid-row: 1 / 3 !important;
  display: flex !important;
  align-items: center !important;
  justify-content: flex-end !important;
  gap: 18px !important;
  min-width: 390px !important;
}

.app-system-status {
  display: inline-flex !important;
  align-items: center !important;
  gap: 8px !important;
  color: #1B2C23 !important;
  font-size: 13px !important;
  font-weight: 600 !important;
  white-space: nowrap !important;
  border-radius: 999px !important;
  padding: 5px 8px !important;
  transition: background 0.2s ease, color 0.2s ease, box-shadow 0.2s ease !important;
}

.app-system-status-dot {
  width: 10px !important;
  height: 10px !important;
  border-radius: 999px !important;
  background: #00A847 !important;
  box-shadow: 0 0 0 4px rgba(0,168,71,0.12) !important;
  flex: 0 0 auto !important;
}

.app-system-status-label {
  line-height: 1 !important;
}

.app-system-status.is-monitoring,
.app-system-status.is-operational {
  color: #1B2C23 !important;
}

.app-system-status.is-monitoring {
  background: rgba(0,168,71,0.08) !important;
  color: #007A3D !important;
  animation: app-system-connected-blink 1.1s ease-in-out infinite !important;
}

.app-system-status.is-monitoring .app-system-status-dot,
.app-system-status.is-operational .app-system-status-dot {
  background: #00A847 !important;
  box-shadow: 0 0 0 4px rgba(0,168,71,0.12) !important;
}

.app-system-status.is-monitoring .app-system-status-dot {
  animation: app-system-dot-pulse 1.1s ease-in-out infinite !important;
}

@keyframes app-system-connected-blink {
  0%, 100% {
    background: rgba(0,168,71,0.06);
    box-shadow: 0 0 0 0 rgba(0,168,71,0.00);
  }
  50% {
    background: rgba(0,168,71,0.18);
    box-shadow: 0 0 0 5px rgba(0,168,71,0.10);
  }
}

@keyframes app-system-dot-pulse {
  0%, 100% {
    transform: scale(0.92);
    box-shadow: 0 0 0 3px rgba(0,168,71,0.12);
  }
  50% {
    transform: scale(1.16);
    box-shadow: 0 0 0 7px rgba(0,168,71,0.24);
  }
}

.app-system-status.is-warning {
  color: #9A5B00 !important;
}

.app-system-status.is-warning .app-system-status-dot {
  background: #F59E0B !important;
  box-shadow: 0 0 0 4px rgba(245,158,11,0.14) !important;
}

.app-system-status.is-closed {
  color: #6B7280 !important;
}

.app-system-status.is-closed .app-system-status-dot {
  background: #94A3B8 !important;
  box-shadow: 0 0 0 4px rgba(148,163,184,0.16) !important;
}

.app-system-status.is-error {
  color: #B42318 !important;
}

.app-system-status.is-error .app-system-status-dot {
  background: #EF4444 !important;
  box-shadow: 0 0 0 4px rgba(239,68,68,0.14) !important;
}

.app-theme-toggle-btn,
.app-bell-btn {
  width: 38px !important;
  height: 38px !important;
  border: 1px solid rgba(15,23,42,0.08) !important;
  border-radius: 999px !important;
  background: #F3F6F4 !important;
  color: #1B2C23 !important;
  display: grid !important;
  place-items: center !important;
  cursor: pointer !important;
  position: relative !important;
}

.app-theme-toggle-btn {
  transition: background 0.2s ease, color 0.2s ease, border-color 0.2s ease !important;
}

.app-theme-toggle-btn .theme-icon {
  width: 18px !important;
  height: 18px !important;
}

.app-theme-toggle-btn .theme-icon--sun {
  display: none !important;
}

.app-theme-toggle-btn[aria-pressed="true"] {
  background: #1B2C23 !important;
  border-color: rgba(255,255,255,0.16) !important;
  color: #F8FAFC !important;
}

.app-theme-toggle-btn[aria-pressed="true"] .theme-icon--moon {
  display: none !important;
}

.app-theme-toggle-btn[aria-pressed="true"] .theme-icon--sun {
  display: block !important;
}

.app-bell-btn.is-open {
  background: #EAF8F0 !important;
  border-color: rgba(0,168,71,0.26) !important;
  color: #008A3B !important;
}

.notification-badge {
  position: absolute !important;
  top: -4px !important;
  right: -4px !important;
  min-width: 17px !important;
  height: 17px !important;
  padding: 0 4px !important;
  border-radius: 999px !important;
  display: none !important;
  align-items: center !important;
  justify-content: center !important;
  background: #0B7A3D !important;
  color: #fff !important;
  border: 2px solid #fff !important;
  font-size: 10px !important;
  font-weight: 800 !important;
  line-height: 1 !important;
}

.notification-badge.is-visible {
  display: inline-flex !important;
}

.app-notification-panel {
  position: fixed !important;
  top: 66px !important;
  right: 20px !important;
  width: min(390px, calc(100vw - 32px)) !important;
  max-height: calc(100vh - 90px) !important;
  z-index: 5200 !important;
  display: grid !important;
  grid-template-rows: auto auto minmax(0, 1fr) auto !important;
  overflow: hidden !important;
  border: 1px solid rgba(15,23,42,0.10) !important;
  border-radius: 12px !important;
  background: #fff !important;
  box-shadow: 0 18px 42px rgba(15,23,42,0.16) !important;
}

.app-notification-panel[hidden] {
  display: none !important;
}

.notification-head,
.notification-actions {
  display: flex !important;
  align-items: center !important;
  justify-content: space-between !important;
  gap: 10px !important;
  padding: 12px 14px !important;
}

.notification-head {
  border-bottom: 1px solid rgba(15,23,42,0.08) !important;
}

.notification-head strong {
  display: block !important;
  color: #1B2C23 !important;
  font-size: 13px !important;
  line-height: 1.2 !important;
}

.notification-head span {
  display: block !important;
  margin-top: 2px !important;
  color: #66756D !important;
  font-size: 11px !important;
  line-height: 1.25 !important;
}

.notification-close-btn {
  width: 30px !important;
  height: 30px !important;
  display: grid !important;
  place-items: center !important;
  border: 1px solid rgba(15,23,42,0.08) !important;
  border-radius: 8px !important;
  background: #F6F8F7 !important;
  color: #1B2C23 !important;
  cursor: pointer !important;
  font-size: 18px !important;
  line-height: 1 !important;
}

.notification-summary {
  display: grid !important;
  grid-template-columns: repeat(3, minmax(0, 1fr)) !important;
  gap: 8px !important;
  padding: 12px 14px !important;
  background: #F8FAF9 !important;
  border-bottom: 1px solid rgba(15,23,42,0.08) !important;
}

.notification-summary-item {
  min-width: 0 !important;
  padding: 8px !important;
  border: 1px solid rgba(15,23,42,0.07) !important;
  border-radius: 9px !important;
  background: #fff !important;
}

.notification-summary-item strong {
  display: block !important;
  color: #00A847 !important;
  font-size: 17px !important;
  line-height: 1 !important;
}

.notification-summary-item span {
  display: block !important;
  margin-top: 4px !important;
  color: #66756D !important;
  font-size: 10px !important;
  font-weight: 800 !important;
  text-transform: uppercase !important;
  white-space: nowrap !important;
  overflow: hidden !important;
  text-overflow: ellipsis !important;
}

.notification-list {
  min-height: 0 !important;
  overflow-y: auto !important;
  padding: 10px 14px !important;
  display: grid !important;
  gap: 8px !important;
}

.notification-item {
  display: grid !important;
  grid-template-columns: 9px minmax(0, 1fr) !important;
  gap: 9px !important;
  padding: 9px !important;
  border: 1px solid rgba(15,23,42,0.08) !important;
  border-radius: 9px !important;
  background: #fff !important;
}

.notification-item::before {
  content: "" !important;
  width: 9px !important;
  height: 9px !important;
  margin-top: 4px !important;
  border-radius: 999px !important;
  background: #00A847 !important;
}

.notification-item.is-warning::before {
  background: #D48A00 !important;
}

.notification-item.is-error::before {
  background: #D92D20 !important;
}

.notification-item.is-info::before {
  background: #0B57D0 !important;
}

.notification-item strong {
  display: block !important;
  color: #1B2C23 !important;
  font-size: 12px !important;
  line-height: 1.2 !important;
}

.notification-item span {
  display: block !important;
  margin-top: 3px !important;
  color: #66756D !important;
  font-size: 11px !important;
  line-height: 1.35 !important;
}

.notification-actions {
  border-top: 1px solid rgba(15,23,42,0.08) !important;
}

.notification-action-btn {
  height: 32px !important;
  flex: 1 !important;
  border: 1px solid rgba(15,23,42,0.10) !important;
  border-radius: 8px !important;
  background: #F6F8F7 !important;
  color: #1B2C23 !important;
  font-size: 11px !important;
  font-weight: 800 !important;
  cursor: pointer !important;
}

.notification-action-btn.is-primary {
  background: #00A847 !important;
  border-color: #00A847 !important;
  color: #fff !important;
}

.message-stack {
  z-index: 5000 !important;
}

.panels-container {
  width: 100% !important;
  max-width: none !important;
  height: 100% !important;
  min-height: 0 !important;
  display: grid !important;
  grid-template-columns: 340px minmax(0, 1fr) !important;
  gap: 0 !important;
  align-items: stretch !important;
  justify-content: stretch !important;
  overflow: hidden !important;
}

.panel {
  border-radius: 0 !important;
  box-shadow: none !important;
  backdrop-filter: none !important;
}

.panel-left,
.panel-left.panel {
  width: 340px !important;
  height: 100% !important;
  min-height: 0 !important;
  padding: 14px 20px 18px !important;
  gap: 16px !important;
  background: rgba(255,255,255,0.88) !important;
  border: none !important;
  border-right: 1px solid rgba(15,23,42,0.08) !important;
  overflow-y: auto !important;
}

.lp-statusbar {
  display: none !important;
}

#drive-sync-panel,
.lp-picker-card,
.lp-tabs-card {
  border-radius: 12px !important;
  border: 1px solid rgba(15,23,42,0.08) !important;
  background: #fff !important;
  box-shadow: 0 12px 24px rgba(15,23,42,0.04) !important;
}

#drive-sync-panel {
  padding: 17px 14px !important;
}

.lp-drive-header {
  padding-bottom: 12px !important;
}

.lp-drive-btns-row {
  display: grid !important;
  grid-template-columns: minmax(0, 1fr) 38px !important;
  gap: 10px !important;
}

#drive-sync-btn,
#drive-sync-stop {
  height: 52px !important;
  border-radius: 9px !important;
  font-size: 14px !important;
}

.lp-drive-sound-trigger {
  width: 38px !important;
  height: 52px !important;
  border-radius: 9px !important;
}

#drive-pending-section {
  border-top: 1px solid rgba(15,23,42,0.08) !important;
  padding-top: 13px !important;
}

.lp-picker-card {
  padding: 15px 14px !important;
}

.lp-picker-card.is-collapsed {
  min-height: 64px !important;
}

.lp-history-card {
  padding: 14px !important;
}

.lp-history-title {
  font-size: 13px !important;
}

.lp-history-caption,
.storage-note,
.history-empty,
.lp-procesados-empty {
  font-size: 11px !important;
}

.panel-main {
  width: 100% !important;
  height: 100% !important;
  min-width: 0 !important;
  min-height: 0 !important;
  padding: 14px 24px 16px !important;
  background: #F7FAF8 !important;
  border: none !important;
  overflow: hidden !important;
}

.results-shell {
  height: 100% !important;
  min-height: 0 !important;
  display: grid !important;
  grid-template-rows: 92px auto auto minmax(0, 1fr) 46px !important;
  gap: 10px !important;
}

.stats {
  order: 1 !important;
  display: grid !important;
  grid-template-columns: repeat(5, minmax(0, 1fr)) !important;
  gap: 7px !important;
  padding: 0 !important;
  border: none !important;
}

.stat-item {
  min-height: 90px !important;
  display: grid !important;
  grid-template-columns: 50px minmax(0, 1fr) !important;
  align-items: center !important;
  justify-items: start !important;
  gap: 12px !important;
  padding: 13px 14px !important;
  border: 1px solid rgba(15,23,42,0.08) !important;
  border-radius: 10px !important;
  background: #fff !important;
  box-shadow: 0 12px 22px rgba(15,23,42,0.045) !important;
  text-align: left !important;
}

.stat-item.is-active,
.stat-item:hover {
  transform: none !important;
  border-color: rgba(0,168,71,0.28) !important;
  background: #fff !important;
  box-shadow: 0 16px 28px rgba(15,23,42,0.065) !important;
}

.stat-icon {
  width: 42px !important;
  height: 42px !important;
  border-radius: 9px !important;
  display: grid !important;
  place-items: center !important;
  color: #00A847 !important;
  background: #EAF8F0 !important;
  border: 1px solid rgba(0,168,71,0.20) !important;
  font-weight: 800 !important;
  font-size: 18px !important;
  text-transform: lowercase !important;
}

.stat-icon--asset {
  background: #fff !important;
  color: inherit !important;
  border-color: rgba(15,23,42,0.10) !important;
  overflow: hidden !important;
}

.stat-icon--asset img {
  width: 40px !important;
  height: 40px !important;
  display: block !important;
  object-fit: contain !important;
  pointer-events: none !important;
  user-select: none !important;
}

.stat-item--colecta .stat-icon {
  background: #FFF5DD !important;
  color: #F2A100 !important;
  border-color: rgba(242,161,0,0.25) !important;
}

.stat-item--bluexpress .stat-icon {
  background: #0D4EA6 !important;
  color: #fff !important;
  border-color: #0D4EA6 !important;
}

.stat-item--walmart .stat-icon {
  background: #0D4EA6 !important;
  color: #FFC400 !important;
  border-color: #0D4EA6 !important;
  font-size: 28px !important;
  line-height: 1 !important;
}

.stat-item--colecta .stat-icon--asset,
.stat-item--bluexpress .stat-icon--asset,
.stat-item--walmart .stat-icon--asset,
.stat-item--total .stat-icon--asset {
  background: #fff !important;
  border-color: rgba(15,23,42,0.10) !important;
}

.stat-item--total {
  background: #EEF9F3 !important;
  border-color: rgba(0,168,71,0.22) !important;
}

.stat-copy {
  min-width: 0 !important;
  display: grid !important;
  gap: 2px !important;
}

.stat-value {
  color: #1B2C23 !important;
  font-size: 23px !important;
  line-height: 1 !important;
  font-weight: 800 !important;
}

.stat-label {
  color: #1B2C23 !important;
  font-size: 11px !important;
  line-height: 1.15 !important;
  font-weight: 800 !important;
  text-transform: uppercase !important;
  letter-spacing: 0 !important;
}

.stat-copy small {
  color: #00A847 !important;
  font-size: 10px !important;
  font-weight: 800 !important;
}

.stat-copy small::after {
  content: " →";
  margin-left: 5px;
}

.stat-item--split {
  grid-template-columns: 42px minmax(0, 1fr) minmax(70px, 0.78fr) !important;
  gap: 9px !important;
}

.stat-item--split .stat-icon {
  width: 40px !important;
  height: 40px !important;
}

.stat-status-split {
  width: 100% !important;
  min-width: 0 !important;
  align-self: stretch !important;
  display: grid !important;
  grid-template-rows: 1fr 1fr !important;
  gap: 4px !important;
  padding-left: 8px !important;
  border-left: 1px solid rgba(15,23,42,0.08) !important;
}

.stat-status-chip {
  min-width: 0 !important;
  display: flex !important;
  align-items: center !important;
  justify-content: space-between !important;
  gap: 5px !important;
  padding: 3px 6px !important;
  border-radius: 7px !important;
  background: #F8FAF9 !important;
  border: 1px solid rgba(15,23,42,0.06) !important;
  color: #526057 !important;
  line-height: 1 !important;
}

.stat-status-chip strong {
  color: #1B2C23 !important;
  font-size: 13px !important;
  font-weight: 900 !important;
  line-height: 1 !important;
}

.stat-status-chip span {
  color: #66756D !important;
  font-size: 9px !important;
  font-weight: 900 !important;
  line-height: 1 !important;
  text-transform: uppercase !important;
  white-space: nowrap !important;
}

.stat-status-chip.is-cancelled {
  background: #FFF1F2 !important;
  border-color: rgba(244,63,94,0.14) !important;
}

.stat-status-chip.is-cancelled strong,
.stat-status-chip.is-cancelled span {
  color: #BE123C !important;
}

.results-toolbar {
  order: 2 !important;
  padding: 12px 18px 6px !important;
  display: grid !important;
  grid-template-columns: minmax(0, 1fr) !important;
  gap: 6px !important;
  align-items: center !important;
  background: #fff !important;
  border-left: 1px solid rgba(15,23,42,0.08) !important;
  border-right: 1px solid rgba(15,23,42,0.08) !important;
}

.results-search-group {
  display: grid !important;
  grid-template-columns: minmax(380px, 1fr) 224px 152px 176px !important;
  gap: 10px !important;
  align-items: center !important;
  min-width: 0 !important;
}

.search-input {
  min-width: 0 !important;
  height: 38px !important;
  border-radius: 8px !important;
  border-color: rgba(15,23,42,0.10) !important;
  font-size: 12px !important;
  padding: 0 14px !important;
  background: #fff !important;
  box-shadow: inset 0 0 0 1px rgba(15,23,42,0.02) !important;
}

.results-history-actions {
  display: grid !important;
  grid-template-columns: 1fr 1fr !important;
  gap: 8px !important;
  margin: 0 !important;
}

.results-history-btn,
.results-advanced-btn,
.results-cancel-btn {
  height: 38px !important;
  min-height: 38px !important;
  width: 100% !important;
  min-width: 0 !important;
  border-radius: 9px !important;
  font-size: 11px !important;
  font-weight: 800 !important;
}

#showStoredBtn {
  background: #00A847 !important;
  border-color: #00A847 !important;
  color: #fff !important;
}

.results-advanced-btn {
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  gap: 7px !important;
  border: 1px solid rgba(15,23,42,0.10) !important;
  background: #F4F6F5 !important;
  color: #1B2C23 !important;
  cursor: pointer !important;
}

.results-cancel-btn {
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  gap: 7px !important;
  border: 1px solid rgba(220,38,38,0.18) !important;
  background: #FFF1F2 !important;
  color: #BE123C !important;
  cursor: pointer !important;
}

.results-cancel-btn:disabled {
  opacity: 0.46 !important;
  cursor: not-allowed !important;
}

.results-advanced-btn.is-active {
  border-color: rgba(0,168,71,0.28) !important;
  background: #EAF8F0 !important;
  color: #008A3B !important;
}

.table-status-filter {
  width: min(128px, 100%) !important;
  height: 26px !important;
  min-width: 0 !important;
  border: 1px solid rgba(15,23,42,0.12) !important;
  border-radius: 7px !important;
  background: #FFFFFF !important;
  color: #1B2C23 !important;
  font-size: 10px !important;
  font-weight: 900 !important;
  text-transform: uppercase !important;
  padding: 0 7px !important;
  outline: none !important;
  cursor: pointer !important;
}

.table-status-filter:focus {
  border-color: rgba(0,168,71,0.48) !important;
  box-shadow: 0 0 0 2px rgba(0,168,71,0.10) !important;
}

.selection-hint {
  min-height: 16px !important;
  font-size: 11px !important;
  line-height: 1.35 !important;
  color: #66756D !important;
  text-align: left !important;
  white-space: nowrap !important;
  overflow: hidden !important;
  text-overflow: ellipsis !important;
}

.results-lookup-slot {
  order: 3 !important;
  background: #fff !important;
  border-left: 1px solid rgba(15,23,42,0.08) !important;
  border-right: 1px solid rgba(15,23,42,0.08) !important;
  padding: 8px 18px 0 !important;
}

.results-lookup-slot[hidden] {
  display: none !important;
}

.dashboard-lookup-card {
  width: 100% !important;
  height: auto !important;
  min-height: 0 !important;
  display: grid !important;
  grid-template-rows: auto !important;
  padding: 0 !important;
  border: none !important;
  background: transparent !important;
  overflow: visible !important;
}

.dashboard-lookup-card .order-lookup-head,
.dashboard-lookup-card .ol-stats {
  display: none !important;
}

.dashboard-lookup-card .order-lookup-controls {
  display: grid !important;
  grid-template-columns: 260px minmax(0, 1fr) auto !important;
  gap: 10px !important;
  align-items: end !important;
  padding: 12px !important;
  border-radius: 10px !important;
  background: #F8FAF9 !important;
}

.dashboard-lookup-card .order-lookup-output {
  margin-top: 10px !important;
  min-height: 0 !important;
}

.dashboard-lookup-card .order-lookup-summary {
  border-radius: 10px !important;
  background: #fff !important;
}

.results-meta {
  order: 3 !important;
  min-height: 18px !important;
  margin: 0 !important;
  padding: 0 18px 10px !important;
  background: #fff !important;
  border-left: 1px solid rgba(15,23,42,0.08) !important;
  border-right: 1px solid rgba(15,23,42,0.08) !important;
  font-size: 10px !important;
  line-height: 1.35 !important;
  color: #66756D !important;
  white-space: nowrap !important;
  overflow: hidden !important;
  text-overflow: ellipsis !important;
}

.table-container,
.carrier-labels-panel {
  order: 4 !important;
  height: 100% !important;
  min-height: 0 !important;
  max-height: none !important;
  margin: 0 !important;
  border-radius: 0 0 10px 10px !important;
  border: 1px solid rgba(15,23,42,0.08) !important;
  border-top: none !important;
  background: #fff !important;
  overflow: auto !important;
}

#dataTable th,
.carrier-labels-table th {
  height: 38px !important;
  background: #F8FAF9 !important;
  color: #1B2C23 !important;
  font-size: 10px !important;
  font-weight: 800 !important;
  letter-spacing: 0 !important;
}

#dataTable td,
.carrier-labels-table td {
  height: 46px !important;
  padding: 9px 12px !important;
  font-size: 12px !important;
}

.carrier-labels-head {
  height: 46px !important;
}

.row-status-badge {
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  min-width: 72px !important;
  max-width: 150px !important;
  height: 24px !important;
  padding: 0 10px !important;
  border-radius: 999px !important;
  font-size: 10px !important;
  font-weight: 800 !important;
  text-transform: uppercase !important;
  white-space: nowrap !important;
  overflow: hidden !important;
  text-overflow: ellipsis !important;
}

.row-status-badge.is-complete {
  background: #DDF6E8 !important;
  color: #008A3B !important;
}

.row-status-badge.is-progress {
  background: #FFF4D7 !important;
  color: #8A5A00 !important;
}

.row-status-badge.is-nd {
  background: #F1F4F2 !important;
  color: #66756D !important;
}

.row-status-badge.is-default {
  background: #E6F1FF !important;
  color: #0B57D0 !important;
}

.row-status-badge.is-cancelled {
  background: #FFE4E6 !important;
  color: #BE123C !important;
}

.carrier-print-status {
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  min-width: 76px !important;
  height: 24px !important;
  padding: 0 10px !important;
  border-radius: 999px !important;
  font-size: 10px !important;
  font-weight: 900 !important;
  text-transform: uppercase !important;
  white-space: nowrap !important;
}

.carrier-print-status.is-printed {
  background: #DDF6E8 !important;
  color: #008A3B !important;
}

.carrier-print-status.is-pending {
  background: #FFF4D7 !important;
  color: #8A5A00 !important;
}

.results-actions {
  order: 5 !important;
  display: grid !important;
  grid-template-columns: minmax(180px, 1fr) minmax(190px, 1fr) minmax(220px, 1.4fr) !important;
  gap: 9px !important;
  align-items: stretch !important;
}

.zebra-printer-control {
  height: 38px !important;
  min-height: 38px !important;
  display: grid !important;
  grid-template-columns: 46px minmax(0, 1fr) !important;
  align-items: center !important;
  gap: 7px !important;
  padding: 0 8px 0 12px !important;
  border: 1px solid #DDE5E1 !important;
  border-radius: 7px !important;
  background: #FFFFFF !important;
  color: #4E6258 !important;
  font-size: 10px !important;
  font-weight: 800 !important;
  text-transform: uppercase !important;
  white-space: nowrap !important;
}

.zebra-printer-control select {
  width: 100% !important;
  min-width: 0 !important;
  height: 28px !important;
  border: 1px solid rgba(15,23,42,0.08) !important;
  border-radius: 6px !important;
  outline: none !important;
  background: #F8FAF9 !important;
  color: #172B22 !important;
  font-size: 11px !important;
  font-weight: 800 !important;
  padding: 0 7px !important;
  text-overflow: ellipsis !important;
}

.results-actions .btn {
  height: 38px !important;
  min-height: 38px !important;
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  gap: 8px !important;
  min-width: 0 !important;
  padding: 0 12px !important;
  border-radius: 7px !important;
  font-size: 12px !important;
  font-weight: 800 !important;
  line-height: 1 !important;
  white-space: nowrap !important;
  overflow: hidden !important;
  text-overflow: ellipsis !important;
  transform: none !important;
}

.results-actions .btn svg,
.results-actions .btn-carrier-mark {
  flex: 0 0 auto !important;
}

#downloadBtn {
  background: #00A847 !important;
  border-color: #00A847 !important;
  color: #FFFFFF !important;
}

#printZebraBtn {
  background: #050505 !important;
  border-color: #050505 !important;
  color: #FFFFFF !important;
}

.btn-carrier-blue,
.btn-carrier-walmart {
  background: #0B57D0 !important;
}

.btn-carrier-mark {
  background: transparent !important;
  font-size: 15px !important;
  line-height: 1 !important;
}

@media (max-width: 1280px) {
  .container {
    height: auto !important;
    min-height: 100vh !important;
  }
  body {
    overflow: auto !important;
  }
  .panels-container {
    grid-template-columns: 340px minmax(0, 1fr) !important;
    height: auto !important;
    min-height: calc(100vh - 86px) !important;
  }
  .stats {
    grid-template-columns: repeat(3, minmax(0, 1fr)) !important;
  }
  .results-shell {
    grid-template-rows: auto auto auto minmax(420px, 1fr) auto !important;
  }
}

@media (max-width: 900px) {
  header {
    grid-template-columns: 1fr !important;
    grid-template-rows: auto auto auto !important;
    padding: 14px 18px !important;
    gap: 6px !important;
  }
  header .app-logo,
  header h1,
  header p,
  .app-top-actions {
    grid-column: 1 !important;
    grid-row: auto !important;
  }
  .app-top-actions {
    min-width: 0 !important;
    justify-content: start !important;
    flex-wrap: wrap !important;
  }
  .panels-container {
    grid-template-columns: 1fr !important;
  }
  .panel-left,
  .panel-left.panel {
    width: 100% !important;
    height: auto !important;
  }
  .stats,
  .results-actions {
    grid-template-columns: 1fr !important;
  }
  .results-search-group {
    grid-template-columns: 1fr !important;
  }
}

body.is-dark-mode {
  color-scheme: dark !important;
  --dark-bg: #070B14;
  --dark-header: #0B1220;
  --dark-sidebar: #0D1626;
  --dark-panel: #101A2C;
  --dark-card: #142137;
  --dark-card-soft: #172A41;
  --dark-table: #0F1A2A;
  --dark-border: rgba(148, 163, 184, 0.24);
  --dark-border-strong: rgba(148, 163, 184, 0.36);
  --dark-text: #F1F7FF;
  --dark-muted: #B8C7DC;
  --dark-soft: #8FA4BE;
  --dark-green: #15C978;
  --dark-green-soft: rgba(21, 201, 120, 0.16);
  background: radial-gradient(circle at top center, rgba(21, 201, 120, 0.10), transparent 30%), var(--dark-bg) !important;
  color: var(--dark-text) !important;
}

body.is-dark-mode .container {
  background: linear-gradient(180deg, #0A1020 0%, #070B14 100%) !important;
  color: var(--dark-text) !important;
}

body.is-dark-mode header {
  background: rgba(11, 18, 32, 0.98) !important;
  border-bottom-color: var(--dark-border) !important;
  box-shadow: 0 16px 34px rgba(0, 0, 0, 0.26) !important;
}

body.is-dark-mode header h1 {
  color: #3DF09A !important;
  text-shadow: 0 0 18px rgba(21, 201, 120, 0.18) !important;
}

body.is-dark-mode header p,
body.is-dark-mode .selection-hint,
body.is-dark-mode .results-meta,
body.is-dark-mode .storage-note,
body.is-dark-mode .history-empty,
body.is-dark-mode .lp-history-caption,
body.is-dark-mode .picker-meta,
body.is-dark-mode .stat-copy small,
body.is-dark-mode .notification-item span {
  color: var(--dark-muted) !important;
}

body.is-dark-mode .app-system-status,
body.is-dark-mode .app-system-status.is-monitoring,
body.is-dark-mode .app-system-status.is-operational {
  color: var(--dark-text) !important;
}

body.is-dark-mode .app-system-status.is-monitoring {
  background: rgba(34, 224, 131, 0.12) !important;
  color: #CFFFE7 !important;
  animation-name: app-system-connected-blink-dark !important;
}

@keyframes app-system-connected-blink-dark {
  0%, 100% {
    background: rgba(34, 224, 131, 0.08);
    box-shadow: 0 0 0 0 rgba(34, 224, 131, 0.00);
  }
  50% {
    background: rgba(34, 224, 131, 0.20);
    box-shadow: 0 0 0 5px rgba(34, 224, 131, 0.14);
  }
}

body.is-dark-mode .app-bell-btn,
body.is-dark-mode .app-theme-toggle-btn,
body.is-dark-mode #drive-sync-panel,
body.is-dark-mode .lp-picker-card,
body.is-dark-mode .lp-history-card,
body.is-dark-mode .stat-item,
body.is-dark-mode .results-toolbar,
body.is-dark-mode .results-meta,
body.is-dark-mode .results-lookup-slot,
body.is-dark-mode .table-container,
body.is-dark-mode .carrier-labels-panel,
body.is-dark-mode .zebra-printer-control,
body.is-dark-mode .dashboard-lookup-card .order-lookup-controls,
body.is-dark-mode .dashboard-lookup-card .order-lookup-summary,
body.is-dark-mode .app-notification-panel,
body.is-dark-mode .notification-item,
body.is-dark-mode .order-lookup-card,
body.is-dark-mode .order-lookup-controls,
body.is-dark-mode .order-lookup-summary,
body.is-dark-mode .order-lookup-table-wrap {
  background: var(--dark-card) !important;
  border-color: var(--dark-border) !important;
  color: var(--dark-text) !important;
  box-shadow: 0 10px 28px rgba(0, 0, 0, 0.18) !important;
}

body.is-dark-mode .panel-left,
body.is-dark-mode .panel-left.panel,
body.is-dark-mode .panel-main {
  background: var(--dark-sidebar) !important;
  border-color: var(--dark-border) !important;
  color: var(--dark-text) !important;
}

body.is-dark-mode .panel-main,
body.is-dark-mode .results-shell {
  background: var(--dark-panel) !important;
  border-color: var(--dark-border) !important;
}

body.is-dark-mode .stat-item--total,
body.is-dark-mode .stat-item.is-active,
body.is-dark-mode .stat-item:hover {
  background: linear-gradient(135deg, rgba(21, 201, 120, 0.18), rgba(34, 197, 94, 0.08)) !important;
  border-color: rgba(21, 201, 120, 0.48) !important;
}

body.is-dark-mode .stat-icon--asset {
  background: rgba(7, 11, 20, 0.82) !important;
  border-color: var(--dark-border-strong) !important;
}

body.is-dark-mode .stat-value,
body.is-dark-mode .stat-label,
body.is-dark-mode #dataTable th,
body.is-dark-mode #dataTable td,
body.is-dark-mode .carrier-labels-table th,
body.is-dark-mode .carrier-labels-table td,
body.is-dark-mode .notification-item strong,
body.is-dark-mode .order-lookup-head h3,
body.is-dark-mode .order-lookup-summary strong {
  color: var(--dark-text) !important;
}

body.is-dark-mode #dataTable th,
body.is-dark-mode .carrier-labels-table th,
body.is-dark-mode .order-lookup-table th {
  background: #162238 !important;
  border-color: var(--dark-border) !important;
  color: #DBEAFE !important;
}

body.is-dark-mode #dataTable td,
body.is-dark-mode .carrier-labels-table td,
body.is-dark-mode .order-lookup-table td {
  background: var(--dark-table) !important;
  border-color: rgba(148, 163, 184, 0.16) !important;
}

body.is-dark-mode tr.is-selected,
body.is-dark-mode #dataTable tr.is-selected td {
  background: rgba(21, 201, 120, 0.18) !important;
}

body.is-dark-mode .search-input,
body.is-dark-mode .panel-left #picker,
body.is-dark-mode .panel-left #textInput,
body.is-dark-mode .order-lookup-search-input,
body.is-dark-mode .order-lookup-filter-field select,
body.is-dark-mode .table-status-filter,
body.is-dark-mode .zebra-printer-control select,
body.is-dark-mode .ds-apikey-input {
  background: #0A1220 !important;
  border-color: var(--dark-border-strong) !important;
  color: var(--dark-text) !important;
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.04) !important;
}

body.is-dark-mode .search-input::placeholder,
body.is-dark-mode .panel-left #textInput::placeholder,
body.is-dark-mode .order-lookup-search-input::placeholder {
  color: #8AA0B8 !important;
}

body.is-dark-mode .results-history-btn,
body.is-dark-mode .results-advanced-btn,
body.is-dark-mode .order-lookup-actions .btn,
body.is-dark-mode .order-lookup-upload-row .btn {
  background: #111D30 !important;
  border-color: var(--dark-border) !important;
  color: var(--dark-text) !important;
}

body.is-dark-mode #showStoredBtn,
body.is-dark-mode #drive-sync-btn,
body.is-dark-mode #processTextBtn,
body.is-dark-mode #downloadBtn {
  background: linear-gradient(180deg, #18C777 0%, #08A85F 100%) !important;
  border-color: #19D27E !important;
  color: #FFFFFF !important;
  box-shadow: 0 8px 18px rgba(8, 168, 95, 0.24) !important;
}

body.is-dark-mode #printZebraBtn {
  background: #020817 !important;
  border-color: #1E293B !important;
  color: #FFFFFF !important;
  box-shadow: 0 8px 18px rgba(0, 0, 0, 0.26) !important;
}

body.is-dark-mode .results-cancel-btn {
  background: rgba(244, 63, 94, 0.12) !important;
  border-color: rgba(251, 113, 133, 0.34) !important;
  color: #FFC0CB !important;
}

body.is-dark-mode .lp-statusbar {
  background: rgba(21, 201, 120, 0.14) !important;
  border-color: rgba(21, 201, 120, 0.32) !important;
}

body.is-dark-mode .lp-statusbar .status-pill-time,
body.is-dark-mode .lp-statusbar .status-pill-meta,
body.is-dark-mode #outsideHoursToggleBtn {
  color: #A7F3D0 !important;
}

body.is-dark-mode .row-status-badge.is-nd {
  background: #1E293B !important;
  color: #CBD5E1 !important;
}

body.is-dark-mode .row-status-badge.is-complete {
  background: rgba(22,163,74,0.20) !important;
  color: #86EFAC !important;
}

body.is-dark-mode .row-status-badge.is-progress {
  background: rgba(245,158,11,0.18) !important;
  color: #FCD34D !important;
}

body.is-dark-mode .row-status-badge.is-default {
  background: rgba(59,130,246,0.18) !important;
  color: #93C5FD !important;
}

body.is-dark-mode .row-status-badge.is-cancelled {
  background: rgba(244,63,94,0.18) !important;
  color: #FDA4AF !important;
}

body.is-dark-mode .carrier-print-status.is-printed {
  background: rgba(22,163,74,0.20) !important;
  color: #86EFAC !important;
}

body.is-dark-mode .carrier-print-status.is-pending {
  background: rgba(245,158,11,0.18) !important;
  color: #FCD34D !important;
}

body.is-dark-mode .app-theme-toggle-btn[aria-pressed="true"],
body.is-dark-mode #drive-sound-menu-btn,
body.is-dark-mode #pickerCardToggleBtn {
  background: #13233B !important;
  border-color: rgba(96, 165, 250, 0.34) !important;
  color: #DCEBFF !important;
  box-shadow: inset 0 1px 0 rgba(255,255,255,0.06) !important;
}

body.is-dark-mode .app-theme-toggle-btn[aria-pressed="true"]:hover,
body.is-dark-mode #drive-sound-menu-btn:hover,
body.is-dark-mode #pickerCardToggleBtn:hover {
  background: #19304F !important;
  border-color: rgba(125, 211, 252, 0.48) !important;
  color: #FFFFFF !important;
}

body.is-dark-mode .notification-summary,
body.is-dark-mode .notification-actions,
body.is-dark-mode .carrier-labels-head {
  background: #0F1D32 !important;
  border-color: var(--dark-border) !important;
}

body.is-dark-mode .notification-close-btn,
body.is-dark-mode .notification-action-btn:not(.is-primary),
body.is-dark-mode .carrier-refresh-btn {
  background: #13233B !important;
  border-color: rgba(96, 165, 250, 0.34) !important;
  color: #DCEBFF !important;
  box-shadow: inset 0 1px 0 rgba(255,255,255,0.06) !important;
}

body.is-dark-mode .notification-close-btn:hover,
body.is-dark-mode .notification-action-btn:not(.is-primary):hover,
body.is-dark-mode .carrier-refresh-btn:hover {
  background: #19304F !important;
  border-color: rgba(125, 211, 252, 0.48) !important;
  color: #FFFFFF !important;
}

body.is-dark-mode .carrier-labels-head strong {
  color: var(--dark-text) !important;
}

body.is-dark-mode .carrier-labels-head span {
  color: var(--dark-muted) !important;
}

body.is-dark-mode .lp-section-label,
body.is-dark-mode .lp-drive-title,
body.is-dark-mode .lp-history-card h3,
body.is-dark-mode .lp-history-card h4,
body.is-dark-mode .lp-history-card strong,
body.is-dark-mode #drive-sync-status,
body.is-dark-mode #drive-sync-help,
body.is-dark-mode .drive-mode-toggle,
body.is-dark-mode .btn-secondary,
body.is-dark-mode .notification-head strong,
body.is-dark-mode .notification-head span {
  color: var(--dark-muted) !important;
}

body.is-dark-mode .lp-card,
body.is-dark-mode .left-panel-top,
body.is-dark-mode .picker-manager,
body.is-dark-mode .history-entry,
body.is-dark-mode .notification-summary-item {
  background: var(--dark-card-soft) !important;
  border-color: var(--dark-border) !important;
  color: var(--dark-text) !important;
}

body.is-dark-mode .lp-drive-modes,
body.is-dark-mode .lp-tabs {
  background: rgba(7, 11, 20, 0.52) !important;
  border-color: var(--dark-border) !important;
}

body.is-dark-mode .lp-drive-mode.is-active,
body.is-dark-mode .lp-tab.is-active {
  background: rgba(21, 201, 120, 0.18) !important;
  color: #CFFFE7 !important;
}

body.is-dark-mode .btn-carrier-blue {
  background: linear-gradient(180deg, #1D6FE8 0%, #1556C7 100%) !important;
  border-color: #3B82F6 !important;
  color: #FFFFFF !important;
}

body.is-dark-mode .btn-carrier-walmart {
  background: linear-gradient(180deg, #1D6FE8 0%, #124FAF 100%) !important;
  border-color: #60A5FA !important;
  color: #FFFFFF !important;
}

    </style>
</head>
<body>
<div class="container">
<header>
<img alt="NovaPet Logo" class="app-logo" src="data:image/png;base64,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"/>
<h1>EXTRACTOR DE ETIQUETAS</h1>
<p>Generador automatico de planilla de carga asignada.</p>
<div aria-label="Estado de la aplicacion" class="app-top-actions">
<span class="app-system-status is-operational" id="appSystemStatus" title="Sistema operativo">
<span aria-hidden="true" class="app-system-status-dot"></span>
<span class="app-system-status-label">Sistema operativo</span>
</span>
<button aria-label="Activar modo oscuro" aria-pressed="false" class="app-theme-toggle-btn" id="themeToggleBtn" title="Activar modo oscuro" type="button">
<svg aria-hidden="true" class="theme-icon theme-icon--moon" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>
<svg aria-hidden="true" class="theme-icon theme-icon--sun" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="4"></circle><path d="M12 2v2"></path><path d="M12 20v2"></path><path d="m4.93 4.93 1.41 1.41"></path><path d="m17.66 17.66 1.41 1.41"></path><path d="M2 12h2"></path><path d="M20 12h2"></path><path d="m6.34 17.66-1.41 1.41"></path><path d="m19.07 4.93-1.41 1.41"></path></svg>
</button>
<button aria-controls="notificationPanel" aria-expanded="false" aria-label="Notificaciones" class="app-bell-btn" id="notificationBellBtn" type="button">
<svg aria-hidden="true" fill="none" height="18" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="18" xmlns="http://www.w3.org/2000/svg"><path d="M18 8a6 6 0 0 0-12 0c0 7-3 7-3 7h18s-3 0-3-7"></path><path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg>
<span aria-hidden="true" class="notification-badge" id="notificationBadge"></span>
</button>
</div>
</header>
<div aria-atomic="true" aria-live="polite" class="message-stack" id="messageStack"></div>
<section aria-label="Centro de notificaciones" class="app-notification-panel" hidden="" id="notificationPanel">
<div class="notification-head">
<div>
<strong>Notificaciones</strong>
<span>Resumen operativo del extractor</span>
</div>
<button aria-label="Cerrar notificaciones" class="notification-close-btn" id="notificationPanelCloseBtn" type="button">×</button>
</div>
<div class="notification-summary" id="notificationSummary"></div>
<div class="notification-list" id="notificationList"></div>
<div class="notification-actions">
<button class="notification-action-btn is-primary" id="notificationDriveBtn" type="button">Ver Drive</button>
<button class="notification-action-btn" id="notificationPanelRefreshBtn" type="button">Actualizar</button>
</div>
</section>
<div class="panels-container">
<div class="panel panel-left">
<!-- STATUS BAR -->
<div class="lp-statusbar">
<span aria-live="polite" class="status-pill lp-statusbar-time" id="storageStatus">Verificando...</span>
<button aria-pressed="false" id="outsideHoursToggleBtn" title="Activar historial fuera de horario" type="button">
<svg fill="none" height="11" stroke="currentColor" stroke-width="2" viewbox="0 0 24 24" width="11" xmlns="http://www.w3.org/2000/svg"><path d="M19 21H5a2 2 0 01-2-2V5a2 2 0 012-2h11l5 5v14a2 2 0 01-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
                        +18:00
                    </button>
</div>
<!-- GOOGLE DRIVE CARD -->
<div id="drive-sync-panel">
<div class="lp-drive-header">
<svg height="18" viewbox="0 0 87.3 78" width="22" xmlns="http://www.w3.org/2000/svg">
<path d="m6.6 66.85 3.85 6.65c.8 1.4 1.95 2.5 3.3 3.3l13.75-23.8h-27.5c0 1.55.4 3.1 1.2 4.5z" fill="#0066da"></path>
<path d="m43.65 25-13.75-23.8c-1.35.8-2.5 1.9-3.3 3.3l-25.4 44a9.06 9.06 0 0 0 -1.2 4.5h27.5z" fill="#00ac47"></path>
<path d="m73.55 76.8c1.35-.8 2.5-1.9 3.3-3.3l1.6-2.75 7.65-13.25c.8-1.4 1.2-2.95 1.2-4.5h-27.502l5.852 11.5z" fill="#ea4335"></path>
<path d="m43.65 25 13.75-23.8c-1.35-.8-2.9-1.2-4.5-1.2h-18.5c-1.6 0-3.15.45-4.5 1.2z" fill="#00832d"></path>
<path d="m59.8 53h-32.3l-13.75 23.8c1.35.8 2.9 1.2 4.5 1.2h50.8c1.6 0 3.15-.45 4.5-1.2z" fill="#2684fc"></path>
<path d="m73.4 26.5-12.7-22c-.8-1.4-1.95-2.5-3.3-3.3l-13.75 23.8 16.15 27h27.45c0-1.55-.4-3.1-1.2-4.5z" fill="#ffba00"></path>
</svg>
<div style="flex:1; display:flex; flex-direction:column; gap:1px;">
<span style="font-weight:600; font-size:13px; color:var(--text);">Google Drive</span>
<span id="drive-sync-status">Desconectado</span>
</div>
<div id="drive-file-count" onclick="DriveSync.togglePanel()" title="Ver archivos del día">
<span id="drive-file-count-num" style="font-size:18px; font-weight:700; color:#00ac47; line-height:1;">0</span>
<span style="font-size:10px; color:#00ac47; font-weight:500;">archivos</span>
</div>
</div>
<div class="lp-drive-modes">
<button id="drive-mode-auto" onclick="DriveSync.setMode('auto')">Automático</button>
<button id="drive-mode-manual" onclick="DriveSync.setMode('manual')">Manual</button>
</div>
<div id="drive-mode-desc">Asigna a <strong>kmendoza</strong> y procesa automáticamente</div>
<div id="drive-day-status">
<div id="drive-day-dot" style="width:8px;height:8px;border-radius:50%;background:#00ac47;flex-shrink:0;"></div>
<div style="flex:1;">
<div id="drive-day-name" style="font-weight:500;color:var(--text);">—</div>
<div style="font-size:11px;color:var(--text-muted);">Revisando cada 30s</div>
</div>
<button onclick="DriveSync.togglePanel()" style="padding:4px 10px;font-size:11px;border-radius:6px;border:1px solid var(--border);background:transparent;cursor:pointer;color:var(--text-muted);white-space:nowrap;">Ver archivos</button>
</div>
<div class="lp-drive-btns-row">
<button class="btn btn-compact" id="drive-sync-btn" onclick="DriveSync.connect()" style="flex:1;">
<svg fill="none" height="13" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="13" xmlns="http://www.w3.org/2000/svg"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" x2="21" y1="14" y2="3"></line></svg>
                            Conectar Drive
                        </button>
<button class="btn btn-secondary" id="drive-sync-stop" onclick="DriveSync.stop()" style="flex:1; display:none;">
<svg fill="none" height="13" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="13" xmlns="http://www.w3.org/2000/svg"><rect height="18" rx="2" width="18" x="3" y="3"></rect></svg>
                            Detener monitoreo
                        </button>
<button aria-expanded="false" aria-label="Abrir configuracion de sonidos" class="btn btn-secondary lp-drive-sound-trigger" id="drive-sound-menu-btn" onclick="DriveSync.toggleSoundMenu()" title="Sonidos" type="button">
<svg aria-hidden="true" fill="none" height="15" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="15" xmlns="http://www.w3.org/2000/svg"><polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"></polygon><path d="M19.07 4.93a10 10 0 0 1 0 14.14"></path><path d="M15.54 8.46a5 5 0 0 1 0 7.07"></path></svg>
</button>
<div class="lp-drive-sound-popover" hidden="" id="drive-sound-popover">
<div class="lp-drive-sound-row">
<button id="drive-sound-test-btn" onclick="DriveSync.testSounds()" type="button">
<svg aria-hidden="true" fill="none" height="12" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="12" xmlns="http://www.w3.org/2000/svg"><polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"></polygon><path d="M19.07 4.93a10 10 0 0 1 0 14.14"></path><path d="M15.54 8.46a5 5 0 0 1 0 7.07"></path></svg>
                                    Probar sonidos
                                </button>
<span id="drive-sound-test-label"></span>
</div>
<div class="lp-drive-sound-grid">
<label class="lp-drive-sound-field">
<span>Archivo nuevo</span>
<div class="lp-drive-sound-control">
<select class="lp-drive-sound-select" id="drive-sound-arrival">
<option value="clearBell">Campana clara</option>
<option value="softDouble">Doble suave</option>
<option value="brightPing">Ping brillante</option>
<option value="risingChime">Subida corta</option>
<option value="warmBell">Campana tibia</option>
<option value="softPulse">Pulso suave</option>
<option value="firmAlert">Alerta firme</option>
<option value="shortTone">Tono corto</option>
<option value="loudBell">Campana fuerte</option>
<option value="urgentTriple">Triple urgente</option>
<option value="digitalAlarm">Alarma digital</option>
<option value="sirenRise">Sirena subida</option>
<option value="rapidPulse">Pulso rápido</option>
<option value="bassKnock">Golpe grave</option>
<option value="highFlash">Destello agudo</option>
<option value="longAlarm">Alarma larga</option>
<option value="silent">Sin sonido</option>
</select>
<button aria-label="Escuchar sonido de archivo nuevo" class="lp-drive-sound-preview" onclick="DriveSync.previewSound('arrival')" title="Escuchar sonido" type="button">
<svg aria-hidden="true" fill="none" height="13" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="13" xmlns="http://www.w3.org/2000/svg"><polygon points="6 3 20 12 6 21 6 3"></polygon></svg>
</button>
</div>
</label>
<label class="lp-drive-sound-field">
<span>Aviso 10 min</span>
<div class="lp-drive-sound-control">
<select class="lp-drive-sound-select" id="drive-sound-warning">
<option value="clearBell">Campana clara</option>
<option value="softDouble">Doble suave</option>
<option value="brightPing">Ping brillante</option>
<option value="risingChime">Subida corta</option>
<option value="warmBell">Campana tibia</option>
<option value="softPulse">Pulso suave</option>
<option value="firmAlert">Alerta firme</option>
<option value="shortTone">Tono corto</option>
<option value="loudBell">Campana fuerte</option>
<option value="urgentTriple">Triple urgente</option>
<option value="digitalAlarm">Alarma digital</option>
<option value="sirenRise">Sirena subida</option>
<option value="rapidPulse">Pulso rápido</option>
<option value="bassKnock">Golpe grave</option>
<option value="highFlash">Destello agudo</option>
<option value="longAlarm">Alarma larga</option>
<option value="silent">Sin sonido</option>
</select>
<button aria-label="Escuchar sonido de aviso 10 minutos" class="lp-drive-sound-preview" onclick="DriveSync.previewSound('warning')" title="Escuchar sonido" type="button">
<svg aria-hidden="true" fill="none" height="13" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="13" xmlns="http://www.w3.org/2000/svg"><polygon points="6 3 20 12 6 21 6 3"></polygon></svg>
</button>
</div>
</label>
<label class="lp-drive-sound-field">
<span>Crítico 5 min</span>
<div class="lp-drive-sound-control">
<select class="lp-drive-sound-select" id="drive-sound-critical">
<option value="clearBell">Campana clara</option>
<option value="softDouble">Doble suave</option>
<option value="brightPing">Ping brillante</option>
<option value="risingChime">Subida corta</option>
<option value="warmBell">Campana tibia</option>
<option value="softPulse">Pulso suave</option>
<option value="firmAlert">Alerta firme</option>
<option value="shortTone">Tono corto</option>
<option value="loudBell">Campana fuerte</option>
<option value="urgentTriple">Triple urgente</option>
<option value="digitalAlarm">Alarma digital</option>
<option value="sirenRise">Sirena subida</option>
<option value="rapidPulse">Pulso rápido</option>
<option value="bassKnock">Golpe grave</option>
<option value="highFlash">Destello agudo</option>
<option value="longAlarm">Alarma larga</option>
<option value="silent">Sin sonido</option>
</select>
<button aria-label="Escuchar sonido crítico de 5 minutos" class="lp-drive-sound-preview" onclick="DriveSync.previewSound('critical')" title="Escuchar sonido" type="button">
<svg aria-hidden="true" fill="none" height="13" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="13" xmlns="http://www.w3.org/2000/svg"><polygon points="6 3 20 12 6 21 6 3"></polygon></svg>
</button>
</div>
</label>
</div>
</div>
</div>
<div id="drive-pending-section" style="display:none;">
<div class="lp-pending-label">📥 Pendientes</div>
<div id="drive-pending-list">
<div id="drive-no-pending">Esperando archivos nuevos...</div>
</div>
</div>
<div id="drive-sync-toast" style="display:none;"></div>
</div>
<!-- PICKER + TEXTO CARD -->
<div class="lp-picker-card is-collapsed">
<div id="dropzone" style="display:none;">
<input accept=".txt" id="fileInput" multiple="" type="file"/>
</div>
<div class="lp-collapsible-head">
<div class="lp-section-label">Usuario / Picker</div>
<button aria-expanded="false" aria-label="Expandir bloque de etiquetas" class="lp-collapse-btn" id="pickerCardToggleBtn" onclick="togglePickerCard()" type="button">
<svg aria-hidden="true" fill="none" height="13" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2.2" viewbox="0 0 24 24" width="13" xmlns="http://www.w3.org/2000/svg"><polyline points="6 9 12 15 18 9"></polyline></svg>
</button>
</div>
<div class="lp-picker-body" id="pickerCardBody">
<div class="input-group">
<div class="form-control">
<div class="picker-select-row">
<select id="picker" required="">
<option disabled="" selected="" value="">Seleccione una opcion...</option>
<option value="bestay">bestay</option>
<option value="eagudelo">eagudelo</option>
<option value="kmendoza">kmendoza</option>
<option value="ovasquez">ovasquez</option>
<option value="ptapia">ptapia</option>
<option value="sperez">sperez</option>
</select>
<button aria-label="Administrar usuarios" class="btn btn-secondary picker-manage-btn" id="manageUsersBtn" title="Administrar usuarios" type="button">+</button>
</div>
<span class="picker-meta" id="pickerMeta">6 usuario(s) disponible(s)</span>
<div class="picker-manager" hidden="" id="pickerManager">
<div class="picker-manager-header">
<div>
<strong>Administrar usuarios</strong>
<span>Agrega nuevos usuarios o elimina los que ya no necesitas.</span>
</div>
<span class="picker-manager-count" id="pickerManagerCount">6</span>
</div>
<div class="picker-manager-top">
<input id="newPickerInput" placeholder="Escribe un usuario" type="text"/>
<button class="btn picker-add-btn" id="addPickerBtn" type="button">Agregar</button>
</div>
<div class="picker-manager-note">Debe quedar al menos un usuario disponible.</div>
<div class="picker-list-wrap">
<div class="picker-list-head">
<span>Usuarios disponibles</span>
<span class="picker-list-total" id="pickerListTotal">6</span>
</div>
<div class="picker-list" id="pickerList"></div>
</div>
</div>
</div>
</div>
<hr class="lp-divider"/>
<div class="lp-text-subheader">
<div class="lp-section-label" style="margin-bottom:0;">Ingresar Etiquetas</div>
<label class="lp-file-label" for="fileInput" title="Cargar archivo .txt">
<svg fill="none" height="14" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="3" viewbox="0 0 24 24" width="14" xmlns="http://www.w3.org/2000/svg"><line x1="12" x2="12" y1="5" y2="19"></line><line x1="5" x2="19" y1="12" y2="12"></line></svg>
</label>
</div>
<textarea id="textInput" placeholder="Pega aqui el contenido de la etiqueta..."></textarea>
<p id="storageSummary" style="display:none!important;">El historial funciona entre las 07:00 y las 18:00.</p>
<div class="lp-text-actions">
<button class="btn btn-compact" id="processTextBtn">
<svg fill="none" height="16" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="16" xmlns="http://www.w3.org/2000/svg"><polyline points="9 11 12 14 22 4"></polyline><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path></svg>
                            Procesar Texto
                        </button>
<button class="btn btn-secondary is-hidden" id="clearBtn">
<svg fill="none" height="16" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="16" xmlns="http://www.w3.org/2000/svg"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
                            Limpiar Datos
                        </button>
</div>
</div>
</div>
<!-- HISTORIAL CARD -->
<div class="lp-tabs-card lp-history-card">
<div class="lp-history-head">
<div class="lp-history-title">Actividad</div>
<div class="lp-history-caption">Historial local</div>
</div>
<div class="lp-tab-panel lp-tab-panel--active" id="lp-panel-historial">
<div class="lp-history-status">
<div class="lp-history-status-label">Estado</div>
<div class="storage-note" id="storageNote">Los archivos procesados se almacenan dentro de la franja operativa.</div>
</div>
<div class="history-list" id="historyList">
<div class="history-empty">Aun no hay documentos guardados en este navegador.</div>
</div>
<button class="btn btn-secondary btn-small" id="savePortableBtn" type="button">Guardar HTML portable</button>
</div>
<div class="lp-tab-panel" hidden="" id="lp-panel-procesados">
<div id="drive-processed-section" style="display:none;">
<div class="lp-proc-label">Procesados hoy</div>
<div id="drive-processed-list"></div>
</div>
<div class="lp-procesados-empty" id="lp-proc-empty">Aun no hay archivos procesados hoy.</div>
</div>
</div>
<script>
                function togglePickerCard() {
                    var card = document.querySelector('.lp-picker-card');
                    var btn = document.getElementById('pickerCardToggleBtn');
                    if (!card || !btn) return;
                    var collapsed = card.classList.toggle('is-collapsed');
                    btn.setAttribute('aria-expanded', String(!collapsed));
                    btn.setAttribute('aria-label', collapsed ? 'Expandir bloque de etiquetas' : 'Retraer bloque de etiquetas');
                }

                function lpSwitchTab(name) {
                    document.getElementById('lp-panel-historial')?.classList.add('lp-tab-panel--active');
                    document.getElementById('lp-panel-procesados')?.classList.remove('lp-tab-panel--active');
                }
                (function(){
                    function sync(){
                        var list=document.getElementById('drive-processed-list');
                        var sec=document.getElementById('drive-processed-section');
                        var empty=document.getElementById('lp-proc-empty');
                        var badge=document.getElementById('lp-proc-badge');
                        if(!list)return;
                        var n=list.querySelectorAll('.ds-proc-row').length;
                        if(sec)sec.style.display=n>0?'block':'none';
                        if(empty)empty.style.display=n>0?'none':'block';
                        if(badge)badge.textContent=n>0?n:'';
                    }
                    document.addEventListener('DOMContentLoaded',function(){
                        var list=document.getElementById('drive-processed-list');
                        if(!list)return;
                        new MutationObserver(sync).observe(list,{childList:true});
                        sync();
                    });
                }());
                </script>
</div>
<div class="panel panel-main" data-results-state="idle" id="results">
<div class="results-shell">
<div class="stats">
<button aria-pressed="false" class="stat-item stat-item--flex stat-item--split" data-row-type-filter="flex" id="flexStatBtn" title="Mostrar solo pedidos FLEX" type="button">
<span aria-hidden="true" class="stat-icon stat-icon--asset">
<img alt="" draggable="false" src="assets/icons/flex.svg?v=option1-line"/>
</span>
<span class="stat-copy"><span class="stat-value" id="countFlex">0</span><span class="stat-label">Bultos Flex</span><small>Ver detalle</small></span>
<span aria-label="Pedidos Flex sin estado y cancelados" class="stat-status-split">
<span class="stat-status-chip"><strong id="countFlexNd">0</strong><span>N/D</span></span>
<span class="stat-status-chip is-cancelled"><strong id="countFlexCancelled">0</strong><span>Cancel.</span></span>
</span>
</button>
<button aria-pressed="false" class="stat-item stat-item--colecta stat-item--split" data-row-type-filter="colecta" id="colectaStatBtn" title="Mostrar solo pedidos COLECTA" type="button">
<span aria-hidden="true" class="stat-icon stat-icon--asset">
<img alt="" draggable="false" src="assets/icons/colecta.svg?v=option1-line"/>
</span>
<span class="stat-copy"><span class="stat-value" id="countColecta">0</span><span class="stat-label">Bultos Colecta</span><small>Ver detalle</small></span>
<span aria-label="Pedidos Colecta sin estado y cancelados" class="stat-status-split">
<span class="stat-status-chip"><strong id="countColectaNd">0</strong><span>N/D</span></span>
<span class="stat-status-chip is-cancelled"><strong id="countColectaCancelled">0</strong><span>Cancel.</span></span>
</span>
</button>
<button aria-pressed="false" class="stat-item stat-item--carrier stat-item--bluexpress" data-label-source="bluexpress" id="bluexpressStatBtn" title="Ver etiquetas PDF Bluexpress" type="button">
<span aria-hidden="true" class="stat-icon stat-icon--asset">
<img alt="" draggable="false" src="assets/icons/bluexpress.svg?v=option1-line"/>
</span>
<span class="stat-copy"><span class="stat-value" id="countBluexpress">0</span><span class="stat-label">Bluexpress</span><small>Ver detalle</small></span>
</button>
<button aria-pressed="false" class="stat-item stat-item--carrier stat-item--walmart" data-label-source="walmart" id="walmartStatBtn" title="Ver etiquetas PDF Walmart" type="button">
<span aria-hidden="true" class="stat-icon stat-icon--asset">
<img alt="" draggable="false" src="assets/icons/walmart.svg?v=option1-line"/>
</span>
<span class="stat-copy"><span class="stat-value" id="countWalmart">0</span><span class="stat-label">Walmart</span><small>Ver detalle</small></span>
</button>
<button aria-pressed="true" class="stat-item stat-item--total" data-row-type-filter="all" id="totalStatBtn" title="Mostrar todos los pedidos" type="button">
<span aria-hidden="true" class="stat-icon stat-icon--asset">
<img alt="" draggable="false" src="assets/icons/total.svg?v=option1-line"/>
</span>
<span class="stat-copy"><span class="stat-value" id="countTotal">0</span><span class="stat-label">Total Extraido</span><small>Ver detalle</small></span>
</button>
</div>
<div class="results-toolbar">
<div class="results-search-group">
<input class="search-input" id="searchInput" placeholder="Buscar pedido en carga actual o historial..." type="text"/>
<div class="results-history-actions">
<button class="results-history-btn" id="showStoredBtn" title="Mostrar todo" type="button">Mostrar todo</button>
<button class="results-history-btn" id="clearStoredBtn" title="Limpiar historial" type="button">Limpiar</button>
</div>
<button class="results-cancel-btn" disabled="" id="cancelOrderBtn" title="Marcar seleccionados como pedido cancelado" type="button">
                                Pedido cancelado
                            </button>
<button aria-expanded="false" class="results-advanced-btn" id="advancedFiltersBtn" title="Subir archivo Excel de estados" type="button">
<svg aria-hidden="true" fill="none" height="15" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="15" xmlns="http://www.w3.org/2000/svg"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="17 8 12 3 7 8"></polyline><line x1="12" x2="12" y1="3" y2="15"></line></svg>
                                Subir Excel
                            </button>
</div>
<div class="selection-hint" id="selectedInfo"></div>
</div>
<div class="results-lookup-slot" hidden="" id="resultsLookupSlot"></div>
<div class="results-meta" id="resultsMeta"></div>
<div class="table-container">
<table id="dataTable">
<thead>
<tr>
<th>Sel.</th>
<th>Proceso</th>
<th>Numero</th>
<th>Picker</th>
<th>Picking</th>
<th>Revision</th>
<th>Guardado</th>
<th>
<select aria-label="Filtrar estado de pedidos" class="table-status-filter" id="mainStatusFilter">
<option value="">Estado</option>
</select>
</th>
</tr>
</thead>
<tbody>
<!-- Data will be populated here -->
</tbody>
</table>
</div>
<div aria-live="polite" class="carrier-labels-panel is-hidden" id="carrierLabelsPanel">
<div class="carrier-labels-head">
<div>
<strong id="carrierLabelsTitle">Etiquetas PDF</strong>
<span id="carrierLabelsSummary">Conecta Drive para revisar archivos PDF.</span>
</div>
<button class="carrier-refresh-btn" id="carrierLabelsRefreshBtn" title="Actualizar etiquetas PDF" type="button">Actualizar</button>
</div>
<div class="carrier-labels-table-wrap">
<table class="carrier-labels-table">
<thead>
<tr>
<th>Archivo</th>
<th>Carpeta</th>
<th>Subido</th>
<th>Impresion</th>
<th>Accion</th>
</tr>
</thead>
<tbody id="carrierLabelsBody">
<tr>
<td class="carrier-empty" colspan="5">Sin archivos PDF para mostrar.</td>
</tr>
</tbody>
</table>
</div>
</div>
<div class="results-actions">
<button class="btn" id="downloadBtn">
<svg fill="none" height="20" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="20" xmlns="http://www.w3.org/2000/svg"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" x2="12" y1="15" y2="3"></line></svg>
                            Descargar CSV
                        </button>
<label class="zebra-printer-control" for="zebraPrinterSelect">
<span>Zebra</span>
<select id="zebraPrinterSelect" title="Seleccionar impresora Zebra">
<option value="default">Predeterminada</option>
<option value="zebra02">ZEBRA 02</option>
<option value="zebra05">ZEBRA 05</option>
</select>
</label>
<button class="btn btn-zebra" id="printZebraBtn">
<svg fill="none" height="20" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="20" xmlns="http://www.w3.org/2000/svg"><polyline points="6 9 6 2 18 2 18 9"></polyline><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path><rect height="8" width="12" x="6" y="14"></rect></svg>
                            Imprimir en Zebra
                        </button>
</div>
</div>
</div>
<section aria-labelledby="orderLookupTitle" class="panel panel-right order-lookup-card">
<!-- Header -->
<div class="order-lookup-head">
<div style="display:flex;align-items:center;gap:10px;">
<div aria-hidden="true" class="ol-head-icon">
<svg fill="none" height="17" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="17" xmlns="http://www.w3.org/2000/svg"><path d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2"></path><rect height="4" rx="2" width="6" x="9" y="3"></rect><line x1="9" x2="15" y1="12" y2="12"></line><line x1="9" x2="13" y1="16" y2="16"></line></svg>
</div>
<div class="order-lookup-head-copy">
<h3 id="orderLookupTitle">Consulta de pedidos</h3>
<p class="ol-head-subtitle">Estado en tiempo real</p>
</div>
</div>
<span class="order-lookup-channel">Mercado Libre</span>
</div>
<!-- Stats -->
<div class="ol-stats">
<div class="ol-stat">
<div class="ol-stat-num" id="olStatTotal"></div>
<div class="ol-stat-label">Total</div>
</div>
<div class="ol-stat">
<div class="ol-stat-num ol-stat-num--success" id="olStatWithState"></div>
<div class="ol-stat-label">Con estado</div>
</div>
<div class="ol-stat">
<div class="ol-stat-num ol-stat-num--warning" id="olStatND"></div>
<div class="ol-stat-label">Sin estado</div>
</div>
</div>
<div class="order-lookup-controls">
<!-- Archivo Excel -->
<div class="ol-controls-section">
<p class="ol-section-label">Archivo Excel</p>
<div class="order-lookup-upload-row">
<button class="btn btn-secondary" id="orderLookupLoadBtn" type="button">
<svg aria-hidden="true" fill="none" height="13" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="13" xmlns="http://www.w3.org/2000/svg"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="17 8 12 3 7 8"></polyline><line x1="12" x2="12" y1="3" y2="15"></line></svg>
                                Cargar Excel
                            </button>
<div aria-live="polite" class="order-lookup-file" id="orderLookupFileName">No hay archivo Excel cargado.</div>
<input accept=".xlsx" id="orderLookupFileInput" type="file"/>
</div>
</div>
<div class="ol-controls-section">
<div class="order-lookup-filter-row">
<!-- Búsqueda por pedido -->
<label class="order-lookup-search-field" for="orderLookupInput">
<span>Pedido</span>
<div class="ol-search-wrapper">
<svg aria-hidden="true" class="ol-search-icon" fill="none" height="14" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewbox="0 0 24 24" width="14" xmlns="http://www.w3.org/2000/svg"><circle cx="11" cy="11" r="8"></circle><line x1="21" x2="16.65" y1="21" y2="16.65"></line></svg>
<input class="order-lookup-search-input" id="orderLookupInput" placeholder="Buscar por número de pedido" type="text"/>
</div>
</label>
<!-- Estado y Ruta -->
<div class="ol-filters-row">
<label class="order-lookup-filter-field" for="orderLookupStateFilter">
<span>Estado</span>
<select id="orderLookupStateFilter">
<option value="">Todos los estados</option>
</select>
</label>
<label class="order-lookup-filter-field" for="orderLookupRouteFilter">
<span>Ruta</span>
<select id="orderLookupRouteFilter">
<option value="">Todas las rutas</option>
</select>
</label>
</div>
<!-- Acciones -->
<div class="order-lookup-actions">
<button class="btn ol-btn-filter" id="orderLookupSearchBtn" type="button">
<svg aria-hidden="true" fill="none" height="14" stroke="currentColor" stroke-width="2" viewbox="0 0 24 24" width="14" xmlns="http://www.w3.org/2000/svg"><line x1="4" x2="20" y1="6" y2="6"></line><line x1="8" x2="16" y1="12" y2="12"></line><line x1="11" x2="13" y1="18" y2="18"></line></svg>
                                Filtrar
                            </button>
<button class="btn btn-secondary" id="orderLookupClearFiltersBtn" type="button">Limpiar</button>
</div>
</div>
</div>
</div>
<div class="order-lookup-output">
<div class="order-lookup-summary is-empty" id="orderLookupSummary">
<strong>Sin resultados</strong>
<span>Carga un archivo Excel para ver solo pedidos de Mercado Libre y filtrarlos por estado, ruta o numero.</span>
</div>
<div class="order-lookup-table-wrap is-hidden" id="orderLookupTableWrap">
<table class="order-lookup-table">
<thead id="orderLookupTableHead">
<tr>
<th>DATO2</th>
<th>ESTADO</th>
<th>RUTAS</th>
</tr>
</thead>
<tbody id="orderLookupTableBody">
<tr>
<td class="order-lookup-empty-row" colspan="3">No hay coincidencias para mostrar.</td>
</tr>
</tbody>
</table>
</div>
</div>
</section>
</div>
<script>
    (function(){
        function setupDashboardLookup(){
            var slot = document.getElementById('resultsLookupSlot');
            var lookup = document.querySelector('.panel-right.order-lookup-card');
            var toggle = document.getElementById('advancedFiltersBtn');
            if (!slot || !lookup || !toggle) return;
            slot.appendChild(lookup);
            lookup.classList.add('dashboard-lookup-card');
            slot.hidden = true;
            toggle.setAttribute('aria-expanded', 'false');
            toggle.addEventListener('click', function(){
                var input = document.getElementById('orderLookupFileInput');
                if (input) input.click();
            });
        }
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', setupDashboardLookup);
        } else {
            setupDashboardLookup();
        }
    }());
    </script>
<script id="embeddedHistoryData" type="application/json">{"version":2,"documents":[]}</script>
<script src="vendor/xlsx.full.min.js"></script>
<link href="order-lookup.css" rel="stylesheet"/>
<style data-dark-mode-fixes="">
body.is-dark-mode {
  --bg-color: #070B14;
  --panel-bg: #0D1626;
  --surface: #0F1A2A;
  --surface-base: #101A2C;
  --surface-soft: #172A41;
  --border: rgba(148, 163, 184, 0.26);
  --text: #F1F7FF;
  --text-muted: #B8C7DC;
}

body.is-dark-mode,
body.is-dark-mode .container {
  background: #070B14 !important;
  background-image: radial-gradient(circle at top center, rgba(21, 201, 120, 0.10), transparent 32%) !important;
  color: var(--text) !important;
}

body.is-dark-mode header,
body.is-dark-mode .panel-left,
body.is-dark-mode .panel-main,
body.is-dark-mode .results-shell,
body.is-dark-mode .results-toolbar,
body.is-dark-mode .results-lookup-slot,
body.is-dark-mode .results-meta,
body.is-dark-mode .table-container,
body.is-dark-mode .carrier-labels-panel,
body.is-dark-mode #drive-sync-panel,
body.is-dark-mode .lp-card,
body.is-dark-mode .lp-picker-card,
body.is-dark-mode .lp-tabs-card,
body.is-dark-mode .lp-history-card,
body.is-dark-mode .stat-item,
body.is-dark-mode .order-lookup-controls,
body.is-dark-mode .order-lookup-summary,
body.is-dark-mode .order-lookup-table-wrap,
body.is-dark-mode .app-notification-panel,
body.is-dark-mode .notification-head,
body.is-dark-mode .notification-summary,
body.is-dark-mode .notification-actions,
body.is-dark-mode .notification-item,
body.is-dark-mode .notification-summary-item,
body.is-dark-mode .zebra-printer-control {
  background: var(--surface-base) !important;
  border-color: var(--border) !important;
  color: var(--text) !important;
  box-shadow: none !important;
}

body.is-dark-mode .panel-left,
body.is-dark-mode .panel-left.panel {
  background: #0D1626 !important;
  border-right-color: var(--border) !important;
}

body.is-dark-mode .panel-main,
body.is-dark-mode .results-shell {
  background: #101A2C !important;
}

body.is-dark-mode .lp-drive-sound-popover,
body.is-dark-mode .panel-left .picker-manager:not([hidden]),
body.is-dark-mode .history-entry,
body.is-dark-mode .left-panel-top,
body.is-dark-mode .storage-card,
body.is-dark-mode .input-group,
body.is-dark-mode .method-card,
body.is-dark-mode .order-lookup-file,
body.is-dark-mode .dashboard-lookup-card .order-lookup-controls,
body.is-dark-mode .dashboard-lookup-card .order-lookup-summary,
body.is-dark-mode .carrier-labels-head {
  background: var(--surface-soft) !important;
  border-color: var(--border) !important;
  color: var(--text) !important;
}

body.is-dark-mode input,
body.is-dark-mode textarea,
body.is-dark-mode select,
body.is-dark-mode .search-input,
body.is-dark-mode .table-status-filter,
body.is-dark-mode .panel-left #picker,
body.is-dark-mode .panel-left #textInput,
body.is-dark-mode .order-lookup-search-input,
body.is-dark-mode .order-lookup-filter-field select,
body.is-dark-mode .lp-drive-sound-select,
body.is-dark-mode .zebra-printer-control select {
  background: #0A1220 !important;
  border-color: var(--border) !important;
  color: var(--text) !important;
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.04) !important;
}

body.is-dark-mode input::placeholder,
body.is-dark-mode textarea::placeholder {
  color: #8FA4BE !important;
}

body.is-dark-mode .app-theme-toggle-btn,
body.is-dark-mode .app-bell-btn,
body.is-dark-mode .notification-close-btn,
body.is-dark-mode .notification-action-btn:not(.is-primary),
body.is-dark-mode .results-advanced-btn,
body.is-dark-mode .lp-collapse-btn,
body.is-dark-mode .lp-drive-sound-preview,
body.is-dark-mode #drive-sound-menu-btn,
body.is-dark-mode #pickerCardToggleBtn {
  background: #13233B !important;
  border-color: rgba(148, 163, 184, 0.30) !important;
  color: #DCEBFF !important;
}

body.is-dark-mode .lp-tabs,
body.is-dark-mode .lp-drive-modes,
body.is-dark-mode #drive-day-status {
  background: rgba(7, 11, 20, 0.58) !important;
  border-color: var(--border) !important;
}

body.is-dark-mode .lp-tab.lp-tab--active,
body.is-dark-mode .lp-tab.is-active,
body.is-dark-mode .lp-drive-mode.is-active {
  background: rgba(21, 201, 120, 0.18) !important;
  color: #CFFFE7 !important;
}

body.is-dark-mode .lp-tab-badge,
body.is-dark-mode .order-lookup-badge.is-flex,
body.is-dark-mode .order-lookup-badge.is-colecta,
body.is-dark-mode .order-lookup-badge.is-unknown,
body.is-dark-mode .ol-chip,
body.is-dark-mode .row-status-badge,
body.is-dark-mode .carrier-print-status {
  background: rgba(148, 163, 184, 0.16) !important;
  border-color: rgba(148, 163, 184, 0.22) !important;
  color: #DCEBFF !important;
}

body.is-dark-mode .order-lookup-channel,
body.is-dark-mode .ol-chip--warning,
body.is-dark-mode .row-status-badge.is-progress,
body.is-dark-mode .carrier-print-status.is-pending {
  background: rgba(245, 158, 11, 0.18) !important;
  color: #FCD34D !important;
}

body.is-dark-mode .ol-chip--success,
body.is-dark-mode .row-status-badge.is-complete,
body.is-dark-mode .carrier-print-status.is-printed {
  background: rgba(22, 163, 74, 0.20) !important;
  color: #86EFAC !important;
}

body.is-dark-mode .order-lookup-state {
  background: rgba(22, 163, 74, 0.20) !important;
  color: #86EFAC !important;
}

body.is-dark-mode .order-lookup-state.is-nd,
body.is-dark-mode .order-lookup-state.is-empty {
  background: rgba(245, 158, 11, 0.18) !important;
  color: #FCD34D !important;
}

body.is-dark-mode .row-status-badge.is-cancelled,
body.is-dark-mode .results-cancel-btn {
  background: rgba(244, 63, 94, 0.16) !important;
  border-color: rgba(251, 113, 133, 0.34) !important;
  color: #FDA4AF !important;
}

body.is-dark-mode .order-lookup-state.is-cancelled {
  background: rgba(244, 63, 94, 0.16) !important;
  color: #FDA4AF !important;
}

body.is-dark-mode .btn,
body.is-dark-mode .results-history-btn,
body.is-dark-mode .results-advanced-btn,
body.is-dark-mode .results-cancel-btn,
body.is-dark-mode .notification-action-btn,
body.is-dark-mode .lp-drive-mode,
body.is-dark-mode .lp-collapse-btn,
body.is-dark-mode .lp-drive-sound-preview,
body.is-dark-mode #drive-sound-menu-btn,
body.is-dark-mode #pickerCardToggleBtn,
body.is-dark-mode .app-theme-toggle-btn,
body.is-dark-mode .app-bell-btn {
  box-shadow: 0 8px 18px rgba(0, 0, 0, 0.22), inset 0 1px 0 rgba(255, 255, 255, 0.08) !important;
}

body.is-dark-mode #drive-sync-btn,
body.is-dark-mode #showStoredBtn,
body.is-dark-mode #downloadBtn,
body.is-dark-mode #processTextBtn,
body.is-dark-mode .notification-action-btn.is-primary,
body.is-dark-mode .ol-btn-filter {
  background: linear-gradient(180deg, #22E083 0%, #10B981 100%) !important;
  border-color: #34F39A !important;
  color: #FFFFFF !important;
}

body.is-dark-mode #orderLookupLoadBtn,
body.is-dark-mode #orderLookupClearFiltersBtn,
body.is-dark-mode .results-advanced-btn,
body.is-dark-mode .notification-action-btn:not(.is-primary),
body.is-dark-mode .btn-secondary,
body.is-dark-mode .lp-collapse-btn,
body.is-dark-mode .lp-drive-sound-preview,
body.is-dark-mode #drive-sound-menu-btn,
body.is-dark-mode #pickerCardToggleBtn,
body.is-dark-mode .app-theme-toggle-btn,
body.is-dark-mode .app-bell-btn {
  background: linear-gradient(180deg, #274568 0%, #1B3352 100%) !important;
  border-color: #4F7CB8 !important;
  color: #EEF6FF !important;
}

body.is-dark-mode #printZebraBtn {
  background: linear-gradient(180deg, #334155 0%, #1E293B 100%) !important;
  border-color: #64748B !important;
  color: #FFFFFF !important;
}

body.is-dark-mode .results-cancel-btn {
  background: linear-gradient(180deg, rgba(244, 63, 94, 0.34) 0%, rgba(190, 18, 60, 0.28) 100%) !important;
  border-color: rgba(251, 113, 133, 0.62) !important;
  color: #FFE4E6 !important;
}

body.is-dark-mode .results-cancel-btn:disabled {
  opacity: 0.72 !important;
  filter: saturate(1.15) !important;
}

body.is-dark-mode .lp-drive-modes {
  background: rgba(7, 11, 20, 0.56) !important;
  border-color: rgba(148, 163, 184, 0.22) !important;
}

body.is-dark-mode #drive-mode-auto,
body.is-dark-mode #drive-mode-manual,
body.is-dark-mode #drive-mode-manual:not(.is-active),
body.is-dark-mode #drive-mode-auto:not(.is-active) {
  background: transparent !important;
  color: #9FB0C4 !important;
  border-color: transparent !important;
  box-shadow: none !important;
}

body.is-dark-mode #drive-mode-auto.is-active,
body.is-dark-mode .lp-drive-mode.is-active,
body.is-dark-mode #drive-mode-manual.is-active {
  background: #142238 !important;
  border-color: transparent !important;
  color: #7EF2B4 !important;
  box-shadow: inset 0 0 0 1px rgba(148, 163, 184, 0.18), 0 1px 6px rgba(0, 0, 0, 0.16) !important;
}

body.is-dark-mode #drive-mode-manual.is-active {
  color: #93C5FD !important;
}

body.is-dark-mode #drive-mode-auto:hover:not(.is-active),
body.is-dark-mode #drive-mode-manual:hover:not(.is-active) {
  background: rgba(148, 163, 184, 0.10) !important;
  color: #DCEBFF !important;
}

body.is-dark-mode .btn:hover:not(:disabled),
body.is-dark-mode .results-advanced-btn:hover:not(:disabled),
body.is-dark-mode .notification-action-btn:hover:not(:disabled),
body.is-dark-mode #orderLookupLoadBtn:hover:not(:disabled),
body.is-dark-mode #orderLookupClearFiltersBtn:hover:not(:disabled) {
  filter: brightness(1.12) saturate(1.08) !important;
  transform: none !important;
}

body.is-dark-mode .stat-item.is-active,
body.is-dark-mode .stat-item:hover,
body.is-dark-mode .stat-item--total {
  background: linear-gradient(135deg, rgba(21, 201, 120, 0.18), rgba(34, 197, 94, 0.08)) !important;
  border-color: rgba(21, 201, 120, 0.42) !important;
}

body.is-dark-mode .stat-icon,
body.is-dark-mode .stat-icon--asset,
body.is-dark-mode .stat-item--colecta .stat-icon--asset,
body.is-dark-mode .stat-item--bluexpress .stat-icon--asset,
body.is-dark-mode .stat-item--walmart .stat-icon--asset,
body.is-dark-mode .stat-item--total .stat-icon--asset {
  background: #0A1220 !important;
  border-color: var(--border) !important;
}

body.is-dark-mode .stat-status-split {
  border-left-color: rgba(148, 163, 184, 0.18) !important;
}

body.is-dark-mode .stat-status-chip {
  background: rgba(148, 163, 184, 0.12) !important;
  border-color: rgba(148, 163, 184, 0.16) !important;
}

body.is-dark-mode .stat-status-chip strong {
  color: #F1F7FF !important;
}

body.is-dark-mode .stat-status-chip span {
  color: #B8C7DC !important;
}

body.is-dark-mode .stat-status-chip.is-cancelled {
  background: rgba(244, 63, 94, 0.16) !important;
  border-color: rgba(251, 113, 133, 0.30) !important;
}

body.is-dark-mode .stat-status-chip.is-cancelled strong,
body.is-dark-mode .stat-status-chip.is-cancelled span {
  color: #FDA4AF !important;
}

body.is-dark-mode #dataTable th,
body.is-dark-mode .carrier-labels-table th,
body.is-dark-mode .order-lookup-table th,
body.is-dark-mode .order-lookup-table thead tr {
  background: #162238 !important;
  color: #DBEAFE !important;
  border-color: var(--border) !important;
}

body.is-dark-mode #dataTable td,
body.is-dark-mode .carrier-labels-table td,
body.is-dark-mode .order-lookup-table td,
body.is-dark-mode .order-lookup-table tr.is-nd,
body.is-dark-mode .order-lookup-table tr.is-nd td,
body.is-dark-mode .order-lookup-table tr.is-cancelled,
body.is-dark-mode .order-lookup-table tr.is-cancelled td {
  background: #0F1A2A !important;
  color: var(--text) !important;
  border-color: rgba(148, 163, 184, 0.16) !important;
}

body.is-dark-mode .order-lookup-table tr.is-cancelled,
body.is-dark-mode .order-lookup-table tr.is-cancelled td {
  background: rgba(244, 63, 94, 0.10) !important;
  color: #FDA4AF !important;
}

body.is-dark-mode .app-message,
body.is-dark-mode .app-message.is-info,
body.is-dark-mode .app-message.is-success,
body.is-dark-mode .app-message.is-warning,
body.is-dark-mode .app-message.is-error {
  background: #13233B !important;
  border-color: var(--border) !important;
  color: var(--text) !important;
}

body.is-dark-mode .app-message-title,
body.is-dark-mode .notification-item strong,
body.is-dark-mode .notification-head strong,
body.is-dark-mode .stat-value,
body.is-dark-mode .stat-label,
body.is-dark-mode .order-lookup-summary strong,
body.is-dark-mode .lp-history-title {
  color: var(--text) !important;
}

body.is-dark-mode .notification-item span,
body.is-dark-mode .notification-head span,
body.is-dark-mode .selection-hint,
body.is-dark-mode .results-meta,
body.is-dark-mode .storage-note,
body.is-dark-mode .history-empty,
body.is-dark-mode .lp-history-caption,
body.is-dark-mode .order-lookup-summary span,
body.is-dark-mode .order-lookup-file,
body.is-dark-mode .ol-section-label,
body.is-dark-mode .order-lookup-search-field span,
body.is-dark-mode .order-lookup-filter-field span {
  color: var(--text-muted) !important;
}

/* Toasts legibles y fuera de los controles inferiores */
.message-stack {
  top: 82px !important;
  right: 18px !important;
  bottom: auto !important;
  left: auto !important;
  width: min(430px, calc(100vw - 36px)) !important;
  gap: 10px !important;
  z-index: 9000 !important;
}

.app-message {
  grid-template-columns: minmax(0, 1fr) 30px !important;
  gap: 10px !important;
  align-items: start !important;
  padding: 12px 12px 12px 14px !important;
  border-radius: 10px !important;
  background: #FFFFFF !important;
  border-color: rgba(15, 23, 42, 0.12) !important;
  color: #17301F !important;
  box-shadow: 0 18px 42px rgba(15, 23, 42, 0.20) !important;
  backdrop-filter: none !important;
  -webkit-user-select: none !important;
  user-select: none !important;
}

.app-message.is-info {
  background: #EFF6FF !important;
  border-color: rgba(37, 99, 235, 0.22) !important;
  color: #1E3A8A !important;
}

.app-message.is-success {
  background: #ECFDF3 !important;
  border-color: rgba(16, 185, 129, 0.30) !important;
  color: #065F46 !important;
}

.app-message.is-warning {
  background: #FFFBEB !important;
  border-color: rgba(245, 158, 11, 0.34) !important;
  color: #78350F !important;
}

.app-message.is-error {
  background: #FFF1F2 !important;
  border-color: rgba(225, 29, 72, 0.32) !important;
  color: #7F1D1D !important;
}

.app-message-content {
  min-width: 0 !important;
  gap: 4px !important;
}

.app-message-content strong,
.app-message-title {
  color: inherit !important;
  font-size: 12px !important;
  font-weight: 900 !important;
  line-height: 1.2 !important;
}

.app-message-text {
  color: inherit !important;
  font-size: 12px !important;
  font-weight: 700 !important;
  line-height: 1.38 !important;
}

.app-message-close {
  display: inline-grid !important;
  place-items: center !important;
  width: 28px !important;
  height: 28px !important;
  border-radius: 999px !important;
  border: 1px solid rgba(15, 23, 42, 0.12) !important;
  background: rgba(255, 255, 255, 0.76) !important;
  color: currentColor !important;
  font-size: 16px !important;
  font-weight: 800 !important;
  line-height: 1 !important;
  opacity: 0.72 !important;
}

.app-message-close:hover {
  background: #FFFFFF !important;
  opacity: 1 !important;
  transform: translateY(-1px) !important;
}

body.is-dark-mode .app-message {
  background: #101A2C !important;
  border-color: rgba(148, 163, 184, 0.24) !important;
  color: #F1F7FF !important;
  box-shadow: 0 18px 42px rgba(0, 0, 0, 0.44) !important;
}

body.is-dark-mode .app-message.is-info {
  background: #10213C !important;
  border-color: rgba(96, 165, 250, 0.34) !important;
  color: #DBEAFE !important;
}

body.is-dark-mode .app-message.is-success {
  background: #0D2A22 !important;
  border-color: rgba(52, 211, 153, 0.34) !important;
  color: #D1FAE5 !important;
}

body.is-dark-mode .app-message.is-warning {
  background: #2B220D !important;
  border-color: rgba(251, 191, 36, 0.34) !important;
  color: #FEF3C7 !important;
}

body.is-dark-mode .app-message.is-error {
  background: #2A1018 !important;
  border-color: rgba(251, 113, 133, 0.42) !important;
  color: #FFE4E6 !important;
}

body.is-dark-mode .app-message-close {
  background: rgba(15, 23, 42, 0.58) !important;
  border-color: rgba(226, 232, 240, 0.18) !important;
}

body.is-dark-mode .app-message-close:hover {
  background: rgba(30, 41, 59, 0.95) !important;
}

@media (max-width: 700px) {
  .message-stack {
    top: 74px !important;
    right: 12px !important;
    left: 12px !important;
    width: auto !important;
  }
}
</style>
<script data-app-script="" defer="" src="app.js"></script>
<script defer="" src="drive-sync.js"></script>
</div></body>
</html>
