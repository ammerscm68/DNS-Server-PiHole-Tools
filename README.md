# DNS-Server Tools for easy interactive <br>
# installation of "Pi-Hole" and more (Raspberry Pi) <br>
<br>
****************************************************************************<br>
<strong>From Version 2 has been completely overhauled, including bug fixes.</strong><br>
****************************************************************************<br>
<br>
<br>
<strong>Individual commands:</strong>
<br>
piholeinstall &nbsp;&nbsp;&nbsp;(Intercative Installation of PiHole DNS-Server) <br>
addblocklists &nbsp;&nbsp;&nbsp;(Automatic add Blocklists for PiHole) <br>
addwhitedomains &nbsp;&nbsp;&nbsp;(Automatic add Allow Domains for PiHole) <br>
setstaticip &nbsp;&nbsp;&nbsp;(set static IPv4- and IPv6 Adress) - recommended <br>
webmininstall &nbsp;&nbsp;&nbsp;(Automatic Install "Webmin" for Raspberry Pi Management - [Optional]) <br>
autoupdate &nbsp;&nbsp;&nbsp;(Automatic System- and Blocklistupdates with a CronJob - [Optional]) <br>
upstreamdns &nbsp;&nbsp;&nbsp;(set Upstream from Pi-Hole to Cloudflare, OpenDNS or Quad9 or Combinations - ipv4 and ipv6) <br>
getipv4 &nbsp;&nbsp;&nbsp;(Displays the current IPv4 Address) <br>
getipv6 &nbsp;&nbsp;&nbsp;(Displays the current IPv6 Address) <br>
setfail2banjail &nbsp;&nbsp;&nbsp;(set the fail2ban config - see alias) <br>
storagestatus &nbsp;&nbsp;&nbsp;(Displays the Memory usage of the Pi-hole Databases) <br>
bootconfig  &nbsp;&nbsp;&nbsp;(Boot Customizations- USB, Bluetooth and WiFi) <br>
expandfilesystem &nbsp;&nbsp;&nbsp;(Enlarge partition if possible.) <br>
clearpiholelogs &nbsp;&nbsp;&nbsp;(delete Pi-Hole Logs) <br>
setrouterconfig &nbsp;&nbsp;&nbsp;(Display showing which Data must be entered into the Router) <br>
getroutermodel &nbsp;&nbsp;&nbsp;(Displays the Name of your Router) <br>
setiptables &nbsp;&nbsp;&nbsp;(Security Settings for Installed Programs (Pi-hole, Webmin, CUPS)  <br>
printserverinstall &nbsp;&nbsp;&nbsp;(Installs a CUPS Print-Server with many Printer drivers - [Optional])  <br>
<br>

---

<br>
Flash the image to a storage medium (USB stick or microSD card) and then <br>
replace the - .bashrc - file in the user's home directory. <br>
<br>
The installation process will start the next time you <strong>restart and login</strong>, and you will <br>
be guided interactively through the installation steps - <strong>and more</strong>. <br>
<br>
<strong>Pi-hole then queries the following directly:</strong>
<br>
<h3><strong>German:&nbsp;Protection against 46.336.073 "evil" Websites (as of May 25, 2026)</strong></h3>
<h3><strong> English: Protection against 15.129.371 "evil" Websites (as of May 25, 2026)</strong></h3>
