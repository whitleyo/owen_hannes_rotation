#!/bin/bash
./philosopher workspace --init
./philosopher peptideprophet --database uniprot-reviewed_yes+taxonomy_9606_W_DECOYS_v3.fasta --nonparam --expectscore --decoy DECOY_ --decoyprobs --masswidth 500 --clevel 2 --forcedistr 053113_Wang_ITRAQ_1.pepXML
./philosopher proteinprophet interact-053113_Wang_ITRAQ_1.pep.xml
./philosopher filter --pepxml interact-053113_Wang_ITRAQ_1.pep.xml --protxml interact.prot.xml
./philosopher report
