#!/bin/bash
# Hardening Automatizzato AGID - Script Principale

VERSION="1.0.0"
CONFIG_DIR="./configs"
LOG_DIR="./logs"
mkdir -p "$LOG_DIR"

source ./scripts/utils/logging.sh
source ./scripts/utils/checks.sh

show_header() {
    clear
    echo "================================================"
    echo " HARDENING AUTOMATIZZATO AGID - v$VERSION"
    echo " Conforme alle Linee Guida AGID 5.2.2"
    echo "================================================"
    echo
}

show_menu() {
    echo "================ MENU PRINCIPALE ==============="
    echo " 1. Hardening BIOS e Avvio"
    echo " 2. Hardening Autenticazione"
    echo " 3. Hardening Kernel"
    echo " 4. Hardening Rete"
    echo " 5. Hardening Filesystem"
    echo " 6. Hardening Servizi"
    echo " 7. Hardening DNS"
    echo " 8. Configurazione Audit"
    echo " 9. Esegui TUTTO (Modalità Completa)"
    echo " 0. Esci"
    echo "================================================"
}

run_hardening() {
    local choice=$1
    case $choice in
        1) run_script "BIOS" "./scripts/1_bios_hardening.sh" ;;
        2) run_script "Autenticazione" "./scripts/2_auth_hardening.sh" ;;
        3) run_script "Kernel" "./scripts/3_kernel_hardening.sh" ;;
        4) run_script "Rete" "./scripts/4_network_hardening.sh" ;;
        5) run_script "Filesystem" "./scripts/5_filesystem_hardening.sh" ;;
        6) run_script "Servizi" "./scripts/6_services_hardening.sh" ;;
        7) run_script "DNS" "./scripts/7_dns_hardening.sh" ;;
        8) run_script "Audit" "./scripts/8_audit_hardening.sh" ;;
        9) run_full_hardening ;;
        0) exit 0 ;;
        *) echo "❌ Scelta non valida"; sleep 1 ;;
    esac
}

run_script() {
    local module=$1
    local script=$2
    
    log "Inizio hardening $module"
    echo "🛡️  Esecuzione: $module"
    if [ -f "$script" ]; then
        chmod +x "$script"
        sudo "$script"
        log "Hardening $module completato"
    else
        echo "❌ Script non trovato: $script"
        log "ERRORE: Script $module non trovato"
    fi
    echo "✔️  Completato: $module"
    sleep 1
}

run_full_hardening() {
    log "Inizio hardening completo"
    echo "🚀 Avvio hardening completo del sistema"
    
    for i in {1..8}; do
        run_hardening "$i"
    done
    
    log "Hardening completo terminato"
    echo "🎉 Hardening completo eseguito con successo!"
    echo "ℹ️  Si consiglia il riavvio del sistema"
}

# Main loop
while true; do
    show_header
    show_menu
    read -p "Seleziona un'opzione [0-9]: " choice
    run_hardening "$choice"
done
