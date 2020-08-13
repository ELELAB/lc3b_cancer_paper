cp ../../../1v49_1-120/analysis/exp/ddg* .
cp ../../../1v49_1-120/analysis/exp/*.sh .
# symbolic linkk for mutation list 

ln -s ../../exp_noHOH/mutation_list.txt 

#symbolic link for mutation ddgs

ln -s ../../exp_noHOH/results/mutation_ddgs/final_averages/

#symbolic link for repaired pdb

ln -s ../../exp_noHOH/repair/repair_3VTUp_model0_checked/3VTUp_model0_checked_Repair.pdb 

# to generate the excel file

 ./ddg2xlsx -p 3VTUp_model0_checked_Repair.pdb -d final_averages/ -l mutation_list.txt
#to generate the Desnity plot of mutational ddgs

 ./ddg2density -p 3VTUp_model0_checked_Repair.pdb -d final_averages/ -l mutation_list.txt
# to generate the heatmap of ddg changes after mutation scanining
./ddg2matrix -p 3VTUp_model0_checked_Repair.pdb -d final_averages/ -l mutation_list.txt -x 8 -c Spectral -s 40 -f 8

#summary of mutations in LC3B

 ./gather_data -p 3VTUp_model0_checked_Repair.pdb -d final_averages/ -L lc3b_mutations_1-120.txt -l mutation_list.txt


                                                                                                                    
