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
# Version 1.4 von Mario Ammerschuber
# -----------------------------------

checksudo() {
# Prüfen ob "Sudo" installiert ist
    if ! command -v sudo &> /dev/null; then
    printf "\n❌ Fehler: 'sudo' ist nicht installiert.\n\n"
    printf "\n📍 Bitte melden Sie sich als 'Root' an und installieren es mit: > apt update && apt upgrade && apt install sudo\n\n"
    return 1
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

    # 2. Vergleich: muss Version 12 (Bookworm) oder höher sein
    if (( os_ver >= 12 )); then
        printf "\n✅ Systemversion %s erkannt (OK).\n\n" "$os_ver"
        return 0
    else
        printf "\n❌ Fehler: Diese Funktionssammlung benötigt mindestens Version 12 (Bookworm) des Betriebssystems.\n\n"
        printf "\n⚠️ Deine aktuelle Version ist: %s\n\n" "$os_ver"
        printf "\n🚫 Leider müssen wir an dieser Stelle abbrechen.\n\n"
        return 1
    fi
}

checkpartitionsize() {
      # --- Systemsprache auf Deutsch umstellen und Partition Expandieren ------------------------
      if ! local_lang_de; then
          printf "\n🚀 Das System muss neu starten, um die Änderungen zu aktivieren.\n\n"
          printf "\n🔄 Der Neustart erfolgt in 15 Sekunden (Abbruch mit Strg+C)...\n\n"
          sleep 15
          sudo reboot
          return 1
      fi
      # ------------------------------------------------------------------------------------------
    printf "\n📊 Prüfe verfügbaren Speicherplatz...\n\n"
    # Liest die Größe von / in Kilobytes aus
    local root_size_kb=$(df / --output=size | tail -1)
    # Umrechnung in GB (durch 1024 / 1024)
    local root_size_gb=$((root_size_kb / 1024 / 1024))

    if [ "$root_size_gb" -lt 16 ]; then
        printf "\n⚠️ ACHTUNG: Die Partition ist nur %s GB groß.\n\n" "$root_size_gb"
        printf "\n❌ Pi-hole benötigt ein Speichermedium mit mindestens 16 GB für einen reibungslosen Betrieb.\n"
        printf "\n🛑 Vorgang wird abgebrochen !\n\n"
        return 1
    else
        printf "\n✅ Speicherplatz okay: %s GB erkannt.\n\n" "$root_size_gb"
        return 0
    fi
}

