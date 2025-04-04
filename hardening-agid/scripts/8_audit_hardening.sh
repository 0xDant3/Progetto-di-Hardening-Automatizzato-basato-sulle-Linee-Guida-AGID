#!/bin/bash
# Hardening Audit e Logging - AGID 5.2.2/5.2.5
# Contromisure per tracciamento attività e rilevamento anomalie

source Progetto-di-Hardening-Automatizzato-basato-sulle-Linee-Guida-AGID/edit/main/hardening-agid/scripts/utils/checks.sh
source Progetto-di-Hardening-Automatizzato-basato-sulle-Linee-Guida-AGID/edit/main/hardening-agid/scripts/utils/logging.sh

log "Inizio configurazione audit e logging"

echo "🛡️  Configurazione auditd..."
apt install -y auditd

# Configurazione regole audit di base
cat > /etc/audit/rules.d/agid.rules <<EOL
# Monitoraggio accessi privilegiati
-a always,exit -F arch=b64 -S execve -k EXEC
-a always,exit -F arch=b32 -S execve -k EXEC

# Monitoraggio modifiche account
-w /etc/passwd -p wa -k IDENTITY
-w /etc/group -p wa -k IDENTITY
-w /etc/shadow -p wa -k IDENTITY

# Monitoraggio attività amministrative
-w /etc/sudoers -p wa -k SUDOERS
-w /etc/sudoers.d/ -p wa -k SUDOERS

# Monitoraggio file di configurazione rete
-w /etc/hosts -p wa -k NETWORK
-w /etc/network/ -p wa -k NETWORK

# Monitoraggio attività cron
-w /etc/crontab -p wa -k CRON
-w /etc/cron.hourly/ -p wa -k CRON
-w /etc/cron.daily/ -p wa -k CRON
-w /etc/cron.weekly/ -p wa -k CRON
-w /etc/cron.monthly/ -p wa -k CRON

# Monitoraggio attività di login
-w /var/log/auth.log -p wa -k AUTH
-w /var/log/faillog -p wa -k AUTH

# Monitoraggio modifiche ai binari critici
-w /bin -p wa -k BINARIES
-w /usr/bin -p wa -k BINARIES
-w /sbin -p wa -k BINARIES
-w /usr/sbin -p wa -k BINARIES
EOL

# Configurazione avanzata auditd
cat > /etc/audit/auditd.conf <<EOL
log_file = /var/log/audit/audit.log
log_format = RAW
log_group = root
priority_boost = 4
flush = INCREMENTAL_ASYNC
freq = 50
max_log_file = 50
num_logs = 5
disp_qos = lossy
dispatcher = /sbin/audispd
name_format = NONE
admin_space_left = 75
space_left = 100
space_left_action = email
action_mail_acct = root
admin_space_left_action = halt
disk_full_action = SUSPEND
disk_error_action = SUSPEND
tcp_listen_queue = 5
tcp_max_per_addr = 1
EOL

# Abilitazione servizi
systemctl enable auditd
systemctl start auditd

echo "📊 Configurazione logrotate..."
cat > /etc/logrotate.d/agid_audit <<EOL
/var/log/audit/audit.log {
    weekly
    rotate 10
    size 100M
    missingok
    notifempty
    compress
    delaycompress
    postrotate
        /usr/lib/auditd/rotate_audit_logs
    endscript
}
EOL

echo "🔍 Configurazione syslog avanzata..."
cat > /etc/rsyslog.d/30-agid.conf <<EOL
# Log delle autenticazioni
auth,authpriv.* /var/log/auth.log

# Log attività cron
cron.* /var/log/cron.log

# Log kernel
kern.* /var/log/kern.log

# Log attività amministrative
local6,local7.* /var/log/admin.log
EOL

systemctl restart rsyslog

echo "📌 Configurazione audit per compliance AGID..."
auditctl -e 1
auditctl -R /etc/audit/rules.d/agid.rules

log "Configurazione audit completata"

echo "✅ Audit hardening completato con successo"
echo "ℹ️  Log di audit disponibili in /var/log/audit/audit.log"
echo "ℹ️  Configurazioni salvate in /etc/audit/rules.d/agid.rules"
