#PBS -l walltime=03:59:00
#PBS -l nodes=1:ppn=8
#PBS -l mem=32gb

my_folder='/home/rostlab/owhitley/MSFragger_20170103/'
my_jar='MSFragger-20171106.jar'
my_jar_path=$my_folder$my_jar
my_frag_params='basigen_complex_open_search_1.params'
my_frag_param_path=$my_folder$my_frag_params
my_mzXML='151029_ly_CD147his_1pmol_complex1.mzXML'
my_mzXML_path=$my_folder$my_mzXML
java -Xmx16G -jar  $my_jar_path $my_frag_param_path $my_mzXML_path 
