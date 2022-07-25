#!/bin/bash
###
### this script copy files from 'leaf' folder to root folder (see bash1_scheme.sh)
###
### Script search deepest subfolders (leaf folders) and copying the files from there to 'root' folder by its own.
### It means, bash2_scheme work with any scheme from Assignment.
### 
### example of using: ./bash2_scheme.sh
###

# name of root folder
root_of_tree="./Boreiko"
# 1 file name
name="Vladyslav"
# 2 file name
surname="Boreiko"

#
# getting 'leaf' folders
#

# find paths to leaf foldes
find_result=`find $root_of_tree -type d -links 2`
# split into array
IFS=$'\n' read -rd '' -a leaf_folder_array <<< "$find_result"
unset IFS

# info about founded paths
for i in "${leaf_folder_array[@]}"
do
    echo "path to leaf folder: ${i} - with files: ${name} and ${surname}"
done

#
# "Bubble sorting" of array with paths to 'leaf' folders, to get 2 folders with files, 
# according to algorithm of bash1_scheme.sh
# 

# get lenght of array
lenght=${#leaf_folder_array[@]}
# performing Bubble sort 
for ((i = 0; i<$lenght; i++))
do
    for ((j = 0; j<lenght-i-1; j++))
    do
# get the number of mathces '/' symbol in path to current 'leaf' folder
        val_current=`echo "${leaf_folder_array[j]}" | awk -F"/" '{print NF-1}'`
# get the number of mathces '/' symbol in path to next 'leaf' folder
        val_next=`echo "${leaf_folder_array[$((j+1))]}" | awk -F"/" '{print NF-1}'`       
# swap
        if [ $val_current -lt $val_next ]
        then
            temp=${leaf_folder_array[j]}
            leaf_folder_array[$j]=${leaf_folder_array[$((j+1))]}
            leaf_folder_array[$((j+1))]=$temp  
        fi
    done
done

#
# copying 2 files to root folder
#

# 1 operand - concat path to the leaf folder with name of file
cp ${leaf_folder_array[0]}"/"$name.txt $root_of_tree
# 1 operand - concat path to the leaf folder with name of file
cp ${leaf_folder_array[1]}"/"$surname.txt $root_of_tree
