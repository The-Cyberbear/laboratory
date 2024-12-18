#!/bin/bash
# CREATED BY Bruno

# Colordefinition
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # Reset Farbe

# Helper function for colored messages
print_msg() {
    echo -e "${1}${2}${NC}"
}

#############################
# Check if executed as root #
#############################
if [ "$(id -u)" -ne 0 ]; then
    print_msg "$RED" ">> This script must be run as root or root privileges."
    exit 1
fi

# ASCII-Art for Menue
menu_ascii_art() {
    echo -e "${RED}"
    echo " _           _                     _                   "
    echo "| |         | |                   | |                  "
    echo "| |     __ _| |__   ___  _ __ __ _| |_ ___  _ __ _   _ "
    echo "| |    / _\` | '_ \ / _ \| '__/ _\` | __/ _ \| '__| | | |"
    echo "| |___| (_| | |_) | (_) | | | (_| | || (_) | |  | |_| |"
    echo "\_____/\__,_|_.__/ \___/|_|  \__,_|\__\___/|_|   \__, |"
    echo "                                                  __/ |"
    echo "                                                 |___/ "
    echo -e "${NC}"
}

# Funktion für das Menü
show_menu() {
    clear
    menu_ascii_art
    print_msg "$BLUE" "======================================================="
    print_msg "$YELLOW" "           Welcome to the Laboratory                 "
    print_msg "$BLUE" "======================================================="
    print_msg "$YELLOW" " > Please choose an option:"
    print_msg "$GREEN" "    1) Start Laboratory"
    print_msg "$GREEN" "    2) Stop Laboratory"
    print_msg "$GREEN" "    3) Load Config controlller"
    print_msg "$GREEN" "    4) Exit Laboratory"
    print_msg "$BLUE" "======================================================="
}

setup_call() {
    if [ ! -f "./source/laboratory_setup" ]; then
        print_msg "$RED" ">> Setup file not found"
        exit 1
    fi
    ./source/laboratory_setup
    read -p "Press Enter to return to the menu."
}

start_call() {
    if [ ! -f "./source/laboratory_start" ]; then
        print_msg "$RED" ">> Start file not found"
        exit 1
    fi
    ./source/laboratory_start
    read -p "Press Enter to return to the menu."
}

stop_call() {
    if [ ! -f "./source/laboratory_stop" ]; then
        print_msg "$RED" ">> Stop file not found"
        exit 1
    fi
    ./source/laboratory_stop
    read -p "Press Enter to return to the menu."
}

config_controller() {
    if [ ! -f "./source/config_controller" ]; then
        print_msg "$RED" ">> Stop file not found"
        exit 1
    fi
    ./source/config_controller
    read -p "Press Enter to return to the menu."
}

# Mainfunction
main_menu() {
    chmod +x ./source/laboratory_start ./source/laboratory_stop ./source/laboratory_setup ./laboratory-image/builder ./source/config_controller
    while true; do
        show_menu
        read -p "Enter your choice [1-4]: " choice
        echo " "
        case $choice in
        1) start_call ;;
        2) stop_call ;;
        3) config_controller ;;
        4)
            print_msg "$RED" "Exiting the Laboratory. Goodbye!"
            break
            ;;
        *)
            print_msg "$RED" "Invalid choice. Please select a valid option."
            sleep 2
            ;;
        esac
    done
}

# Skript starten
main_menu

# CREATED BY Bruno
