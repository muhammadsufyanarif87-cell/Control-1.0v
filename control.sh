#!/bin/bash

# ============================================================
#              CONTROLL - Kali Linux Command Tool
#              Version 2.2
#              Developer: Muhammad Sufyan Arif Khan
# ============================================================

VERSION="2.2"
AUTHOR="Muhammad Sufyan Arif Khan"

# ============================================================
# COLORS
# ============================================================

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[1;33m'
blue='\033[0;34m'
cyan='\033[0;36m'
white='\033[1;37m'
magenta='\033[0;35m'
re='\033[0m'

# ============================================================
# USER INFORMATION
# ============================================================

CURRENT_USER="$(whoami)"
USER_HOME="$HOME"
DOWNLOAD_DIR="$HOME/Downloads"

# ============================================================
# BASIC FUNCTIONS
# ============================================================

pause() {
    echo
    read -r -p "Press Enter to continue..."
}

success() {
    echo -e "${green}[+] $1${re}"
}

error() {
    echo -e "${red}[-] $1${re}"
}

info() {
    echo -e "${cyan}[*] $1${re}"
}

warning() {
    echo -e "${yellow}[!] $1${re}"
}

# ============================================================
# BANNER
# ============================================================

banner() {
    clear

    echo -e "${green}"

    cat << "EOF"

   ______            __             ____
  / ____/___  ____  / /__________  / / /
 / /   / __ \/ __ \/ __/ ___/ __ \/ / /
/ /___/ /_/ / / / / /_/ /  / /_/ / / /
\____/\____/_/ /_/\__/_/   \____/_/_/

EOF

    echo -e "${red}Version: ${VERSION}${re}"
    echo -e "${red}Developer: ${AUTHOR}${re}"
    echo -e "${cyan}User: ${CURRENT_USER}${re}"
    echo -e "${cyan}Home: ${USER_HOME}${re}"
    echo
}

# ============================================================
# EXIT HANDLER
# ============================================================

trap 'echo; echo -e "${yellow}Controll stopped.${re}"; exit 0' INT

# ============================================================
# SUDO CHECK
# ============================================================

check_sudo() {

    if ! command -v sudo >/dev/null 2>&1; then
        error "sudo is not installed."
        return 1
    fi

    return 0
}

# ============================================================
# DIRECTORY PATH RESOLVER
# ============================================================

resolve_path() {

    local input="$1"

    # Empty path
    if [[ -z "$input" ]]; then
        echo "$PWD"
        return
    fi

    # Home directory
    if [[ "$input" == "~" ]]; then
        echo "$HOME"
        return
    fi

    # ~/something
    if [[ "$input" == ~/* ]]; then
        echo "$HOME/${input#~/}"
        return
    fi

    # Absolute path
    if [[ "$input" == /* ]]; then
        echo "$input"
        return
    fi

    # Special directories
    case "$input" in

        Desktop|desktop)
            echo "$HOME/Desktop"
            ;;

        Documents|documents)
            echo "$HOME/Documents"
            ;;

        Downloads|downloads)
            echo "$HOME/Downloads"
            ;;

        Pictures|pictures)
            echo "$HOME/Pictures"
            ;;

        Videos|videos)
            echo "$HOME/Videos"
            ;;

        Music|music)
            echo "$HOME/Music"
            ;;

        *)
            echo "$PWD/$input"
            ;;

    esac
}

# ============================================================
# CHANGE DIRECTORY
# ============================================================

change_directory() {

    echo
    echo -e "${cyan}Current Directory:${re}"
    echo "$PWD"

    echo
    echo -e "${cyan}Home Directory:${re}"
    echo "$HOME"

    echo
    echo -e "${yellow}Examples:${re}"
    echo "Desktop"
    echo "Documents"
    echo "Downloads"
    echo ".."
    echo "~"
    echo "/home/$CURRENT_USER"

    echo

    read -r -p "Enter directory: " dir_path

    if [[ -z "$dir_path" ]]; then
        error "Directory cannot be empty."
        pause
        return
    fi

    local target
    target="$(resolve_path "$dir_path")"

    if [[ -d "$target" ]]; then

        if cd "$target"; then
            success "Directory changed successfully."

            echo
            echo -e "${cyan}Now you are in:${re}"
            echo "$PWD"
        else
            error "Could not change directory."
        fi

    else

        error "Directory does not exist."
        echo -e "${yellow}Resolved path:${re} $target"

    fi

    pause
}

# ============================================================
# GO BACK DIRECTORY
# ============================================================

back_directory() {

    if [[ "$PWD" == "/" ]]; then

        warning "You are already at /."

    else

        if cd ..; then

            success "Moved to parent directory."

            echo
            echo -e "${cyan}Current Directory:${re}"
            echo "$PWD"

        else

            error "Could not go back."

        fi

    fi

    pause
}

# ============================================================
# SHOW CURRENT DIRECTORY
# ============================================================

show_current_directory() {

    echo
    echo -e "${cyan}Current Directory:${re}"
    pwd

    pause
}

# ============================================================
# SHOW FILES
# ============================================================

show_files() {

    echo
    echo -e "${cyan}Files:${re}"

    ls

    pause
}

# ============================================================
# DETAILED FILE LIST
# ============================================================

detailed_list() {

    echo
    echo -e "${cyan}Detailed Directory List:${re}"

    ls -lah

    pause
}

# ============================================================
# TERMINAL UPDATE
# ============================================================

terminal_update() {

    check_sudo || {
        pause
        return
    }

    info "Updating package lists..."

    sudo apt update

    pause
}

# ============================================================
# TERMINAL UPGRADE
# ============================================================

terminal_upgrade() {

    check_sudo || {
        pause
        return
    }

    info "Upgrading system..."

    sudo apt upgrade -y

    pause
}

# ============================================================
# FIX BROKEN PACKAGES
# ============================================================

fix_broken() {

    check_sudo || {
        pause
        return
    }

    info "Fixing broken packages..."

    sudo apt --fix-broken install -y

    pause
}

# ============================================================
# APT CLEAN
# ============================================================

apt_clean() {

    check_sudo || {
        pause
        return
    }

    info "Cleaning APT cache..."

    sudo apt clean
    sudo apt autoclean

    success "APT cache cleaned."

    pause
}

# ============================================================
# INSTALL PYTHON
# ============================================================

install_python() {

    check_sudo || {
        pause
        return
    }

    info "Installing Python3..."

    sudo apt install python3 python3-pip python3-venv -y

    pause
}

# ============================================================
# INSTALL GIT
# ============================================================

install_git() {

    check_sudo || {
        pause
        return
    }

    info "Installing Git..."

    sudo apt install git -y

    pause
}

# ============================================================
# INSTALL WGET
# ============================================================

install_wget() {

    check_sudo || {
        pause
        return
    }

    info "Installing wget..."

    sudo apt install wget -y

    pause
}

# ============================================================
# INSTALL FIGLET
# ============================================================

install_figlet() {

    check_sudo || {
        pause
        return
    }

    info "Installing figlet..."

    sudo apt install figlet -y

    pause
}

# ============================================================
# INSTALL BASH
# ============================================================

install_bash() {

    check_sudo || {
        pause
        return
    }

    info "Installing Bash..."

    sudo apt install bash -y

    pause
}

# ============================================================
# IP CHECK
# ============================================================

ip_check() {

    echo
    echo -e "${cyan}========== IP INFORMATION ==========${re}"
    echo

    if command -v ip >/dev/null 2>&1; then
        ip addr show
    else
        error "ip command is not installed."
    fi

    echo

    pause
}

# ============================================================
# IP ROUTE
# ============================================================

ip_route() {

    echo
    echo -e "${cyan}========== ROUTING TABLE ==========${re}"
    echo

    if command -v ip >/dev/null 2>&1; then
        ip route
    else
        error "ip command is not installed."
    fi

    echo

    pause
}

# ============================================================
# ROOT SHELL
# ============================================================

root_shell() {

    check_sudo || {
        pause
        return
    }

    warning "You are entering a root shell."
    echo -e "${yellow}Type 'exit' to return to Controll.${re}"
    echo

    sudo -i
}

# ============================================================
# SHUTDOWN
# ============================================================

shutdown_pc() {

    check_sudo || {
        pause
        return
    }

    warning "Computer will shut down."

    read -r -p "Continue? [y/N]: " ans

    if [[ "$ans" =~ ^[Yy]$ ]]; then
        sudo poweroff
    else
        info "Shutdown cancelled."
        pause
    fi
}

# ============================================================
# RESTART
# ============================================================

restart_pc() {

    check_sudo || {
        pause
        return
    }

    warning "Computer will restart."

    read -r -p "Continue? [y/N]: " ans

    if [[ "$ans" =~ ^[Yy]$ ]]; then
        sudo reboot
    else
        info "Restart cancelled."
        pause
    fi
}

# ============================================================
# DOWNLOAD FILE
# ============================================================

download_file() {

    echo
    echo -e "${cyan}========== DOWNLOAD FILE ==========${re}"
    echo

    mkdir -p "$DOWNLOAD_DIR"

    echo -e "${cyan}Download folder:${re}"
    echo "$DOWNLOAD_DIR"

    echo

    read -r -p "Enter download URL: " url

    if [[ -z "$url" ]]; then
        error "URL cannot be empty."
        pause
        return
    fi

    # Check downloader
    local downloader=""

    if command -v wget >/dev/null 2>&1; then
        downloader="wget"
    elif command -v curl >/dev/null 2>&1; then
        downloader="curl"
    else
        error "wget or curl is required."
        pause
        return
    fi

    # Get filename
    local filename="${url##*/}"

    # Remove query string
    filename="${filename%%\?*}"

    # Remove fragment
    filename="${filename%%#*}"

    if [[ -z "$filename" || "$filename" == "/" ]]; then
        filename="downloaded_file"
    fi

    # Safe filename
    filename="${filename// /_}"

    local output="$DOWNLOAD_DIR/$filename"

    echo
    echo -e "${cyan}File:${re} $filename"
    echo -e "${cyan}Downloading...${re}"
    echo

    # WGET
    if [[ "$downloader" == "wget" ]]; then

        if wget \
            --show-progress \
            -O "$output" \
            "$url"; then

            echo
            success "Download completed."

        else

            rm -f -- "$output"
            error "Download failed."
            pause
            return

        fi

    # CURL
    else

        if curl \
            -L \
            --fail \
            --show-error \
            --output "$output" \
            "$url"; then

            echo
            success "Download completed."

        else

            rm -f -- "$output"
            error "Download failed."
            pause
            return

        fi

    fi

    # Verify
    if [[ -f "$output" ]]; then

        echo
        echo -e "${green}Saved to:${re}"
        echo "$output"

        echo
        echo -e "${green}File size:${re}"
        du -h "$output" | cut -f1

    else

        error "Downloaded file was not created."

    fi

    pause
}

# ============================================================
# CREATE FILE
# ============================================================

create_file() {

    read -r -p "Enter file name: " filename

    if [[ -z "$filename" ]]; then

        error "File name cannot be empty."

    elif touch -- "$filename"; then

        success "File created: $filename"

    else

        error "Could not create file."

    fi

    pause
}

# ============================================================
# CREATE FOLDER
# ============================================================

create_folder() {

    read -r -p "Enter folder name: " folder

    if [[ -z "$folder" ]]; then

        error "Folder name cannot be empty."

    elif mkdir -p -- "$folder"; then

        success "Folder created: $folder"

    else

        error "Could not create folder."

    fi

    pause
}

# ============================================================
# REMOVE FILE/FOLDER
# ============================================================

remove_file_folder() {

    read -r -p "Enter file/folder path: " target

    if [[ -z "$target" ]]; then
        error "Path cannot be empty."
        pause
        return
    fi

    target="$(resolve_path "$target")"

    if [[ ! -e "$target" ]]; then

        error "File or folder not found."
        pause
        return

    fi

    # Safety checks
    if [[ "$target" == "/" ||
          "$target" == "$HOME" ||
          "$target" == "$HOME/" ]]; then

        error "This path cannot be removed by Controll."
        pause
        return

    fi

    echo
    echo -e "${yellow}Target:${re} $target"

    read -r -p "Are you sure? [y/N]: " confirm

    if [[ "$confirm" =~ ^[Yy]$ ]]; then

        if rm -rf -- "$target"; then
            success "Removed successfully."
        else
            error "Could not remove."
        fi

    else

        info "Operation cancelled."

    fi

    pause
}

# ============================================================
# INSTALL PACKAGE
# ============================================================

install_package() {

    check_sudo || {
        pause
        return
    }

    read -r -p "Package name: " package

    if [[ -z "$package" ]]; then

        error "Package name cannot be empty."

    else

        sudo apt install "$package" -y

    fi

    pause
}

# ============================================================
# GITHUB CLONE
# ============================================================

clone_github() {

    read -r -p "GitHub repository URL: " repo

    if [[ -z "$repo" ]]; then

        error "Repository URL cannot be empty."

    elif ! command -v git >/dev/null 2>&1; then

        error "Git is not installed."

    else

        git clone "$repo"

    fi

    pause
}

# ============================================================
# PYTHON VENV
# ============================================================

create_venv() {

    if ! command -v python3 >/dev/null 2>&1; then
        error "Python3 is not installed."
        pause
        return
    fi

    read -r -p "Venv folder name: " venv

    if [[ -z "$venv" ]]; then

        error "Venv name cannot be empty."
        pause
        return

    fi

    if python3 -m venv "$venv"; then

        success "Virtual environment created."

        echo
        echo -e "${cyan}Activate it with:${re}"
        echo "source $venv/bin/activate"

    else

        error "Could not create virtual environment."

    fi

    pause
}

# ============================================================
# RUN PYTHON
# ============================================================

run_python() {

    read -r -p "Python file path: " pyfile

    pyfile="$(resolve_path "$pyfile")"

    if [[ -f "$pyfile" ]]; then

        python3 "$pyfile"

    else

        error "Python file not found."

    fi

    pause
}

# ============================================================
# RUN BASH
# ============================================================

run_bash() {

    read -r -p "Bash file path: " bashfile

    bashfile="$(resolve_path "$bashfile")"

    if [[ -f "$bashfile" ]]; then

        bash "$bashfile"

    else

        error "Bash file not found."

    fi

    pause
}

# ============================================================
# REMOVE PACKAGE
# ============================================================

remove_package() {

    check_sudo || {
        pause
        return
    }

    read -r -p "Package name to remove: " package

    if [[ -z "$package" ]]; then

        error "Package name cannot be empty."

    else

        sudo apt remove "$package" -y

    fi

    pause
}

# ============================================================
# INSTALL WALLPAPERS
# ============================================================

install_wallpapers() {

    check_sudo || {
        pause
        return
    }

    info "Installing Kali wallpapers..."

    sudo apt install kali-wallpapers -y

    pause
}

# ============================================================
# INSTALL THEMES
# ============================================================

install_themes() {

    check_sudo || {
        pause
        return
    }

    info "Installing Kali themes..."

    sudo apt install kali-themes -y

    pause
}

# ============================================================
# INSTALL SNAP
# ============================================================

install_snap() {

    check_sudo || {
        pause
        return
    }

    info "Installing Snap..."

    sudo apt update
    sudo apt install snapd -y

    if command -v systemctl >/dev/null 2>&1; then

        if systemctl list-unit-files 2>/dev/null |
            grep -q '^snapd.socket'; then

            sudo systemctl enable --now snapd.socket

        fi

    fi

    success "Snap installation completed."

    pause
}

# ============================================================
# INSTALL SNAP PACKAGE
# ============================================================

install_snap_package() {

    check_sudo || {
        pause
        return
    }

    read -r -p "Snap package name: " snap_package

    if [[ -z "$snap_package" ]]; then

        error "Snap package name cannot be empty."

    elif ! command -v snap >/dev/null 2>&1; then

        error "Snap is not installed."

    else

        sudo snap install "$snap_package"

    fi

    pause
}

# ============================================================
# INSTALL VS CODE
# ============================================================

install_vscode() {

    check_sudo || {
        pause
        return
    }

    info "Installing Visual Studio Code..."

    sudo apt update
    sudo apt install code -y

    pause
}

# ============================================================
# INSTALL DEB
# ============================================================

install_deb() {

    check_sudo || {
        pause
        return
    }

    read -r -p "DEB file path: " debfile

    debfile="$(resolve_path "$debfile")"

    if [[ -f "$debfile" ]]; then

        sudo apt install "$debfile" -y

    else

        error "DEB file not found."

    fi

    pause
}

# ============================================================
# RUN SNAP APP
# ============================================================

run_snap() {

    read -r -p "Snap application command: " snapapp

    if [[ -z "$snapapp" ]]; then

        error "Application name cannot be empty."

    elif command -v "$snapapp" >/dev/null 2>&1; then

        "$snapapp"

    else

        error "Snap application not found."

    fi

    pause
}

# ============================================================
# OPEN IMAGE
# ============================================================

open_image() {

    read -r -p "Image path: " image

    image="$(resolve_path "$image")"

    if [[ ! -f "$image" ]]; then

        error "Image not found."
        pause
        return

    fi

    if command -v xdg-open >/dev/null 2>&1; then

        xdg-open "$image" >/dev/null 2>&1 &

        success "Opening image..."

    else

        error "xdg-open is not installed."

    fi

    pause
}

# ============================================================
# OPEN FILE / DIRECTORY
# ============================================================

open_path() {

    read -r -p "File/Directory path: " path

    path="$(resolve_path "$path")"

    if [[ ! -e "$path" ]]; then

        error "Path not found."
        pause
        return

    fi

    if command -v xdg-open >/dev/null 2>&1; then

        xdg-open "$path" >/dev/null 2>&1 &

        success "Opening..."

    else

        error "xdg-open is not installed."

    fi

    pause
}

# ============================================================
# INSTALL DESKTOP
# ============================================================

install_desktop() {

    check_sudo || {
        pause
        return
    }

    local desktop="$1"
    local package="$2"

    info "Installing ${desktop}..."

    sudo apt install "$package" -y

    pause
}

# ============================================================
# SYSTEM INFORMATION
# ============================================================

system_information() {

    echo
    echo -e "${cyan}========== SYSTEM INFORMATION ==========${re}"
    echo

    echo "Hostname : $(hostname)"
    echo "User     : $(whoami)"
    echo "Home     : $HOME"
    echo "Directory: $PWD"
    echo "Kernel   : $(uname -r)"
    echo "System   : $(uname -o)"
    echo "Uptime   : $(uptime -p)"

    echo

    if command -v lsb_release >/dev/null 2>&1; then
        lsb_release -a
    fi

    pause
}

# ============================================================
# DISK USAGE
# ============================================================

disk_usage() {

    echo
    echo -e "${cyan}========== DISK USAGE ==========${re}"
    echo

    df -h

    pause
}

# ============================================================
# RAM USAGE
# ============================================================

ram_usage() {

    echo
    echo -e "${cyan}========== RAM USAGE ==========${re}"
    echo

    free -h

    pause
}

# ============================================================
# CPU INFORMATION
# ============================================================

cpu_information() {

    echo
    echo -e "${cyan}========== CPU INFORMATION ==========${re}"
    echo

    lscpu

    pause
}

# ============================================================
# RUNNING PROCESSES
# ============================================================

running_processes() {

    echo
    echo -e "${cyan}========== RUNNING PROCESSES ==========${re}"
    echo

    ps aux --sort=-%cpu | head -20

    pause
}

# ============================================================
# NETWORK INFORMATION
# ============================================================

network_information() {

    echo
    echo -e "${cyan}========== NETWORK INFORMATION ==========${re}"
    echo

    if command -v ip >/dev/null 2>&1; then

        ip addr

        echo
        echo -e "${cyan}========== ROUTES ==========${re}"
        echo

        ip route

    else

        error "ip command is not installed."

    fi

    pause
}

# ============================================================
# INTERNET CHECK
# ============================================================

check_internet() {

    info "Checking internet connection..."

    if ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1; then

        success "Internet connection is working."

    else

        error "Internet connection is unavailable."

    fi

    pause
}

# ============================================================
# SERVICE MANAGER
# ============================================================

manage_services() {

    while true; do

        clear

        echo -e "${cyan}"
        echo "========== SERVICE MANAGER =========="
        echo -e "${re}"

        echo "1. Start service"
        echo "2. Stop service"
        echo "3. Restart service"
        echo "4. Service status"
        echo "5. Enable service"
        echo "6. Disable service"
        echo "00. Back"

        echo

        read -r -p "Select: " service_action

        if [[ "$service_action" == "00" ]]; then
            return
        fi

        case "$service_action" in

            1|2|3|4|5|6)
                ;;

            *)
                error "Invalid option."
                pause
                continue
                ;;

        esac

        read -r -p "Service name: " service

        if [[ -z "$service" ]]; then

            error "Service name cannot be empty."
            pause
            continue

        fi

        case "$service_action" in

            1)
                sudo systemctl start "$service"
                ;;

            2)
                sudo systemctl stop "$service"
                ;;

            3)
                sudo systemctl restart "$service"
                ;;

            4)
                systemctl status "$service"
                ;;

            5)
                sudo systemctl enable "$service"
                ;;

            6)
                sudo systemctl disable "$service"
                ;;

        esac

        pause

    done
}

