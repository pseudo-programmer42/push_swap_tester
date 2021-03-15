# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    push_swap_tester.bash                              :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: minckim <minckim@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/14 18:07:27 by minckim           #+#    #+#              #
#    Updated: 2021/03/15 12:57:04 by minckim          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

#==============================================================================

#	|- [ Your push_swap directory ]
#			|- Makefile (Your push_swap Makefile)
#			|- [ tester ]
#					|- push_swap_tester.bash
#					|- random_numbers.cpp
#					|- Makefile

#==============================================================================
# push_swap directory
PUSHSWAP_DIR=../push_swap

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
CHECKER=$PUSHSWAP_DIR/checker
TESTER=./random_numbers

#==============================================================================
# Functions
function set_arg(){
	export ARG=$($TESTER ${1} ${2} ${3})
	echo -n "         ARG: "
	if [ "$1" -le 20 ]
	then
		echo $ARG
	else
		echo $1 elements
	fi
}

function test(){
	ANS=$($PUSHSWAP $ARG | $CHECKER $ARG)
	INS=$($PUSHSWAP $ARG | wc -l)
	RESULT="PASS"
	COLOR=$GREEN
	SCORE="-1"

	if [ ${2} -eq 3 ]
	then
		if [ $INS -gt 3 ]
		then
			RESULT="FAIL"
		fi
	elif [ ${2} -eq 5 ]
	then
		if [ $INS -gt 12 ]
		then
			RESULT="FAIL"
		fi
	elif [ ${2} -eq 100 ]
	then
		if [ $INS -le 700 ]
		then
			SCORE="5"
		elif [ $INS -le 900 ]
		then
			SCORE="4"
		elif [ $INS -le 1100 ]
		then
			SCORE="3"
		elif [ $INS -le 1300 ]
		then
			SCORE="2"
		elif [ $INS -le 1500 ]
		then
			SCORE="1"
		else
			SCORE="0"
			RESULT="FAIL"
		fi
	elif [ ${2} -eq 500 ]
	then
		if [ $INS -le 5500 ]
		then
			SCORE="5"
		elif [ $INS -le 7000 ]
		then
			SCORE="4"
		elif [ $INS -le 8500 ]
		then
			SCORE="3"
		elif [ $INS -le 10000 ]
		then
			SCORE="2"
		elif [ $INS -le 11500 ]
		then
			SCORE="1"
		else
			SCORE="0"
			RESULT="FAIL"
		fi
	fi
	if [ $ANS != "Error" ]
	then
		if [ $SCORE != "-1" ]
		then
			if [ $SCORE -eq 5 ]
			then
				echo "       Score: "$GREEN$SCORE$WHITE
				echo "Instructions: "$GREEN$INS$WHITE
			elif [ $SCORE -ge 1 ]
			then
				echo "       Score: "$YELLOW$SCORE$WHITE
				echo "Instructions: "$YELLO$INS$WHITE
			else
				echo "       Score: "$RED$SCORE$WHITE
				echo "Instructions: "$RED$INS$WHITE
			fi
		else
			if [ $RESULT = "FAIL" ]
			then
				echo "Instructions: "$RED$INS$WHITE
			else [ $RESULT = "FAIL" ]
				echo "Instructions: "$GREEN$INS$WHITE
			fi
		fi
	fi
	if [ $ANS = ${1} ]
	then
		echo "     Display: "$GREEN$ANS$WHITE
	else
		echo "     Display: "$RED$ANS$WHITE
		RESULT="FAIL"
	fi
	
	if [ $RESULT = "FAIL" ]
	then
		COLOR=$RED
	fi
	echo "      Result: "$COLOR$RESULT$WHITE
	echo $COLOR"------------------------------"$WHITE
}

function run_test(){
	set_arg ${1} ${2} ${3}
	test OK ${1}
}

function run_test_arg(){
	export ARG="${3} ${4} ${5}"
	echo -n "         ARG: "
	echo $ARG
	test ${1} ${2}
}

function run_non_arg_test(){
	echo "$CHECKER (with no argument): "
	ANS="$($CHECKER)"
	if [ -z $ANS ]
	then
		echo "     display: "$ANS
		echo -n "      result: "
		echo $GREEN"OK"
		echo "------------------------------"$WHITE
	else
		echo "     display: "$ANS
		echo -n "      result: "
		echo $RED"FAIL"
		echo "------------------------------"$WHITE
	fi
	echo "$PUSHSWAP (with no argument): "
	ANS="$($PUSHSWAP)"
	if [ -z $ANS ]
	then
		echo "     display: "$ANS
		echo -n "      result: "
		echo $GREEN"OK"
		echo "------------------------------"$WHITE
	else
		echo "     display: "$ANS
		echo -n "      result: "
		echo $RED"FAIL"
		echo "------------------------------"$WHITE
	fi
}

#==============================================================================
# makefile

# random numbers
make
# push_swap
make -C $PUSHSWAP_DIR
echo $GREEN"------------------------------"$WHITE

#==============================================================================
# TEST START

# Non argument
run_non_arg_test
# duplicates
run_test_arg Error 3 3 2 2
run_test_arg Error 3 1 2 1
run_test_arg Error 3 a 1 2
# overflow
run_test_arg Error 3 2147483648 3 2 5
run_test_arg Error 3 -2147483649 3 2 5
# negative numbers
run_test_arg OK 3 -5 2 3
# 3 elements
run_test_arg OK 3 1 2 3
run_test_arg OK 3 1 3 2
run_test_arg OK 3 2 1 3
run_test_arg OK 3 2 3 1
run_test_arg OK 3 3 1 2
run_test_arg OK 3 3 2 1
# 4 elements
run_test 4 1
run_test 4 1
run_test 4 1
run_test 4 1
run_test 4 1
# 5 elements
run_test 5 1
run_test 5 1
run_test 5 1
run_test 5 1
run_test 5 1
run_test 5 1
run_test 5 1
# 100 elements
run_test 100 1
run_test 100 1
run_test 100 1
run_test 100 1
run_test 100 1
run_test 100 1
# 500 elements
run_test 500 1
run_test 500 1
run_test 500 1
run_test 500 1
run_test 500 1
run_test 500 1
