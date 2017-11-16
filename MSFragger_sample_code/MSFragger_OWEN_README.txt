Included in this folder are a set of programs, a set of scripts, and a set of sample outputs

The general workflow:

1. Set up '.params' file
	* edit this file (some examples are found in the folder) to set up the database generation and search parameters for MSFragger
	* more or less, you put in search parameters as well as a FASTA file (with decoys if you want) containing the proteins you want to search for
	* see MSFragger Manual (pdf file included) for more details

2. Setup a bash script to run MSFragger
	* setup walltime, memory allotment, # nodes, processors per node
	* There are two MSFragger programs included in this folder: MSFragger.jar (Latest release, 20170103) and MSFragger-20171106.jar (beta version, bug fixed from Latest release).
	  The beta release fixes a bug from the latest release which prevents the program from working with small FASTA files 
	* include a line with 'java -jar MSFragger.jar -Xmx#G my_file.mzXML' to run MSFragger. Substitute MSFragger.jar with MSFragger-20171106.jar if you want to use the new beta version. This will run the program. Xmx#G specifies # GB ram to the program. my_file.mzXML is the mzXML file you pass to MSFragger

3. Run the bash script with qsub my_script.sh. The script is submitted to banting as a job to run.

4. If you specified in the params file to get a pepXML formatted output, you will get a pepXML output file. This is input into the philosopher implementation of Trans Proteomic Pipeline components.

	* you will need the philosopher program. The linux amd64 version is included with this folder. If you want a windows or other version, you can download it from here: https://github.com/prvst/philosopher/releases/tag/1.9
	* the documentation (pretty limited) for philosopher, you should consult: https://prvst.github.io/philosopher/documentation.html
	* With philosopher, the general syntax for running a program is 'philosopher program -options'
	* The general workflow of philosopher is to
		1) initiate a workspace (philosopher workspace --init)
		2) run peptideprophet (philosopher peptideprophet -options my_results.pepXML)
		3) run proteinprohet (philosopher proteinprophet -options interact-my_results.pep.xml)
		4) run filter (philosopher filter  --pepxml interact-my_results.pep.xml --protxml interact-my_results.prot.xml)
		5) run report (philosopher report)
	* Note that I haven't yet gotten steps 4 and 5 to work. The prot.xml file will still contain information as to the putative probabilities of proteins being in your samples, and should also contain mass shift information


At the end of the day, you'll have pepxml and protxml files giving likely peptides and proteins, essentially as with their counterparts from the TPP, only with mass shift information for the peptides.

=================================== Sample Scripts and Outputs =========================================

All pride datasets have citations for the corresponding papers

All runs used a fasta file containing all reviewed human proteins from uniprot (about 20k proteins) plus their reversed decoys.
The fasta file is named  uniprot-reviewed_yes+taxonomy_9606_W_DECOYS_v3.fasta.
It was generated from uniprot-reviewed_yes+taxonomy_9606.fasta via the make_decoys_v3.py script.
A test of this function was done via the script test_make_decoys_v3.py.
The test script essentially uses the make_decoy function in make_decoys_v3 to make an output file (test_output_v3.txt) with reversed decoys, and 
checks the file line by line against a manually generated reference file (dummy_output_v3.fasta).

Basigin Simple and Complex Samples: https://www.ebi.ac.uk/pride/archive/projects/PXD004243

Use one of the complex samples and one of the regular samples
In this experiment, they acquired HCD spectra of tryptic basigin fragments either in a simple mixture (basigen only)
or in a complex mixture (spiked into a mixture of proteins secreted from cancer cells).
See link to PRIDE for more details

scripts: 

	basigen_complex_open_search_1.sh
	basigen_simple_open_search_1.sh

param files:

	basigen_complex_open_search_1.params
	basigen_simple_open_search_1.params

run philosopher:

	philosopher_basigen_complex.sh
	philosopher_basigen_simple.sh

outputs:

	interact-150809_ly_CD147his1_simple_search.pep.xml
	interact-151029_ly_CD147his_1pmol_complex1.pep.xml
	150809_ly_CD147his1_simple_search.pepXML
	151029_ly_CD147his_1pmol_complex1..pepXML

iTRAQ tagged Human Prostate Cancer Proteome: https://www.ebi.ac.uk/pride/archive/projects/PXD002107

script: 

	prostate_cancer_open_search_3.sh

param file:

	prostate_cancer_open_search_3.params

run philosopher:

	philosopher_ITRAQ_search_3.sh

outputs:

	053113_Wang_ITRAQ_1_search_3.pepXML
	interact-053113_Wang_ITRAQ_1_search_3.pep.xml
	interact-053113_Wang_ITRAQ_1_search_3.prot.xml.prot.xml

Human Plasma Cryoprecipitome: https://www.ebi.ac.uk/pride/archive/projects/PXD006031

script:

	cryo_human_open_search_2.sh

param file:

	cryo_human_open_search_2.params

run philosopher:

	philosopher_human_cryo_2.sh

outputs:

	CryoPrecipitate_01_pickpeak_02pct_bpi_search_2.pepXML
	interact-CryoPrecipitate_01_pickpeak_02pct_bpi_search_2.pep.xml
	interact-CryoPrecipitate_01_pickpeak_02pct_bpi_search_2.prot.xml




