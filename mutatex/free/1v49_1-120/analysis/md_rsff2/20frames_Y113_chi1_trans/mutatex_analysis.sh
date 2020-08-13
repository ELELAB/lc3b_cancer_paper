cp ../20frames_Y113_chi1_plus/gather_data .
cp ../20frames_Y113_chi1_plus/ddg* .
cp ../20frames_Y113_chi1_plus/mutatex_analysis.sh .


# symbolic linkk for mutation list 
 ln -s ../../../../../free/1v49_1-120/md_rsff2/replicate1/20frames_Y113_chi1_trans/mutation_list.txt 


#symbolic link for mutation ddgs

ln -s ../../../../../free/1v49_1-120/md_rsff2/replicate1/20frames_Y113_chi1_trans/results/mutation_ddgs/final_averages/ 


#symbolic link for repaired pdb
ln -s ../../../../../free/1v49_1-120/md_rsff2/replicate1/20frames_Y113_chi1_trans/repair/repair_chi1trans2A_model0_checked/chi1trans2A_model0_checked_Repair.pdb 




# to generate the excel file

./ddg2xlsx -p chi1trans2A_model0_checked_Repair.pdb -d final_averages/ -l mutation_list.txt


#to generate the Desnity plot of mutational ddgs

./ddg2density -p chi1trans2A_model0_checked_Repair.pdb -d final_averages/ -l mutation_list.txt

# to generate the heatmap of ddg changes after mutation scanining
./ddg2matrix -p chi1trans2A_model0_checked_Repair.pdb -d final_averages/ -l mutation_list.txt -x 8 -c Spectral -s 40 -f 8

 
 #summary of mutations in LC3B
./gather_data -p chi1trans2A_model0_checked_Repair.pdb -d final_averages/ -L lc3b_mutations_1-120.txt -l mutation_list.txt 
                                                                                                                   
