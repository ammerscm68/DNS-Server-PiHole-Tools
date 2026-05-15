# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
alias packlist='echo sudo dpkg -l Pipe grep " xxx "'
alias apt-orders='echo apt search --names-only xxx && echo apt show xxx && echo apt install xxx'
alias update='clear && echo ***disable pihole dns-server*** && echo && sudo pihole disable && echo && sudo dpkg --configure -a && sudo apt-get update && sudo apt-get --assume-yes upgrade && sudo apt-get --assume-yes autoremove && sudo apt --fix-broken install && sudo apt-get autoclean && echo && echo ***enable pihole dns-server*** && sudo pihole enable && echo'
alias pimc='sudo mc'
alias neustart='echo && echo Reboot System && sudo reboot'
alias cpu-temp='clear && vcgencmd measure_temp'
alias cpu-volt='clear && vcgencmd measure_volts'
alias cpu-takt='clear && vcgencmd measure_clock arm'
alias cpu-com='clear && vcgencmd commands'
alias herunterfahren='echo && echo Shutdown System && sudo shutdown -h 0'
alias piconfig='sudo raspi-config'
alias cls='clear'
alias swap-off='sudo swapoff -a'
alias swap-on='sudo swapon -a'
alias swap-disable='sudo service dphys-swapfile stop && free && sudo systemctl disable dphys-swapfile && sudo apt-get purge dphys-swapfile'
alias swap-enable='sudo systemctl enable dphys-swapfile && sudo systemctl enable dphys-swapfile'
alias datum='date'
alias autoupdate-log='sudo cat /var/log/unattended-upgrades/unattended-upgrades.log'
alias pi-uptime='uptime -p'
alias pihole-passwd='sudo pihole setpassword'
alias pihole-ip='sudo nano /etc/pihole/setupVars.conf'
alias wpad='sudo nano /etc/hosts && sudo nano /etc/pihole/lan.list'
alias xdir='ls -la'
alias pihole-reset='sudo pihole -f && echo && echo Shutdown System && sudo shutdown -h 0'
alias pihole-repair='echo && sudo pihole -r && echo && echo Reboot System && sudo reboot'
alias pihole-dnsflush='echo && sudo pihole restartdns && echo'
alias pihole-update='clear && echo && echo ***disable pihole dns-server*** && echo && sudo pihole disable && echo && sudo pihole -up && echo && echo ***enable pihole dns-server*** && echo && sudo pihole enable && echo'
alias pihole-upgrade='clear && echo && echo ***disable pihole dns-server*** && echo && sudo pihole disable && echo && sudo pihole -g && echo && echo ***enable pihole dns-server*** && echo && sudo pihole enable && echo'
alias pihole-deleteblacklist='sudo sqlite3 /etc/pihole/gravity.db "delete from domainlist where type=1;" && sudo sqlite3 /etc/pihole/gravity.db "delete from domainlist where type=3;"'
alias pihole-deletewhitelist='sudo sqlite3 /etc/pihole/gravity.db "delete from domainlist where type=0;" && sudo sqlite3 /etc/pihole/gravity.db "delete from domainlist where type=2;"'
alias pihole-stop='clear && echo && echo ***disable pihole dns-server*** && echo && sudo pihole disable && echo'
alias pihole-start='clear && echo ***enable pihole dns-server*** && echo && sudo pihole enable && echo'
alias ipconfig='sudo ifconfig'
alias speicher='df -h'
alias usbpower='echo max_usb_current = 1 | sudo tee -a /boot/config.txt'
alias btdisable='echo dtoverlay=pi3-disable-bt | sudo tee -a /boot/config.txt && sudo systemctl disable hciuart'
alias partuuid='sudo lsblk -o name,label,partuuid'
alias btscan='sudo hcitool -i hci0 lescan'
alias clone='sudo rpi-clone -l -L RPI-Server sda && sudo mlabel -i /dev/sda1 ::RPI-Boot && echo Shutdown System && sudo shutdown -h 0'
alias firmware-update='sudo wget https://raw.github.com/Hexxeh/rpi-update/master/rpi-update -O /usr/bin/rpi-update && sudo chmod +x /usr/bin/rpi-update && sudo rpi-update && echo Reboot System && sudo reboot'
alias firmware-version='sudo rpi-eeprom-update'
alias bootloader-version='vcgencmd bootloader_version'
alias bootloader-config='vcgencmd bootloader_config'
alias pihole-cache='sudo nano /etc/dnsmasq.d/01-pihole.conf && echo Reboot System && sudo reboot'
alias ddns-ipv6='sudo nano /home/pi/ddnsipv6.txt && pihole disable && sudo apt-get install ddclient && pihole enable && sudo nano /etc/ddclient.conf && echo Reboot System && sudo reboot'
alias ddns-check='sudo ddclient -force'
alias timesync='ntpdate -s 0.de.pool.ntp.org'
alias timesync-check='timedatectl'
alias osversion='lsb_release -dr'
alias networkmanager='sudo nmtui'
alias log='journalctl -f'
alias portscan='clear && echo && echo ***PortScan*** Please wait ... && sudo nmap -p- 192.168.178.210 -sU -sN && echo && echo done'
alias fail2ban-log='clear && echo ***fail2ban log*** && echo && sudo tail -f /var/log/fail2ban.log'
alias fail2ban-ssh='clear && echo ***fail2ban ssh*** && echo && sudo fail2ban-client status sshd'
alias fail2ban-webmin='clear && echo ***fail2ban webmin*** && echo && sudo fail2ban-client status webmin-auth'
alias fail2ban-webserver1='clear && echo ***fail2ban webserver*** && echo && sudo fail2ban-client status apache-auth'
alias fail2ban-webserver2='clear && echo ***fail2ban webserver*** && echo && sudo fail2ban-client status lighttpd-custom'
alias fail2ban-status='clear && echo ***fail2ban status*** && echo && sudo fail2ban-client status'
alias fail2ban-service='clear && echo ***fail2ban restart*** && echo && sudo systemctl status fail2ban'
alias fail2ban-unban='clear && echo ***fail2ban all unban*** && sudo fail2ban-client unban --all'
alias deletepiholecache='find /etc/pihole/ListsCache -type f -exec sudo rm {} \;'
alias ipv4tables='sudo iptables -L -v -n --line-numbers'
alias ipv6tables='sudo ip6tables -L -v -n --line-numbers'
alias ipv4tables-del='clear && echo ***"Der Deletebefehl: sudo iptables -D INPUT <Zeilennummer>"***'
alias ipv6tables-del='clear && echo ***"Der Deletebefehl: sudo ip6tables -D INPUT <Zeilennummer>"***'
alias iptables-save='sudo netfilter-persistent save'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
#
# ----------DNS-Server---------------
#     DNS-Tools (Assistent)
#
#          Mai 2026
# Version 2.1 von Mario Ammerschuber
# -----------------------------------

checksudo() {
# Prüfen ob "Sudo" installiert ist
    if ! command -v sudo &> /dev/null; then
    printf "\n❌ Fehler: 'sudo' ist nicht installiert.\n\n"
    printf "\n📍 Bitte melden Sie sich als 'Root' an und installieren es mit: > apt update && apt upgrade && apt install sudo\n\n"
    return 1
  fi
}

bootconfig() {
    printf "\n🚀 Optimiere Boot-Konfiguration für USB-Modus...\n"
    
    local boot_conf="/boot/firmware/config.txt"
    # Fallback für ältere OS-Versionen
    [ ! -f "$boot_conf" ] && boot_conf="/boot/config.txt"

    # PRÜFUNG: Ist der Eintrag schon vorhanden?
    if grep -q "program_usb_boot_mode=1" "$boot_conf"; then
        printf "\nℹ️ Die Boot-Parameter sind bereits in %s konfiguriert.\n\n" "$boot_conf"
        return 0
    else
        printf "\n➕ Füge Boot-Parameter hinzu...\n\n"
    if sudo bash -c "cat >> $boot_conf" <<-EOF > /dev/null 2>&1
# --- USB Boot & Power Tuning ---
dtoverlay=disable-wifi # WLAN deativieren, da Server nicht über WLAN laufen sollten !!!
dtoverlay=disable-bt # Bluetooth deaktivieren
program_usb_boot_mode=1
max_usb_current=1 # mehr Power für USB-Ports
boot_delay=15 # Startverzögerung von 15 Sekunden. 
program_usb_boot_timeout=1
EOF
    then
    printf "\n✅ Die Boot-Parameter wurden erfolgreich hinzugefügt.\n\n"
    return 1
     else
     printf "\n❌ Fehler: Die Boot-Parameter konnten nicht gespeichert werden !\n\n"
     return 2 # FEHLER: Schreiben fehlgeschlagen!
    fi
  fi
}

expandfilesystem() {
    printf "\n🚀 Prüfe Datenträger auf ungenutzten Speicherplatz...\n"
    # 1. Check: Ist das benötigte Werkzeug vorhanden?
    if ! command -v growpart >/dev/null 2>&1; then
        printf "\n❌ Fehler: Das Dateisystem konnte nicht expandiert werden.\n\n"
        printf "\n👉 Das Paket 'cloud-guest-utils' ist nicht installiert.\n"
        printf "\n👉 Bitte installieren Sie es manuell mit: sudo apt install cloud-guest-utils\n"
        return 1
    fi
    # 2. Root-Laufwerk und Partition ermitteln
    local root_dev=$(findmnt -n -o SOURCE /)
    local parent_dev=$(lsblk -no PKNAME "$root_dev")
    local part_num=$(echo "$root_dev" | grep -o '[0-9]\+$')

    if [ -z "$parent_dev" ]; then
        printf "⚠️ Die Laufwerksstruktur konnte nicht ermittelt werden. Expansion abgebrochen.\n"
        return 1
    fi
    # 3. Versuch die Partition zu vergrößern
    printf "\n💾 Expandiere Dateisystem auf maximale Größe...\n\n"
    # growpart gibt 0 bei Erfolg und 1 bei "kein Platz" zurück
    if sudo growpart "/dev/$parent_dev" "$part_num" > /dev/null 2>&1; then
        # 4. Das Dateisystem online vergrößern
        sudo resize2fs "$root_dev" > /dev/null 2>&1
        printf "✅ Erfolg: Die Partition wurde auf die volle Größe erweitert.\n"
    else
        printf "ℹ️ Hinweis: Die Partition nutzt bereits den gesamten verfügbaren Speicherplatz.\n"
    fi
}

