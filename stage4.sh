#!/usr/bin/env bash

echo "Welcome to the True or False Game!"

while true; do
    echo "0. Exit"
    echo "1. Play a game"
    echo "2. Display scores"
    echo "3. Reset scores"
    echo "Enter an option:"
    read choice

    case $choice in
        0)
            echo "See you later!"
            exit 0
            ;;
        1)
            echo "Playing game"  
            ;;
        2)
            echo "Displaying scores"
            ;;
        3)
            echo "Resetting scores"
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
done

