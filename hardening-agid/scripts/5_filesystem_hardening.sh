#!/bin/bash
source Progetto-di-Hardening-Automatizzato-basato-sulle-Linee-Guida-AGID/edit/main/hardening-agid/scripts/utils/checks.sh
source Progetto-di-Hardening-Automatizzato-basato-sulle-Linee-Guida-AGID/edit/main/hardening-agid/scripts/utils/logging.sh

log "Inizio hardening filesystem"

# 1. Permessi file di sistema
echo "Impostazione permessi file critici:"
chmod 644 /etc/passwd
chmod 600 /etc/shadow
chmod 600 /etc/gshadow
chmod 644 /etc/group
chmod 750 /etc/sudoers.d

# 2. Configurazione PATH sicuro
echo "Configurazione PATH sicuro:"
echo 'export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"' > /etc/profile.d/secure_path.sh

# 3. Configurazione mount options
echo "Configurazione opzioni mount:"
sed -i '/ \/ /s/defaults/defaults,nodev,nosuid/' /etc/fstab
sed -i '/ \/home /s/defaults/defaults,nodev,nosuid/' /etc/fstab
sed -i '/ \/tmp /s/defaults/defaults,nodev,nosuid,noexec/' /etc/fstab

# 4. Disabilitazione USB
echo "Disabilitazione dispositivi USB:"
echo "install usb-storage /bin/true" > /etc/modprobe.d/disable-usb-storage.conf

log "Hardening filesystem completato"