checkosversion() {
    # 1. Die reine Versionsnummer extrahieren (z.B. 11 oder 12 u.s.w)
    # tr -d '"' entfernt eventuelle Anführungszeichen um die Zahl
    local os_ver
    os_ver=$(grep "^VERSION_ID=" /etc/os-release | cut -d= -f2 | tr -d '"')

    printf "\n🔍 Prüfe Betiebssystem Version...\n"

    # Falls die Variable leer ist (Sicherheitscheck)
    if [[ -z "$os_ver" ]]; then
        printf "\n❌ Fehler: Die OS-Version konnte nicht ermittelt werden. - Abbruch!\n\n"
        return 1
    fi

    # 2. Vergleich: muss Version 13 (Trixi) oder höher sein
    if [ "$os_ver" -ge 13 ] 2>/dev/null; then
        printf "\n✅ Systemversion %s erkannt (OK).\n\n" "$os_ver" 
        # ========================================================
        local_lang_de # Sprache auf Deutsch einstellen
        local lang_changed=$?
        bootconfig # zusätzliche Bootparameter eintragen
        local boot_changed=$?
          # Neustart wenn nötig
          if [ $lang_changed -ne 0 ] || [ $boot_changed -ne 0 ]; then
          printf "\n🚀 Das System muss neu gestartet werden um die Änderungen zu aktivieren.\n\n"
          printf "\n🔄 Der Neustart erfolgt in 10 Sekunden (Abbruch mit Strg+C)...\n\n"
          sleep 10
          sudo reboot
          return 1
          fi
       return 0
    else
        printf "\n❌ Fehler: Diese Funktionssammlung benötigt mindestens Version 13 (Trixi) des Betriebssystems.\n\n"
        printf "\n⚠️ Die aktuelle Version ist: %s\n\n" "$os_ver"
        printf "\n🚫 Leider müssen wir an dieser Stelle abbrechen.\n\n"
        return 1
    fi
}

checkpartitionsize() {
    printf "\n📊 Prüfe verfügbaren Speicherplatz...\n\n"
    
    # Funktion zur Größenermittlung
    get_size_mb() {
        # awk entfernt hierbei automatisch alle führenden Leerzeichen
        df -m / --output=size | tail -1 | awk '{print $1}'
    }

    local root_size_mb=$(get_size_mb)
    local min_size_mb=15360 # 15 GB in MB

    # 2. Expansion versuchen, wenn zu klein
    if [ "$root_size_mb" -lt "$min_size_mb" ]; then
        # MB zu GB umrechnen für die Anzeige
        local root_size_display=$((root_size_mb / 1024))
        
        printf "\nℹ️ Die Partition ist zu klein für Pi-hole (%s GB). Versuche Expansion...\n\n" "$root_size_display"
        expandfilesystem 
        
        # Größe nach Expansion neu einlesen
        root_size_mb=$(get_size_mb)
    fi

    # 3. Finaler Check
    local root_size_gb=$((root_size_mb / 1024))

    if [ "$root_size_mb" -lt "$min_size_mb" ]; then
        printf "\n⚠️ ACHTUNG: Die Partition ist zu klein (%s GB).\n\n" "$root_size_gb"
        printf "\n❌ Pi-hole benötigt ein Speichermedium mit mindestens 16 GB für einen reibungslosen Betrieb.\n\n"
        printf "\n🛑 Die Installation von Pi-hole wird abgebrochen!\n\n"
        return 1
    else
        printf "\n✅ Der verfügbare Speicherplatz ist OK: %s GB wurden erkannt.\n\n" "$root_size_gb"
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        clear # Bildschirm leeren
        return 0
    fi
}

piholeinstall() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    storagestatus -phc # Pi-hole Speicherstatus anzeigen wenn installiert

    # Vorab-Check: Ist Pi-hole vielleicht schon installiert ?
    if command -v pihole >/dev/null 2>&1; then
    return 0 # Installation abbrechen
    fi

    sleep 2
    clear # Bildschirm leeren
    sleep 1
    # Prüfen ob die Bedingung der OS-Version stimmt
    checkosversion || return 1

    # Prüfen ob genug Speicherplatz vorhanden ist (min. 16 GB)
    checkpartitionsize || return 1

    # ******************************************************
    setstaticip // Check ob eine statische IP vorhanden ist
    # ******************************************************

    printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
    read -n 1 -s -r
    clear # Bildschirm leeren
    printf "==================================\n\n"
    printf "🏠 Pi-hole Installations-Assistent\n"
    printf "==================================\n\n"
    printf "\nℹ️ Das offizielle Installations-Skript wird geladen...\n\n"
    
    # Aktives Interface ermitteln (Sprachneutral)
    local interface
    interface=$(nmcli -t -f DEVICE,STATE device status | grep -E ":connected|:verbunden" | head -n 1 | cut -d: -f1)
    if [[ -z "$interface" ]]; then
        printf "\n❌ Fehler: Es wurde kein verbundenes Netzwerk-Interface gefunden! - Abbruch!\n\n"
        return 1
    fi
    local conn_name
    conn_name=$(nmcli -t -f NAME,DEVICE connection show --active | grep ":$interface" | cut -d: -f1)
    if [[ -z "$conn_name" ]]; then
        printf "\n❌ Fehler: Es wurde kein aktives LAN-Interface Profil für %s gefunden. - Abbruch!\n\n" "$interface"
        return 1
    fi
    # Methode über die CONNECTION abfragen
    local method
    method=$(nmcli -g ipv4.method connection show "$conn_name")
    method="${method,,}"
    if [[ "$method" != "manual" ]]; then
      printf "\n⚠️ Hinweis: Der Raspberry PI sollte eine ***feste*** IPv4-Adresse haben.\n\n"
    fi
    # ************************** Begin Installation von Pi-hole **************************
    printf "\n\n"
    read -p "❓ Jetzt mit der Installation von Pi-hole beginnen? (ja/nein): " confirm
    if [[ "$confirm" == "ja" ]]; then
        clear # Bildschirm leeren
        printf "\n🚀 Starte Systemaktualisierung - Bitte warten...\n\n\n"
        sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
        sudo apt --assume-yes autoremove
        sudo apt autoclean
        # curl installieren wenn noch nicht vorhanden (Achtung:  Nur für DEBIAN-Linux !!!)
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" curl # curl installieren wenn noch nicht vorhanden
        clear # Bildschirm leeren
        printf "\n\n🚀 Starte Pi-hole Download und Installation - Bitte warten...\n\n\n"
        sleep 3
        # Der offizielle curl-Befehl
        curl -sSL https://install.pi-hole.net | sudo bash
        printf "\n\n"
        printf "\n\nℹ️ Hilfspakete werden installiert - Bitte warten...\n\n\n"
        printf "\n\n"
        # Zusätzliche Installationen (Achtung:  Nur für DEBIAN-Linux !!!)
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" sqlite3 # SQLite für Blocklist Import
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" mc # Midnight Commander
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" fail2ban # fail2ban installieren
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" iptables-persistent # iptables-persistent installieren

     # Check: Wurde Pi-hole installiert ?
     if command -v pihole >/dev/null 2>&1; then
     printf "\n\n✅ Der DNS-Server (Pi-hole) wurde erfolgreich installiert...\n\n\n"
     printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
     clear # Bildschirm leeren
     # =================================
     # DNS Upstream Server hinzufügen 
     upstreamdns
     # =================================
     setrouterconfig -phi # Routerkonfiguration anzeigen
     # =================================================
     printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
     clear # Bildschirm leeren
     printf "\n\n\n"
     # ===============================================================
     addwhitedomains # Zugelassene Domains in die Datenbank einfügen
     addblocklists   # ******* Blocklisten hinzufügen *********
     # ===============================================================
     printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
     # ===============================================================
     local IPv4
     IPv4=$(hostname -I | awk '{print $1}') # für die kommende Anzeige
     clear # Bildschirm leeren
     echo "" | sudo pihole setpassword ""  # Setzt ein leeres Passwort, was die Abfrage deaktiviert
     printf "\n"
     printf "#########################################################\n"
     printf "🎉 Pi-hole Installation komplett abgeschlossen!\n"
     printf "🌐 Grafische Oberfläche aufrufen mit:\n"
     printf "👉 http://%s/admin\n" "$IPv4"
     printf "=========================================================\n"
     printf "🔐 Passwort: DEAKTIVIERT (kein Login nötig)\n"
     printf "=========================================================\n"
     printf "#########################################################\n"
     printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
     clear # Bildschirm leeren
     printf "\n\n" # Leerzeilen einfügen.
     read -r -p "❓ Soll ein automatisches System- und Blocklistenupdate eingerichtet werden ? (ja/nein): " au_antwort
     printf "\n"
     if [ "$au_antwort" = "ja" ]; then
     autoupdate -c
     fi
     printf "\n\n\n" # Leerzeilen einfügen.
     # ============ Zusätzliche Installationen ====================
     # Fragen ob "Webmin-Manager" installiert werden soll wenn noch nicht installiert
     webmininstall -install
     # ================================
     # CUPS-Printserver installieren ?
     printserverinstall -phi
     # ================================
     # Fail2Ban aktivieren
     setfail2banjail
     # ================================
     setiptables # Sicherheitseinstellungen für Pi-hole, Webmin-Manager und CUPS konfigurieren
     # ===============================================================================
     clear # Bildschirm leeren
     printf "\n\n"
     printf "\n🚀 Es erfolgt ein abschließender Neustart des Systems.\n\n"
     printf "\n🔄 Der Neustart erfolgt in 5 Sekunden (Abbruch mit Strg+C)...\n\n"
     sleep 5
     sudo reboot
     return 1
      else
       printf "\n❌ Fehler: Der DNS-Server (Pi-hole) konnte nicht installiert werden !\n\n"
       return 1
    fi
    else
        printf "\n⚠️ Die Pi-hole Installation wurde durch den Benutzer abgebrochen!\n\n"
        return 1
    fi
}

