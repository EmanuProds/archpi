#!/bin/bash
#
# Facilitate post installation Arch Linux in minutes personalizated.
#
# Website:       https://archlinux.org/
# Author:        Emanuel Pereira
#
# ------------------------------------------------------------------------ #

## directorys ##
# src directory
API_SRC_DIR="./src"

# sudo config file
SUDOERS_FILE="/etc/sudoers"

# config directory
CONFIG_DIR="$HOME/.config"

# local directory
LOCAL_DIR="$HOME/.local/share"

# fish directory
FISH_DIR="$HOME/.config/fish"
FISH_CONFD="$HOME/.config/fish/conf.d"

# extensions directory
EXTENSIONS_DIR="$HOME/.local/share/gnome-shell/extensions"

# plymouth spinner directory
SPINNER_DIR="/usr/share/plymouth/themes/spinner"
SPINNER_CONFIG="$SPINNER_DIR/spinner.plymouth"

# mkinitcpio config file
MKINITCPIO_CONFIG="/etc/mkinitcpio.conf"

# locale config file
LOCALE="/etc/locale.gen"

# nobeep config file
NOBEEP="/etc/modprobe.d/nobeep.conf"

## gnome extensions ##
ADW_GTK3_COLORIZER="8084"
SYSTEM_MONITOR="6807"
CAFFEINE="517"
MONITOR_VOLUME_DDCUTIL="6325"
TOUCHPAD_TOGGLE="7000"
HOT_EDGE="4222"
TASKS_PANEL="8642"
SHOTZY="9707"
JUST_PERFECTION="3843"
TILING_SHELL="7065"
GSCONNECT="1319"
BLUETOOTH_BATTERY_METER="6670"
AUTO_POWER_PROFILE="6583"
EXTENSIONS=($ADW_GTK3_COLORIZER $SYSTEM_MONITOR $CAFFEINE $MONITOR_VOLUME_DDCUTIL $TOUCHPAD_TOGGLE $HOT_EDGE $TASKS_PANEL $SHOTZY \
    $JUST_PERFECTION $TILING_SHELL $GSCONNECT $BLUETOOTH_BATTERY_METER $AUTO_POWER_PROFILE)

## terminal font colors ##
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
RESET="\033[0m"

## dialog theme ##
cat << EOF > /tmp/theme
screen_color = (WHITE,BLACK,OFF)
dialog_color = (BLACK,WHITE,OFF)
menubox_border_color = (BLACK,WHITE,ON)
title_color = (BLACK,WHITE,ON)

item_selected_color = (WHITE,BLACK,OFF)
tag_key_color = (BLUE,WHITE,OFF)
tag_selected_color = (WHITE,BLACK,OFF)
tag_key_selected_color = (WHITE,BLACK,OFF)

button_active_color = (WHITE,BLACK,ON)
button_inactive_color = (BLACK,WHITE,OFF)
button_label_active_color = (WHITE,BLACK,ON)
button_label_inactive_color = (BLACK,WHITE,OFF)

position_indicator_color = (WHITE,BLACK,OFF)
use_shadow = OFF
shadow_color = (BLACK,BLACK,ON)
EOF

export DIALOGRC=/tmp/theme

## packages variables ##
# system
BLOTWARE="gnome-connections gnome-contacts gnome-maps gnome-music gnome-software epiphany htop vim"
BASE="base-devel git nano wget curl cava fastfetch paru"
KERNEL="linux-cachyos linux-cachyos-headers"
SYSTEM_PACKAGES="pacman-contrib archlinux-appstream-data fish gdm-settings bazaar power-profiles-daemon resources topgrade gnome-epub-thumbnailer samba nautilus-share tesseract tesseract-data-por \
openssl gnome-tweaks fuse ddcutil grub-btrfs-support grub-hook gst-thumbnailers gufw"
SYSTEM_PACKAGES_AUR="gnome-extensions-cli grub-silent"
ARCHIVE="file-roller zip unzip p7zip unrar"
FONTS="ttf-dejavu ttf-liberation noto-fonts noto-fonts-emoji noto-fonts-cjk"
PRINTERS="cups gutenprint gutenprint-cups cups-pdf bluez-cups bluez-utils foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds \
foomatic-db-nonfree-ppds foomatic-db-ppds"
FLATPAK_PACKAGE_SYSTEM="io.github.flattool.Warehouse com.github.tchx84.Flatseal it.mijorus.gearlever io.github.flattool.Ignition \
com.mattjakeman.ExtensionManager com.github.tchx84.Flatseal page.codeberg.libre_menu_editor.LibreMenuEditor"

