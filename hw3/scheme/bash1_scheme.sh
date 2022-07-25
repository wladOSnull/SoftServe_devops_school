#!/bin/bash
###
### this script create tree of folder in CURRENT directory + filling each 'leaf' folders with 1 file (name.txt and surname.txt)
### name.txt contain data of: group number, current date
### surname.txt contain data of: e-email
###
### Script search deepest subfolders (leaf folders) and put the files there by its own.
### It means, bash1_scheme work with any scheme from Assignment, just need to change variable 'tree_patern'.
### 
### example of using: ./bash1_scheme.sh
###

#
# data according to assigments
#

# name of root folder
root_of_tree="./Boreiko"
# tree 'pattern' - scheme 16.
tree_patern=" \
Boreiko/{\
VARD/GR1,\
VARE,\
VARF/GR2\
}"

# tree 'patern':
# - Boreiko - root folder
# - sdir - subfolder
# - d? - leaf folder

# 1 file name
name="Vladyslav"
# 2 file name
surname="Boreiko"
# number of group - data for 1 file
group="131"
# date of assigment - data for 1 file
hw3_date=`date "+%H:%M - %d %b %Y"`
# e-mail - data for 2 file
email="wlad1324@gmail.com"

#
# creating tree of folders
#

# if tree of directories already exist...
if [ -d "$root_of_tree" ]; 
    then

    echo -e "Tree ${root_of_tree} is here\n Recreate existing tree ? (Y/N)"   
    read answer
# case1: leave available tree -> quit
    case $answer in
        "N" | "n")
            exit 0
        ;;
# case2: delete available tree -> then creating new
        "Y" | "y")
            rm -r "$root_of_tree"
        ;;
# default: inappropriate input -> quit
        *)
            echo "Unknow answer... quit"
            exit 1
        ;;  
    esac
# tree has not found
else
    echo -e "Tree ${root_of_tree} isn't here" 
fi

# creating
echo "Creating ${root} tree..."
eval mkdir -p $tree_patern

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
# "Bubble sorting" of array with paths to 'leaf' folders, to get 2 folders with the longest paths  
# for files name.txt and surname.txt. This make algorithm independent of the path structure, 
# name of folders and puts files to the deepest folders by its own. 
# (work with any scheme from assignment)
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
# write files into leaf directories
#

# create name file
# filing the name file with data
touch ${leaf_folder_array[0]}"/"$name.txt
echo -e "${group}\n${hw3_date}" > ${leaf_folder_array[0]}"/"$name.txt
# create surname file
# filing the surname file with data
touch ${leaf_folder_array[1]}"/"$surname.txt
echo "${email}" > ${leaf_folder_array[1]}"/"$surname.txt
