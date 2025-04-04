#!/bin/bash
source ../utils/checks.sh
source ../utils/logging.sh

log "Inizio hardening rete"

# 1. Disabilitazione IP forwarding
echo "Disabilitazione IP forwarding:"
echo 0 > /proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward=0" >> /etc/sysctl.conf

# 2. TCP SYN cookies
echo "Abilitazione SYN cookies:"
echo 1 > /proc/sys/net/ipv4/tcp_syncookies

# 3. Disabilitazione ICMP broadcast
echo "Disabilitazione risposta ICMP broadcast:"
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts

# 4. Configurazione firewall
echo "🔥 Configurazione regole firewall di base:"
iptables -F
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 1/s -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -P INPUT DROP
iptables -P FORWARD DROP

# 5. Disabilitazione servizi legacy
echo "🚫 Disabilitazione servizi non sicuri:"
systemctl disable telnet.socket
systemctl disable rsh.socket
systemctl disable rexec.socket

log "Hardening rete completato"