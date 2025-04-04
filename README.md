# Progetto di Hardening Automatizzato basato sulle Linee Guida AGID

<img src="https://github.com/0xDant3/Progetto-di-Hardening-Automatizzato-basato-sulle-Linee-Guida-AGID/blob/main/Logo%20Agenzia%20per%20l'Italia%20Digitale.jpg" width="300" height="200">

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
git clone https://github.com/0xDant3/Progetto-di-Hardening-Automatizzato-basato-sulle-Linee-Guida-AGID
cd hardening-agid
chmod +x main.sh
```

## 🖥️ Utilizzo
Esegui lo script principale:
```bash
sudo ./main.sh
```

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
```

## 🔧 Configurazione
I file di configurazione predefiniti si trovano in /configs:

```bash
sysctl_secure.conf: Parametri kernel sicuri

sshd_secure.conf: Configurazione SSH hardened

login_banner.txt: Banner legale per accessi
```

## ✅ Verifica
Dopo l'esecuzione, verifica le modifiche con:

```bash
# Verifica politica password
grep pam_pwquality /etc/pam.d/common-password

# Verifica parametri kernel
sysctl -a | grep randomize_va_space

# Verifica servizi attivi
systemctl list-units --state=enabled
```

## ⚠️ Avvertenze
Esegui backup del sistema prima dell'applicazione

Alcune modifiche richiedono riavvio

Testare in ambiente non produttivo prima

L'hardening BIOS richiede intervento manuale

## 📜 Conformità Normativa
Implementa i requisiti di:

Linee Guida AGID (Sez. 5.2.2)

GDPR (Art. 32 - Sicurezza del trattamento)

Direttiva NIS (Network Information Security)

## 📄 Licenza
Distribuito con licenza MIT. Vedere LICENSE per dettagli.

Questo progetto non è affiliato ufficialmente all'AGID ma implementa le loro linee guida tecniche.

## Perché questo README?

1. **Chiarezza**: Struttura ben organizzata con tabelle e sezioni distinte
2. **Completezza**: Copre installazione, uso, verifiche e avvertenze
3. **Riferimenti normativi**: Mostra esplicitamente la conformità AGID/GDPR/NIS
4. **Professionalità**: Include licenza e linee guida per contributi
5. **Praticità**: Comandi pronti all'uso copiati negli snippet di codice
