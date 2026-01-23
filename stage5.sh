#!/usr/bin/env bash

RANDOM=4096
congritulations=("Perfect!" "Awesome!" "You are a genius!" "Wow!" "Wonderful!")

function print_random_congritulation() {
    index=$(($RANDOM % ${#congritulations[*]}))
    echo "${congritulations[$index]}"
}

function play_game() {
    echo "What is your name?"
    read player_name
    correct_answers=0
    score=0

    curl -s -o ID_card.txt http://127.0.0.1:8000/download/file.txt

    username=$(grep -oP '(?<="username": ")[^"]*' ID_card.txt)
    password=$(grep -oP '(?<="password": ")[^"]*' ID_card.txt)

    curl -s --cookie-jar cookie.txt --user "${username}:${password}" http://127.0.0.1:8000/login
    
    while true; do
        item=$(curl -s --cookie cookie.txt http://127.0.0.1:8000/game)
        question=$(echo "$item" | sed 's/.*"question": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')
        answer=$(echo "$item" | sed 's/.*"answer": *"\{0,1\}\([^,"]*\)"\{0,1\}.*/\1/')    

        echo "$question"
        echo "True or False?"
        read user_answer

      if [ "$user_answer" == "$answer" ]; then
            correct_answers=$((correct_answers + 1))
            score=$((correct_answers * 10))
            print_random_congritulation
        else
            echo "Wrong answer, sorry!"
            echo "$player_name you have $correct_answers correct answer(s)."
            echo "Your score is $score points."
            break
        fi
    done   
}


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
            play_game
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


