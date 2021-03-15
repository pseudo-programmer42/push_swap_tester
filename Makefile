# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: minckim <minckim@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/09 02:28:13 by minckim           #+#    #+#              #
#    Updated: 2021/03/12 15:47:28 by minckim          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all : name

name : random_numbers

random_numbers : random_numbers.cpp
	clang++ random_numbers.cpp --std=c++11 -o random_numbers

fclean:
	rm -rf random_numbers