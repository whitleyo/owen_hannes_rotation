#Test make_decoys from make_decoysv2 script

import os
import make_decoys_v3 as MD

inp_file = 'dummy_input.fasta'
out_file = 'test_output_v3.fasta' # to be produced by this script
ref_file = 'dummy_output_v3.fasta' # used as a reference

if os.path.exists(out_file):
	print('removing ' + out_file)
	os.remove(out_file)

inp_file_obj = open(inp_file)
out_file_obj = open(out_file, 'a')
inp_file_str = inp_file_obj.read()

out_file_str = MD.make_decoys(inp_file_str)
out_file_obj.write(out_file_str)
inp_file_obj.close()
out_file_obj.close()

test_file_obj = open(out_file)
test_file_str_list = test_file_obj.read().split('\n')
ref_file_obj = open(ref_file)
ref_file_str_list = ref_file_obj.read().split( '\n')

num_mismatch = 0
mismatch_ind = []
for i in range(0, min(len(test_file_str_list), len(ref_file_str_list)), 1):

	if test_file_str_list[i] == ref_file_str_list[i]:

		continue

	else:

		num_mismatch += 1
		mismatch_ind.append(i)

if num_mismatch > 0:

	print('mismatches at:')
	print(mismatch_ind)
	raise ValueError(str(num_mismatch) + ' mismatches between test and dummy files')

elif len(test_file_str_list) != len(ref_file_str_list):

	raise ValueError('different number of lines in test and ref files')

else:

	print('Test Passed')