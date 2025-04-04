#!/bin/bash
# Funzioni di logging

LOG_FILE="../logs/hardening_$(date +%Y%m%d).log"

log() {
    local message=$1
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $message" >> "$LOG_FILE"
    logger -t "AGID-Hardening" "$message"
}

log_success() {
    log "SUCCESS: $1"
    echo "✔️ $1"
}

log_error() {
    log "ERROR: $1"
    echo "❌ $1" >&2
}