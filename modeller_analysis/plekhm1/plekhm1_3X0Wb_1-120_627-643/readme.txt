#ATG8-LIR MODELS SELECTION

This protocol is meant to evaluate and rank the models obtained using MODELLER of a LC3-LIR complex. 
This is done by analysing properties on each model using GROMACS tools. The outcome of the analysis is then processed by a R script
to evaluate: 
1) which models can be considered valid 
2) rank them according to the radius of gyration (Rg), so that we can easily select the models with
highest and lowest Rgs. 
We consider a model valid if the solvent
accessible surface of the LIR HP1 and HP2 residues is lower than the maximum identified in a set of experimental structure (0.75 nm**2 for HP1 and 0.5 nm**2 for HP2)


#REQUIREMENTS

GROMACS >=5.0
theseus
R, with the Peptides package installed

#HOW TO

The calculation is handled by the do_ranking.sh script (check to see if something need to be changed)

Also the script rank_models_nodih.R Rscript is needed in the folder
Create a symbolic link to the models folder from modeller
    
1. The script will use theseus to merge the models in a multi-pdb file
2. Then make_ndx is used to create the index file for the Rg calculation
3. g_gyrate is used to calculate Rg
4. g_sasa to calculate the solvent accessibility of HP1 and HP2 residues
5. the R script to do the ranking 

outputs:

two csv files with one line per model and the associated values of Rg and SASA
it also contains one 'isok' column that says whether the HP1 and HP2 SASA values
are withing the expected range, as specified by the command line.

ranked_models.csv  -> all the models 
ranked_filtered_models.cvs  -> only the ones selected as acceptable

