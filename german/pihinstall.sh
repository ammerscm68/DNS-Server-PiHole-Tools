#!/bin/bash

# --- KONFIGURATION ---
GITHUB_URL="https://raw.githubusercontent.com/ammerscm68/DNS-Server-PiHole-Tools/main/german/.bashrc"
DEST_FILE="$HOME/.bashrc"
TEMP_FILE="/tmp/.bashrc_new"

# Betriebssystem-ID ermitteln
os_id=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"' | xargs)

# OS-Check: Sicherstellen, dass es Debian Linux ist
if [[ "$os_id" != "debian" ]]; then
    printf "\n❌ Fehler: Die DNS-Server Tools sind nur für 'Debian' Linux geeignet! - Abbruch!\n\n\n"
    exit 1
fi

clear
printf "==================================================\n"
printf "🌐 .bashrc Update-Service (DNS-Server Tools)\n"
printf "==================================================\n"
printf "\n\n⌨️ Weiter mit beliebiger Taste (Abbruch mit Strg+C)...\n\n"
read -n 1 -s -r

# 1. Download der neuen Datei von GitHub
printf "\n\n🚀 Lade neue Konfiguration von GitHub herunter...\n"
if curl -sSL "$GITHUB_URL" -o "$TEMP_FILE"; then
    
    # Sicherstellen, dass die Datei nicht leer ist
    if [ ! -s "$TEMP_FILE" ]; then
        printf "❌ Fehler: Die heruntergeladene Datei ist leer!\n"
        rm -f "$TEMP_FILE"
        exit 1
    fi

    printf "✅ Download erfolgreich.\n\n"
    
    # 2. Abfrage zur Bestätigung
    read -p "❓ Soll die vorhandene .bashrc wirklich ersetzt werden? (ja/nein): " confirm
    if [[ "$confirm" == "ja" || "$confirm" == "j" ]]; then
        # Backup der alten Datei erstellen
        cp "$DEST_FILE" "${DEST_FILE}.bak" 2>/dev/null
        
        # Datei überschreiben
        mv "$TEMP_FILE" "$DEST_FILE"
        
        printf "\n✅ Datei erfolgreich ersetzt (Backup unter .bashrc.bak gespeichert).\n"
        printf "🔄 Das System wird in 5 Sekunden neu gestartet...\n"
        sleep 5
        sudo reboot
    else
        printf "\n⏩ Vorgang abgebrochen. Es wurden keine Änderungen vorgenommen.\n"
        rm -f "$TEMP_FILE"
    fi
else
    printf "❌ Fehler: Download fehlgeschlagen. Bitte Internetverbindung prüfen.\n"
    exit 1
fi