setrouterconfig() {
   local param="$1"
   local router_name
   router_name=$(getroutermodel)

     # Wir holen die IPv4-Adresse
    if [[ "$param" == "-phi" ]]; then
     # globale IPv6-Adresse auslesen wen vorhanden
     if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
       printf "\n======================================================================================================================\n"
       printf "ℹ️ Hinweis: Die IPv4-Adresse und die globale IPv6-Adresse muß jetzt noch als DSN-Server im Router eingetragen werden .\n" 
       printf "======================================================================================================================\n\n"
     else
        printf "\n=========================================================================================\n"
       printf "ℹ️ Hinweis: Die IPv4-Adresse muß jetzt noch als DSN-Server im Router eingetragen werden .\n" 
       printf "=========================================================================================\n\n"  
     fi
     printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
    fi
     clear # Bildschirm leeen
     local IPv4
     IPv4=$(hostname -I | awk '{print $1}')
      if [[ -n "$router_name" ]]; then
      printf "\n\n🌐 *** Eintragungen im Router (%s) ***\n\n\n" "$router_name"
      else
      printf "\n\n🌐 *** Eintragungen im Router (deines Netzwerks) ***\n\n\n"
      fi
        # Formatierte Ausgabe mit fester Breite 
        printf "###############################################\n"
        printf "######## IPv4 - Eintragungen im Router ########\n"
        printf "###############################################\n"
        printf "📝 %-25s: %s\n" "Bevorzugter DNSv4-Server" "$IPv4"
        printf "📝 %-25s: %s\n" "Alternativer DNSv4-Server" "1.1.1.1"
        printf -- "-----------------------------------------------\n\n\n"
     if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
     # globale IPv6-Adresse auslesen wen vorhanden
     local IPv6
     IPv6=$(ip -6 addr show | grep "scope global" | awk '{print $2}' | cut -d/ -f1 | head -n 1)
     # Formatierte Ausgabe mit fester Breite 
     printf "########################################################################\n"
     printf "#################### IPv6 - Eintragungen im Router #####################\n"
     printf "########################################################################\n"
     printf "📝 %-25s: %s\n" "Bevorzugter DNSv6-Server" "$IPv6"
     printf "📝 %-25s: %s\n" "Alternativer DNSv6-Server" "2606:4700:4700::1111"
     printf -- "------------------------------------------------------------------------\n\n"
     fi
}

getroutermodel() {
    local r_ip
    r_ip=$(ip route show | grep default | awk '{print $3}' | head -n1)

    if [[ -n "$r_ip" ]]; then
        # 1. Spezieller UPnP-Standardpfad (Port 1900/49000 Kombi für AVM, Telekom & Co)
        local urls=(
            "http://${r_ip}:49000/igddesc.xml"
            "http://${r_ip}:49000/tr64desc.xml"
            "http://${r_ip}/rootDesc.xml"
        )
        
        local url
        for url in "${urls[@]}"; do
            local xml
            xml=$(curl -s --connect-timeout 1 "$url" 2>/dev/null)
            if [[ -n "$xml" ]]; then
                local r_model
                r_model=$(echo "$xml" | grep -oP '(?<=<modelName>)[^<]+' | head -n1)
                if [[ -n "$r_model" ]]; then
                    echo "$r_model"
                    return 0
                fi
            fi
        done
    fi
    return 1
}

setiptables() {
if command -v iptables >/dev/null 2>&1; then
     clear # Bildschirm leeren
     printf "\n\n🚀 *** Die Sicherheitseinstellungen für die installierten Programme werden eingerichtet ... ***\n\n"

     printf "\n\n➕ *** Sicherheitseinstellungen für Pi-hole DNS-Server\n"

     # --- Automatisierung für iptables-persistent (für BEIDE Fälle v4/v6) ---
     echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
     echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections

     # --- Eigene Ketten für IPv4 und IPv6 erstellen (falls nicht vorhanden) ---
     sudo iptables -N PIHOLE_RULES 2>/dev/null
     sudo ip6tables -N PIHOLE_RULES 2>/dev/null

     # --- Nur die eigenen Ketten leeren (fremde Regeln bleiben aktiv!) ---
     sudo iptables -F PIHOLE_RULES
     sudo ip6tables -F PIHOLE_RULES

     # --- Verknüpfung zur Haupt-Firewall (INPUT) herstellen, falls nötig ---
     if ! sudo iptables -C INPUT -j PIHOLE_RULES 2>/dev/null; then
          sudo iptables -I INPUT 1 -j PIHOLE_RULES
     fi
     if ! sudo ip6tables -C INPUT -j PIHOLE_RULES 2>/dev/null; then
          sudo ip6tables -I INPUT 1 -j PIHOLE_RULES
     fi

     if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
     # ******** IPv4 & IPv6 ***********
     sudo iptables -A PIHOLE_RULES -i lo -j ACCEPT # Loopback IPv4
     sudo iptables -A PIHOLE_RULES -m state --state ESTABLISHED,RELATED -j ACCEPT # Bestehende Verbindungen IPv4
     sudo ip6tables -A PIHOLE_RULES -i lo -j ACCEPT # Loopback IPv6
     sudo ip6tables -A PIHOLE_RULES -m state --state ESTABLISHED,RELATED -j ACCEPT # Bestehende Verbindungen IPv6

     # 1. ZUERST: Den Zugriff auf das Web-Interface für Dich selbst erlauben (WICHTIG!)
     sudo iptables -A PIHOLE_RULES -p tcp --dport 80 -j ACCEPT # für Pi-hole
     sudo ip6tables -A PIHOLE_RULES -p tcp --dport 80 -j ACCEPT # für Pi-hole
     sudo iptables -A PIHOLE_RULES -p tcp --dport 8080 -j ACCEPT # für Pi-hole
     sudo ip6tables -A PIHOLE_RULES -p tcp --dport 8080 -j ACCEPT # für Pi-hole
     sudo iptables -A PIHOLE_RULES -p tcp --dport 443 -j ACCEPT # für Webinterface
     sudo ip6tables -A PIHOLE_RULES -p tcp --dport 443 -j ACCEPT # für Webinterface
     
     if dpkg -l | grep -q "^ii  cups "; then
          printf "\n➕ *** Sicherheitseinstellungen für CUPS Printserver\n"
          sudo iptables -A PIHOLE_RULES -p tcp --dport 631 -j ACCEPT  # Für Printserver
          sudo iptables -A PIHOLE_RULES -p udp --dport 631 -j ACCEPT  # Für Printserver 
          sudo ip6tables -A PIHOLE_RULES -p tcp --dport 631 -j ACCEPT # Für Printserver 
          sudo ip6tables -A PIHOLE_RULES -p udp --dport 631 -j ACCEPT # Für Printserver 
          sudo iptables -A PIHOLE_RULES -p udp --dport 5353 -j ACCEPT # Für AirPrint/mDNS
          sudo ip6tables -A PIHOLE_RULES -p udp --dport 5353 -j ACCEPT # Für AirPrint/mDNS
     fi
     
        if dpkg -l | grep -q "^ii  webmin " || [ -d "/etc/webmin" ]; then
          printf "\n➕ *** Sicherheitseinstellungen für Webmin-Manager\n"
          sudo iptables -A PIHOLE_RULES -p tcp --dport 10000 -j ACCEPT # Für Webmin-Manager
          sudo ip6tables -A PIHOLE_RULES -p tcp --dport 10000 -j ACCEPT # Für Webmin-Manager
        fi

     # 2. DANACH: Den restlichen "Müll" blockieren
     sudo iptables -A PIHOLE_RULES -p tcp --destination-port 80 -j REJECT --reject-with tcp-reset # für Pi-hole
     sudo iptables -A PIHOLE_RULES -p tcp --destination-port 8080 -j REJECT --reject-with tcp-reset # für Pi-hole
     sudo iptables -A PIHOLE_RULES -p udp --destination-port 80 -j REJECT --reject-with icmp-port-unreachable # für Pi-hole
     sudo iptables -A PIHOLE_RULES -p udp --destination-port 8080 -j REJECT --reject-with icmp-port-unreachable # für Pi-hole
     sudo ip6tables -A PIHOLE_RULES -p tcp --destination-port 80 -j REJECT --reject-with tcp-reset # für Pi-hole
     sudo ip6tables -A PIHOLE_RULES -p tcp --destination-port 8080 -j REJECT --reject-with tcp-reset # für Pi-hole
     sudo iptables -A PIHOLE_RULES -p tcp --destination-port 443 -j REJECT --reject-with tcp-reset # für Webinterface
     sudo ip6tables -A PIHOLE_RULES -p tcp --destination-port 443 -j REJECT --reject-with tcp-reset # für Webinterface
     
     if dpkg -l | grep -q "^ii  cups "; then
          sudo iptables -A PIHOLE_RULES -p tcp --destination-port 631 -j REJECT --reject-with tcp-reset  # Für Printserver
          sudo iptables -A PIHOLE_RULES -p udp --destination-port 631 -j REJECT --reject-with icmp-port-unreachable # Für Printserver
          sudo ip6tables -A PIHOLE_RULES -p tcp --destination-port 631 -j REJECT --reject-with tcp-reset # Für Printserver
          sudo ip6tables -A PIHOLE_RULES -p udp --destination-port 631 -j REJECT --reject-with icmp6-port-unreachable # Für Printserver
     fi
     
     if dpkg -l | grep -q "^ii  webmin " || [ -d "/etc/webmin" ]; then
          sudo iptables -A PIHOLE_RULES -p tcp --destination-port 10000 -j REJECT --reject-with tcp-reset # Für Webmin-Manager
          sudo ip6tables -A PIHOLE_RULES -p tcp --destination-port 10000 -j REJECT --reject-with tcp-reset # Für Webmin-Manager
     fi
     
     else
     # ******** Nur IPv4 ***********
     # 1. ZUERST: Den Zugriff auf das Web-Interface für Dich selbst erlauben (WICHTIG!)
     sudo iptables -A PIHOLE_RULES -i lo -j ACCEPT # Loopback IPv4
     sudo iptables -A PIHOLE_RULES -m state --state ESTABLISHED,RELATED -j ACCEPT # Bestehende Verbindungen IPv4
    
     sudo iptables -A PIHOLE_RULES -p tcp --dport 80 -j ACCEPT # für Pi-hole
     sudo iptables -A PIHOLE_RULES -p tcp --dport 8080 -j ACCEPT # für Pi-hole
     sudo iptables -A PIHOLE_RULES -p tcp --dport 443 -j ACCEPT # für Webinterface
     
     if dpkg -l | grep -q "^ii  cups "; then
      printf "\n➕ *** Sicherheitseinstellungen für CUPS Printserver\n"
      sudo iptables -A PIHOLE_RULES -p tcp --dport 631 -j ACCEPT # für Printserver
      sudo iptables -A PIHOLE_RULES -p udp --dport 631 -j ACCEPT  # für Printserver
      sudo iptables -A PIHOLE_RULES -p udp --dport 5353 -j ACCEPT # Für AirPrint/mDNS
     fi
     
     if dpkg -l | grep -q "^ii  webmin " || [ -d "/etc/webmin" ]; then
       printf "\n➕ *** Sicherheitseinstellungen für Webmin-Manager\n"
       sudo iptables -A PIHOLE_RULES -p tcp --dport 10000 -j ACCEPT # für Webmin-Manager
     fi

     # 2. DANACH: Den restlichen "Müll" blockieren
     sudo iptables -A PIHOLE_RULES -p tcp --destination-port 80 -j REJECT --reject-with tcp-reset # für Pi-hole
     sudo iptables -A PIHOLE_RULES -p tcp --destination-port 8080 -j REJECT --reject-with tcp-reset # für Pi-hole
     sudo iptables -A PIHOLE_RULES -p tcp --destination-port 443 -j REJECT --reject-with tcp-reset # für Webinterface
     
     if dpkg -l | grep -q "^ii  cups "; then
          sudo iptables -A PIHOLE_RULES -p tcp --destination-port 631 -j REJECT --reject-with tcp-reset # Für Printserver
          sudo iptables -A PIHOLE_RULES -p udp --destination-port 631 -j REJECT --reject-with icmp-port-unreachable # Für Printserver
     fi
     
     if dpkg -l | grep -q "^ii  webmin " || [ -d "/etc/webmin" ]; then
          sudo iptables -A PIHOLE_RULES -p tcp --destination-port 10000 -j REJECT --reject-with tcp-reset # Für Webmin-Manager
     fi
     fi

     # IPTables speichern & Erfolgsmeldung
     sudo netfilter-persistent save > /dev/null 2>&1
     printf "\n\n🎉 *** Die Sicherheitseinstellungen für die installierten Programme wurden abgeschlossen ***\n\n"
     printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
else
     printf "\n\n🎉 *** Die Sicherheitseinstellungen für die installierten Programme konnten ***nicht*** abgeschlossen werden !\n\n" 
     printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
fi
}

