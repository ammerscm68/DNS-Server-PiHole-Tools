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
printf "\n\n"
printf "========================================================\n"
printf "🌐          DNS-Server-Tools Version 3.1\n" 
printf "ℹ️ (Interaktive Installation von Pi-hole und Optionen)\n"
printf "========================================================\n"

# 1. Download
printf "\n🚀 Lade Konfiguration von GitHub herunter - Bitte warten...\n\n"
if curl -sSL "$GITHUB_URL" -o "$TEMP_FILE"; then
    
    # Sicherstellen, dass die Datei nicht leer ist
    if [ ! -s "$TEMP_FILE" ]; then
        printf "❌ Fehler: Die heruntergeladene Datei '.bashrc' ist leer!\n\n"
        rm -f "$TEMP_FILE"
        exit 1
    fi

    printf "\n✅ Der Download war erfolgreich.\n\n"

    # Hinweis 
    printf "\nℹ️ Hinweis: Die Startdatei '.bashrc' muss ersetzt werden"
    printf "\nℹ️    (Eine Kopie der Originaldatei wird erstellt)\n\n\n"
    
    # 2. Abfrage zur Bestätigung
    # < /dev/tty zwingt read, auf die Tastatur zu warten
    printf "❓ Soll die vorhandene Datei '.bashrc' jetzt ersetzt werden? (ja/nein): "
    read -r confirm < /dev/tty
    
    # In Kleinbuchstaben umwandeln und Zeilenumbrüche entfernen
    confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]' | tr -d '\r')

    if [[ "$confirm" == "ja" ]]; then
        # Backup erstellen
        BACKUP_FILE="${DEST_FILE}.bak"
        cp "$DEST_FILE" "$BACKUP_FILE" 2>/dev/null
        
        # Neue Datei an Zielort verschieben
        mv "$TEMP_FILE" "$DEST_FILE"
        
        # Ausgabe für den Benutzer, wo das Backup liegt
        printf "\n\n✅ Die Datei '.bashrc' wurde erfolgreich ersetzt.\n\n"
        printf "\n📂 Eine Sicherung der Originaldatei wurde gespeichert unter: %s\n\n" "$BACKUP_FILE"
        # System Neustart
        printf "\n🔄 Das System wird in 5 Sekunden neu gestartet...\n\n"
        sleep 5
        # sudo reboot
    else
        printf "\n⏩ Der Vorgang wurde abgebrochen. (Eingabe war: '$confirm')\n\n"
        rm -f "$TEMP_FILE"
    fi
else
    printf "❌ Fehler: Download fehlgeschlagen - Bitte Internetverbindung prüfen !\n"
    exit 1
fi