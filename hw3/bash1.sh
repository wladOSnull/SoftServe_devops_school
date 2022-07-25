#!/bin/bash
###
### this script create tree of folder in CURRENT directory + filling 'leaf' folders with 2 files (name.txt and surname.txt)
### name.txt contain data of: group number, current date
### surname.txt contain data of: e-email
### 
### example of using: ./bash1.sh
###

#
# data according to assigments
#

# name of root folder
root_of_tree="./Boreiko"
# tree 'pattern'
tree_patern=" \
./Boreiko/{\
sdir1/{d1,d2},\
sdir2/{d3,d4}\
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
# write files into leaf directories
#

# create file
# filing the file with data
touch $name.txt
echo -e "${group}\n${hw3_date}" > $name.txt
touch $surname.txt
echo "${email}" > $surname.txt

# finally, copy temporary files to leaf folder
for i in "${leaf_folder_array[@]}"
do
# each time copying files to leaf folders
    cp $name.txt $surname.txt $i
done

# remove temporary files
rm $name.txt $surname.txt
