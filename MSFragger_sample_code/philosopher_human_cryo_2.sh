#!/bin/bash
./philosopher workspace --init
./philosopher peptideprophet --database uniprot-reviewed_yes+taxonomy_9606_W_DECOYS_v3.fasta --nonparam --expectscore --decoy DECOY_ --decoyprobs --masswidth 1000 --clevel 2 --forcedistr CryoPrecipitate_01_pickpeak_02pct_bpi_search_2.pepXML
./philosopher proteinprophet --minprob 0.05 interact-CryoPrecipitate_01_pickpeak_02pct_bpi_search_2.pep.xml --output interact-CryoPrecipitate_01_pickpeak_02pct_bpi_search_2
./philosopher filter --pepxml interact-CryoPrecipitate_01_pickpeak_02pct_bpi_search_2.pep.xml --protxml interact-CryoPrecipitate_01_pickpeak_02pct_bpi_search_2.prot.xml

./philosopher report