upstreamdns() {
    if command -v pihole >/dev/null 2>&1; then
        local dns_list
        local choice

        while true; do
            clear
            printf "============================================\n"
            printf "🌐 Auswahl der Upstream DNS-Server\n"
            printf "============================================\n"
            printf "1) Cloudflare\n"
            printf "2) OpenDNS\n"
            printf "3) Quad9 (filtered, DNSSEC)\n"
            printf "4) Cloudflare und OpenDNS (Empfohlen)\n"
            printf "5) Cloudflare und Quad9 (filtered, DNSSEC)\n"
            printf "6) OpenDNS und Quad9 (filtered, DNSSEC)\n"
            printf "7) ALLE (Cloudflare, OpenDNS, Quad9)\n"
            printf -- "--------------------------------------------\n\n"
            read -p "👉 Bitte wählen (1-7): " choice

            if [[ "$choice" =~ ^[1-7]$ ]]; then
                break 
            else
                printf "\n❌ Ungültige Eingabe! Bitte wählen Sie eine Zahl von 1 bis 7.\n"
                sleep 3
            fi
        done

        if (( choice > 3 )); then
            printf "\n\n⚙️ Die gewählten Upstream-Server werden eingestellt...\n"
        else
            printf "\n\n⚙️ Der gewählte Upstream-Server wird eingestellt...\n"
        fi    
        
        # Lokale Variablen für alle Varianten deklarieren
        local cf_v4="\"1.1.1.1\", \"1.0.0.1\"" # Cloudflare IPv4
        local cf_v6="\"2606:4700:4700::1111\", \"2606:4700:4700::1001\"" # Cloudflare IPv6
        local od_v4="\"208.67.222.222\", \"208.67.220.220\"" # OpenDNS IPv4
        local od_v6="\"2620:119:35::35\", \"2620:119:53::53\"" # OpenDNS IPv6
        local q9_v4="\"9.9.9.9\", \"149.112.112.112\"" # Quad9 IPv4
        local q9_v6="\"2620:fe::fe\", \"2620:fe::9\"" # Quad9 IPv6

        # ----- IPv4 und IPv6 Upstream -----
        if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
            case $choice in
                1) dns_list="[ $cf_v4, $cf_v6 ]" ;;
                2) dns_list="[ $od_v4, $od_v6 ]" ;;
                3) dns_list="[ $q9_v4, $q9_v6 ]" ;;
                4) dns_list="[ $cf_v4, $od_v4, $cf_v6, $od_v6 ]" ;;
                5) dns_list="[ $cf_v4, $q9_v4, $cf_v6, $q9_v6 ]" ;;
                6) dns_list="[ $od_v4, $q9_v4, $od_v6, $q9_v6 ]" ;;
                7) dns_list="[ $cf_v4, $od_v4, $q9_v4, $cf_v6, $od_v6, $q9_v6 ]" ;;
            esac
        else
            # ----- nur IPv4 Upstream -----
            case $choice in
                1) dns_list="[ $cf_v4 ]" ;;
                2) dns_list="[ $od_v4 ]" ;;
                3) dns_list="[ $q9_v4 ]" ;;
                4) dns_list="[ $cf_v4, $od_v4 ]" ;;
                5) dns_list="[ $cf_v4, $q9_v4 ]" ;;
                6) dns_list="[ $od_v4, $q9_v4 ]" ;;
                7) dns_list="[ $cf_v4, $od_v4, $q9_v4 ]" ;;
            esac
        fi

        # Pi-hole optimieren
        printf "\n\n⚙️ Pi-hole wird optimiert...\n"
        sudo pihole-FTL --config dns.cacheSize 10000 > /dev/null 2>&1
        sudo pihole-FTL --config dns.dnssec true > /dev/null 2>&1
        sudo pihole-FTL --config dns.rateLimit.count 5000 > /dev/null 2>&1
        sudo pihole-FTL --config dns.cacheLocalHosts true > /dev/null 2>&1
        sudo pihole-FTL --config dns.domainNeeded true > /dev/null 2>&1
        sudo pihole-FTL --config database.DBinterval 5 > /dev/null 2>&1
        sudo pihole-FTL --config dns.upstreams "$dns_list" > /dev/null 2>&1

        if [ -f "/etc/pihole/setupVars.conf" ]; then
         sudo sed -i '/PIHOLE_DNS_/d' /etc/pihole/setupVars.conf > /dev/null 2>&1
        fi
        printf "\n🔄 Die Pi-hole FTL wird gestoppt - Bitte warten...\n\n"
        sudo systemctl stop pihole-FTL > /dev/null 2>&1
        sleep 3
        printf "\n⚙️ Die FTL-Datenbank wird angepasst...\n\n"
        local ddb="/etc/pihole/pihole-FTL.db"
        if [ -f "$ddb" ]; then
            # Wir löschen den Key komplett, statt ihn nur zu updaten
            sudo sqlite3 "$ddb" "DELETE FROM config WHERE key = 'dns.upstreams';" > /dev/null 2>&1
        fi
        # Die FTL-Datenbank-Konfiguration zwingend setzen
        local udb="/etc/pihole/pihole-FTL.db"
        if [ -f "$udb" ]; then
            # Wir prüfen kurz, ob die Tabelle 'config' existiert
            local table_check=$(sudo sqlite3 "$udb" "SELECT name FROM sqlite_master WHERE type='table' AND name='config';")
            if [[ -n "$table_check" ]]; then
              sudo sqlite3 "$udb" "INSERT OR REPLACE INTO config (key, value) VALUES ('dns.upstreams', '$dns_list');" > /dev/null 2>&1
            fi
        fi
        # FTL neu starten
        printf "\n🔄 Die Pi-hole FTL wird neu gestartet - Bitte warten...\n\n"      
        sudo systemctl start pihole-FTL > /dev/null 2>&1
        sleep 3
        printf "\n✅ DNS Upstream-Server konfiguriert und Optimierungen erfolgreich abgeschlossen.\n\n"
    else
        printf "\n⚠️ Pi-hole ist nicht installiert. Die Upstream-Konfiguration wird übersprungen.\n\n"
    fi
}

addwhitedomains() {
    if command -v pihole >/dev/null 2>&1; then
        printf "\n🚀 Füge Domains hinzu, welche immer zugelassen werden...\n\n"

            printf "=============================================\n"
            printf "ℹ️ Folgende Domains werden immer zugelassen\n"
            printf "=============================================\n"
            printf "1. Microsoft Windows Update\n"
            printf "2. YouTube\n\n"
            
        local allow_regex=(
            "(\.|^)download\.windowsupdate\.com$"
            "(\.|^)windowsupdate\.microsoft\.com$"
            "(\.|^)update\.microsoft\.com$"
            "(\.|^)download\.microsoft\.com$"
            "(\.|^)assets\.windowsupdate\.com$"
            "(\.|^)docs\.microsoft\.com$"
            "^(.+.)?(youtube\.com|googlevideo\.com|ytimg\.com|\
youtubei\.googleapis\.com|s\.youtube\.com|youtube-nocookie\.com|\
ggpht\.com|googleusercontent\.com)$"
        )

        # SQL-Direkt-Import
        local db="/etc/pihole/gravity.db"
        local sql_add="INSERT OR IGNORE INTO domainlist (type, domain, enabled, comment)"
        local added_regex_count=0
      for regex in "${allow_regex[@]}"; do
        local result
        result=$(sudo sqlite3 "$db" "$sql_add VALUES (2, '$regex', 1, 'Auto-Whitelist'); SELECT changes();")
        if [[ "$result" == "1" ]]; then
        ((added_regex_count++))
        fi
      done
       
       if [[ $added_regex_count -gt 0 ]]; then
        printf "\n\n🔄 Die Pi-hole FTL wird neu gestartet - Bitte warten...\n\n\n"
        sudo systemctl restart pihole-FTL
        sleep 5
        # Prüfen ob Domains in der Datenbank sind 
        # pihole-FTL-inspect domains | grep "regex"
        printf "\n✅ Die zugelassenen Domains wurden hinzugefügt.\n\n"
      else
       printf "\nℹ️ Alle zugelassenen Domains sind bereits in der Datenbank vorhanden.\n"
      fi
    else
        printf "\n⚠️ Pi-hole ist nicht installiert. Der Vorgang wird abgebrochen!\n\n"
    fi
    printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
    read -n 1 -s -r
    clear # Bildschirm leeren
}

