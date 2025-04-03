# Progetto-di-Hardening-Automatizzato-basato-sulle-Linee-Guida-AGID

# Hardening Automatizzato AGID

![AGID Logo](https://example.com/agid-logo.png) *(sostituisci con URL reale)*

**Script di hardening sistemistico conforme alle Linee Guida AGID per la sicurezza dei sistemi informatici**

## 📌 Panoramica

Set di script modulari per l'implementazione automatica delle misure di hardening specificate nel documento:
- **Sezione 5.2.2 Hardening del sistema** delle Linee Guida AGID
- Best practice per la sicurezza di sistemi Linux/Unix

## 🛡️ Funzionalità Principali

| Modulo | Contromisure Implementate | Riferimento AGID |
|--------|---------------------------|------------------|
| BIOS | Password BIOS, Secure Boot, Crittografia dischi | 5.2.2 (BIOS protection) |
| Autenticazione | Politica password, 2FA, Blocco account | 5.2.4 (Autenticazione) |
| Kernel | ASLR, DEP, Restrizioni memoria | 5.2.2 (Memory protection) |
| Rete | Firewall, SYN cookies, IP spoofing | 5.2.2 (TCP/IP hardening) |
| Filesystem | Permessi, Mount options, PATH sicuro | 5.2.2 (File system) |
| Servizi | Disabilitazione servizi legacy, Timeout | 5.2.2 (Service hardening) |

## 🚀 Installazione

```bash
git clone https://github.com/tuorepo/hardening-agid.git
cd hardening-agid
chmod +x main.sh

## 🖥️ Utilizzo
Esegui lo script principale:
```bash
sudo ./main.sh

Menu interattivo:
```bash
===== Menu Hardening AGID =====
1. Hardening BIOS e Avvio
2. Hardening Autenticazione
3. Hardening Kernel
4. Hardening Rete
5. Hardening Filesystem
6. Hardening Servizi
7. Hardening DNS
8. Esegui TUTTO (modalità completa)
0. Esci

## 🔧 Configurazione
I file di configurazione predefiniti si trovano in /configs:

```bash
sysctl_secure.conf: Parametri kernel sicuri
sshd_secure.conf: Configurazione SSH hardened
login_banner.txt: Banner legale per accessi

## ✅ Verifica
Dopo l'esecuzione, verifica le modifiche con:

```bash
# Verifica politica password
grep pam_pwquality /etc/pam.d/common-password

# Verifica parametri kernel
sysctl -a | grep randomize_va_space

# Verifica servizi attivi
systemctl list-units --state=enabled
