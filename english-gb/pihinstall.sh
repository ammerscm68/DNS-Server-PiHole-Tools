#!/bin/bash

# --- CONFIGURATION ---
# Replace the link with your actual GitHub raw link if needed
GITHUB_URL="https://raw.githubusercontent.com/ammerscm68/DNS-Server-PiHole-Tools/main/english-gb/.bashrc"
DEST_FILE="$HOME/.bashrc"
TEMP_FILE="/tmp/.bashrc_new"

# Extract OS ID (No 'local' used as this is the main script)
os_id=$(grep "^ID=" /etc/os-release | cut -d= -f2 | tr -d '"' | xargs)

# OS Check: Ensure it is Debian Linux
if [[ "$os_id" != "debian" ]]; then
    printf "\n❌ Error: These DNS Server Tools are only compatible with 'Debian' Linux! - Aborting!\n\n\n"
    exit 1
fi

clear
printf "==================================================\n"
printf "🌐 .bashrc Update Service (DNS Server Tools)\n"
printf "==================================================\n"
printf "\n\n⌨️ Press any key to continue (Ctrl+C to cancel)...\n\n"
read -n 1 -s -r

# 1. Download the new file
printf "\n\n🚀 Downloading new configuration from GitHub...\n"
if curl -sSL "$GITHUB_URL" -o "$TEMP_FILE"; then
    
    # Ensure the downloaded file is not empty
    if [ ! -s "$TEMP_FILE" ]; then
        printf "❌ Error: The downloaded file is empty!\n"
        rm -f "$TEMP_FILE"
        exit 1
    fi

    printf "✅ Download successful.\n\n"
    
    # 2. Confirmation prompt
    read -p "❓ Do you really want to replace the existing .bashrc? (yes/no): " confirm
    if [[ "$confirm" == "yes" ]]; then
        # Create a backup (safety net)
        cp "$DEST_FILE" "${DEST_FILE}.bak" 2>/dev/null
        
        # Overwrite file
        mv "$TEMP_FILE" "$DEST_FILE"
        
        printf "\n✅ File successfully replaced (Backup saved as .bashrc.bak).\n"
        printf "🔄 System will reboot in 5 seconds...\n"
        sleep 5
        sudo reboot
    else
        printf "\n⏩ Operation canceled. No changes were made.\n"
        rm -f "$TEMP_FILE"
    fi
else
    printf "❌ Error: Download failed. Please check your internet connection.\n"
    exit 1
fi