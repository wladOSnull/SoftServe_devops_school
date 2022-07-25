#!/bin/bash
###
### script for searching (output + counting) '404' string in .log file 
### 
### example of using: ./bash4.sh /home/user/Documents/Apache_2.4-PHP_5.5-5.6_queriesa.log
###

# simple regex for checking contained substring (404) anywhere
regex="(.*404.*)"
# counter for number of '404' string
counter=0
echo

# reading file line by line
while IFS= read -r line
do
# validating current string
    if [[ $line =~ $regex ]]
    then
# increment counter
        ((counter+=1))
# output current '404' string
        echo "404 !!! >> ${line}"
    fi   
done < $1

# the result of text processing
echo -e "\n\ncount of '404 error': ${counter}"