piholeinstall() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    # Vorab-Check: Ist Pi-Hole vielleicht schon installiert ?
    if command -v pihole >/dev/null 2>&1; then
    return 0 # Installation abbrechen
    fi

    # Prüfen ob genug Speicherplatz vorhanden ist (min. 16 GB)
    checkpartitionsize || return 1

    # ******************************************************
    setstaticip // Check ob eine statische IP vorhanden ist
    # ******************************************************

    printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
    read -n 1 -s -r
    clear
    printf "==================================\n\n"
    printf "🏠 Pi-Hole Installations-Assistent\n"
    printf "==================================\n\n"
    printf "\nℹ️  Das offizielle Installations-Skript wird geladen...\n\n"
    #---------------------------------------------------------------------------------------------------
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
      printf "\n⚠️  Hinweis: Der Raspberry PI sollte eine ***feste*** IP-Adresse haben.\n\n"
    fi
    # -------------------------------------------------------------------------------------------------
    read -p "❓ Jetzt mit der Installation von Pi-Hole beginnen? (ja/nein): " confirm
    if [[ "$confirm" == "ja" ]]; then
        clear # Bildschirm leeren
        printf "\n🚀 Starte Systemaktualisierung - Bitte warten...\n\n\n"
        sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade &&  sudo apt --assume-yes autoremove && sudo apt autoclean
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" curl # curl installieren wenn noch nicht vorhanden
        clear # Bildschirm leeren
        printf "\n\n🚀 Starte Pi-Hole Download und Installation - Bitte warten...\n\n\n"
        sleep 3
        # Der offizielle curl-Befehl
        curl -sSL https://install.pi-hole.net | sudo bash
        printf "\n\n"
        # Zusätzliche Installationen (Achtung:  Nur für DEBIAN-Linux !!!)
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" sqlite3 # SQLite für Blocklist Import
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" mc # Midnight Commander
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" fail2ban # fail2ban installieren
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" iptables-persistent # iptables installieren

     # Check: Wurde Pi-Hole installiert ?
     if command -v pihole >/dev/null 2>&1; then
     printf "\n\n✅ Der DNS-Server (Pi-Hole) wurde erfolgreich installiert...\n\n\n"
     printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
     clear # Bildschirm leeren
     # Zur Sicherheit Cloudflare Upstream hinzufügen 
     setcloudflareupstream
     # Wir holen die IPv4-Adresse
     local IPv4
     IPv4=$(hostname -I | awk '{print $1}')
     printf "\nℹ️ Hinweis: Die IPv4-Adresse '%s' muß jetzt noch als DSN-Server im Router eingetragen werden .\n\n" "$IPv4"
     if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
     # Adresse auslesen
     local IPv6
     IPv6=$(ip -6 addr show | grep "scope global" | awk '{print $2}' | cut -d/ -f1 | head -n 1)
     printf "\nℹ️ Hinweis: Die IPv6-Adresse '%s' muß jetzt noch als DSN-Server im Router eingetragen werden .\n\n" "$IPv6"
     fi
     printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
     clear # Bildschirm leeren
     printf "\n\n\n"
     addblocklists # ***** Blocklisten hinzufügen *******
     printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
     if command -v iptables >/dev/null 2>&1; then
     clear # Bildschirm leeren
     printf "\n\n🚀 *** Tuning des Pi-Hole DNS-Server ... ***\n"
     # 1. ZUERST: Den Zugriff auf das Web-Interface für Dich selbst erlauben (WICHTIG!)
     sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
     sudo ip6tables -A INPUT -p tcp --dport 80 -j ACCEPT
     sudo iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
     sudo ip6tables -A INPUT -p tcp --dport 8080 -j ACCEPT
     sudo iptables -A INPUT -p tcp --dport 10000 -j ACCEPT
     sudo ip6tables -A INPUT -p tcp --dport 10000 -j ACCEPT

     # 2. DANACH: Den restlichen "Müll" blockieren
     sudo iptables -A INPUT -p tcp --destination-port 80 -j REJECT --reject-with tcp-reset
     sudo iptables -A INPUT -p tcp --destination-port 8080 -j REJECT --reject-with tcp-reset
     sudo iptables -A INPUT -p tcp --destination-port 10000 -j REJECT --reject-with tcp-reset
     sudo iptables -A INPUT -p tcp --destination-port 443 -j REJECT --reject-with tcp-reset
     sudo iptables -A INPUT -p udp --destination-port 80 -j REJECT --reject-with icmp-port-unreachable
     sudo iptables -A INPUT -p udp --destination-port 8080 -j REJECT --reject-with icmp-port-unreachable
     sudo iptables -A INPUT -p udp --destination-port 10000 -j REJECT --reject-with icmp-port-unreachable
     sudo iptables -A INPUT -p udp --destination-port 443 -j REJECT --reject-with icmp-port-unreachable

     sudo ip6tables -A INPUT -p tcp --destination-port 80 -j REJECT --reject-with tcp-reset
     sudo ip6tables -A INPUT -p tcp --destination-port 8080 -j REJECT --reject-with tcp-reset
     sudo ip6tables -A INPUT -p tcp --destination-port 10000 -j REJECT --reject-with tcp-reset
     sudo ip6tables -A INPUT -p tcp --destination-port 443 -j REJECT --reject-with tcp-reset
     sudo ip6tables -A INPUT -p udp --destination-port 80 -j REJECT --reject-with icmp6-port-unreachable
     sudo ip6tables -A INPUT -p udp --destination-port 8080 -j REJECT --reject-with icmp6-port-unreachable
     sudo ip6tables -A INPUT -p udp --destination-port 10000 -j REJECT --reject-with icmp6-port-unreachable
     sudo ip6tables -A INPUT -p udp --destination-port 443 -j REJECT --reject-with icmp6-port-unreachable
     # Regeln dauerhaft speichern (da du iptables-persistent installierst)
     echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
     echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
     sudo netfilter-persistent save
     printf "\n🎉 *** Tuning abgeschlossen ***\n\n"
     printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
     fi
     clear # Bildschirm leeren
     echo "" | sudo pihole setpassword ""  # Setzt ein leeres Passwort, was die Abfrage deaktiviert
     printf "\n"
     printf "#########################################################\n"
     printf "🎉 Pi-Hole Installation komplett abgeschlossen!\n"
     printf "🌐 Grafische Oberfläche aufrufen:\n"
     printf "👉 http://%s/admin\n" "$IPv4"
     printf "=========================================================\n"
     printf "🔐 Passwort: DEAKTIVIERT (kein Login nötig)\n"
     printf "=========================================================\n"
     printf "#########################################################\n"
     printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
     read -n 1 -s -r
     clear # Bildschirm leeren
     # Fragen ob "Webmin" installiert werden soll wenn noch nicht installiert
     webmininstall install
     clear # Bildschirm leeren
     # Fail2Ban aktivieren
     setfail2banjail
     printf "\n\n\n"
     read -r -p "❓ Soll ein automatisches System-Update eingerichtet werden ? (ja/nein): " au_antwort
     printf "\n"
     if [ "$au_antwort" = "ja" ]; then
     # Auto-Update erstellen
     autoupdate -c
     fi
     printf "\n🚀 Es erfolgt ein abschließender Neustart des Systems.\n\n"
     printf "\n🔄 Der Neustart erfolgt in 15 Sekunden (Abbruch mit Strg+C)...\n\n"
     sleep 15
     sudo reboot
     return 1
      else
       printf "\n❌ Fehler: Der DNS-Server (Pi-Hole) konnte nicht installiert werden !\n\n"
       return 1
    fi
    else
        printf "\n⚠️ Installation durch Benutzer abgebrochen!\n\n"
        return 1
    fi
}