# drivers
GRAPHICS_CARD_DRIVERS="lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader"
FFMPEG="ffmpeg ffmpegthumbnailer"
HA="libva libva-utils"
FLATPAK_FFMPEG="org.freedesktop.Platform.ffmpeg-full/x86_64/24.08 org.freedesktop.Platform.ffmpeg-full/x86_64/23.08
org.freedesktop.Platform.ffmpeg-full/x86_64/22.08"

# apps
APPS="remmina gimp inkscape handbrake zen-browser-bin"
APPS_AUR="anydesk-bin gpu-screen-recorder-gtk"
OFFICE="libreoffice-fresh libreoffice-fresh-pt-br"
FLATPAK_APPS="be.alexandervanhee.gradia io.github.diegoivan.pdf_metadata_editor com.obsproject.Studio io.github.flattool.Ignition org.pitivi.Pitivi \
io.gitlab.adhami3310.Impression io.anytype.anytype org.nickvision.tubeconverter com.microsoft.Edge io.github.giantpinkrobots.varia io.github.diegoivan.pdf_metadata_editor"

# development
IDE="zed visual-studio-code-bin"
CONTAINERS="podman podman-compose docker containerd.io docker-compose docker-compose"
DEV_PACKAGES="python-pip kubectl mise github-cli starship android-tools tailscale opencode"
DEV_PACKAGES_AUR="bdf-unifont linuxtoys"
FLATPAK_DEV_APPS="io.github.shonebinu.Brief me.iepure.devtoolbox rest.insomnia.Insomnia io.podman_desktop.PodmanDesktop io.dbeaver.DBeaverCommunity"
JETBRAINS_FONTS="jetbrains-mono-nerd-fonts jetbrains-mononl-nerd-fonts"
MICROSOFT_FONTS=" ttf-ms-fonts cabextract fontconfig"

# virtualization
VIRT_APPS="winboat gnome-boxes"

# games
GAMING="steam gamemode gamescope protonplus protontricks mangojuice heroic-games-launcher adwsteamgtk prismlauncher"
GAMING_AUR="adwsteamgtk eden-bin"
FLATPAK_GAMING="com.steamgriddb.SGDBoop net.retrodeck.retrodeck io.github.hedge_dev.hedgemodmanager"

# wine
WINE="proton-cachyos proton-cachyos-slr wine-ge-custom winetricks wine-mono wine-gecko icoutils"
FLATPAK_WINE="com.usebottles.bottles"

# personalization
ICONS="adwaita-colors-icon-theme morewaita-icon-theme morewaita-icon-theme"
THEME="adw-gtk-theme"
PLYMOUTH="plymouth"
FLATPAK_THEME="org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark"
GRADIA_EXTENSION="gnome-shell-extension-gradia-capture-git"

## dependencies to inicialize ##
# zenity installation
if pacman -Qi zenity &> /dev/null; then
    echo -e "${GREEN}The zenity package is already installed. Skipping...${RESET}"
    sleep 1.5
else
    echo -e "${YELLOW}Installing zenity...${RESET}"
    sudoz pacman -S --noconfirm zenity &> /dev/null
    sleep 1.5
fi

# sudo in memory with zenity
echo -e "${YELLOW}Requesting root access for operations...${RESET}"
SUDOPASSWORD=$(zenity --password --title="Authentication" --text="Enter your administrator password:")

if [ -z "$SUDOPASSWORD" ]; then
    exit 1
fi

trap 'SUDOPASSWORD=""; unset SUDOPASSWORD' EXIT INT TERM

sudoz() {
    echo "$SUDOPASSWORD" | sudo -S "$@"
}

