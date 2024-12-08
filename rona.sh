#!/bin/bash


declare -A reservations
reservation_id=0

# Function to display a header
display_header() {
    echo "==============================================================="
    echo "       🌟 Welcome to Roan's Hotel Reservation System 🌟       "
    echo "==============================================================="
}


add_reservation() {
    echo "-----------------------------------------"
    echo "            Add Reservation"
    echo "-----------------------------------------"
    read -p "Enter Guest Name: " name
    read -p "Enter Room Type (Single/Double/Suite): " room_type
    read -p "Enter Check-In Date (YYYY-MM-DD): " check_in
    read -p "Enter Check-Out Date (YYYY-MM-DD): " check_out
    reservation_id=$((reservation_id + 1))
    reservations[$reservation_id]="$name | $room_type | $check_in | $check_out"
    echo "✅ Reservation added successfully!"
}


view_reservations() {
    echo "-----------------------------------------"
    echo "           View Reservations"
    echo "-----------------------------------------"
    if [ ${#reservations[@]} -eq 0 ]; then
        echo "❌ No reservations found."
    else
        echo "Reservation ID | Name | Room Type | Check-In | Check-Out"
        echo "---------------------------------------------------------"
        for id in "${!reservations[@]}"; do
            echo "$id | ${reservations[$id]}"
        done
    fi
}


delete_reservation() {
    echo "-----------------------------------------"
    echo "          Delete Reservation"
    echo "-----------------------------------------"
    view_reservations
    if [ ${#reservations[@]} -ne 0 ]; then
        read -p "Enter Reservation ID to delete: " delete_id
        if [ -n "${reservations[$delete_id]}" ]; then
            unset reservations[$delete_id]
            echo "✅ Reservation deleted successfully!"
        else
            echo "❌ Invalid Reservation ID."
        fi
    fi
}

# Main menu
main_menu() {
    while true; do
        clear
        display_header
        echo "1️⃣ Add Reservation"
        echo "2️⃣ View Reservations"
        echo "3️⃣ Delete Reservation"
        echo "4️⃣ Exit"
        echo "-----------------------------------------"
        read -p "Enter your choice (1-4): " choice

        case $choice in
        1)
            add_reservation
            ;;
        2)
            view_reservations
            ;;
        3)
            delete_reservation
            ;;
        4)
            echo "👋 Exiting the system. Goodbye!"
            break
            ;;
        *)
            echo "❌ Invalid choice. Please try again."
            ;;
        esac
        echo "Press any key to return to the main menu..."
        read -n 1
    done
}

# Run the program
main_menu
