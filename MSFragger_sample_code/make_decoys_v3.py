#Make a fasta file with decoys appended to the end of the file
#decoy names must be appended as prefixes to gene names
import re
import sys
import os

def make_decoys(input_str, mode = 'uniprot'):

	input_fasta_lines = input_str.split('\n')

	if mode == 'uniprot':
		
		header_regex = '>[A-z]*\|\w*\|\w*'
		first_fasta = True
		decoy_str = ''
		temp_fasta_str = '' # will be used as a container for each fasta sequence. When next sequence reached,
							#t this is reversed and put underneath the decoy header
	def add_newline_delim(match_obj):
		new_string = match_obj.group(0) + '\n'
		return(new_string)

	for i in range(0,len(input_fasta_lines)):

		current_line = input_fasta_lines[i] #set current line
		header_match = re.match(header_regex, current_line)

		#two possible scenarios: you've reached a header line or your in FASTA body
		if header_match:

			if first_fasta == True: #If this is first fasta header/sequence, skip the else statement

				first_fasta = False # Set the first_fasta condition to false

			else:
				
				temp_fasta_str = temp_fasta_str[::-1]
				regex_60_cols = '.{1,60}'
				temp_fasta_lines = re.sub(regex_60_cols, add_newline_delim, temp_fasta_str)
				temp_str = temp_str + temp_fasta_lines
				decoy_str = decoy_str + temp_str # add temp string to larger string
				temp_fasta_str = ''
				temp_str = ''

			header_text = header_match.group(0) #takes the first part of the header match
			header_split_regex = '(>)'
			header_split = re.split(header_split_regex, header_text)
			new_header = header_split[1] + 'DECOY_' + header_split[2] + '\n' # make new header with decoy prefix for protein name
			temp_str = new_header

		else:

			temp_fasta_str = temp_fasta_str + current_line

		if i == (len(input_fasta_lines) - 1): #if we've reached the end of the input fasta lines

				temp_fasta_str = temp_fasta_str[::-1]
				regex_60_cols = '.{1,60}'
				temp_fasta_lines = re.sub(regex_60_cols, add_newline_delim, temp_fasta_str)
				temp_str = temp_str + temp_fasta_lines
				decoy_str = decoy_str + temp_str # add temp string to larger string

	new_file_str = input_str + '\n' + decoy_str #concatenate strings containing fasta sequences and decoys
	return(new_file_str)

if __name__ == '__main__':

	input_file = sys.argv[1]
	output_file = sys.argv[2]

	if len(sys.argv) != 3:

		raise ValueError('input filename and output filename required as arguments')

	if os.path.exists(output_file):

		overwrite = input('would you like to overwrite file ' + output_file + '? y/n')

		if overwrite == 'y':

			os.remove(output_file)

		elif overwrite == 'n':

			print('do not overwrite, terminating program')
			assert(False)

		else:

			raise ValueError('only y and n accepted')

	inp_file_obj = open(input_file)
	out_file_obj = open(output_file,'a')

	inp_file_str = inp_file_obj.read()
	out_file_str = make_decoys(inp_file_str, mode = 'uniprot')

	
	out_file_obj.write(out_file_str) #write to output file
