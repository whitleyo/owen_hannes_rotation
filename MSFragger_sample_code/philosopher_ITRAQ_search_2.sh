#!/bin/bash
rm -rf .meta
./philosopher workspace --clean
./philosopher workspace --init
./philosopher peptideprophet --database uniprot-reviewed_yes+taxonomy_9606_W_DECOYS_v3.fasta --nonparam --expectscore --decoy DECOY_ --decoyprobs --masswidth 1000 --clevel 2 --forcedistr 053113_Wang_ITRAQ_1_search_2.pepXML
./philosopher proteinprophet interact-053113_Wang_ITRAQ_1_search_2.pep.xml --output interact-053113_Wang_ITRAQ_1_search_2
./philosopher filter --pepxml interact-053113_Wang_ITRAQ_1_search_3.pep.xml --protxml interact-053113_Wang_ITRAQ_1_search_2.prot.xml
./philosopher report
