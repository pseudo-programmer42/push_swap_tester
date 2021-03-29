/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   random_numbers.cpp                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: minckim <minckim@student.42seoul.kr>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/07 01:27:52 by minckim           #+#    #+#             */
/*   Updated: 2021/03/30 04:28:35 by minckim          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <set>
#include <vector>
#include <random>
#include <iostream>
#include <unistd.h>

int				myrandom(long min, long max)
{
	std::random_device					random_device;
	std::mt19937						generator(random_device());
	std::uniform_int_distribution<int>	distribute(min, max);
	return distribute(generator);
}

void	random_number_vector(std::vector<int>& v, int size, int min = 1, int max = 1)
{
	if (min > max)
		std::swap(min, max);
	if (max + 1 - min < size)
		max = min + size - 1;

	std::vector<int>	v_tmp;
	v_tmp.reserve(max - min + 1);
	for (int i = min ; i <= max ; i++)
		v_tmp.push_back(i);
	for (int i = 0 ; i < max - min + 1 ; i++)
		std::swap(v_tmp[i], v_tmp[myrandom(0, max - min)]);
	for (int i = 0 ; i < size ; i++)
		v.push_back(v_tmp[i]);
}

int		main(int argc, char** argv)
{
	std::vector<int>	v;
	
	int		size;
	int		min;
	int		max;
	if (argc < 2)
	{
		std::cout << "Usage: " << argv[0] << " <size> [min] [max]\n"
		<< "- <min> and <max> is optional arguments.\n"
		<< "- Default value of <min> and <max> is 1. But <size> must be defined.\n"
		<< "- If (<max> - <min>) is less than <size>, <max> would be changed to fit the <size>\n"
		<< "- To set ARG:\n\n"
		<< "	$ export ARG=\"$(" << argv[0] << " <size> [min] [max])\"\n\n"
		<< "- By: minckim <minckim@student.42seoul.kr>\n";
		return 1;
	}
	try
	{
		size = atoi(argv[1]);
		if (argc >= 3)
			min = atoi(argv[2]);
		else
			min = 0;
		if (argc >= 4)
		{
			max = atoi(argv[3]);
			max = max > min + size - 1 ? max : min + size - 1;
		}
		else
			max = min + size - 1;
	}
	catch(const std::exception& e)
	{
		std::cout << e.what() << '\n';
		return 1;
	}
	random_number_vector(v, size, min, max);
	for (int i : v)
	{
		std::cout << i << " ";
	}
	return 0;
}