addblocklists() {
   # Prüfen ob "sudo" installiert ist
   checksudo || return 1

   # Prüfen ob Pi-hole installiert ist
   if command -v pihole >/dev/null 2>&1; then
    # Hier Blocklisten eintragen
    local blocklists=(
        "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/child-protection"
        "https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/Corona-Blocklist"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/crypto"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DatingSites"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting3"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting4"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/easylist"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/Fake-Science"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/gambling"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/malware"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/MS-Office-Telemetry"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/notserious"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/Overblock"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/Phishing-Angriffe"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/pornblock1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/pornblock2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/pornblock3"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/pornblock4"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/pornblock5"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/pornblock6"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/proxies"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/samsung"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/spam.mails"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/Streaming"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/SupportingRussia"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/Win10Telemetry"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/AddikoBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/AnadiBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/Bank99"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/BankBurgenland"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/Bawag"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/BKSBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/ConsorsFinanz"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/Denizbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/Easybank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/Eurambank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/Hypotirol"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/Kommunalkreditinvest"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/LichtensteinischeLandesbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/N26"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/OberBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/PrivatBankRaiffeisenlandesbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/RaiffeisenBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/Raiffeisenzertifikate"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/RenaultBankdirekt"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/SantanderBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/SchelhammerCapitalBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/Schoellerbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/SpardaBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/SparkasseBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/SWKBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/Teambank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/TFBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/UniCreditBankAustria"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/VolksbankKaernten"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/VolksbankNiederoesterreich"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/VolksbankOberoesterreich"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/VolksbankSalzburg"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/VolksbankSteiermark"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/VolksbankTirol"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/VolksbankVorarlberg"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/VolksbankWien"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/AT/ZuercherKantonalbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/AargauischeKantonalbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/AlternativeBankSchweiz"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Arabbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/BankCler"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/BCJ-BanqueCantonaleduJura"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/BCN-BanqueCantonaleNeuchateloise"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/BCVS-BanqueCantonaleduValais"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/BNP-Paribas"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Ca-Indosuez"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Cash"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/CIC"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Citi"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Credit-Suisse-AG"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/DZ-Privatbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Gemeinschaftsbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/HelvetischeBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Heritage"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Hypobank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/HypoVoralberg"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/JSafraSarasin"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/LGTBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Mbaerbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Migrosbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Monyland"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/NeonSchwitzerlandAG"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/ObwaldnerKantonalbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/OneSwissBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/PKB"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/PostFinance"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/PPI-Schweiz"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Raiffeisen"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/SaxoBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/SchwyzerKantonalbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/SNB-SchweizerischeNationalbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Swissbanking"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/SyzGroup"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/UBS"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/Vontobel"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/VPBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/CH/ZKB"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/Commerzbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/Consorsbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/Deka"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/DeutscheBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/DKB"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/HamburgCommercialBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/HelebaBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/Hypovereinsbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/ING"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/KFWBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/LandesbankBadenWuerttemberg"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/NorddeutscheLandesbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/NRWBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/Pfandbriefbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/Postbank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/PSD-Bank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/SantanderBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/Sparda-Bank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/StaatsbankBadenWuerttemberg"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/Targobank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/sonstige_Banken/VolkswagenBank"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/BadenWuerttemberg1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/BadenWuerttemberg2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Bayern1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Bayern2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Berlin"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Brandenburg"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Bremen"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Hamburg"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Hessen1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Hessen2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/MecklenburgVorpommern"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Niedersachsen1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Niedersachsen2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/NRW1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/NRW2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/NRW3"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/NRW4"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/RheinlandPfalz"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Saarland"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Sachsen"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/SachsenAnhalt"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/SchleswigHolstein"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Sparkasse/Thueringen"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-0"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-1-Teil-1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-1-Teil-2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-3-Teil-1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-3-Teil-2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-4"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-5-Teil-1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-5-Teil-2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-6"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-7-Teil-1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-7-Teil-2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-8-Teil-1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-8-Teil-2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-9-Teil-1"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-9-Teil-2"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/DE/Volks-und-Raiffeisenbank/VR-PLZ-9-Teil-3"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/INT/interactivebrokers"
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/DomainSquatting/INT/traderepublic"
	"https://raw.githubusercontent.com/notracking/hosts-blocklists/master/adblock/adblock.txt" 
	"https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt" 
	"https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt" 
	"https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/AmazonFireTV.txt" 
	"https://raw.githubusercontent.com/wlqY8gkVb9w1Ck5MVD4lBre9nWJez8/W10TelemetryBlocklist/master/W10TelemetryBlocklist" 
	"https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt" 
	"https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt" 
	"https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt" 
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/samsung" 
	"https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt" 
	"https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt" 
	"https://raw.githubusercontent.com/AdguardTeam/cname-trackers/master/data/combined_disguised_trackers.txt"
	"https://raw.githubusercontent.com/Monstanner/DuckDuckGo-Fakeshops-Blocklist/main/Blockliste"
	"https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt" 
	"https://v.firebog.net/hosts/Easyprivacy.txt" 
	"https://v.firebog.net/hosts/Easylist.txt" 
	"https://v.firebog.net/hosts/Prigent-Ads.txt" 
	"https://v.firebog.net/hosts/AdguardDNS.txt" 
	"https://adaway.org/hosts.txt" 
	"https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt" 
	"https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts" 
	"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt" 
	"https://raw.githubusercontent.com/AdguardTeam/cname-trackers/master/data/combined_disguised_ads.txt" 
	"https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt" 
	"https://raw.githubusercontent.com/RPiList/specials/master/Blocklisten/crypto" 
	"https://v.firebog.net/hosts/Prigent-Malware.txt" 
	"https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt" 
	"https://raw.githubusercontent.com/Spam404/lists/master/adblock-list.txt" 
	"https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts" 
	"https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADomains.txt" 
	"https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt" 
	"https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts" 
	"https://urlhaus.abuse.ch/downloads/hostfile" 
	"https://raw.githubusercontent.com/AmnestyTech/investigations/master/2021-07-18_nso/domains.txt" 
	"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/tif.txt"
	"https://raw.githubusercontent.com/namePlayer/dhl-scamlist/main/dns-blocklists/pihole-blacklist" 
	"https://www.einmalzahlungzweihundert.de/bl-einmalzahlung.txt"
    )
    printf "\n\n"
    printf "🚀 Starte automatischen Import von weiteren %s Blocklisten - Bitte etwas Geduld...\n\n" "${#blocklists[@]}"
    printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
    read -n 1 -s -r

    local added_count=0
    for url in "${blocklists[@]}"; do
        printf "➕ Verarbeite Blockliste: %s\n" "$url"
        # PRAGMA busy_timeout=10000 setzt das Warten auf 10 Sekunden (in Millisekunden)
        local result
        result=$(sudo sqlite3 /etc/pihole/gravity.db \
        "PRAGMA busy_timeout=10000; BEGIN TRANSACTION; INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$url', 1, 'Auto-Setup'); SELECT changes(); COMMIT;")
        
        # Wir filtern nur die Zahl heraus, da PRAGMA keine Ausgabe erzeugt, changes() aber schon
        if [[ "$result" =~ "1" ]]; then
            ((added_count++))
        fi
    done
    printf "\n\n\n👉 Fertig! Alle Blocklisten sind verarbeitet worden ...\n\n"
    printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
    read -n 1 -s -r

    if [[ $added_count -gt 0 ]]; then
      clear # Bildschirm leeren
      printf "\n\n🔄 Aktualisiere Pi-hole Gravity - Bitte warten...\n\n"
      sudo pihole -g # Blocklisten in die Datenbank einfügen
      printf "\n\n\n✅ Fertig! Alle Listen sind aktiv. Der DNS-Server ist bereit.\n\n"
    else
      printf "\n\n\nℹ️ Keine neuen Blocklisten gefunden. Die Datenbank ist bereits aktuell.\n\n"
    fi
   else
    printf "\n⚠️ Pi-hole ist nicht installiert. Es können keine Blocklisten hinzugefügt werden! \n\n"
   fi
}

getipv4() {
 clear # Bildschirm leeren
 # Wir holen die IPv4-Adresse
 local IPv4
 IPv4=$(hostname -I | awk '{print $1}')
 if [[ -n "$IPv4" ]]; then
 printf "\nℹ️ Die IPv4-Adresse lautet: '%s'\n\n" "$IPv4"
 else
 printf "\n⚠️ Keine IPv4-Adresse gefunden!\n\n" 
 fi 
}

getipv6() {
clear # Bildschirm leeren
# IPv6-Adresse auslesen
if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
local IPv6
IPv6=$(ip -6 addr show | grep "scope global" | awk '{print $2}' | cut -d/ -f1 | head -n 1)
printf "\nℹ️ Die globale IPv6-Adresse lautet: '%s'\n\n" "$IPv6"
else
printf "\nℹ️ Die globale IPv6-Adresse lautet: keine\n"
printf "\n🌐 Die Verwendung einer IPv6-Adresse ist wahrscheinlich im Router deaktiviert.\n\n"
fi
}

