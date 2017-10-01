#!/bin/bash

###############################################################################
#
#	note keep
#	
#	adding and displaying notes : main menu
#
#	author: michael kosko
#
###############################################################################

PROG_DIR=~/notekeep

 . ${PROG_DIR}/addition.sh
 . ${PROG_DIR}/deletion.sh
 . ${PROG_DIR}/varhold.sh
 . ${PROG_DIR}/color.sh
 . ${PROG_DIR}/index.sh

mainloopctl=1
menuoption=-1
workoption='i'
keyp=''
numofpages=10

while [ ${mainloopctl} -gt 0 ]
do
	clear

	. ${PROG_DIR}/varhold.sh
	. ${PROG_DIR}/index.sh

	echo -e "******************************************************"
	echo -e "*                                                    *"
	echo -e "*	       Welcome to Note Keep		     *"
	echo -e "*                                                    *"
	echo -e "******************************************************"
	echo

	for key in ${!bookalias[@]}; do
		echo -e "  ${bookalias[${key}]}"
		for pkey in ${!notepage[@]}; do
			if echo ${notepage[${pkey}]} | grep -q ${bookalias[${key}]}
			then
				echo -e "	${pkey}	: ${notealias[${pkey}]}"
			fi
		done
	done
###########################
	echo
	echo -e "	0	: exit"
	echo
	echo -e "	98	: make an addition"
	echo -e "	99	: make a deletion"
	echo
	echo -n "	Make a selection: "
	read menuoption
	
	if [ ${menuoption} -eq 0 ]
	then
		mainloopctl=-1
		exit 0
	elif [ ${menuoption} -le ${pages} ]
	then

		echo -n "	d(isplay) or e(dit): "
		read workoption

		if [ "${workoption}" == "d" ]
		then
			clear
			echo -e "${TC_BLUE}============================================================="
			echo -e "${NORMAL}"
			cat "${notepage[${menuoption}]}"
			echo -e "${TC_BLUE}============================================================="
                	echo -e "${NORMAL}press a key to continue..."
			read -N 1 keyp
		elif [ "${workoption}" == "e" ]
		then
			clear
			echo -e "${TC_BLUE}============================================================="
			echo -e "${BOLD}${TC_BLUE}${BLINK}			vi terminal open"
			echo -e "${NORMAL}${TC_BLUE}============================================================="
			echo -e "${NORMAL}press a key to continue..."
			gnome-terminal -x vi "${notepage[${menuoption}]}"
			read -N 1 keyp
		fi
	elif [ ${menuoption} -eq 98 ]
	then
		pageadd
		. ${PROG_DIR}/index.sh
		. ${PROG_DIR}/varhold.sh
	elif [ ${menuoption} -eq 99 ]
	then
		pagedel
		. ${PROG_DIR}/index.sh
	else
		echo " "
	fi
done

exit 0 
