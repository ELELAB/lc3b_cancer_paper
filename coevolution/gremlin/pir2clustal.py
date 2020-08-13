#!/usr/bin/env python
# -*- Mode: python; tab-width: 4; indent-tabs-mode:nil; coding:utf-8 -*-
#
# Convert a PIR-formatted multiple sequence alignment into a 
# CLUSTALW multiple sequence alignment.
#
# USAGE: python2.7 pir2clustal.py in_file out_file

import sys


def pir2clustal(in_file, \
				out_file, \
				char_per_line = 60):

	"""
	Convert a PIR file containing a multiple sequence alignment
	to the CLUSTALW format.

	Parameters
	----------
	in_file : str
		Name of the PIR input file.

	out_file : str
		Name of the CLUSTALW output file (with extension).

	char_per_line : int, default: 60
		Number of sequence characters per line.

	Returns
	-------
	None
	"""

	with open(in_file, "r") as f, 	\
		 open(out_file, "w") as out:

		data = {}
		
		# keep track of the original sequence order in the PIR
		# file to reproduce it in the output file
		original_sorting = []
		
		# set a boolean switch to record when a new sequence starts
		new_seq = False
		
		for line in f:
			if line.startswith(">"):
				# get the sequence name
				seq_name = line.lstrip(">").strip("\n").split(" ")[0]
				original_sorting.append(seq_name)
				new_seq = True
			else:
				if new_seq:
					data[seq_name] = line.rstrip("\n")
					new_seq = False
				else:
					data[seq_name] += line.rstrip("\n")

		# get the maximum length of sequence names (to correctly
		# format the output file)
		maxlen_name = max([len(name) for name in data.keys()])

		# cut each sequence in chuncks of maximum length equal to
		# 'char_per_line'
		data = {key : [seq[i:i+char_per_line] \
						for i in range(0,len(seq), char_per_line)] \
				for key, seq in data.items()}

		# get the number of chunks (identical for each sequence
		# because it is a multiple sequence alignment)
		num_chunks = len(list(data.values())[0])

		for i in range(num_chunks):
			offset = char_per_line*(i+1)
			for name in original_sorting:
				out.write("{0}{1}\t{2}\n".format(name.ljust(maxlen_name+4), \
											     data[name][i], \
											     offset))

			out.write("\n")



pir2clustal(sys.argv[1], sys.argv[2])
