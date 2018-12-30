#!/bin/bash
# 交互式
function throw(){
    whiptail --title "Continue command(yes/no)" --yesno "Save the file in the DFS system?" 10 60
    if [ $? -eq 0 ];then
        fileloc=$(whiptail --title "Input Box" --inputbox "Please enter the absolute address of the file" 10 60 3>&1 1>&2 2>&3)
        block=$(whiptail --title "Input Box" --inputbox "Please enter the block size" 10 60 3>&1 1>&2 2>&3)
        rep=$(whiptail --title "Input Box" --inputbox "Please enter the copy number" 10 60 3>&1 1>&2 2>&3)
        bash ./throw.sh $fileloc $block $rep
    else
        whiptail --title "Prompt" --msgbox "Welcome to use next time" 10 60
        exit 1
    fi
}

function readfile(){
    whiptail --title "Continue command(yes/no)" --yesno "Read the file from the DFS system?" 10 60
    if [ $? -eq 0 ];then
        file=$(whiptail --title "Input Box" --inputbox "Please enter the filename" 10 60 3>&1 1>&2 2>&3)
        loc=$(whiptail --title "Input Box" --inputbox "Please enter the local address" 10 60 3>&1 1>&2 2>&3)
        bash ./read.sh $file $loc
    else
        whiptail --title "Prompt" --msgbox "Welcome to use next time" 10 60
        exit 1
    fi
}

function rename(){
    whiptail --title "Continue command(yes/no)" --yesno "Rename the file?" 10 60
    if [ $? -eq 0 ];then
        file=$(whiptail --title "Input Box" --inputbox "Please enter the filename" 10 60 3>&1 1>&2 2>&3)
        changename=$(whiptail --title "Input Box" --inputbox "Please enter the changed name" 10 60 3>&1 1>&2 2>&3)
        bash ./rename.sh $file $changename
    else
        whiptail --title "Prompt" --msgbox "Welcome to use next time" 10 60
        exit 1
    fi
}

function delete(){
    whiptail --title "Continue command(yes/no)" --yesno "Delete the file?" 10 60
    if [ $? -eq 0 ];then
        file=$(whiptail --title "Input Box" --inputbox "Please enter the filename" 10 60 3>&1 1>&2 2>&3)
        bash ./delete_file.sh $file
    else
        whiptail --title "Prompt" --msgbox "Welcome to use next time" 10 60
        exit 1
    fi
}

function info(){
    whiptail --title "Continue command(yes/no)" --yesno "View file information in the dfs system?" 10 60
    if [ $? -eq 0 ];then
        file=$(whiptail --title "Input Box" --inputbox "Please enter the filename" 10 60 3>&1 1>&2 2>&3)
        bash ./info.sh $file
    else
        whiptail --title "Prompt" --msgbox "Welcome to use next time" 10 60
        exit 1
    fi
}

function summary (){
    whiptail --title "Continue command(yes/no)" --yesno "view all files?" 10 60
    if [ $? -eq 0 ];then
         bash ./summary.sh
     else
         whiptail --title "Prompt" --msgbox "Welcome to use next time" 10 60
         exit 1
    fi
}

function clear(){
    whiptail --title "Continue command(yes/no)" --yesno "initialization?（Caution！）" 10 60
    if [ $? -eq 0 ];then
        whiptail --title "Continue command(yes/no)" --yesno "Are you sure?" 10 60
            if [ $? -eq 0 ];then
                bash ./clear.sh
            else
                whiptail --title "Prompt" --msgbox "Welcome to use next time" 10 60
                exit 1
            fi
    else
        whiptail --title "Prompt" --msgbox "Welcome to use next time" 10 60
        exit 1
    fi
}

function rep(){
    whiptail --title "Continue command(yes/no)" --yesno "Change the repetition number?" 10 60
    if [ $? -eq 0 ];then
        file=$(whiptail --title "Input Box" --inputbox "Please enter the filename" 10 60 3>&1 1>&2 2>&3)
        repe=$(whiptail --title "Input Box" --inputbox "Please enter the number " 10 60 3>&1 1>&2 2>&3)
        bash ./rep.sh $file $repe
    else
        whiptail --title "Prompt" --msgbox "Welcome to use next time" 10 60
        exit 1
    fi
}

DISTROS=$(whiptail --title "Test Checklist Dialog" --menu "Command guide" 15 60 7 \
"throw.sh" "Store local data in the DFS system" \
"read.sh" "Retrieve data from DFS back to local" \
"rename.sh" "Rename files in DFS" \
"rep.sh" "Adjust the number of copies in the DFS file" \
"delete.sh" "Delete files in DFS" \
"info.sh" "View block information of files in DFS" \
"clear.sh" "Empty all files in DFS" \
"summary.sh" "View all files in DFS" 3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo $DISTROS
    case $DISTROS in
	"throw.sh")
	    whiptail --title "Test Message Box" --msgbox "bash throw.sh <filelocation> <block_size> < repeatation>" 10 60
	    throw
 	    whiptail --title "Test Message Box" --msgbox "Done!" 10 60
		;;
	"read.sh")
	     whiptail --title "Test Message Box" --msgbox "bash read.sh <filename> <targetlocation>" 10 60
	     readfile
	     whiptail --title "Test Message Box" --msgbox "Done!" 10 60
		;;
	"rename.sh")
	     whiptail --title "Test Message Box" --msgbox "bash rename.sh <oldfilename> <newfilename>" 10 60
	     rename
	     whiptail --title "Test Message Box" --msgbox "Done!" 10 60
		;;
	"rep.sh")
	     whiptail --title "Test Message Box" --msgbox "bash rep.sh <filename> <setrep>" 10 60
	     rep
	     whiptail --title "Test Message Box" --msgbox "Done!" 10 60
		;;
	"delete.sh")
	        whiptail --title "Test Message Box" --msgbox "bash delete_file.sh <filename>" 10 60
        	delete
		whiptail --title "Test Message Box" --msgbox "Done!" 10 60
                ;;
	"info.sh")
	        whiptail --title "Test Message Box" --msgbox "bash info.sh <filename>" 10 60
        	info
		whiptail --title "Test Message Box" --msgbox "Done!" 10 60
		;;
	"summary.sh")
		whiptail --title "Test Message Box" --msgbox "bash summary.sh " 10 60
		summary
		whiptail --title "Test Message Box" --msgbox "Done!" 10 60
                ;;
	"clear.sh")  
	        whiptail --title "Test Message Box" --msgbox "bash clear.sh" 10 60
        	clear
		whiptail --title "Test Message Box" --msgbox "Done!" 10 60
                ;;
	esac
    if [ $DISTROS == "ubuntu" ]; then
	echo "yes"
    fi
else
    echo "You chose Cancel."
fi


