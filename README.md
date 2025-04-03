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