# ============================================================
# FIND PACKAGE
# ============================================================

find_package() {

    read -r -p "Search package: " package

    if [[ -z "$package" ]]; then

        error "Package name cannot be empty."

    else

        apt search "$package"

    fi

    pause
}

# ============================================================
# SEARCH FILE
# ============================================================

search_files() {

    read -r -p "Search filename: " filename

    if [[ -z "$filename" ]]; then

        error "Filename cannot be empty."

    else

        find "$PWD" -iname "*$filename*" 2>/dev/null

    fi

    pause
}

# ============================================================
# ENVIRONMENT VARIABLES
# ============================================================

show_environment() {

    echo
    echo -e "${cyan}========== ENVIRONMENT ==========${re}"
    echo

    env | sort

    pause
}

# ============================================================
# ADVANCED MENU
# ============================================================

advanced_menu() {

    while true; do

        banner

        echo -e "${green}"

        cat << "EOF"

========== CONTROLL ADVANCED MENU ==========

0   Go Back One Directory
1   Change Directory
2   Create File
3   Create Folder
4   Remove File / Folder
5   Show Current Directory
6   Show Files
7   Detailed Directory List
8   Install Package
9   Clone GitHub Repository
10  Create Python Venv
11  Run Python File
12  Run Bash File
13  Remove Package
14  Install Wallpapers
15  Install Themes
16  Install Snap
17  Install Snap Package
18  Install VS Code
19  Install DEB Application
20  Run Snap Application
21  Open Image
22  Open File / Directory
23  Install GNOME
24  Install XFCE
25  Install LXDE
26  Install MATE
27  Install Cinnamon
28  Install KDE Plasma
29  Install Budgie
30  System Information
31  Disk Usage
32  RAM Usage
33  CPU Information
34  Running Processes
35  Network Information
36  Check Internet
37  Manage Services
38  Find Package
39  Search Files
40  Show Environment
41  Update Controll
42  Download File

00  Back to Main Menu

=============================================

EOF

        echo -e "${re}"

        echo -e "${cyan}Current Directory: ${PWD}${re}"
        echo

        read -r -p "Enter number: " new

        case "$new" in

            0)
                back_directory
                ;;

            1)
                change_directory
                ;;

            2)
                create_file
                ;;

            3)
                create_folder
                ;;

            4)
                remove_file_folder
                ;;

            5)
                show_current_directory
                ;;

            6)
                show_files
                ;;

            7)
                detailed_list
                ;;

            8)
                install_package
                ;;

            9)
                clone_github
                ;;

            10)
                create_venv
                ;;

            11)
                run_python
                ;;

            12)
                run_bash
                ;;

            13)
                remove_package
                ;;

            14)
                install_wallpapers
                ;;

            15)
                install_themes
                ;;

            16)
                install_snap
                ;;

            17)
                install_snap_package
                ;;

            18)
                install_vscode
                ;;

            19)
                install_deb
                ;;

            20)
                run_snap
                ;;

            21)
                open_image
                ;;

            22)
                open_path
                ;;

            23)
                install_desktop "GNOME" "kali-desktop-gnome"
                ;;

            24)
                install_desktop "XFCE" "kali-desktop-xfce"
                ;;

            25)
                install_desktop "LXDE" "kali-desktop-lxde"
                ;;

            26)
                install_desktop "MATE" "kali-desktop-mate"
                ;;

            27)
                install_desktop "Cinnamon" "kali-desktop-cinnamon"
                ;;

            28)
                install_desktop "KDE Plasma" "kali-desktop-kde"
                ;;

            29)
                install_desktop "Budgie" "kali-desktop-budgie"
                ;;

            30)
                system_information
                ;;

            31)
                disk_usage
                ;;

            32)
                ram_usage
                ;;

            33)
                cpu_information
                ;;

            34)
                running_processes
                ;;

            35)
                network_information
                ;;

            36)
                check_internet
                ;;

            37)
                manage_services
                ;;

            38)
                find_package
                ;;

            39)
                search_files
                ;;

            40)
                show_environment
                ;;

            41)
                warning "Controll self-update is not configured yet."
                pause
                ;;

            42)
                download_file
                ;;

            00)
                success "Returning to main menu..."
                return
                ;;

            *)
                error "Invalid option: $new"
                pause
                ;;

        esac

    done
}