setcloudflareupstream() {
# Check: Wurde Pi-Hole installiert ?
if command -v pihole >/dev/null 2>&1; then
local dns_servers
# --- IPv4 & IPv6 UPSTREAM AKTIVIEREN (Cloudflare) ---
if ip -6 addr show | grep -q "scope global"; then
    printf "\n🧬 IPv4 & IPv6 erkannt. Aktiviere Cloudflare Upstream DNS...\n\n"
    
    # Cloudflare IPv4 & IPv6 Adressen im Pi-hole v6 JSON-Format
    dns_servers="[ \"1.1.1.1\", \"1.0.0.1\", \"2606:4700:4700::1111\", \"2606:4700:4700::1001\" ]"
    
    # In Pi-hole v6 die Konfiguration setzen
    sudo pihole-FTL --config dns.upstreams "$dns_servers" > /dev/null 2>&1
    
    # Dienst neu starten, um Änderungen zu übernehmen
    sudo systemctl restart pihole-FTL
    printf "\n✅ Cloudflare IPv4 und IPv6 Upstream-Server wurden hinzugefügt.\n\n"
else
   # --- IPv4 UPSTREAM AKTIVIEREN (Cloudflare) ---
   printf "\n🧬 Nur IPv4 erkannt. Aktiviere Cloudflare Upstream DNS...\n\n"
    
    # Cloudflare IPv4 im Pi-hole v6 JSON-Format
    dns_servers="[ \"1.1.1.1\", \"1.0.0.1\" ]"
    
    # In Pi-hole v6 die Konfiguration setzen
    sudo pihole-FTL --config dns.upstreams "$dns_servers" > /dev/null 2>&1
    
    # Dienst neu starten, um Änderungen zu übernehmen
    sudo systemctl restart pihole-FTL
    printf "\n✅ Cloudflare IPv4 Upstream-Server wurden hinzugefügt.\n\n"
    fi
     else
     printf "\n⚠️ Pi-hole ist nicht installiert. Upstream-Konfiguration wird übersprungen.\n\n"
fi
}

addblocklists() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

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
    )
    printf "🚀 Starte automatischen Import von weiteren %s Blocklisten - Bitte etwas Geduld...\n\n" "${#blocklists[@]}"
    printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
    read -n 1 -s -r

    for url in "${blocklists[@]}"; do
        printf "➕ Verarbeite Blockliste: %s\n" "$url"
        # INSERT OR IGNORE verhindert Duplikate, falls die Liste schon existiert
        sudo sqlite3 /etc/pihole/gravity.db \
        "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$url', 1, 'Auto-Setup');"
    done
    clear # Bildschirm leeren
    printf "\n\n🔄 Aktualisiere Pi-Hole Gravity - Bitte warten...\n\n"
    sudo pihole -g
    printf "\n\n\n✅ Fertig! Alle Listen sind aktiv. Der DNS-Server ist bereit.\n\n"
}

