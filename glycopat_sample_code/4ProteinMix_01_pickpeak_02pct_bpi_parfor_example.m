%Perform Basic Run though of functions/workflow for glycopat
%start up a pool for matlab workers

%disp(gcp)
poolobj = parpool(8);
disp(gcp)

%======================== SETUP PARAMETERS/INPUTS ========================================

my_folder = '/home/rostlab/owhitley/GlycoPAT-master/demo/' % Going to have to change this as well as any filenames depending on
							% which files you're using and in what directory
glypepdb_file = '4Protein_mix_02_digest.txt'; % This is the name for the glypepdb file. Rename this depending on the name of the glypepdb file you generagte
mzxml_dir = my_folder
my_csv_dir = my_folder
my_csv = '4ProtMix_01_pickpeak_02pct_bpi_parfor_scoring_results.csv' %output csv name

   pepfilefullname= strcat(my_folder,glypepdb_file); % Full Filepath to glypepDB file, produced by digestSGP in previous script
   mzxmlfileDirectory = mzxml_dir;
   mzxmlfilename = '4ProteinMix_01_pickpeak_02pct_bpi.mzXML';
   fragMode = 'CID'; 	% note : since using default CID mode, glycopat will defaault to permitting 2 glycan fragmentations, 0 peptide fragmentations
			% if glycan PTM >= 4 sugars, and 1 glycan fragmentation and 1 peptide fragmentation if glcyan PTM < 4 sugars
			% 
   MS1tol = 20.000000; %MS1 tolerance
   MS1tolUnit = 'ppm';	% MS1 tolerance unit
   MS2tol = 1.000000;	%MS2 tolerance
   MS2tolUnit = 'Da';	% MS2 tolerance unut
   OutputDir = my_csv_dir; % Directory where CSV written
   OutCSVname = my_csv; %name of csv (not full filepath, just filename)
   maxlag = 50; % maxlag argument used for XCorr. See Liu et al. 2017 for detail
	% Cutoff MS2 spectra if < 2x median peak AND if < 1% of Max peak 
   CutOffMed = 2.000000; % 2x median peak
   FracMax = 0.010000; % min fraction of max peak is 1%
	% Number of fragmentations allowed
   nmFrag = 0; % # modification fragmentation events permitted
   npFrag = 1;
   ngFrag = 2;
   selectPeak =[]; % Leave this empty, unless you want to select particular peaks, in which case you pass a list of floats
	
%====================== PERFORM SCORING ====================================================
% Below: ScoreAllSpectra_parfor goes and performs scoring with the given inputs
   calchit = scoreAllSpectra_parfor(pepfilefullname,mzxmlfileDirectory,fragMode,MS1tol,MS1tolUnit,MS2tol, ...
     MS2tolUnit,OutputDir,OutCSVname,maxlag,CutOffMed,FracMax,nmFrag,npFrag,ngFrag, selectPeak,...
     true,mzxmlfilename);

 
%hit = scoreAllSpectra(Pepfile = out_file ,nm_frag = 0, np_frag = 0, ng_frag = 2, fragMod = 'CID', OutputDir = my_csv_dir, OutCSVname = my_csv, mzxmlfilena )
