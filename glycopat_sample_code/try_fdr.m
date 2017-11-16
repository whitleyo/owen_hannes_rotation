my_file = 'C:\Users\newot\hannes_work\4_protein_samples\filter_conversion\4ProtMix_01_pickpeak_02pct_bpi_parfor_copy_scoring_results.csv'
option = struct('fdrfilter',0.01,'glycopep',1,'singlemode',1,'fragmode','CID')
[es_cutoff, filter_scoretable] = fdrfilter(my_file,option)
new_file = '4ProtMix_01_pickpeak_02pct_bpi_parfor_copy_scoring_results_FDR_filter_script.csv'
writetable(filter_scoretable, new_file)