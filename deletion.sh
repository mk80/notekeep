#!/bin/bash

##################################################
#
#	deletion script for notekeep
#
#	author: michael kosko
#
##################################################

pagedel ()
{
	pickdel=0
	storebook=0
	storepage=0

	clear
	echo -e "************************************************"
	echo -e "*						*"
	echo -e "*		Page deletion			*"
	echo -e "*						*"
	echo -e "************************************************"
	echo

	echo -e "  1. Delete a page"
	echo -e "  2. Delete entire book"
	echo -e "  0. exit"
	echo
	echo -n " selection: "
	read pickdel
	echo

	if [ ${pickdel} -eq 0 ]
	then
		break
	elif [ ${pickdel} -eq 1 ]
	then
		for bkey in ${!bookalias[@]}; do
			echo -e " ${bkey}	: ${bookalias[${bkey}]}"
		done
		echo
		echo -n " From which book? "
		read storebook
		echo
		for pkey in ${!notepage[@]}; do
			if echo ${notepage[${pkey}]} | grep -q ${bookalias[${storebook}]}
			then
				echo -e "	${pkey}	: ${notealias[${pkey}]}"
			fi
		done
		echo
		echo -n " Which page? "
		read storepage

		grep -i 'notealias\[${storepage}\]' ${PROG_DIR}/index.sh

	elif [ ${pickdel} -eq 2 ]
	then
		echo -e "  not yet"
	else
		echo " "
	fi
}
