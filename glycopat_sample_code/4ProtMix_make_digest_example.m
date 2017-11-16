my_folder = '/home/rostlab/owhitley/GlycoPAT-master/demo/' 
directory = my_folder; 				% working directory where files read from and written
protein_filename = '4_protein_mix.fasta'; 	% FASTA file containing all the proteins you want to make a digest for
fixedptm = 'fixed_ptm_std.txt'; 		% I've included this in the git project but you can find this file
						% in the GlycoPAT-master/demo folder if you download the GlycoPAT git project
varptm = 'standard_N_glycans_met_o.txt';	% variable ptm file. See glycopat manual for details. In this case, I basically 
						% took the standard N glycans file and put in a line at the top specifying methionine oxidation
output_file = '4Protein_mix_02_digest.txt';	% output file name. Not the full path, just the filename
enzname = 'Trypsin';				% enzyme name for digestion
MissedMax = 3;					% Max number of missed cleavages
MinPepLen = 4;					% Min peptide length
MaxPepLen = 100;				% Max Peptide length. I know this looks a bit ridiculous, but I didn't know that generally you shouldn't
						% be getting that many peptides above 30-40 AAs in length
minPTM = 0;					% min number of PTMs
maxPTM = 2;					% max number of PTMs

% digestSGP will do your digestion and make the output file. theoretical peptides also stored in my_theor_peptides variable
my_theor_peptides = digestSGP(directory, protein_filename, fixedptm, varptm, output_file, enzname, MissedMax, MinPepLen, MaxPepLen, minPTM, maxPTM)

