#!/bin/bash

#file: newCompany.sh
#author: Caleb M. McLaren
#email: kbmclaren@gmail.com
#date April 26th, 2022
#description: newCompany.sh must be a command line tool to take in a company name and create new directory for files related to that company.
#usage: $ ./newCompany [a-zA-Z] --> D: Apply4Job/2022-Applications/[a-zA-Z]-[currentMonth]-[currentYear]

##############################################
#Help
#############################################
Help()
{
	#Display correct usage:
	echo
	echo "Usage:% ./newCompany [-h] NEW_COMPANY_NAME"
	echo "Changes: Apply4Job/2022-Applications/NEW_COMPANY_NAME-[currentMonth]-[currentYear]"
	echo 

}

##############################################
##############################################
# Main Program				#
##############################################
##############################################

declare -r new_company=$1
declare -r target_dir="/Users/calebmclaren/Apply4Job/2022-Applications"
declare -r def_app="2022-Application.docx"
declare NewTarget="${target_dir}/${new_company}"

##############################################
# Process Input Option. 		#
##############################################
#get the options
while getopts ':h' options;
do
	case $options in
		h) #display Help
			Help
			exit;;

		\?) #invalid option
			echo "Error: Invalid option."
			exit;;
	esac
done

##############################################
#check if input empty	#
##############################################
if [[ -z $new_company ]]
then
	Help
	exit
fi

##############################################
#check for numbers in input	#
##############################################
#re='[0-9]+'
#if [[ $new_company =~ $re ]]
#then
#	Help
#	exit
#fi

##############################################
#check if target_dir already exist	#
##############################################
if [[ -d $target_dir ]]
then
	declare CurMon=$(date +%b)
	declare CurYr=$(date +%Y)	
	#declare NewTarget="${target_dir}/${new_company}-${CurMon}-${CurYr}"
	NewTarget+="-${CurMon}-${CurYr}"
	mkdir $NewTarget
	echo "You have created the new directory $NewTarget"

fi

##############################################
#COPY and RENAME DEFAULT APPLICATION      #
##############################################
if test -f "${target_dir}/${def_app}"; 
then
	tempSrc="${target_dir}/${def_app}"
	tempTar="${NewTarget}/${def_app}"
	cp $tempSrc $NewTarget
	
	tempFile="${NewTarget}/${def_app}"
	newFile="${NewTarget}/${new_company}_resume_mclaren_caleb.docx"
	mv $tempFile $newFile	
else
	echo "file not found"
fi


##############################################
##############################################
# End newComapny.sh                          #
##############################################
##############################################	
