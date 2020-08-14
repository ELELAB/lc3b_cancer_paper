#analysis and plotting of rosetta scan for binding and stability

### CONTENTS ###

lir_atg8 -> includes the output file for binding scans (i.e. on lc3b-lir complexes)
fonts -> fonts to use for plotting purpouses 
python_environment -> environment to activate before running the scripts
scripts -> scripts for analyses


### STEP BY STEP ###

cd lir_atg8/lc3b/lir_complexes/

#for each lir_complexes subfolder run the python script for analysis and follow the readmes

#come back to the main folder

#source local environment
 
source python_environment/bin/activate


cd lir_atg8/lc3b/free/analysis_steps

python3.7 run_ddg_stability_analysis.py

cd lir_atg8/lc3b/lir_complexes/analysis_steps

python3.7 run_ddg_binding_analysis.py

