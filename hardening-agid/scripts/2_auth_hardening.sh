#!/bin/bash
source /Progetto-di-Hardening-Automatizzato-basato-sulle-Linee-Guida-AGID/edit/main/hardening-agid/scripts/utils/checks.sh
source /Progetto-di-Hardening-Automatizzato-basato-sulle-Linee-Guida-AGID/edit/main/hardening-agid/scripts/utils/logging.sh

log "Inizio hardening autenticazione"

# 1. Politica password
echo "Configurazione politica password:"
echo "Installa libpam-pwquality:"
apt install libpam-pwquality -y

echo "Configura /etc/security/pwquality.conf:"
cat > /etc/security/pwquality.conf <<EOL
minlen = 12
minclass = 3
maxrepeat = 3
maxsequence = 4
EOL

echo "Configura /etc/pam.d/common-password:"
sed -i 's/pam_pwquality.so.*/pam_pwquality.so retry=3 minlen=12 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 enforce_for_root/' /etc/pam.d/common-password

# 2. Blocco account
echo "Configurazione blocco account:"
echo "auth required pam_tally2.so deny=5 unlock_time=900" >> /etc/pam.d/common-auth

# 3. Disabilitazione account default
echo "Disabilitazione account non utilizzati:"
for user in games lp news uucp gnats; do
    usermod -L $user 2>/dev/null
done

# 4. Autenticazione a due fattori
echo "Per 2FA installare:"
echo "libpam-google-authenticator per OTP"
echo "Configurare /etc/pam.d/sshd con:"
echo "auth required pam_google_authenticator.so"

log "Hardening autenticazione completato"
