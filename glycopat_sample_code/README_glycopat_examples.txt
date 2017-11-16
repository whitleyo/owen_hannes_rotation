NOTE: First I give a basic overview of the workflow with a few important details here and there. Afterwards, I give a description of the results I've obtained by performing the steps mentioned with settings identical to those used in the sample scripts

Instructions for use:

1. Wherever you want to use this glycopat workflow, you will need GlycoPAT installed into MATLAB (already done for all nodes on banting cluster).
You will probably want to use it on the cluster anyways since for 100,000 scans of a simple 4 protein mixture, and searching for various potential glycopeptides of these four proteins, it took a bit under 72 hours for the search to run.

2. First thing you will need to do will be to make yourself a 'glypepdb', or a dtabase of glycopeptides. This can easily be done via GlycoPAT's digestSGP function.
 You will need:
	1)  a file listing fixed post-translational modifications (PTMs) (see fixed_ptm_std.txt as an example, this is the default shipped with GlycoPAT)
	2) a file listing variable PTMs, including N-glycans, O-glycans, and/or other PTMs such as oxidation of a particular amino acid.
	 The files of this type which I've included in the 'sample files' include:
		 standard_N_glycans_met_o.txt;  includes standard N glycans and methionine oxidation
		 standard_N_standard_O_met_o.txt; includes standard N glycans, standard O glycans, methionine oxidation
	 GlycoPAT's git repository also comes with standard N and standard O glycan libraries. From my experience I suggest against using standard N and standard O glycan libraries together as this has made already long peptide searches even longer, likely due to vastly expanding the search space.
	3) FASTA file containing all the proteins you want to include in your peptide search.
		e.g. 4_protein_mix.fasta, which contains the FASTA sequences (from uniprot) of the 4 proteins in the 4 protein samples from Liu et al 2017.

  You will then need to make a MATLAB script along the lines of 4ProtMix_make_digest_example.m, and make a bash script to run the program on banting.
  Since this will not be a parallel job, you should only specify 1 processor per node and 1 node for your job, and set walltime and memory as appropriate.
  Keep in mind that banting will kill your job if it exceeds allotted memory (default is 2 GB)
  At the end of the day, you should get a text file output such as 4ProteinMix_02_digest.txt, which contains a list of glycopeptides with and without PTMs

3. The next thing to do is run the scoring function. There are three implementations of the same scoring function, scoreAllSpectra; we will be using scoreAllSpectra_parfor.

You will need:
	1) your glypepdb (glycopeptide database) generated in step 2
	2) an mzXML file (Can also work with DTA files but I've never tried this out)
	

The search/scoring algorithm is essentially as described in Liu et al 2017. For each MS2 spectrum, MS1 precursors within a particular mass tolerance of the real MS1 precursor will be selected for search against the spectrum. Then, a theoretical set of glycopeptide fragment ions will be generated, and the potential precursors will be scored by several metrics to assess how their theoretical fragments mtach up with the observed spectra.


You will have to specify various parameters, such as MS1 tolerance, MS2 tolerance, etc. If you specify CID, HCD, or ETD for fragMode, you will get default cleavage settings for CID, HCD, and ETD. For CID, this is 2 glycan cleavages if # of sugars >= 4, 1 glycan cleavage and 1 peptide cleavage otherwise. For HCD, there should be b-y peptide cleavages and glycans with max length of 2 attached, as described in Liu et al 2017. For ETD, there should be no glycan fragments and 1 peptide fragmentation events. Note that under none of thesee circomstances are non-glycan modifications permitted to be removed (nmFrag = 0). I have not tried out CIDspecial, HCDspecial or ETDspecial modes, but this should cause the program to ignore default settings and take user specified npFrag, nmFrag, and ngFrag parameters. You can also specify fragMode = Auto, the function will determine the fragmentation mode that was used for the particular MS2 scan (this is metadata extracted from the mzXML well before scoring), and use default parameters for the particular fragmentation mode

Note that I've only tried out CID mode on an actual dataset from PRIDE.

You run scoreAllSpectra_parfor from a script, such as 4ProteinMix_01_pickpeak_02pct_bpi_parfor_example.m, and you run this script via a bash script such as 4ProteinMix_01_pickpeak_02pctbpi_parfor_example.sh. Depending on the node you plan on using, specify the number of matlab worker processes (via parpool) appropriately. For example, I've run my scripts using 8 worker processes on one node. Also, be sure to allot an appropriate amount of walltime for the job, as well as memory. For a 4 protein sample with 100,000 scans, and a glypepdb generated for 4 proteins and standard N glycans + methionine oxidation and fixed cysteine carbamidomethylation, it took a bit under 3 days (<72 hr) to complete.

A csv file should be produced containing your spectral hits

4. For downstream fdr filtering, I've generally used the glycopat GUI, can be downloaded from https://sourceforge.net/projects/glycopat/files/Standalone/v1.0/. Open the Browse Results GUI, load in csv file from step 3, select appropriate FDR, hit apply, and you will see only a subset of the spectral matches displayed. These can be saved to a csv file (there's a button to do this).


However, if you would like to write a script to FDR filter, you can try out the fdrfilter function: see script try_fdrfilter.m for an example usage.

=========================== GlycoPAT Results ==========================================

See Liu et al. 2017 for experiments and details of glycopat algorithm.

Raw file used: 4ProteinMix_01.raw (from PRIDE PXD006031)
Preprocessing: ProteoWizard msconvert
		* filters: peakpicking (vendor), 2% BPI threshold for MS1, MS2
GlyPepDB generation:
	* Settings identical to those used in 4ProtMix_make_digest_example.m
	* See 4ProtMix_make_digest_example.m for input files used for variable PTMs, fixed PTMs, fasta

spectra scoring:
	* settings identical to those used in 4ProteinMix_01_pickpeak_02pct_bpi_parfor_example.m

FDR filtering:
	* input csv: 4ProtMix_01_pickpeak_02pct_bpi_parfor_copy_scoring_results.csv
	* used GlycoPAT standalone GUI for FDR filtering
	* selected FDR of 1%.
	* output csv: 4ProtMix_01_pickpeak_02pct_bpi_parfor_copy_scoring_results_FDR_01pct.csv

After FDR filtering, the spectral matches were dominated by glycopeptides corresponding to A1AG1 and FINC1_Human, there were nonetheless matches to RNASE1 and FETUA_BOVIN

A total of 14 unique sites were found by manual inspection of the FDR filtered match results.
