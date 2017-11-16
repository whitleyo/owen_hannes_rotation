#!/bin/bash
rm -rf .meta
./philosopher workspace --clean
./philosopher workspace --init
./philosopher peptideprophet --database uniprot-reviewed_yes+taxonomy_9606_W_DECOYS_v3.fasta --nonparam --expectscore --decoy DECOY_ --decoyprobs --masswidth 2000 --clevel 2 --forcedistr 150809_ly_CD147his1_simple_search.pepXML
./philosopher proteinprophet interact-150809_ly_CD147his1_simple_search.pep.xml --output interact-150809_ly_CD147his1_simple_search