# shh key autenticate
echo -n "Do you want to configure theSSH key? (yes/no): "
read -r ANSWER

case "$ANSWER" in
    [Yy][Ee][Ss]|[Yy])
        echo -e "${YELLOW}Verifying SSH connection with GitHub...${RESET}"
        if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
            echo -e "${GREEN}SSH already configured! Ignoring...${RESET}"
        else
            echo -e "${YELLOW}Setting up an SSH key...${RESET}"
            eval "$(ssh-agent -s)"
            ssh-add ~/.ssh/id_ed25519 &> /dev/null || echo -e "${RED}Warning:${RESET} File ~/.ssh/id_ed25519 not found."
            ssh -T git@github.com
        fi
        ;;
    *)
        echo -e "${YELLOW}Skipping SSH configuration...${RESET}"
        ;;
esac

# dialog installation
if pacman -Qi dialog &> /dev/null; then
    echo -e "${GREEN}The dialog package is already installed. Skipping...${RESET}"
    sleep 1.5
else
    echo -e "${YELLOW}Installing Dialog...${RESET}"
    sudoz pacman -S --noconfirm dialog &> /dev/null
    sleep 1.5
fi

# update system and remove blotwares
update_configs() {
    dialog --title "Wait" --infobox "\nRemove bloatwares..." 7 50
    {
    sudoz pacman -Sy --noconfirm; sudoz pacman -Rsc --noconfirm $BLOTWARE
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nSetting up Cachyos repositories..." 7 50
    {
    curl -fsSL https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
    tar xvf cachyos-repo.tar.xz
    rm cachyos-repo.tar.xz
    cd cachyos-repo
    yes | sudoz ./cachyos-repo.sh
    cd ..
    rm -rf cachyos-repo
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nSetting up Cachyos kernel..." 7 50
    {
    sudoz pacman -S --noconfirm $KERNEL
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nUptdate system...\nThis may take a few minutes." 7 50
    {
    sudoz pacman -Syu --noconfirm
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Process completed" --msgbox "\nThe system was successfully cleaned and updated!" 8 45
    }

# install system dependencies
dependencies() {
    dialog --title "Wait" --infobox "\nAdding asterisks to passwords inputs..." 7 50
    {
    if grep -q "pwfeedback" "$SUDOERS_FILE"; then
        dialog --title "Interrompido" --infobox "\nThe asterisks are already activated" 7 50
        sleep 1
    else
        sudoz sed -i "/Defaults/a Defaults pwfeedback" "$SUDOERS_FILE"

        if sudoz visudo -c; then
            dialog --title "Process completed" --infobox "\nConfiguration applied successfully!" 7 50
            sleep 5
        else
            sudoz sed -i "/Defaults pwfeedback/d" "$SUDOERS_FILE"
            dialog --title "Aborted" --msgbox "\nError validating sudoers file. Reverting changes..." 7 50
            sleep 1
        fi
    fi
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nAdding support for AUR..." 7 50
    {
    sudoz pacman -S --noconfirm $BASE
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nInstalling and configuring system dependencies..." 7 50
    {
    sudoz pacman -S -noconfirm $SYSTEM_PACKAGES $ARCHIVE $FONTS $PRINTERS
    sudoz pacman -Rdd --noconfirm grub
    echo "$SUDOPASSWORD" | paru -S --noconfirm --sudoflags "-S" $SYSTEM_PACKAGES_AUR
    sudoz grub-install --efi-directory=/boot/efi
    sudoz systemctl enable --now cups
    sudoz usermod -aG lp $USER
	sudoz usermod -aG saned,scanner $USER
    sudoz systemctl enable --now snapper-timeline.timer
    sudoz systemctl enable --now snapper-cleanup.timer
    sudoz timedatectl set-local-rtc 0 --adjust-system-clock
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nSetting up and installing system flatpaks..." 7 50
    {
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub -y $FLATPAK_PACKAGE_SYSTEM
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Process completed" --msgbox "\nRepositories and dependencies installed successfully!" 8 45
}

# install graphics drivers and enable video acceleration
video_multimedia() {
    dialog --title "Wait" --infobox "\nInstalling AMD video drivers..." 7 50
    {
    sudoz pacman -S --noconfirm $GRAPHICS_CARD_DRIVERS
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nAdding video acceleration..." 7 50
    {
    sudoz pacman -S --noconfirm $HA
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nAdding proprietary codecs..." 7 50
    {
    sudoz pacman -S --noconfirm $FFMPEG
    flatpak install flathub -y $FLATPAK_FFMPEG
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Process completed" --msgbox "\nThe video drivers were successfully configured!" 8 45
}

# apps and utilities
apps_and_utilities() {
    dialog --title "Wait" --infobox "\nInstalling essential applications..." 7 50
    {
    sudoz pacman -S --noconfirm $APPS
    echo "$SUDOPASSWORD" | paru -S --noconfirm --sudoflags "-S" $APPS_AUR
    sudoz pacman -S --noconfirm $OFFICE
    flatpak install flathub -y $FLATPAK_APPS
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Process completed" --msgbox "\nThe apps were installed successfully!" 8 45
}

# development dependencies
development() {
    dialog --title "Wait" --infobox "\nInstalling plugins..." 7 50
    {
    cp $API_SRC_DIR/.shell_aliases $HOME
    cp $API_SRC_DIR/.blerc $HOME
    cp $API_SRC_DIR/config.fish $FISH_DIR
    cp $API_SRC_DIR/aliases.fish $FISH_CONFD
    git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
    make -C ble.sh install PREFIX=~/.local
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nInstalling code editors..." 7 50
    {
    echo "$SUDOPASSWORD" | paru -S --noconfirm --sudoflags "-S" $IDE
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nInstalling containers and their dependencies..." 7 50
    {
    sudoz pacman -S --noconfirm $CONTAINERS
    sudoz usermod -aG docker $USER
    sudoz systemctl enable docker
    sudoz systemctl start docker
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nInstalling development tools..." 7 50
    {
    sudoz pacman -S --noconfirm $DEV_PACKAGES
    echo "$SUDOPASSWORD" | paru -S --noconfirm --sudoflags "-S" $DEV_PACKAGES_AUR
    flatpak install flathub -y $FLATPAK_DEV_APPS
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nSetting up the mise..." 7 50
    {
    cp $API_SRC_DIR/.bashrc $HOME
    source $HOME/.bashrc
    mkdir -p $LOCAL_DIR/bash-completion/completions/
    mise completion bash --include-bash-completion-lib > ~/.local/share/bash-completion/completions/mise
    mise use -g usage
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nInstalling programming dependencies with mise..." 7 50
    {
    mise use -g java@temurin-8
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nInstalling JetBrains Mono Nerd Font and Microsoft Fonts..." 7 50
    {
    sudoz pacman -S --noconfirm $JETBRAINS_FONTS
    echo "$SUDOPASSWORD" | paru -S --noconfirm --sudoflags "-S" $MICROSOFT_FONTS
    gsettings set org.gnome.desktop.interface monospace-font-name "JetBrainsMono Nerd Font 11"
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Process completed" --msgbox "\nYour system is ready for development!" 8 45
}

# installation virtualization and dependencies
winboat (){
    dialog --title "Wait" --infobox "\nInstalling Winboat and Gnome-Boxes..." 7 50
    {
    sudoz pacman -S --noconfirm $VIRT_APPS
    sudoz gpasswd -a libvirt $USER
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Process completed" --msgbox "\nThe virtualization apps were successfully installed!" 8 45
}

# gaming dependencies
gaming() {
    dialog --title "Wait" --infobox "\nInstalling Steam and Heroic Games Launcher..." 7 50
    {
    sudoz pacman -S --noconfirm $GAMING
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nInstalling gaming dependencies..." 7 50
    {
    echo "$SUDOPASSWORD" | paru -S --noconfirm --sudoflags "-S" $GAMING_AUR
    flatpak install flathub -y $FLATPAK_GAMING
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Process completed" --msgbox "\nYour system is ready for gaming!" 8 45
}

# wine dependencies
wine() {
    dialog --title "Wait" --infobox "\nInstalling Wine and dependencies..." 7 50
    {
    sudoz pacman -S --noconfirm $WINE
    flatpak install flathub -y $FLATPAK_WINE
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Process completed" --msgbox "\nO Wine foi instalado com sucesso!" 8 45
}

# personalize system and themes
personalize() {
    dialog --title "Wait" --infobox "\nCustomizing the system and themes..." 7 50
    {
    sudoz echo "pt_BR.UTF-8 UTF-8" >> $LOCALE
    sudoz locale-gen
    sudoz rmmod pcspkr
    sudoz echo "blacklist pcspkr" >> $NOBEEP
    echo "$SUDOPASSWORD" | paru -S --noconfirm --sudoflags "-S" $ICONS $THEME
    flatpak install flathub -y $FLATPAK_THEME
    gsettings set org.gnome.desktop.interface gtk-theme "Adw-gtk3-dark"
    gsettings set org.gnome.desktop.interface icon-theme "Adwaita-slate"
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nInstall gnome extensions..." 7 50
    {
    echo "$SUDOPASSWORD" | paru -S --noconfirm --sudoflags "-S" $GRADIA_EXTENSION
    for ext in "${EXTENSIONS[@]}"; do
        (gnome-extensions-cli install "$ext" && gnome-extensions-cli enable "$ext")
    done
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Wait" --infobox "\nSetting up Plymouth..." 7 50
    {
    sudoz rm $SPINNER_DIR/watermark.png
    sudoz sed -i "s/VerticalAlignment=.7/VerticalAlignment=.5/" $SPINNER_CONFIG
    sudoz sed -i "s/MODULES=()/MODULES=(amdgpu)" $MKINITCPIO_CONFIG
    sudoz sed -i "/^HOOKS=/s/\(udev \)/\1plymouth /" $MKINITCPIO_CONFIG
    sudoz plymouth-set-default-theme -R spinner
    } >> $HOME/archPI_logs.txt 2>&1
    sleep 1

    dialog --title "Process completed" --msgbox "\nThe system was successfully customized!" 8 45
}

# system cleanup
cleanup() {
    dialog --title "Wait" --infobox "\nClearing system cache and orphaned packages..." 7 50
    {
    sudoz pacman -Sc --noconfirm
	sudoz pacman -Rns $(pacman -Qtdq) --noconfirm
	sudoz flatpak uninstall --unused
    }
    sleep 1
}

## script ui ##
# welcome screen
tput civis
TITLE="
░█████╗░██████╗░░██████╗██╗░░██╗  ██████╗░██╗
██╔══██╗██╔══██╗██╔════╝██║░░██║  ██╔══██╗██║
███████║██████╔╝██║░░░░░███████║  ██████╔╝██║
██╔══██║██╔══██╗██║░░░░░██╔══██║  ██╔═══╝░██║
██║░░██║██║░░██║╚██████╗██║░░██║  ██║░░░░░██║
╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝╚═╝░░╚═╝  ╚═╝░░░░░╚═╝

By: EmanuProds
"
rm $HOME/archPI_logs.txt &> /dev/null
dialog --infobox "$TITLE" 11 49
sleep 5

# loop menu #
while true; do
    OPTIONS=$(dialog --stdout \
        --menu "Choose an option:" \
        0 0 8 \
        1 "Update and remove system blotwares" \
        2 "Install system repositories and dependencies" \
        3 "Configure video drivers and acceleration" \
        4 "Install apps and tools" \
        5 "Install development tools" \
        6 "Install and configure WinBoat" \
        7 "Install and configure game support" \
        8 "Install and configure Wine" \
        9 "Customize the system" \
        0 "Clanup and exit")

    [ $? -ne 0 ] && break

    # menu options
    case $OPTIONS in
        1)
            update_configs
            ;;
        2)
            dependencies
            ;;
        3)
            video_multimedia
            ;;
        4)
            apps_and_utilities
            ;;
        5)
            development
            ;;
        6)
            winboat
            ;;
        7)
            gaming
            ;;
        8)
            wine
            ;;
        9)
            personalize
            ;;
        0)
            cleanup
            break
    esac
done

clear
echo -e "${GREEN}Completed! It is strongly recommended that you restart your system -_^${RESET}"
