#!/bin/bash
#PBS -l nodes=1:ppn=8
#PBS -l walltime=72:00:00
#PBS -l mem=32gb

# Here, I've specified to the job scheduler that this job will need 1 node, 8 processors per node (recall that we specified a pool of 8 workers in matlab)
# and a memory of 32gb (will take less than 32gb, but you're using all 8 processors on node, so may as well specify the rest of the 32gb).
# Walltime is specified as 72 hours (hh:mm:ss), i.e. 3 days, and will be placed on banting's long queue (for jobs that last > 24 hours)

#Below, run matlab, usinng matlab script as input, suppressing display and redirecting output to an output file

#NOTE: change filenames/paths depending on files used and their locations!
matlab -r -nodesktop -nodisplay -nosplash < 4ProteinMix_01_02pct_bpi_parfor_example.m > 4ProteinMix_01_02pct_bpi_parfor_example_output.txt
