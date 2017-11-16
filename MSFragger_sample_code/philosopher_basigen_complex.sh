#!/bin/bash
rm -rf .meta
./philosopher workspace --clean
./philosopher workspace --init
./philosopher peptideprophet --database uniprot-reviewed_yes+taxonomy_9606_W_DECOYS_v3.fasta --nonparam --expectscore --decoy DECOY_ --decoyprobs --masswidth 2000 --clevel 2 --forcedistr 151029_ly_CD147his_1pmol_complex1..pepXML 
./philosopher proteinprophet interact-151029_ly_CD147his_1pmol_complex1.pep.xml --output 150809_ly_CD147his1_complex_search
