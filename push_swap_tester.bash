# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    push_swap_tester.bash                              :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: minckim <minckim@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/14 18:07:27 by minckim           #+#    #+#              #
#    Updated: 2021/11/29 15:27:28 by minckim          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

#==============================================================================
# Directroy

#	|- [ push_swap ]
#			|- Makefile (Your push_swap Makefile)
#			|- checker_linux (or checker_Mac)
#	|- [ push_swap_tester ]
#			|- push_swap_tester.bash
#			|- random_numbers.cpp
#			|- Makefile

#==============================================================================
# push_swap directory

PUSHSWAP_DIR=../push_swap

#==============================================================================
# OS

OS="Mac"
# OS="linux"

#==============================================================================

#
#
#
# 여백의 미
#
#
#

#==============================================================================
# Colors
BLACK=$'\033[0;30m'
RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[0;33m'
BLUE=$'\033[0;34m'
PURPLE=$'\033[0;35m'
CYAN=$'\033[0;36m'
WHITE=$'\033[0;39m'

#==============================================================================
# Path
PUSHSWAP=$PUSHSWAP_DIR/push_swap
if [[ $OS = "linux" ]]
then
	CHECKER=$PUSHSWAP_DIR/checker_linux
elif [[ $OS = "Mac" ]]
then
	CHECKER=$PUSHSWAP_DIR/checker_Mac
else
	CHECKER=$PUSHSWAP_DIR/checker
fi
TESTER=./random_numbers

#==============================================================================
# Functions

BORDER_LINE="------------------------------------"

# parameters:
#	$1 : number of args
function print_arguments(){
	if [ $1 -ge 32 ]
	then
		echo "   Arguments : "$1" elements"
	else
		echo "   Arguments : $2 $3 $4 $5 $6"
	fi
}


# parameters:
#	$1 : result
#	$2 : to be displayed
function print_display(){
	if [[ "$1" = "PASS" ]]
	then
		echo "     Display : "$GREEN$2$WHITE
	else
		echo "     Display : "$RED$2$WHITE
	fi
}


# parameters:
#	$1 : answer to print
function print_result(){
	if [ $1 == "FAIL" ]
	then
		echo "      Result : "$RED"FAIL"$WHITE
		echo $RED$BORDER_LINE$WHITE
	else
		echo "      Result : "$GREEN"PASS"$WHITE
		echo $GREEN$BORDER_LINE$WHITE
	fi
}


# parameters:
#	$1 : arg1
#	$2 : arg2
#	$3 : arg3
function test_error(){
	print_arguments 3 $1 $2 $3
	ARG="$1 $2 $3"
	# ANS_OUT=$(echo "" | $CHECKER $ARG 2>/dev/null)
	ANS_OUT=$(echo "" | $CHECKER $ARG 2>/dev/null)
	ANS_ERR=$(echo "" | $CHECKER $ARG 2>&1 > /dev/null)
	if [ ! -z $ANS_OUT ]
	then
		# echo "Display : "$RED$ANS_OUT$WHITE"(Standard out)"
		print_display FAIL $ANS_OUT"(Error should be displayed on stderr.)"
		print_result "FAIL"
	elif [[ "Error" = "$ANS_ERR" ]]
	then
		print_display PASS $ANS_ERR
		print_result "PASS"
	else
		print_display FAIL $ANS_ERR
		print_result "FAIL"
	fi
}

# parameters:
#	$1 : number of args
#	$2 : arg1
#	$3 : arg2
#	$4 : arg3
#	$5 : arg4
#	$6 : arg5
function test(){
	if [[ $1 -le 3 ]]
	then
		ARG="$2 $3 $4 $5 $6"
	else
		ARG=$($TESTER $1 1)
	fi
	print_arguments $1 $ARG
	SCORE=-1

	ANS=$($PUSHSWAP $ARG | $CHECKER $ARG)
	INS=$($PUSHSWAP $ARG | wc -l)


	RESULT="PASS"
	if [[ ! "$ANS" = "OK" ]]
	then
		RESULT="FAIL"
	fi

	if [[ "$RESULT" = "PASS" ]]
	then
		print_display PASS $ANS
	else
		print_display FAIL $ANS
	fi


	INS_RESULT="PASS"
	if [[ $1 -eq 3 ]]
	then
		if [[ $INS -gt 3 ]]
		then
			INS_RESULT="FAIL"
		fi
	elif [[ $1 -eq 5 ]]
	then
		if [[ $INS -gt 12 ]]
		then
			INS_RESULT="FAIL"
		fi
	elif [[ $1 -eq 100 ]]
	then
		if [[ $INS -le 700 ]]
		then
			SCORE="5"
		elif [[ $INS -le 900 ]]
		then
			SCORE="4"
		elif [[ $INS -le 1100 ]]
		then
			SCORE="3"
		elif [[ $INS -le 1300 ]]
		then
			SCORE="2"
		elif [[ $INS -le 1500 ]]
		then
			SCORE="1"
		else
			SCORE="0"
			INS_RESULT="FAIL"
		fi
	elif [[ $1 -eq 500 ]]
	then
		if [[ $INS -le 5500 ]]
		then
			SCORE="5"
		elif [[ $INS -le 7000 ]]
		then
			SCORE="4"
		elif [[ $INS -le 8500 ]]
		then
			SCORE="3"
		elif [[ $INS -le 10000 ]]
		then
			SCORE="2"
		elif [[ $INS -le 11500 ]]
		then
			SCORE="1"
		else
			SCORE="0"
			INS_RESULT="FAIL"
		fi
	fi

	if [[ "$INS_RESULT" = "PASS" ]]
	then
		if [[ $SCORE -ne -1 ]]
		then
			if [[ $SCORE -eq 5 ]]
			then
				echo "       Score : "$GREEN$SCORE$WHITE
				echo "Instructions : "$GREEN$INS$WHITE
			elif [[ $SCORE -ge 1 ]]
			then
				echo "       Score : "$YELLOW$SCORE$WHITE
				echo "Instructions : "$YELLO$INS$WHITE
			else
				echo "       Score : "$RED$SCORE$WHITE
				echo "Instructions : "$RED$INS$WHITE
			fi
		else
			if [[ "$INS_RESULT" = "PASS" ]]
			then
				echo "Instructions : "$GREEN$INS$WHITE
			else
				echo "Instructions : "$RED$INS$WHITE
			fi
		fi
	fi


	if [[ $INS_RESULT = "FAIL" ]]
	then
		RESULT="FAIL"
	fi

	print_result $RESULT
}

function run_non_arg_test(){
	echo "$CHECKER (with no argument): "
	ANS="$($CHECKER)"
	if [ -z $ANS ]
	then
		print_display PASS $ANS
		print_result PASS
	else
		print_display FAIL $ANS
		print_result FAIL
	fi
	echo "$PUSHSWAP (with no argument): "
	ANS="$($PUSHSWAP)"
	if [ -z $ANS ]
	then
		print_display PASS $ANS
		print_result PASS
	else
		print_display FAIL $ANS
		print_result FAIL
	fi
}

#==============================================================================
# makefile

# random numbers
echo "Building random number creator..."
if [[ -z $(make 2>&1 > /dev/null) ]]
then
	echo $GREEN"  Building Successs!"$WHITE
else
	echo $RED"  Building Failed!"$WHITE
	exit 1
fi

# push_swap
echo "Building push_swap..."
if [[ -z $(make -C $PUSHSWAP_DIR 2>&1 > /dev/null) ]]
then
	echo $GREEN"  Building Successs!"$WHITE
else
	echo $RED"  Building Failed!"$WHITE
	exit 1
fi
echo $GREEN$BORDER_LINE$WHITE

#==============================================================================
# TEST START

# no arg test
run_non_arg_test

# duplicates
test_error 1 2 2
test_error 2 2 1
test_error 2 1 2
test_error a 1 2
test_error 1 a 2
test_error 1 2 a
test_error 1 2 2147483648
test_error 1 2 -2147483649
# negative numbers, near overflow
test 3 1 -5 2
test 3 1 -2147483648 2
test 3 2147483647 2 1
# # 3 elements
test 3 2 0 1
test 3 1 2 3
test 3 1 3 2
test 3 2 1 3
test 3 2 3 1
test 3 3 1 2
test 3 3 2 1
# 4 elements
test 4
test 4
test 4
test 4
test 4
# 5 elements
test 5
test 5
test 5
test 5
test 5
test 5
test 5
# 100 elements
test 100
test 100
test 100
test 100
test 100
test 100
# 500 elements
test 500
test 500
test 500
test 500
test 500
test 500

rm $TESTER