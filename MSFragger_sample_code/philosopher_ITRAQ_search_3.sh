#!/bin/bash
./philosopher workspace --init
./philosopher peptideprophet --database uniprot-reviewed_yes+taxonomy_9606_W_DECOYS_v3.fasta --nonparam --expectscore --decoy DECOY_ --decoyprobs --masswidth 1000 --clevel 2 --forcedistr 053113_Wang_ITRAQ_1_search_3.pepXML
./philosopher proteinprophet interact-053113_Wang_ITRAQ_1_search_3.pep.xml --output interact-053113_Wang_ITRAQ_1_search_3.prot.xml
./philosopher filter --pepxml interact-053113_Wang_ITRAQ_1_search_3.pep.xml --protxml interact-053113_Wang_ITRAQ_1_search_3.prot.xml.prot.xml
./philosopher report
