#!/bin/bash
./philosopher workspace --init
./philosopher peptideprophet --database uniprot-reviewed_yes+taxonomy_9606_W_DECOYS_v3.fasta --nonparam --expectscore --decoy DECOY_ --decoyprobs --masswidth 2000 --clevel 2 --forcedistr CryoPrecipitate_01_pickpeak_02pct_bpi.pepXML
./philosopher proteinprophet --minprob 0.01 interact-CryoPrecipitate_01_pickpeak_02pct_bpi.pep.xml
./philosopher filter --pepxml interact-CryoPrecipitate_01_pickpeak_02pct_bpi.pep.xml --protxml interact.prot.xml
./philosopher report
