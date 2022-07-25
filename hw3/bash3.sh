#!/bin/bash
###
### script for validating single string as e-mail
### 
### example of using: ./bash3.sh /home/user/Documents/Boreiko/Boreiko0.txt
###

# geting test string from file-argument
string=`cat $1`
# simple regular expression: https://gist.github.com/guessi/82a73ee7eb2b1216eb9db17bb8d65dd1
regex="^(([A-Za-z0-9]+((\.|\-|\_|\+)?[A-Za-z0-9]?)*[A-Za-z0-9]+)|[A-Za-z0-9]+)@(([A-Za-z0-9]+)+((\.|\-|\_)?([A-Za-z0-9]+)+)*)+\.([A-Za-z]{2,})+$"

# validating e-mail string
if [[ $string =~ $regex ]]
then
    echo "e-mail address ${string} is valid."
else
    echo "e-mail address ${string} is invalid."
fi
