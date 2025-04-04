#!/bin/bash
source ../utils/checks.sh
source ../utils/logging.sh

log "Inizio hardening servizi"

# 1. Disabilitazione servizi non necessari
echo "Disabilitazione servizi non necessari:"
systemctl disable avahi-daemon
systemctl disable cups
systemctl disable isc-dhcp-server

# 2. Configurazione SSH
echo "Configurazione SSH sicura:"
cp ../configs/sshd_secure.conf /etc/ssh/sshd_config
systemctl restart sshd

# 3. Configurazione banner login
echo "Configurazione banner login:"
cp ../configs/login_banner.txt /etc/issue.net
echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config

# 4. Configurazione timeout sessione
echo "Configurazione timeout sessione:"
echo "TMOUT=900" >> /etc/profile
echo "readonly TMOUT" >> /etc/profile
echo "export TMOUT" >> /etc/profile

log "Hardening servizi completato"