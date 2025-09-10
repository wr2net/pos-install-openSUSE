#!/bin/bash

# SET COLORS USING tput
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
GREEN=$(tput setaf 2)
NC=$(tput sgr0)

APP_DIR="applications/"
ICONS_DIR="icons/"
IMAGES_DIR="images/"
LAYOUT_DIR="layout/"

clear
echo -e "${YELLOW} 00. Add Additional Repositories\n ${NC}"
sudo zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_$releasever/Essentials' packman-essentials
sudo zypper ar -cfp 90 'http://codecs.opensuse.org/openh264/openSUSE_Leap/' Open-H264
sudo zypper ar -cfp 90 'https://dl.google.com/linux/chrome/rpm/stable/x86_64' Google-Chrome
sudo zypper ar -cfp 90 'https://download.nvidia.com/opensuse/leap/$releasever' NVidia
sudo zypper ar -cfp 90 'https://download.opensuse.org/repositories/system:/snappy/openSUSE_Leap_$releasever' SNAPPY
sudo zypper ar -cfp 90 'https://repo.vivaldi.com/archive/rpm/x86_64' Vivaldi
sudo zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_$releasever/' Packman
sudo zypper ar -cfp 90 'https://download.opensuse.org/repositories/mozilla/openSUSE_Leap_$releasever/' Mozilla

sudo zypper --gpg-auto-import-keys refresh
sudo zypper dup --from snappy
sudo zypper install snapd
sudo systemctl enable --now snapd
sudo systemctl enable --now snapd.apparmor
echo -e "${GREEN} Repositories successfully applied! ${NC}"

echo -e "${YELLOW} 01. Distro Update\n ${NC}"
sudo zypper dup
echo -e "${GREEN} Distro Update successfully! ${NC}"

echo -e "${YELLOW} 02. Install Software\n ${NC}"
echo -e "${CYAN} 02.1. Install Software - Zypper\n ${NC}"
sudo zypper in -y docker docker-compose filezilla git git-core mysql gimp-save-for-web terminator mozilla-thunderbird dbeaver rclone neofetch notepadqq vivaldi alien
echo -e "${GREEN} Zypper successfully applied! ${NC}"

echo -e "${CYAN} 02.2. Install Software - Snap\n ${NC}"
sudo snap install drawio
sudo snap install insomnia
sudo snap install kesty-whatsapp
sudo snap install opera
sudo snap install slack
sudo snap install spotify
sudo snap install teams-for-linux
sudo snap install marktext
echo -e "${GREEN} Snap successfully applied! ${NC}"

echo -e "${CYAN} 02.3. Install Software - RPM\n ${NC}"
# shellcheck disable=SC2164
cd "${APP_DIR}rpm/"
rpm -ivh -y anydesk.rpm
rpm -ivh -y dbeaver.rpm
rpm -ivh -y google-chrome.rpm
rpm -ivh -y jdk.rpm
rpm -ivh -y jre.rpm
rpm -ivh -y rustdesk.rpm
rpm -ivh -y zoom.rpm
echo -e "${GREEN} RPM successfully applied! ${NC}"

echo -e "${YELLOW} 03. Wallpaper Apply\n ${NC}"
WALLPAPER_PATH="${IMAGES_DIR}wallpaperbetter.jpg"

for i in $(qdbus org.kde.plasmashell /PlasmaShell getActivities); do
    qdbus org.kde.plasmashell /PlasmaShell setWallpaper "$i" "$WALLPAPER_PATH"
done

for screen in $(qdbus org.kde.plasmashell /PlasmaShell getScreens); do
    qdbus org.kde.plasmashell /PlasmaShell setWallpaper "$screen" "$WALLPAPER_PATH"
done
echo -e "${GREEN} Wallpaper successfully applied! ${NC}"

echo -e "${YELLOW} 04. Install Softwares - TAR\n ${NC}"
# shellcheck disable=SC2164
cd ../../${ICONS_DIR}
cp *.desktop ~/.local/share/applications/

mkdir -P ~/Programas/TAR/
# shellcheck disable=SC2164
cd ../"${APP_DIR}tar/"
# shellcheck disable=SC2164
cp * ~/Programas/TAR/
# shellcheck disable=SC2164
cd ~/Programas/TAR/
tar -xvzf discord.tar.gz
tar -xvzf postman.tar.gz
tar -xvzf firefox.tar.xz
tar -xvzf caffeine.tar.xz

# shellcheck disable=SC2164
cd plasma-applet-caffeine-plus-master
sudo sh install

echo -e "${GREEN} TAR successfully applied! ${NC}"

echo -e "${YELLOW} 05. Add Icons && Theme\n ${NC}"
# shellcheck disable=SC2164
cd "${LAYOUT_DIR}icons/"
cp *.gz ~/.icons/
# shellcheck disable=SC2164
cd "${LAYOUT_DIR}themes/"
cp *.gz ~/.themes/

echo -e "${GREEN} Icons && Theme successfully applied! ${NC}"

echo -e "${GREEN} End Installation\n ${NC}"