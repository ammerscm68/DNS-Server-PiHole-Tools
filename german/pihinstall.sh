#!/bin/bash

# --- KONFIGURATION ---
GITHUB_URL="https://githubusercontent.com"
DEST_FILE="$HOME/.bashrc"
TEMP_FILE="/tmp/.bashrc_new"

os_id=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"' | xargs)

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

# 1. Download
printf "\n🚀 Lade neue Konfiguration von GitHub herunter...\n"
if curl -sSL "$GITHUB_URL" -o "$TEMP_FILE"; then
    
    if [ ! -s "$TEMP_FILE" ]; then
        printf "❌ Fehler: Die heruntergeladene Datei ist leer!\n"
        rm -f "$TEMP_FILE"
        exit 1
    fi

    printf "✅ Download erfolgreich.\n\n"
    
    # --- WICHTIG: Tastaturpuffer leeren ---
    # Dies verhindert, dass der Tastendruck von oben die Abfrage überspringt
    while read -r -t 0; do read -r; done
    
    # 2. Abfrage zur Bestätigung
    # Wir nutzen "read -r", um Backslashes sauber zu behandeln
    read -p "❓ Soll die vorhandene .bashrc wirklich ersetzt werden? (ja/nein): " confirm
    
    # Sicherstellen, dass die Eingabe klein geschrieben ist
    confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')

    if [[ "$confirm" == "ja" || "$confirm" == "j" ]]; then
        cp "$DEST_FILE" "${DEST_FILE}.bak" 2>/dev/null
        mv "$TEMP_FILE" "$DEST_FILE"
        
        printf "\n✅ Datei erfolgreich ersetzt.\n"
        printf "🔄 Das System wird in 5 Sekunden neu gestartet...\n"
        sleep 5
        sudo reboot
    else
        printf "\n⏩ Vorgang abgebrochen. (Eingabe war: '$confirm')\n"
        rm -f "$TEMP_FILE"
    fi
else
    printf "❌ Fehler: Download fehlgeschlagen.\n"
    exit 1
fi