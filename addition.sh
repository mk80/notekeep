#!/bin/bash

##########################################################
#
#	addition script to notekeep
#
#	author: michael kosko
#
##########################################################

pageadd ()
{
	newadd=0
	existingbook=0
	newpalias="no"
	newbalias="no"
	bcount=0
	pcount=0

	clear
	echo -e "************************************************"
	echo -e "*						*"
	echo -e "*		Page addition			*"
	echo -e "*						*"
	echo -e "************************************************"
	echo

	echo -e "  1. Add a new book and page"
	echo -e "  2. Add a new page to existing book"
	echo -e "  0. exit"
	echo
	echo -n "  selection: "
	read newadd
	echo
	
	if [ ${newadd} -eq 0 ]
	then
		break
	elif [ ${newadd} -eq 1 ]
	then
		echo -n "  What is the name of the book? "
		read newbalias
		echo
		echo -n "  What is the name of the page? "
		read newpalias

		mkdir ${NOTE_DIR}/${newbalias}
		touch ${NOTE_DIR}/${newbalias}/${newpalias}

		let "bcount=books+1"
		sed -i "s|${books}|${bcount}|" ${PROG_DIR}/varhold.sh
		let "pcount=pages+1"
		sed -i "s|${pages}|${pcount}|" ${PROG_DIR}/varhold.sh
		. ${PROG_DIR}/varhold.sh
		echo "notepage[${pages}]=\"${NOTE_DIR}/${newbalias}/${newpalias}\"" >> ${PROG_DIR}/index.sh 
		echo "notealias[${pages}]=\"${newpalias}\"" >> ${PROG_DIR}/index.sh
		echo "bookalias[${books}]=\"${newbalias}\"" >> ${PROG_DIR}/index.sh
	elif [ ${newadd} -eq 2 ]
	then
		echo -e "  Which existing book?"
		echo
		for key in ${!bookalias[@]}; do
			echo -e "  ${key} : ${bookalias[${key}]}"
		done
		echo
		echo -n "  selection: "
		read existingbook
		echo
		echo -n "  What is the name of the page? "
		read newpalias

		touch ${NOTE_DIR}/${bookalias[${existingbook}]}/${newpalias}

		let "pcount=pages+1"
		sed -i "s|${pages}|${pcount}|" ${PROG_DIR}/varhold.sh
		. ${PROG_DIR}/varhold.sh 
		echo "notepage[${pages}]=\"${NOTE_DIR}/${bookalias[${existingbook}]}/${newpalias}\"" >> ${PROG_DIR}/index.sh
		echo "notealias[${pages}]=\"${newpalias}\"" >> ${PROG_DIR}/index.sh
	else
		echo " "
	fi
}
