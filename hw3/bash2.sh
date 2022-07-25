#!/bin/bash
###
### this script copy files from 'leaf' folder to root folder (see bash1.sh)
### algorithm implements the "COPY BUT KEEP BOTH" function (considering multiple files with same name)
### 
### example of using: ./bash2.sh
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
# copying files from leaf foldes to root folder
#

# function for copying files into root directory:
# $1 - 1st argument of copy_files() - the pathto file
# $2 - 2nd arguments of copy_files() - suffix
function copy_files()
{
# copying 2 files:
# 1 operand - concat path to the leaf folder from 1 argument ($1)  name of file
# 2 operand - concat new name: the path to root + name of file + suffix +  
    cp $1"/"$name".txt" $root_of_tree"/"$name$2".txt"
    cp $1"/"$surname".txt" $root_of_tree"/"$surname$2".txt"
}

# copying files to root folder
counter=0;
for i in "${leaf_folder_array[@]}"
do
# each time copy_files() gets path to folder from array item and counter as argument 
     copy_files $i $counter
     ((counter+=1))
done
