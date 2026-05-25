#!/bin/bash

# --- CONFIGURATION ---
GITHUB_URL="https://raw.githubusercontent.com/ammerscm68/DNS-Server-PiHole-Tools/main/english-us/.bashrc"
DEST_FILE="$HOME/.bashrc"
TEMP_FILE="/tmp/.bashrc_new"

# Extract OS ID
os_id=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"' | xargs)

# OS Check: Ensure it is Debian Linux
if [[ "$os_id" != "debian" ]]; then
    printf "\n❌ Error: The DNS Server Tools are only compatible with 'Debian' Linux! - Aborting!\n\n\n"
    exit 1
fi

clear
printf "\n\n"
printf "========================================================\n"
printf "🌐           DNS Server Tools Version 3.1\n" 
printf "ℹ️  (Interactive installation of Pi-hole and options)\n"
printf "========================================================\n"

# 1. Download
printf "\n🚀 Downloading configuration from GitHub - Please wait...\n\n"
if curl -sSL "$GITHUB_URL" -o "$TEMP_FILE"; then
    
    # Ensure the downloaded file is not empty
    if [ ! -s "$TEMP_FILE" ]; then
        printf "❌ Error: The downloaded file '.bashrc' is empty!\n\n"
        rm -f "$TEMP_FILE"
        exit 1
    fi

    printf "\n✅ Download successful.\n\n"

    # Note 
    printf "\nℹ️  Note: The startup file '.bashrc' must be replaced"
    printf "\nℹ️    (A copy of the original file will be created)\n\n\n"
    
    # 2. Confirmation prompt
    # < /dev/tty forces read to wait for keyboard input
    printf "❓ Should the existing file '.bashrc' be replaced now? (yes/no): "
    read -r confirm < /dev/tty
    
    # Convert to lowercase and remove carriage returns
    confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]' | tr -d '\r')

    if [[ "$confirm" == "yes" ]]; then
        # Create backup
        BACKUP_FILE="${DEST_FILE}.bak_$(date +%Y%m%d_%H%M%S)"
        cp "$DEST_FILE" "$BACKUP_FILE" 2>/dev/null
        
        # Move new file to destination
        mv "$TEMP_FILE" "$DEST_FILE"
        
        # Output for the user to see where the backup is
        printf "\n\n✅ The file '.bashrc' was successfully replaced.\n\n"
        printf "\n📂 A backup of the original file was saved as: %s\n\n" "$BACKUP_FILE"
        # System reboot
        printf "\n🔄 The system will reboot in 5 seconds...\n\n"
        sleep 5
        sudo reboot
    else
        printf "\n⏩ Operation Canceled. (Input was: '$confirm')\n\n"
        rm -f "$TEMP_FILE"
    fi
else
    printf "❌ Error: Download failed - Please check your internet connection!\n"
    exit 1
fi
