#!/bin/bash
source Progetto-di-Hardening-Automatizzato-basato-sulle-Linee-Guida-AGID/edit/main/hardening-agid/scripts/utils/checks.sh
source Progetto-di-Hardening-Automatizzato-basato-sulle-Linee-Guida-AGID/edit/main/hardening-agid/scripts/utils/logging.sh

log "Inizio hardening DNS"

# 1. Installazione DNSSEC
echo "Configurazione DNSSEC:"
apt install dnssec-tools -y

# 2. Configurazione BIND sicura
if [ -f /etc/bind/named.conf.options ]; then
    echo "Configurazione BIND sicura:"
    sed -i '/options {/a \
        dnssec-enable yes; \
        dnssec-validation yes; \
        allow-recursion { trusted; }; \
        allow-query-cache { trusted; }; \
        version "Not Available";' /etc/bind/named.conf.options
    systemctl restart bind9
fi

# 3. Disabilitazione DNS caching
echo "Disabilitazione DNS caching se non necessario:"
systemctl disable systemd-resolved 2>/dev/null

log "Hardening DNS completato"
