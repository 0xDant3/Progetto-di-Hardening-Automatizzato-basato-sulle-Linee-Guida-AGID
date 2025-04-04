#!/bin/bash
# Funzioni di verifica

check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        log_error "Lo script deve essere eseguito come root"
        exit 1
    fi
}

check_os() {
    if [ ! -f /etc/os-release ]; then
        log_error "Sistema operativo non supportato"
        exit 1
    fi
    source /etc/os-release
    echo "ℹ️  Rilevato: $PRETTY_NAME"
}

check_dependencies() {
    local deps=("$@")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            log_error "Dipendenza mancante: $dep"
            exit 1
        fi
    done
}