getipv4() {
 # Wir holen die IP-Adresse
 local IPv4
 IPv4=$(hostname -I | awk '{print $1}')
 if [[ -n "$IPv4" ]]; then
 printf "\nℹ️ Die IPv4-Adresse lautet: '%s'\n\n" "$IPv4"
 else
 printf "\n⚠️ Keine IPv4-Adresse gefunden!\n\n"
 fi  
}

getipv6() {
# Adresse auslesen
if ip -6 addr show 2>/dev/null | grep -q "scope global"; then
local IPv6
IPv6=$(ip -6 addr show | grep "scope global" | awk '{print $2}' | cut -d/ -f1 | head -n 1)
printf "\nℹ️ Die IPv6-Adresse lautet: '%s'\n\n" "$IPv6"
else
printf "\nℹ️ Die IPv6-Adresse lautet: keine\n"
printf "\n🌐 Die Verwendung einer IPv6-Adresse ist wahrscheinlich im Router deaktiviert.\n\n"
fi
}

setstaticip() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    # Wenn der Networkmanager nicht installiert ist dann noch installieren
    if ! command -v nmcli >/dev/null 2>&1; then
    printf "\n\nℹ️ Der 'Netzwerk-Manager' muss noch installiert werden - Bitte warten...\n\n"
    sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade &&  sudo apt --assume-yes autoremove && sudo apt autoclean
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" network-Manager # Netzwerkmanager installieren
    printf "\n\n🚀 Das System muss neu starten um den 'Netzwerk-Manager' zu aktivieren.\n\n"
    printf "\n🔄 Der Neustart erfolgt in 15 Sekunden (Abbruch mit Strg+C)...\n\n"
    sleep 15
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
        printf "\n✅ Das Interface [%s] nutzt eine STATISCHE IP-Adresse.\n\n" "$interface"
        return 0
    fi

    # Wenn die Flag-Datei existiert, überspringen wir die Abfrage
    if [[ -f "$skip_file" ]]; then
        return 0  # Benutzer hatte sich für DHCP entschieden
    fi

    # 3. Umstellung anbieten
    printf "\n🌐 Aktueller Status für [%s]: DHCP (Dynamische IP-Adresse)\n\n" "$interface"
    printf "\n\n"
    read -r -p "❓ Möchten Sie jetzt auf eine STATISCHE IPv4-Adresse umstellen? (ja/nein/nie): " sip_antwort

    if [[ "$sip_antwort" == "ja" ]]; then
        clear # Bildschirm leeren
        printf "\n\n\n--- Konfiguration der statischen IP-Adresse ---\n"
        printf "\nℹ️  Hinweis: Wählen Sie eine IP-Adresse außerhalb des DHCP-Pools.\n\n"
        printf "      (z.Bsp. FritzBox meist: .2 bis .19 oder .201 bis .253)\n\n"

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
            read -r -p "👉 statische IP-Adresse [Vorschlag: ${base_ip}.212]: " new_ip
            new_ip=${new_ip:-"${base_ip}.212"}

            if ! validate_ip "$new_ip"; then
                printf "\n❌ Fehler: '%s' ist keine gültige IP-Adresse (0-254, Ende nicht 0/255)!\n\n" "$new_ip"
                continue
            fi

            printf "\n🔍 Prüfe ob IP-Adresse %s frei ist...\n\n" "$new_ip"
            if ping -c 1 -W 1 "$new_ip" >/dev/null 2>&1; then
                printf "\n❌ BELEGT: Ein anderes Gerät nutzt bereits diese IP-Adresse!\n\n"
            else
                break
            fi
        done

        # --- GATEWAY IP-Adresse ---
        local new_gw
        local def_gw="${current_gw:-${base_ip}.1}"
        while true; do
            read -r -p "👉 Gateway IP-Adresse (Router) - [Vorschlag: $def_gw]: " new_gw
            new_gw=${new_gw:-"$def_gw"}
            # KORREKTUR: ! für "Wenn NICHT gültig", dann Fehlermeldung
            if ! validate_ip "$new_gw"; then
                printf "\n❌ Fehler: '%s' ist keine gültige Gateway IP-Adresse!\n\n" "$new_gw"
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
        # Prüfen, ob die Einstellungen im NetworkManager-Profil angekommen sind
        local check_v6_method=$(nmcli -g ipv6.method connection show "$conn_name")
        local check_v6_privacy=$(nmcli -g ipv6.ip6-privacy connection show "$conn_name")
        if [[ "$check_v6_method" == "auto" && "$check_v6_privacy" == "0" ]]; then
        printf "\n✅ IPv6-Konfiguration (EUI-64) wurde erfolgreich hinterlegt.\n\n"
        else
        printf "\n⚠️ Warnung: IPv6-Einstellungen konnten nicht verifiziert werden.\n"
        printf "\n🌐 IPv6 ist wahrscheinlich nicht auf Ihrem Router aktiviert.\n\n"
        fi
        # ----------------------- IPv6 ----------------------------------------------
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        printf "\n\n🚀 Neustart in 15 Sekunden, um auf die neuen IP-Adressen umzustellen - Bitte warten...\n\n"
        sleep 15
        sudo reboot
        exit 0

    elif [[ "$sip_antwort" == "nie" ]]; then
        printf "DNS-Server - Benutzer hat sich am $(date +'%d.%m.%Y um %H:%M') für eine DHCP-Adresse entschieden!" > "$skip_file"
        printf "\n✅ Die IP-Adresse des DNS-Server bleibt auf DHCP Konfiguration. (Aktuell: %s)\n\n" "$current_ip"
        sudo nmcli connection modify "$conn_name" \
        ipv6.method "auto" \
        ipv6.addr-gen-mode "eui64" \
        ipv6.ip6-privacy 0
    else
        printf "\n🔄 Abbruch. Die IP-Adresse bleibt vorerst auf DHCP. (Aktuell: %s)\n\n" "$current_ip"
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

    # Prüfen ob "Webmin" bereits installiert ist
    printf "\n🔍 Prüfe Installationsstatus von grafischer Oberläche 'Webmin'...\n\n"

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
        printf "\b✅ fertig...\n"
        printf "\n🚀 Die grafische Oberfläche 'Webmin' ist bereits installiert.\n"
        # Extrahiert nur die Version sauber
        local version=$(echo "$check_result" | awk '{print $3}')
        printf "   -> Version: $version\n\n"
        printf "\n✅ Zugriff über: https://%s:10000\n\n" "$(hostname -I | awk '{print $1}')"
        printf "\b \b"
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        return 0
    else
        # Spinner sauber entfernen
        printf "\b \b" 
    fi

    printf "\n\n"
    read -r -p "❓ Möchten Sie die grafische Oberfläche 'Webmin' jetzt installieren? (ja/nein): " wmconfirm
    if [[ "$wmconfirm" == "ja" ]]; then
        printf "\n\n"
        printf "\n🚀 Starte Systemupdate - Bitte warten...\n\n"
        # Abhängigkeiten installieren (curl wird für das Skript benötigt)
        sudo dpkg --configure -a && sudo apt update && sudo apt --assume-yes upgrade && sudo apt --assume-yes dist-upgrade &&  sudo apt --assume-yes autoremove && sudo apt autoclean
        sudo apt-get install -y curl gnupg2 apt-transport-https

        printf "\n\n🚀 Starte Webmin-Installation - Bitte warten...\n\n"
        # Offizielles Webmin Repository-Setup-Skript laden und ausführen
        # Dies fügt automatisch den Key und die Sources hinzu
        curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
        sudo sh setup-repos.sh -f  # -f erzwingt die Ausführung ohne erneute Bestätigung

        # Webmin installieren
        sudo apt-get install -y webmin --install-recommends

        # Aufräumen
        rm setup-repos.sh

        # Firewall-Port 10000 freischalten (falls UFW aktiv ist)
        # if command -v ufw > /dev/null; then
        #    sudo ufw allow 10000/tcp
        #    sudo ufw reload
        # fi

        printf "\n✅ Die grafische Oberfläche 'Webmin' wurde installiert. -  Zugriff über: https://%s:10000\n\n" "$(hostname -I | awk '{print $1}')"
        # Logik für den Reboot anpassen
       if [[ "$param" == "install" ]]; then
        printf "⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        else
        # Standard-Verhalten ohne den Parameter "install"
        printf "\n\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
        printf "\n🚀 Das System muss neu starten, um 'Webmin' zu aktivieren.\n\n"
        printf "\n🔄 Der Neustart erfolgt in 15 Sekunden (Abbruch mit Strg+C)...\n\n"
        sleep 15
        sudo reboot
        fi
    else
        printf "\n⏩ Die grafische Oberfläche 'Webmin' wird ***nicht*** installiert.\n\n"
        printf "\n⌨️ Weiter mit beliebiger Taste...\n\n"
        read -n 1 -s -r
    fi
}

