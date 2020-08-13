cp ../../../../free/3vtu_2-119/analysis/exp_noHOH/ddg* .
cp ../../../../free/3vtu_2-119/analysis/exp_noHOH/mutatex_analysis.sh .
cp ../../../../free/3vtu_2-119/analysis/exp_noHOH/gather_data .
cp ../../../../free/3vtu_2-119/analysis/exp_noHOH/lc3b_mutations_1-120.txt .
# symbolic linkk for mutation list 

ln -s ../../../../free/1v49_1-120/md_charmm22star/replicate1/movie_dt50000/mutation_list.txt 

#symbolic link for mutation ddgs
ln -s ../../../../free/1v49_1-120/md_charmm22star/replicate1/movie_dt50000/results/mutation_ddgs/final_averages/

#symbolic link for repaired pdb

ln -s ../../../../free/1v49_1-120/md_charmm22star/replicate1/movie_dt50000/repair/repair_moviedt50000A_model0_checked/moviedt50000A_model0_checked_Repair.pdb 

# to generate the excel file
 ./ddg2xlsx -p moviedt50000A_model0_checked_Repair.pdb -d final_averages/ -l mutation_list.txt

 #to generate the Desnity plot of mutational ddgs
./ddg2density -p moviedt50000A_model0_checked_Repair.pdb -d final_averages/ -l mutation_list.txt

# to generate the heatmap of ddg changes after mutation scanining
 ./ddg2matrix -p moviedt50000A_model0_checked_Repair.pdb -d final_averages/ -l mutation_list.txt -x 8 -c Spectral -s 40 -f 8


#summary of mutations in LC3B

./gather_data -p moviedt50000A_model0_checked_Repair.pdb -d final_averages/ -L lc3b_mutations_1-120.txt -l mutation_list.txt 


                                                                                                                    
