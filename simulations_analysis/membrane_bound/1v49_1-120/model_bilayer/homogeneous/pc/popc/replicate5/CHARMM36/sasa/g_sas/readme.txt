#We here calculated the accessibility of residues in HP1 and HP2 of LC3B and missense mutation sites identified from cancer genomic studies and evaluate the masking effects of the membrane on them
#To perform the analysis execute the bash script mutaz_hp1hp2_sites_sasa.sh and mutaz_hp1hp2_sites_sasa.nomemb.sh
#In the script there are informations about the steps of the calculation performed using the g_sas tool of GROMACS 
#the output are located in the folder with_membrane for the simulations containing the membrane (g_sas calculation performed considering all the protein and lipid atoms) 
#and in the folder without_membrane for the same simulations as before but here we filtered out the membrane before performing the calculation as a control (g_sas calculation performed considering only all the protein atoms).
#the accessibility values for each selected residues are in the file area.xvg
#after removing the header of the area.xvg the data have be plotted using the R script located in the compare folder in
#/data/user/shared_projects/lc3b_md_paper/simulations_analysis/lc3b/compare/sasa/g_sas/ 
