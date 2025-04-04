#!/bin/bash
source ../utils/checks.sh
source ../utils/logging.sh

log "Inizio hardening kernel"

# 1. Configurazione sysctl
echo "Applicazione parametri kernel sicuri:"
cp ../configs/sysctl_secure.conf /etc/sysctl.d/99-hardening.conf
sysctl -p /etc/sysctl.d/99-hardening.conf

# 2. ASLR
echo "Configurazione ASLR:"
echo 2 > /proc/sys/kernel/randomize_va_space

# 3. Disabilitazione core dump
echo "Disabilitazione core dump:"
echo "* hard core 0" >> /etc/security/limits.conf
ulimit -c 0

# 4. Kernel modules hardening
echo "Disabilitazione moduli kernel non necessari:"
for module in cramfs freevxfs jffs2 hfs hfsplus squashfs udf; do
    echo "install $module /bin/true" >> /etc/modprobe.d/disable_filesystems.conf
done

echo "blacklist usb-storage" >> /etc/modprobe.d/disable_usb_storage.conf

log "Hardening kernel completato"