autoupdate() {
    # Prüfen ob "sudo" installiert ist
    checksudo || return 1

    local script_path="/home/$USER/systemupdate.sh"
    local log_path="/home/$USER/systemupdate.log"
    local param="$1"
    local cron_entry=$(cat <<EOF
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
0 2 * * 2 $script_path
EOF
)
    # --- OPTION: DEAKTIVIEREN (-d) ---
    if [[ "$param" == "-d" ]]; then
        if [[ ! -f "$script_path" ]]; then
            printf "\n⚠️ Abbruch: Keine 'Autoupdate'-Datei '%s' gefunden.\n\n" "$script_path"
            return 1
        fi

        read -r -p "❓ Soll das 'Autoupdate' wirklich deaktiviert werden? (ja/nein): " auconfirm
        if [[ "$auconfirm" == "ja" ]]; then
            # Datei löschen
            rm "$script_path" > /dev/null && rm "$log_path" > /dev/null
            # Cronjob aus crontab entfernen
            (crontab -l 2>/dev/null | grep -vF "$script_path") | crontab -
            printf "\n✅ Auto-Update wurde deaktiviert.\n\n"
        else
            printf "\n🔄 Der Vorgang wurde abgebrochen.\n\n"
        fi
        return 0
    fi

    # --- OPTION: ERSTELLEN (-c) ---
    if [[ "$param" == "-c" ]]; then
        if [[ -f "$script_path" ]]; then
            printf "\n\n"
            read -r -p "⚠️ Das 'Autoupdate' existiert bereits. Überschreiben? (ja/nein): " overwrite
            [[ "$overwrite" != "ja" ]] && { printf "\n⚠️ Der Vorgang wurde abgebrochen.\n\n"; return 1; }
        fi

        # Datei erstellen mit Here-Doc (Nutzt $USER dynamisch)
        cat <<EOF > "$script_path"
#!/bin/bash
rm -f "$log_path"
date > "$log_path" 2>&1
sudo pihole disable >> "$log_path" 2>&1
sudo apt-get update >> "$log_path" 2>&1
sudo apt-get --assume-yes upgrade >> "$log_path" 2>&1
sudo apt-get --assume-yes dist-upgrade >> "$log_path" 2>&1
sudo apt-get --assume-yes upgrade --fix-missing >> "$log_path" 2>&1
sudo apt-get --assume-yes autoremove >> "$log_path" 2>&1
sudo apt-get autoclean >> "$log_path" 2>&1
sudo pihole -up >> "$log_path" 2>&1
sudo pihole enable >> "$log_path" 2>&1
echo "***Neustart***" >> "$log_path" 2>&1
sudo reboot >> "$log_path" 2>&1
EOF
        # Ausführbar machen
        chmod +x "$script_path"

        # --- NEUE CRONTAB HIER ---
        local current_cron
        current_cron=$(crontab -l 2>/dev/null)

        if [[ -z "$current_cron" ]]; then
            # Crontab ist leer: Nur cron_entry schreiben
            echo "$cron_entry" | crontab -
        else
            # Crontab existiert: Alten Job entfernen, neuen cron_entry anhängen
            (echo "$current_cron" | grep -vF "$script_path"; echo "$cron_entry") | crontab -
        fi
        printf "\n✅ Das 'Autoupdate' '%s'  wurde erstellt.\n\n" "$script_path"
        printf "\n📅 Planung: Automatisches Systemupdate für jeden Dienstag um 02:00 Uhr wurde eingerichtet.\n\n"
        return 0
    fi

    # Falscher oder kein Parameter
    printf "\n⚠️ Ungültiger Parameter: - Nutzung von 'Autoupdate': autoupdate [-c | -d]\n\n"
    printf "🔄  -c : Erstellen & Aktivieren\n"
    printf "🔄  -d : Deaktivieren & Löschen\n\n"
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
        checkosversion || return 1
        export LC_ALL=C.UTF-8
        export LANG=C.UTF-8
        export LANGUAGE=C.UTF-8
        printf "\n🌐 Stelle Systemsprache und Tastatur auf Deutsch um - Bitte warten...\n\n\n"

        # Tastatur-Konfiguration schreiben
        cat <<EOF | sudo tee /etc/default/keyboard > /dev/null
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
        printf "\n💾 Expandiere Dateisystem auf maximale Größe...\n"
        # Der Befehl markiert die Partition für die Erweiterung beim nächsten Boot
        if sudo raspi-config --expand-rootfs > /dev/null 2>&1; then
        printf "\n✅ Erfolg: Die Partition wird beim nächsten Neustart vergrößert.\n"
        else
        printf "❌ Fehler: Dateisystem konnte nicht expandiert werden.\n"
        fi
        return 1
    else
        printf "\nℹ️ Systemsprache und Tastatur sind bereits auf Deutsch eingestellt.\n"
        return 0
    fi
}

