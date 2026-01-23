#!/usr/bin/env bash

echo "Welcome to the True or False Game!"

curl -s -o ID_card.txt http://127.0.0.1:8000/download/file.txt

username=$(grep -oP '(?<="username": ")[^"]*' ID_card.txt)
password=$(grep -oP '(?<="password": ")[^"]*' ID_card.txt)

login_message=$(curl -s --cookie-jar cookie.txt --user "${username}:${password}" http://127.0.0.1:8000/login)

echo "Login message: ${login_message}"