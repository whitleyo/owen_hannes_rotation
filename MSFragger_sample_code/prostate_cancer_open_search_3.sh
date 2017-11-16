#PBS -l walltime=03:59:00
#PBS -l nodes=1:ppn=8
#PBS -l mem=32gb

my_folder='/home/rostlab/owhitley/MSFragger_20170103/'
my_jar='MSFragger-20171106.jar'
my_jar_path=$my_folder$my_jar
my_frag_params='prostate_cancer_open_search_3.params'
my_frag_param_path=$my_folder$my_frag_params
my_mzXML='053113_Wang_ITRAQ_1.mzXML'
my_mzXML_path=$my_folder$my_mzXML
java -Xmx32G -jar  $my_jar_path $my_frag_param_path $my_mzXML_path 
