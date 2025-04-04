#!/bin/bash
source ../utils/checks.sh
source ../utils/logging.sh

log "Inizio hardening BIOS e avvio"

# 1. Password BIOS (richiede accesso fisico/BIOS)
echo "Configura password BIOS manualmente seguendo:"
echo "1. Entrare nel BIOS (tipicamente Canc/F2 all'avvio)"
echo "2. Impostare password amministratore"
echo "3. Impostare password di avvio"
echo "4. Disabilitare avvio da dispositivi esterni"

# 2. Secure Boot
check_and_enable_secure_boot() {
    if [ -d /sys/firmware/efi ]; then
        echo "Abilitazione Secure Boot..."
        mokutil --enable-validation
    else
        echo "Sistema non UEFI, Secure Boot non disponibile"
    fi
}

# 3. Crittografia disco
setup_disk_encryption() {
    echo "Configurazione crittografia disco:"
    echo "Per Linux:"
    echo "1. cryptsetup luksFormat /dev/sdX"
    echo "2. cryptsetup open /dev/sdX cryptdisk"
    echo "3. Creare filesystem su /dev/mapper/cryptdisk"
    
    echo "Per Windows abilitare BitLocker"
}

check_and_enable_secure_boot
setup_disk_encryption

log "Hardening BIOS completato"