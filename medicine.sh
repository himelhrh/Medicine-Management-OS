#!/bin/bash

# Define text colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Define the medicine file
MEDICINE_FILE="medicines.txt"

# Function to display the main menu
display_menu() {
    clear
    echo -e "${BLUE}Medicine Management System${NC}"
    echo "--------------------------"
    echo -e "1. ${GREEN}Add Medicine${NC}"
    echo -e "2. ${GREEN}View Medicines${NC}"
    echo -e "3. ${GREEN}Search Medicine${NC}"
    echo -e "4. ${GREEN}Update Medicine${NC}"
    echo -e "5. ${GREEN}Remove Medicine${NC}"
    echo -e "6. ${RED}Exit${NC}"
}

# Function to add a medicine
add_medicine() {
    clear
    echo -e "${BLUE}Add Medicine${NC}"
    echo "------------"
    echo

    read -p "Enter the medicine name: " name
    read -p "Enter the medicine manufacturer: " manufacturer
    read -p "Enter the medicine price: " price

    echo "$name|$manufacturer|$price" >> "$MEDICINE_FILE"

    echo
    echo -e "${GREEN}Medicine added successfully!${NC}"
    read -n 1 -s -r -p "Press any key to continue..."
}

# Function to view all medicines
view_medicines() {
    clear
    echo -e "${BLUE}View Medicines${NC}"
    echo "--------------"
    echo

    if [[ -s "$MEDICINE_FILE" ]]; then
        printf "%-20s %-20s %-10s\n" "Medicine Name" "Manufacturer" "Price"
        echo "--------------------------------------------------"

        while IFS='|' read -r name manufacturer price; do
            printf "%-20s %-20s %-10s\n" "$name" "$manufacturer" "$price"
        done < "$MEDICINE_FILE"
    else
        echo -e "${YELLOW}No medicines found.${NC}"
    fi

    echo
    read -n 1 -s -r -p "Press any key to continue..."
}


# Function to search for a medicine
search_medicine() {
    clear
    echo -e "${BLUE}Search Medicine${NC}"
    echo "---------------"
    echo

    read -p "Enter the medicine name to search: " search_name
    echo

    if [[ -s "$MEDICINE_FILE" ]]; then
        printf "%-20s %-20s %-10s\n" "Medicine Name" "Manufacturer" "Price"
        echo "--------------------------------------------------"

        while IFS='|' read -r name manufacturer price; do
            if [[ $name == *"$search_name"* ]]; then
                printf "%-20s %-20s %-10s\n" "$name" "$manufacturer" "$price"
            fi
        done < "$MEDICINE_FILE"
    else
        echo -e "${YELLOW}No medicines found.${NC}"
    fi

    echo
    read -n 1 -s -r -p "Press any key to continue..."
}

# Function to update a medicine
update_medicine() {
    clear
    echo -e "${BLUE}Update Medicine${NC}"
    echo "---------------"
    echo

    read -p "Enter the medicine name to update: " update_name

    if [[ -s "$MEDICINE_FILE" ]]; then
        grep -iv "$update_name" "$MEDICINE_FILE" > "$MEDICINE_FILE.tmp"
        mv "$MEDICINE_FILE.tmp" "$MEDICINE_FILE"

        read -p "Enter the updated medicine name: " name
        read -p "Enter the updated medicine manufacturer: " manufacturer
        read -p "Enter the updated medicine price: " price

        echo "$name|$manufacturer|$price" >> "$MEDICINE_FILE"

        echo -e "${GREEN}Medicine updated successfully!${NC}"
    else
        echo -e "${YELLOW}No medicines found.${NC}"
    fi

    echo
    read -n 1 -s -r -p "Press any key to continue..."
}

# Function to remove a medicine
remove_medicine() {
    clear
    echo -e "${BLUE}Remove Medicine${NC}"
    echo "---------------"
    echo

    read -p "Enter the medicine name to remove: " remove_name

    if [[ -s "$MEDICINE_FILE" ]]; then
        if grep -iq "$remove_name" "$MEDICINE_FILE"; then
            grep -iv "$remove_name" "$MEDICINE_FILE" > "$MEDICINE_FILE.tmp"
            mv "$MEDICINE_FILE.tmp" "$MEDICINE_FILE"
            echo -e "${GREEN}Medicine removed successfully!${NC}"
        else
            echo -e "${YELLOW}Medicine not found.${NC}"
        fi
    else
        echo -e "${YELLOW}No medicines found.${NC}"
    fi

    echo
    read -n 1 -s -r -p "Press any key to continue..."
}

# Main program loop
while true; do
    display_menu

    read -p "Enter your choice (1-6): " choice
    echo

    case $choice in
        1)
            add_medicine
            ;;
        2)
            view_medicines
            ;;
        3)
            search_medicine
            ;;
        4)
            update_medicine
            ;;
        5)
            remove_medicine
            ;;
        6)
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice. Please try again.${NC}"
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
    esac
done