setfail2banjail() {
    printf "\n🛡️  Konfiguriere Fail2Ban Schutz (SSH, Webmin & IPv6)...\n\n"
    
    # Aktuelle IP für die Whitelist ermitteln
    local my_ip
    my_ip=$(hostname -I | awk '{print $1}')
    
    # 1. Datei: /etc/fail2ban/fail2ban.local (IPv6-Unterstützung)
    local f2b_conf="/etc/fail2ban/fail2ban.local"
    local ipv6_entry="allowipv6 = auto"

    if [ -f "$f2b_conf" ] && grep -qF "$ipv6_entry" "$f2b_conf"; then
        printf "\nℹ️  IPv6-Einstellung ist bereits in fail2ban.local vorhanden.\n\n"
    else
        printf "\n➕ Konfiguriere IPv6-Unterstützung...\n\n"
        if [ ! -f "$f2b_conf" ]; then
            echo "[DEFAULT]" | sudo tee "$f2b_conf" > /dev/null
        fi
        echo "$ipv6_entry" | sudo tee -a "$f2b_conf" > /dev/null
    fi

    # 2. Datei: /etc/fail2ban/jail.local (SSH & Allgemein)
    printf "\n➕ Erstelle jail.local (SSH-Schutz)...\n\n"
    sudo cat <<EOF | sudo tee /etc/fail2ban/jail.local > /dev/null
##### SSH Server Fail2Ban #####

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
bantime = 86400
ignoreip = whitelist-IP
backend = systemd

[apache-auth]
enabled = false
filter  = apache-auth
bantime = 86400
maxretry = 5
ignoreip = whitelist-IP

[lighttpd-custom]
enabled = false
filter = lighttpd-custom
port = http,https
logpath = /var/log/lighttpd/error.log
bantime = 86400
maxretry = 2
ignoreip = whitelist-IP
EOF

    # 3. Datei: /etc/fail2ban/jail.d/webmin.conf (Webmin Schutz)
    printf "\n➕ Erstelle webmin.conf (Port 10000)...\n\n"
    sudo cat <<EOF | sudo tee /etc/fail2ban/jail.d/webmin.conf > /dev/null
[webmin-auth]
enabled = true
port    = 10000
filter  = webmin-auth
logpath = /var/log/auth.log
maxretry = 5
bantime = 86400
ignoreip = whitelist-IP
backend = systemd
EOF

    # Neustart und Status
    printf "\n🔄 Starte Fail2Ban Dienst neu...\n\n"
    sudo systemctl restart fail2ban
    
    if systemctl is-active --quiet fail2ban; then
        printf "\n✅ Fail2Ban erfolgreich konfiguriert und aktiv.\n\n"
    else
        printf "\n❌ Fehler: Fail2Ban konnte nicht gestartet werden. Bitte Logs prüfen.\n\n"
    fi
}

piholeinstall # Bei der Anmeldung Pi-Hole installieren wenn noch nicht geschehen.
