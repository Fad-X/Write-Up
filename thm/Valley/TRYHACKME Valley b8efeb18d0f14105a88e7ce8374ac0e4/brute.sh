#!/bin/bash

username="valley"
password_file="/usr/share/wordlists/rockyou.txt"
auth_file="./valleyAuthenticator"
error_message="Wrong Password or Username"

while IFS= read -r password; do
    echo "Trying password: $password"
    output=$(echo -e "$username\n$password" | "$auth_file")

    if [[ "$output" != *"$error_message"* ]]; then
        echo "Password found: $password"
        exit 0
    fi
done < "$password_file"

echo "Password not found in the wordlist."
exit 1
