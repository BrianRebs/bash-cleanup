#!/bin/bash

function extract_files {

    find /Volumes/BK/Courses/ -maxdepth 1 -name "*.zip" | while read i
    do
        unzip "${i}" 
    done
}

function rm_junk {
    find /Volumes/BK/Courses/** \( -name "*.srt" -o -name "*.vtt" -o -name "*Free.txt" -o -name "*extracting.txt" -o -name "*.url" -o -name "*links.txt" -o -name "*torrentgalaxy.to .txt" -o -name "*Node.com.txt"  -o -name "*Free!.txt"  -o -name "*Visible.url" -o -name "*dnoid.to.txt" -o -name "*TutsGalaxy.com.txt"  \) -exec rm -rf {} \;
}


function change_names {
    find /Volumes/BK/Courses/** -name "*--- \[ FreeCourseWeb.com \] ---*" | while read i
    do
        mv "${i}" "${i//--- [ FreeCourseWeb.com \] ---/}"
    done

    find /Volumes/BK/Courses/** -name "*--- \[ DevCourseWeb.com \] ---*" | while read i
    do
        mv "${i}" "${i//--- [ DevCourseWeb.com \] ---/}"
    done
}


function change_dirNames {
    find /Volumes/BK/Courses/** -type d -name "*\[ FreeCourseWeb.com \]*" | while read i
    do
        mv "${i}" "${i//[ FreeCourseWeb.com \] /}"
    done
    find /Volumes/BK/Courses/** -type d -name "*\[ DevCourseWeb.com \]*" | while read i
    do
        mv "${i}" "${i//[ DevCourseWeb.com \] /}"
    done
    find /Volumes/BK/Courses/** -type d -name "*\[TutsNode.com\] - *" | while read i
    do
        mv "${i}" "${i//[TutsNode.com] -  /}"
    done
}

getDirs=`find /Volumes/BK/Courses/** -type d -name "*\[TutsNode.com\]*" -o -type d -name "~Get Your Course Here !"`

function move_to_parent {
IFS= 
    echo $getDirs | while read i 
    do
        # echo "$i"
        # echo $(dirname "${i}")
        mv "$i"/* $(dirname "${i}")
    done
}


function rm_parent_dir {
IFS= 
    echo $getDirs | while read i 
    do 
        rm -rf $i
    done 
}


extract_files
rm_junk
move_to_parent
change_names
rm_parent_dir
change_dirNames


# tput setaf 1; echo $getDirs
########## OTHER SNIPPETS FOR REFERENCE ##########

# echo ${i//[ FreeCourseWeb.com \] /}
# mv ${i} ${i//[ FreeCourseWeb.com \] /}   ### mv command didn't work without the quotes
# Replacing with Regex ${variable//pattern/replacement}
# rm -rf `find /Volumes/BK/Courses -name "*.srt" -o -name "*.vtt" -o -name "*.url"` 
# find * | xargs -0 | sed 's/[ FreeCourseWeb.com ] //'
# rename 's/--- [ FreeCourseWeb.com ] ---//'

#     if [ -d "$b" ]
#     then 
#         mv ${b} ${b//\[ FreeCourseWeb.com \] /}
#     fi

# echo $(dirname "$i" )
# echo $(basename "$i" )

# for i in `find ~/courses -name "*Free*"`
# do
#     mv -- ${i} ${i//--- [ FreeCourseWeb.com \] ---/}
# done

# fswatch /Volumes/BK/Courses | xargs -n1 sh test.sh >> .logs
# fswatch /Volumes/BK/Courses | xargs -n1 sh /Volumes/BK/Courses/.courses.sh >> .logs

# Turn the Internal Filename Separator (IFS) to colon
# IFS=":" 
# Turn the Internal Filename Separator (IFS) to space
# IFS=  

# toFind=`find /Volumes/BK/Courses/** -name "~Get Your Course Here !"` -exec mv {} {///} \;
# toFind=`find /Volumes/BK/Courses/** -name "~Get Your Course Here !"`
# echo "$toFind"
# toShow=`sed 's/~Get Your Course Here !//' "$toFind"`
# echo "$toShow"

# if [ "$toFind" ]
# then 
#     mv "$toFind" $(sed 's/~Get Your Course Here !//g' "$toFind")
# fi

# red=`tput setaf 1`
# green=`tput setaf 2`
# reset=`tput sgr0`
# echo "${red}red text ${green}green text${reset}"