# ============================================================
# MAIN MENU
# ============================================================

while true; do

    banner

    echo -e "${green}"

    cat << "EOF"

========== CONTROLL MAIN MENU ==========

1   Terminal Update
2   Terminal Upgrade
3   Fix Broken Packages
4   APT Clean
5   Install Python3
6   Install Git
7   Install Wget
8   Install Figlet
9   Install Bash
10  IP Check
11  IP Route
12  Root Shell
13  Shutdown Computer
14  Restart Computer
16  Advanced Features

00  Exit

=========================================

EOF

    echo -e "${re}"

    read -r -p "Enter Number: " choice

    case "$choice" in

        1)
            terminal_update
            ;;

        2)
            terminal_upgrade
            ;;

        3)
            fix_broken
            ;;

        4)
            apt_clean
            ;;

        5)
            install_python
            ;;

        6)
            install_git
            ;;

        7)
            install_wget
            ;;

        8)
            install_figlet
            ;;

        9)
            install_bash
            ;;

        10)
            ip_check
            ;;

        11)
            ip_route
            ;;

        12)
            root_shell
            ;;

        13)
            shutdown_pc
            ;;

        14)
            restart_pc
            ;;

        16)
            advanced_menu
            ;;

        00)
            echo
            success "Thanks for using Controll!"
            echo -e "${cyan}Developer: ${AUTHOR}${re}"
            exit 0
            ;;

        *)
            error "Invalid option. Please enter a valid number."
            sleep 1
            ;;

    esac

done