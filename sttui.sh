#!/bin/bash

# Author: Haitham Aouati
# GitHub: github.com/haithamaouati
# Scrape TikTok User Info

# Custom
CLEAR="\e[0m"
BOLD="\e[1m"
UNDERLINE="\e[4m"
RED="\e[31m"
RED_BOLD="\e[1;31m"

# Clear the screen
clear

# Author
echo -e "\n${RED}$(figlet -f pagga.flf Sttui)\n"
echo -e "${RED_BOLD} Sttui ${CLEAR}by Haitham Aouati"
echo -e "${BOLD} GitHub${CLEAR} ${UNDERLINE}github.com/haithamaouati${CLEAR}\n"

# Function to fetch user info by username
fetch_user_info() {
    username="$1"
    response=$(curl -s "https://www.tiktok.com/@$username" | grep -Eo '"(id|uniqueId|nickname|signature|verified|privateAccount|region|language|followerCount|followingCount|heartCount|videoCount|friendCount)":("[^"]*"|[^,"]*)' | sed 's/"//g' | sed 's/,/ /g')
    id=$(echo "$response" | grep -oP 'id:\K[^ ]*')
    uniqueId=$(echo "$response" | grep -oP 'uniqueId:\K[^ ]*')
    nickname=$(echo "$response" | grep -oP 'nickname:\K[^ ]*')
    signature=$(echo "$response" | grep -oP 'signature:\K[^ ]*')
    verified=$(echo "$response" | grep -oP 'verified:\K[^ ]*')
    privateAccount=$(echo "$response" | grep -oP 'privateAccount:\K[^ ]*')
    region=$(echo "$response" | grep -oP 'region:\K[^ ]*' | sed -n '2p')
    language=$(echo "$response" | grep -oP 'language:\K[^ ]*' | sed -n '2p')
    followerCount=$(echo "$response" | grep -oP 'followerCount:\K[^ ]*')
    followingCount=$(echo "$response" | grep -oP 'followingCount:\K[^ ]*')
    heartCount=$(echo "$response" | grep -oP 'heartCount:\K[^ ]*')
    videoCount=$(echo "$response" | grep -oP 'videoCount:\K[^ ]*')
    friendCount=$(echo "$response" | grep -oP 'friendCount:\K[^ ]*' | sed 's/}.*//')

    # Print user info
    echo "ID: $id"
    echo "Username: $uniqueId"
    echo "Name: $nickname"
    echo "Bio: $signature"
    echo -e "\nFollowers: $followerCount"
    echo "Following: $followingCount"
    echo "Likes: $heartCount"
    echo "Videos: $videoCount"
    echo "Friends: $friendCount"
    echo -e "\nCountry: $region"
    echo "Language: $language"
    echo -e "\nIs Verified: $verified"
    echo -e "Is Private: $privateAccount\n"
}

# Check if username is provided
if [ -z "$1" ]; then
    echo "Please provide a TikTok username."
    exit 1
fi

# Call function to fetch user info
fetch_user_info "$1"