setstaticip() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    # Wenn der Networkmanager nicht installiert ist dann noch installieren
    if ! command -v nmcli >/dev/null 2>&1; then
    printf "\n\nℹ️ Der 'Netzwerk-Manager' muss noch installiert werden - Bitte warten...\n\n"
    sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
    sudo apt --assume-yes autoremove
    sudo apt autoclean
    # (Achtung:  Nur für DEBIAN-Linux !!!)
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" network-manager # Netzwerkmanager installieren
    printf "\n\n🚀 Das System muss neu starten um den 'Netzwerk-Manager' zu aktivieren.\n\n"
    printf "\n🔄 Der Neustart erfolgt in 10 Sekunden (Abbruch mit Strg+C)...\n\n"
    sleep 10
    sudo reboot
    return 1
    fi

    local skip_file="/home/$USER/.skip_ip_check"
    local sparam="$1"

    # --- Parameter-Check (Silent) ---
    if [[ "$1" == "-clear" ]]; then
    rm -f "$skip_file" 2>/dev/null
    fi

    # 1. Aktives Interface ermitteln (Sprachneutral)
    local interface
    interface=$(nmcli -t -f DEVICE,STATE device status | grep -E ":connected|:verbunden" | head -n 1 | cut -d: -f1)

    if [[ -z "$interface" ]]; then
        printf "\n❌ Fehler: Es wurde kein verbundenes Netzwerk-Interface gefunden! - Abbruch!\n\n"
        return 1
    fi

    # 2. Den Namen der aktiven Verbindung (Connection) finden
    local conn_name
    conn_name=$(nmcli -t -f NAME,DEVICE connection show --active | grep ":$interface" | cut -d: -f1)

    if [[ -z "$conn_name" ]]; then
        printf "\n❌ Fehler: Es wurde kein aktives Profil für %s gefunden. - Abbruch!\n\n" "$interface"
        return 1
    fi

    # 3. Methode über die CONNECTION abfragen
    local method
    method=$(nmcli -g ipv4.method connection show "$conn_name")
    method="${method,,}"

    # 4. Wir holen die IP auch über die CONNECTION
    local current_ip=$(nmcli -g ip4.address connection show "$conn_name" | cut -d/ -f1)

    # --- Warnung bei WLAN-Betrieb ---
    if [[ "$interface" == w* ]]; then
        printf "\n⚠️ WARNUNG: Der DNS-Server wird über WLAN (%s) betrieben!\n\n" "$interface"
        printf "Für maximale Stabilität und Geschwindigkeit wird ein LAN-Kabel empfohlen.\n\n"
        read -r -p "❓ Trotzdem fortfahren? (ja/nein): " wlan_confirm
        [[ "$wlan_confirm" != "ja" ]] && { printf "\n🔄 Abbruch durch Benutzer.\n\n"; return 1; }
    fi

    if [[ "$method" == "manual" ]]; then
        printf "\n✅ Das Netzwerk-Interface [%s] nutzt eine STATISCHE IPv4-Adresse.\n\n" "$interface"
        return 0
    fi

    # Wenn die Flag-Datei existiert, überspringen wir die Abfrage
    if [[ -f "$skip_file" ]]; then
        return 0  # Benutzer hatte sich für DHCP entschieden
    fi

    # 3. Umstellung anbieten
    printf "\n🌐 Aktueller Status für Netzwerk-Interface [%s]: DHCP (Dynamische IPv4-Adresse)\n\n" "$interface"
    printf "\n\n"
    read -r -p "❓ Möchten Sie jetzt auf eine STATISCHE IPv4-Adresse umstellen? (ja/nein/nie): " sip_antwort

    if [[ "$sip_antwort" == "ja" ]]; then
        clear # Bildschirm leeren
        printf "\n\n\n--- Konfiguration der statischen IPv4-Adresse ---\n"
        printf "\nℹ️ Hinweis: Wählen Sie eine IPv4-Adresse außerhalb des DHCP-Pools.\n\n"
        printf "\n👉 (z.Bsp. FritzBox meist: .2 bis .19 oder .201 bis .253)\n\n"

        local base_ip=$(echo "$current_ip" | cut -d. -f1-3)

        # Gateway über CONNECTION abfragen, nicht über DEVICE
        local current_gw=$(nmcli -g ipv4.gateway connection show "$conn_name")

        # --- Interne Validierungs-Funktion ---
        validate_ip() {
            local ip=$1
            [[ ! "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] && return 1
            local IFS='.'
            local oct=($ip)
            for i in {0..3}; do
                local val=$((10#${oct[$i]}))
                [[ $val -lt 0 || $val -gt 255 ]] && return 1
            done
            local last=$((10#${oct[3]}))
            [[ $last -eq 0 || $last -eq 255 ]] && return 1
            return 0
        }

        while true; do
            read -r -p "👉 statische IPv4-Adresse [Vorschlag: ${base_ip}.212]: " new_ip
            new_ip=${new_ip:-"${base_ip}.212"}

            if ! validate_ip "$new_ip"; then
                printf "\n❌ Fehler: '%s' ist keine gültige IPv4-Adresse (0-254, Ende nicht 0/255)!\n\n" "$new_ip"
                continue
            fi

            printf "\n🔍 Prüfe ob IPv4-Adresse %s frei ist...\n\n" "$new_ip"
            if ping -c 1 -W 1 "$new_ip" >/dev/null 2>&1; then
                printf "\n❌ BELEGT: Ein anderes Gerät nutzt bereits diese IPv4-Adresse!\n\n"
            else
                break
            fi
        done

        # --- GATEWAY IPv4-Adresse ---
        local new_gw
        local def_gw="${current_gw:-${base_ip}.1}"
        while true; do
            read -r -p "👉 Gateway IPv4-Adresse (Router) - [Vorschlag: $def_gw]: " new_gw
            new_gw=${new_gw:-"$def_gw"}
            # KORREKTUR: ! für "Wenn NICHT gültig", dann Fehlermeldung
            if ! validate_ip "$new_gw"; then
                printf "\n❌ Fehler: '%s' ist keine gültige Gateway IPv4-Adresse!\n\n" "$new_gw"
            else
                break
            fi
        done

        # --- UMSETZUNG ---
        clear # Bildschirm leeren
        printf "\n\n⚙️ Einstellungen für [%s] werden angewendet...\n\n" "$conn_name"

        sudo nmcli connection modify "$conn_name" \
            ipv4.addresses "${new_ip}/24" \
            ipv4.gateway "$new_gw" \
            ipv4.dns "${new_ip} 1.1.1.1" \
            ipv4.method manual \
            ipv6.method "auto" \
            ipv6.addr-gen-mode "eui64" \
            ipv6.ip6-privacy 0

        rm -f "$skip_file" 2>/dev/null
        printf "\n✅ Die statische IPv4-Adresse wurde erfolgreich konfiguriert: %s\n" "$new_ip"
        # ----------------------- IPv6 ----------------------------------------------
        if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
         # Prüfen, ob die Einstellungen im NetworkManager-Profil angekommen sind
         local check_v6_method=$(nmcli -g ipv6.method connection show "$conn_name")
         local check_v6_privacy=$(nmcli -g ipv6.ip6-privacy connection show "$conn_name")
         if [[ "$check_v6_method" == "auto" && "$check_v6_privacy" == "0" ]]; then
         printf "\n✅ IPv6-Konfiguration (EUI-64) wurde erfolgreich hinterlegt.\n\n"
         else
         printf "\n⚠️ Warnung: Die IPv6-Einstellungen konnten nicht verifiziert werden.\n"
         fi
        fi
        # ----------------------- IPv6 ----------------------------------------------
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        clear # Bildschirm leeren
        printf "\n\n🚀 Neustart in 10 Sekunden, um auf die neuen IP-Adressen umzustellen - Bitte warten...\n\n"
        sleep 10
        sudo reboot
        exit 0

    elif [[ "$sip_antwort" == "nie" ]]; then
        printf "DNS-Server - Benutzer hat sich am $(date +'%d.%m.%Y um %H:%M') für eine DHCP-Adresse entschieden!" > "$skip_file"
        printf "\n✅ Die IPv4-Adresse des DNS-Server bleibt auf DHCP Konfiguration. (Aktuell: %s)\n\n" "$current_ip"
        sudo nmcli connection modify "$conn_name" \
        ipv6.method "auto" \
        ipv6.addr-gen-mode "eui64" \
        ipv6.ip6-privacy 0
    else
        printf "\n🔄 Abbruch. Die IPv4-Adresse bleibt vorerst auf DHCP. (Aktuell: %s)\n\n" "$current_ip"
        sudo nmcli connection modify "$conn_name" \
        ipv6.method "auto" \
        ipv6.addr-gen-mode "eui64" \
        ipv6.ip6-privacy 0
    fi
}

webmininstall() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    # Parameter in Variable speichern
    local param="$1"

    local spinner="/|\\-"
    local i=1

    clear # Bildschirm leeren
    printf "\n\n\n"
    # Prüfen ob "Webmin-Manager" bereits installiert ist
    printf "\n🔍 Prüfe Installationsstatus von grafischer Oberläche 'Webmin-Manager'...\n\n"

    # Wir führen die Prüfung in einer Variablen aus, um Job-Meldungen zu vermeiden
    # Das geht schnell genug, dass wir den Spinner manuell kurz zeigen
    for j in {1..8}; do
        i=$(( (i % 4) + 1 ))
        printf "\b%s" "${spinner:$i-1:1}"
        sleep 0.1
    done

    # Jetzt die echte Prüfung ohne Hintergrundprozess-Meldungen
    local check_result=$(dpkg -l 2>/dev/null | grep "webmin")

    if [[ -n "$check_result" ]]; then
        printf "\b✅ Prüfung Installationsstatus - fertig...\n"
        printf "\n🚀 Die grafische Oberfläche 'Webmin-Manager' ist bereits installiert.\n"
        # Extrahiert nur die Version sauber
        local version=$(echo "$check_result" | awk '{print $3}')
        printf "   -> Version: $version\n\n"
        printf "\n✅ Zugriff über: https://%s:10000\n\n" "$(hostname -I | awk '{print $1}')"
        printf "\b \b"
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        clear # Bildschirm leeren
        return 0
    else
        # Spinner sauber entfernen
        printf "\b \b" 
    fi

    printf "\n\n"
    read -r -p "❓ Möchten Sie die grafische Oberfläche 'Webmin-Manager' jetzt installieren? (ja/nein): " wmconfirm
    if [[ "$wmconfirm" == "ja" ]]; then
        printf "\n\n"
        if [[ "$param" != "-install" ]]; then
        printf "\n🚀 Starte Systemupdate - Bitte warten...\n\n"
        # Abhängigkeiten installieren (curl wird für das Skript benötigt)
        sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
        sudo apt --assume-yes autoremove
        sudo apt autoclean
        fi
        # (Achtung:  Nur für DEBIAN-Linux !!!)
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" curl gnupg2 apt-transport-https
        printf "\n\n🚀 Starte Webmin-Manager-Installation - Bitte warten...\n\n"
        # Offizielles Webmin Repository-Setup-Skript laden und ausführen
        # Dies fügt automatisch den Key und die Sources hinzu
        curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
        sudo sh setup-repos.sh -f  # -f erzwingt die Ausführung ohne erneute Bestätigung

        # Webmin-Manager installieren
        sudo apt-get install -y webmin --install-recommends

        # Aufräumen
        rm setup-repos.sh

        # Firewall-Port 10000 freischalten (falls UFW aktiv ist)
        # if command -v ufw > /dev/null; then
        #    sudo ufw allow 10000/tcp
        #    sudo ufw reload
        # fi

        printf "\n✅ Die grafische Oberfläche 'Webmin-Manager' wurde installiert. -  Zugriff über: https://%s:10000\n\n" "$(hostname -I | awk '{print $1}')"
        # Logik für den Reboot anpassen
       if [[ "$param" == "-install" ]]; then
        printf "⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        clear # Bildschirm leeren
        else
        # Standard-Verhalten ohne den Parameter "install"
        printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        clear # Bildschirm leeren
        printf "\n🚀 Das System muss neu gestartet werden um 'Webmin-Manager' zu aktivieren.\n\n"
        printf "\n🔄 Der Neustart erfolgt in 10 Sekunden (Abbruch mit Strg+C)...\n\n"
        sleep 10
        sudo reboot
        fi
    else
        printf "\n⏩ Die grafische Oberfläche 'Webmin-Manager' wird ***nicht*** installiert.\n\n"
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        clear # Bildschirm leeren
    fi
}

autoupdate() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    local sys_path="/home/$USER/systemupdate.sh"
    local bl_path="/home/$USER/blocklistupdate.sh"
    local syslog_path="/home/$USER/systemupdate.log"
    local bllog_path="/home/$USER/blocklistupdate.log"
    local param="$1"

    # --- OPTION: DEAKTIVIEREN (-d) ---
    if [[ "$param" == "-d" ]]; then
        if [[ ! -f "$sys_path" && ! -f "$bl_path" ]]; then
            printf "\n⚠️ Abbruch: Keine 'Autoupdate'-Dateien gefunden.\n\n"
            return 1
        fi

        read -r -p "❓ Sollen die Auto-Updates wirklich deaktiviert werden? (ja/nein): " auconfirm
        if [[ "$auconfirm" == "ja" ]]; then
            rm -f "$sys_path" "$syslog_path" "$bl_path" "$bllog_path"
            (crontab -l 2>/dev/null | grep -vE "($sys_path|$bl_path)") | crontab -
            printf "\n✅ Auto-Update wurde deaktiviert.\n\n"
        else
            printf "\n🔄 Der Vorgang wurde abgebrochen.\n\n"
        fi
        return 0
    fi

    # --- OPTION: ERSTELLEN (-c) ---
    if [[ "$param" == "-c" ]]; then
        local run_sys="true"
        local run_bl="true"

        # Check Systemupdate
        if [[ -f "$sys_path" ]]; then
            printf "\n"
            read -r -p "⚠️ Das 'Autoupdate' (System) existiert bereits. Überschreiben? (ja/nein): " overwrite_sys
            if [[ "$overwrite_sys" != "ja" ]]; then
                printf "\n⚠️ Abbruch: System-Update wird nicht überschrieben.\n\n"
                run_sys="false"
            fi
        fi
        
        # Check Blocklisten
        if [[ -f "$bl_path" ]]; then
            printf "\n"
            read -r -p "⚠️ Das 'Autoupdate' (Blocklisten) existiert bereits. Überschreiben? (ja/nein): " overwrite_bl
            if [[ "$overwrite_bl" != "ja" ]]; then
                printf "\n⚠️ Abbruch: Blocklisten-Update wird nicht überschrieben.\n\n"
                run_bl="false"
            fi
        fi

        # Wenn beide auf "false" stehen, können wir hier komplett aufhören
        if [[ "$run_sys" == "false" && "$run_bl" == "false" ]]; then
            return 1
        fi

        # 1. Systemupdate-Skript erstellen (nur wenn run_sys=true)
        if [[ "$run_sys" == "true" ]]; then
            cat <<-EOF > "$sys_path"
#!/bin/bash
rm -f "$syslog_path"
date > "$syslog_path" 2>&1
sudo pihole disable >> "$syslog_path" 2>&1
sudo apt-get update >> "$syslog_path" 2>&1
sudo apt-get --assume-yes upgrade >> "$syslog_path" 2>&1
sudo apt-get --assume-yes dist-upgrade >> "$syslog_path" 2>&1
sudo apt-get --assume-yes upgrade --fix-missing >> "$syslog_path" 2>&1
sudo apt-get --assume-yes autoremove >> "$syslog_path" 2>&1
sudo apt-get autoclean >> "$syslog_path" 2>&1
sudo pihole -up >> "$syslog_path" 2>&1
sudo pihole enable >> "$syslog_path" 2>&1
echo "***Neustart nach Systemupdate***" >> "$syslog_path" 2>&1
sudo reboot >> "$syslog_path" 2>&1
EOF
            chmod +x "$sys_path"
        fi
# =======================================================================
        # 2. Blocklistenupdate-Skript erstellen (nur wenn run_bl=true)
        if [[ "$run_bl" == "true" ]]; then
            cat <<-EOF > "$bl_path"
#!/bin/bash
rm -f "$bllog_path"
date > "$bllog_path" 2>&1
sudo pihole disable >> "$bllog_path" 2>&1
sudo apt-get update >> "$bllog_path" 2>&1
sudo apt-get --assume-yes upgrade >> "$bllog_path" 2>&1
sudo apt-get --assume-yes dist-upgrade >> "$bllog_path" 2>&1
sudo apt-get --assume-yes upgrade --fix-missing >> "$bllog_path" 2>&1
sudo apt-get --assume-yes autoremove >> "$bllog_path" 2>&1
sudo apt-get autoclean >> "$bllog_path" 2>&1
sudo pihole -g >> "$bllog_path" 2>&1
sudo pihole enable >> "$bllog_path" 2>&1
echo "***Neustart nach Blocklisten-Update***" >> "$bllog_path" 2>&1
sudo reboot >> "$bllog_path" 2>&1
EOF
            chmod +x "$bl_path"
        fi

        # --- CRONTAB AKTUALISIEREN ---
        {
            printf "# Edit this file to introduce tasks to be run by cron.\n#\n"
            printf "# Each task to run has to be defined through a single line\n"
            printf "# indicating with different fields when the task will be run\n"
            printf "# and what command to run for the task\n#\n"
            printf "# To define the time you can provide concrete values for\n"
            printf "# minute (m), hour (h), day of month (dom), month (mon),\n"
            printf "# and day of week (dow) or use '*' in these fields (for 'any').\n#\n"
            printf "# Notice that tasks will be started based on the cron's system\n"
            printf "# daemon's notion of time and timezones.\n#\n"
            printf "# Output of the crontab jobs (including errors) is sent through\n"
            printf "# email to the user the crontab file belongs to (unless redirected).\n#\n"
            printf "# For example, you can run a backup of all your user accounts\n"
            printf "# at 5 a.m every week with:\n# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/\n#\n"
            printf "# For more information see the manual pages of crontab(5) and cron(8)\n#\n"
            printf "# m h  dom mon dow   command\n"

            crontab -l 2>/dev/null | grep -vE "($sys_path|$bl_path)" | grep -v "^#" | grep -v "^$"
            
            [[ "$run_sys" == "true" ]] && echo "0 2 * * 2 $sys_path"
            [[ "$run_bl" == "true" ]] && echo "0 2 1-7 * * [ \"\$(date '+\%u')\" = \"4\" ] && $bl_path"
        } | crontab -

       # --- ZUSAMMENFASSUNG ---
        printf "\n✅ Die 'Autoupdate' Skripte wurden erstellt.\n"
        [[ "$run_sys" == "true" ]] && printf "\n📅 Planung: Automatisches Systemupdate an jedem Dienstag um 02:00 Uhr wurde eingerichtet.\n"
        [[ "$run_bl" == "true" ]] && printf "\n📅 Planung: Automatisches Blocklistenupdate an jedem 1. Donnerstag im Monat um 02:00 Uhr wurde eingerichtet.\n"
        printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        clear # Bildschirm leeren
        return 0
    fi

    printf "\n⚠️ Ungültiger Parameter: - Nutzung von 'Autoupdate': autoupdate [-c | -d]\n\n"
    printf "🔄 -c : Erstellen & Aktivieren\n"
    printf "🔄 -d : Deaktivieren & Löschen\n\n"
}

local_lang_de() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    # --- PRÜFUNG: Ist Deutsch schon aktiv? ---
    local kbd_check=0
    local lang_check=0

    if grep -q 'XKBLAYOUT="de"' /etc/default/keyboard 2>/dev/null; then
        kbd_check=1
    fi

    if [[ "$LANG" == "de_DE.UTF-8" ]]; then
        lang_check=1
    fi

    if [[ $kbd_check -eq 0 || $lang_check -eq 0 ]]; then
        # Betriebssystem Version prüfen
        export LC_ALL=C.UTF-8
        export LANG=C.UTF-8
        export LANGUAGE=C.UTF-8
        printf "\n🌐 Stelle Systemsprache und Tastatur auf Deutsch um - Bitte warten...\n\n\n"

        # Tastatur-Konfiguration schreiben
        cat <<-EOF | sudo tee /etc/default/keyboard > /dev/null
XKBMODEL="pc105"
XKBLAYOUT="de"
XKBVARIANT=""
XKBOPTIONS=""
BACKSPACE="guess"
EOF
        # Alle anderen Sprachen deaktivieren
        sudo sed -i 's/^[^#]/# &/g' /etc/locale.gen

        # Deutsch hinzufügen
        echo "de_DE.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen > /dev/null
        # System-Locale Dateien schreiben (Greift nach dem Reboot)
        echo "LANG=de_DE.UTF-8" | sudo tee /etc/default/locale > /dev/null
        echo "LC_ALL=de_DE.UTF-8" | sudo tee -a /etc/default/locale > /dev/null
        # Sprache physisch generieren
        sudo locale-gen de_DE.UTF-8 > /dev/null 2>&1
        # Offiziell im System registrieren
        sudo update-locale LANG=de_DE.UTF-8 LC_ALL=de_DE.UTF-8
        # Tastatur für die aktuelle Sitzung aktivieren
        sudo loadkeys de 2>/dev/null
        # Zeitzone setzen
        if [[ "$(cat /etc/timezone 2>/dev/null)" != "Europe/Berlin" ]]; then
            sudo timedatectl set-timezone Europe/Berlin 2>/dev/null
        fi
        printf "\n✅ Systemsprache und Tastatur erfolgreich auf Deutsch umgestellt.\n\n"
        return 1
    else
        printf "\nℹ️ Systemsprache und Tastatur sind bereits auf Deutsch eingestellt.\n\n"
        return 0
    fi
}

setfail2banjail() {
    printf "\n🛡️ Konfiguriere Fail2Ban Schutz (dynamische Erkennung)...\n\n"
    
    local my_ip=$(hostname -I | awk '{print $1}')

    # --- Check: Was ist wirklich installiert und aktiv? ---
    local apache_active="false"
    local lighttpd_active="false"
    local webmin_active="false"
    local ssh_active="false"

    # Prüfen ob die Dienste/Verzeichnisse existieren
    command -v apache2 >/dev/null 2>&1 && apache_active="true"
    command -v lighttpd >/dev/null 2>&1 && lighttpd_active="true"
    [[ -d "/etc/webmin" ]] && webmin_active="true"
    
    # Prüfen ob SSH im System aktiv ist
    systemctl is-active --quiet ssh && ssh_active="true"

    # 1. Datei: fail2ban.local (IPv6 Support - nur wenn IPv6 aktiviert ist)
    if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
      local f2b_conf="/etc/fail2ban/fail2ban.local"
      if ! grep -q "allowipv6 = auto" "$f2b_conf" 2>/dev/null; then
        printf "➕ Konfiguriere IPv6-Unterstützung...\n"
        echo -e "[DEFAULT]\nallowipv6 = auto" | sudo tee "$f2b_conf" > /dev/null
      fi
    fi

    # 2. Datei: jail.local (Zentrale Konfiguration)
    printf "➕ Erstelle Jail-Datei: 'jail.local'...\n"
    sudo cat <<-EOF | sudo tee /etc/fail2ban/jail.local > /dev/null
[DEFAULT]
ignoreip = 127.0.0.1/8 ::1 $my_ip
bantime  = 86400
maxretry = 5
backend  = systemd

[sshd]
enabled = $ssh_active
port    = ssh
filter  = sshd

[apache-auth]
enabled = $apache_active
filter  = apache-auth
port    = http,https
logpath = /var/log/apache2/error.log

[lighttpd-custom]
enabled = $lighttpd_active
port    = http,https
logpath = /var/log/lighttpd/error.log
filter  = lighttpd-custom
EOF

    # 3. Webmin-Manager Jail Logik (Nur wenn Webmin aktiv ist)
    if [[ "$webmin_active" == "true" ]]; then
        printf "➕ Erstelle Jail-Datei 'webmin.conf'...\n"
        sudo cat <<-EOF | sudo tee /etc/fail2ban/jail.d/webmin.conf > /dev/null
[webmin-auth]
enabled = $webmin_active
port    = 10000
filter  = webmin-auth
backend = systemd
EOF
    else
        sudo rm -f /etc/fail2ban/jail.d/webmin.conf 2>/dev/null
        printf "\n🧹 Die grafische Oberfläche 'Webmin-Manager' wurde nicht gefunden – Jail-Datei wird entfernt!\n"
    fi

    # Neustart und Status-Ausgabe
    printf "\n🔄 Der 'Fail2Ban' Dienst wird neu gestartet...\n\n"
    sudo systemctl restart fail2ban
    sleep 5
    if systemctl is-active --quiet fail2ban; then
        printf "\n✅ Die 'Fail2Ban' Konfiguration ist abgeschlossen:\n"
        printf "👉 - SSH:      $([[ "$ssh_active" == "true" ]] && echo "AKTIV ✅" || echo "INAKTIV ❌")\n"
        printf "👉 - Webmin:   $([[ "$webmin_active" == "true" ]] && echo "AKTIV ✅" || echo "INAKTIV ❌")\n"
        printf "👉 - Webserver: $([[ "$apache_active" == "true" || "$lighttpd_active" == "true" ]] && echo "AKTIV ✅" || echo "INAKTIV ❌")\n\n"
    else
        printf "\n❌ Fehler beim Starten von 'Fail2Ban' - Abbruch!\n\n"
    fi
 printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
 read -n 1 -s -r
 clear # Bildschirm leeren
}

storagestatus() {
    local param="$1"
    if command -v pihole >/dev/null 2>&1; then
        printf "\n"
        printf "===========================================\n"
        printf "🗄️  Pi-hole SPEICHER-STATUS\n"
        printf "==========================================="

        # 1. Root-Partition und Laufwerk ermitteln
        local root_part=$(findmnt -n -o SOURCE /)
        local parent_disk=$(lsblk -no PKNAME "$root_part")
        
        # 2. Disk-Info und Datenbankgrößen
        local fmt='s/\([0-9]\)\([GKkM]\)/\1 \2B/'
        local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%/ %/')
        
        local g_db="/etc/pihole/gravity.db"
        local f_db="/etc/pihole/pihole-FTL.db"
        local gravity_size=$(sudo du -sh "$g_db" 2>/dev/null | awk '{print $1}' | sed "$fmt")
        local ftl_size=$(sudo du -sh "$f_db" 2>/dev/null | awk '{print $1}' | sed "$fmt")

        # 3. Formatierte Ausgabe mit fester Breite 
        printf "\n💾 %-22s: %s (%s)\n" "Laufwerk" "/dev/$parent_disk" "${root_part#/dev/}"
        printf "📍 %-23s: %s\n" "Datenträger belegt zu" "$disk_usage"
        printf "📝 %-22s: %s\n" "Blocklisten-Datenbank" "${gravity_size:-0 B}"
        printf "📈 %-22s: %s\n" "Statistik-Datenbank" "${ftl_size:-0 B}"
        printf -- "-------------------------------------------\n\n"
    else
        if [[ "$param" != "-phc" ]]; then
            printf "\n⚠️  Pi-hole ist nicht installiert. Der Speicherstatus kann nicht angezeigt werden! \n\n"
        fi
    fi
}

clearpiholelogs() {
    # Check: Ist Pi-hole installiert?
    if command -v pihole >/dev/null 2>&1; then
    printf "\n"
    printf "\n⚠️ WARNUNG: Dies wird das gesamte Query-Log und alle\n"
    printf "   Statistiken (Grafiken/Historie) dauerhaft löschen!\n\n"

    read -r -p "❓ Möchten Sie die Pi-hole Logs und Statistiken wirklich löschen? (ja/nein): " logconfirm

    if [[ "$logconfirm" == "ja" ]]; then
        printf "\n🧹 Lösche Pi-hole Logs und Statistiken - Bitte warten...\n\n"

        # 1. Dienst stoppen
        printf "\n🔄 Die Pi-hole FTL wird gestoppt - Bitte warten...\n\n\n"
        sudo systemctl stop pihole-FTL > /dev/null 2>&1
        sleep 5

        # 2. Die Statistik-Datenbank löschen
        if [ -f "/etc/pihole/pihole-FTL.db" ]; then
            sudo rm /etc/pihole/pihole-FTL.db
            printf "\n✅ Die Statistik-Datenbank wurde gelöscht.\n"
        fi

        # 3. Das Text-Log leeren
        if [ -f "/var/log/pihole/pihole.log" ]; then
            sudo truncate -s 0 /var/log/pihole/pihole.log
            printf "\n✅ Das Text-Log von Pi-hole wurde geleert.\n"
        fi

        # 4. Dienst wieder starten
        printf "\n🔄 Die Pi-hole FTL wird gestartet - Bitte warten...\n\n\n"
        sudo systemctl start pihole-FTL > /dev/null 2>&1
        sleep 5
        printf "✨ Alle Logs und Statistiken wurden erfolgreich gelöscht - Bitte warten...\n\n"
        if systemctl is-active --quiet pihole-FTL; then
        storagestatus # Speicher Status anzeigen
        fi
    else
        printf "\n🔄 Vorgang abgebrochen. Die Logs und Statistiken bleiben erhalten.\n\n"
    fi
    else 
    printf "\n⚠️ Pi-hole ist nicht installiert. Die Logs und Statistiken können nicht gelöscht werden! \n\n"
    fi
}

printserverinstall() {
     local ip_addr=$(hostname -I | awk '{print $1}')
     local param="$1"

     # 1. PRÜFUNG: Ist CUPS schon installiert?
     if dpkg -l | grep -q "^ii  cups "; then
        printf "\n🖨️  Der 'CUPS-Printserver' ist bereits auf diesem System installiert.\n\n"            
        printf "\n=====================================================\n"
        printf "✅ CUPS PRINT-SERVER ZUGANGSDATEN\n"
        printf "=====================================================\n"
        printf "🌐 Web-Interface:  http://%s:631\n" "$ip_addr"
        printf "👤 Admin-User:     %s\n" "$USER"
        printf "🔐 Passwort:       Systempasswort für den Login.\n"
        printf "=====================================================\n\n"
        return 0
    fi
    
    clear # Bildschirm leeren
    printf "\n\n" # Leerzeilen einfügen
    printf "==================================================\n"
    printf "============= EXTRA Optionen =====================\n"
    printf "==================================================\n\n\n"
    printf "\n❓ Möchten Sie jetzt den 'CUPS Print-Server' installieren? (ja/nein): "
    read -r cups_confirm

    if [[ "$cups_confirm" == "ja" ]]; then
    local cups_conf="/etc/cups/cupsd.conf"
        
        # 1. Systemupdate vorab
        if [[ "$param" != "-phi" ]]; then
        printf "\n🔄 Aktualisiere Systempakete (Update & Upgrade)...\n\n"
        sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade
        sudo apt --assume-yes autoremove
        sudo apt autoclean
        fi

        # 2. Installation von CUPS
        printf "\n\n🖨️ Die 'CUPS-Printserver' Pakete werden installiert - Bitte warten...\n\n"
        sleep 3
        if sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
            -o Dpkg::Options::="--force-confdef" \
            -o Dpkg::Options::="--force-confold" \
            cups printer-driver-gutenprint; then
            # 3. Konfiguration für Netzwerkzugriff
            clear # Bildschirm leeren
            printf "\n⚙️ CUPS: Netzwerkzugriff und Admin-Rechte werden konfiguriert - Bitte warten...\n\n"
            
            # Erlaubt Zugriff von anderen PCs im Netzwerk & Filesharing via cupsctl
            sudo cupsctl WebInterface=yes --remote-admin --remote-any --share-printers
            
            # Fügt den aktuellen User der Admin-Gruppe hinzu
            sudo usermod -aG lpadmin "$USER"

            # 4. CUPS Dienst aktivieren und neu starten 
            printf "\n🖨️ Der 'CUPS-Printserver' wird aktiviert - Bitte warten...\n\n"
            sudo systemctl enable --now cups > /dev/null 2>&1
            sudo systemctl restart cups > /dev/null 2>&1
            sleep 5 

            printf "\n=====================================================\n"
            printf "✅ CUPS PRINT-SERVER ERFOLGREICH INSTALLIERT\n"
            printf "=====================================================\n"
            printf "🌐 Web-Interface:  https://%s:631/admin\n" "$ip_addr"
            printf "👤 Admin-User:     %s\n" "$USER"
            printf "🔐 Passwort:       Systempasswort für den Login.\n"
            printf "=====================================================\n\n"
            printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
            read -n 1 -s -r
            clear # Bildschirm leeren
        else
            printf "\n❌ Fehler: Die Installation von 'CUPS-Printserver' ist fehlgeschlagen.\n\n"
            return 1
        fi
    else
        printf "\n⏭️ Die 'CUPS-Printserver' Installation wird übersprungen.\n\n"
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        clear # Bildschirm leeren
    fi
}

piholeinstall # Bei der Anmeldung - Pi-hole installieren wenn noch nicht geschehen.
