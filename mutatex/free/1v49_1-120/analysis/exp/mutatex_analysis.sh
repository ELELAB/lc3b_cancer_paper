cp ../../../lir_complexes/analyses/plekhm1/maxg_model_25/ddg* .

cp ../../../lir_complexes/analyses/plekhm1/maxg_model_25/*.sh .

# symbolic linkk for mutation list 

ln -s ../../exp/mutation_list.txt 

#symbolic link for mutation ddgs

ln -s ../../exp/results/mutation_ddgs/final_averages/

#symbolic link for repaired pdb

ln -s ../../exp/repair/repair_1V49_model0_checked/1V49_model0_checked_Repair.pdb 
# to generate the excel file
./ddg2xlsx -p 1V49_model0_checked_Repair.pdb -d final_averages/ -l mutation_list.txt

#to generate the Desnity plot of mutational ddgs
./ddg2density -p 1V49_model0_checked_Repair.pdb -d final_averages/ -l mutation_list.txt 

# to generate the heatmap of ddg changes after mutation scanining
./ddg2matrix -p 1V49_model0_checked_Repair.pdb -d final_averages -l mutation_list.txt -x 8 -c Spectral -s 40 -f 8


#to get the summary of mutations in LC3B
./gather_data -p 1V49_model0_checked_Repair.pdb -d final_averages/ -L lc3b_mutations_1-120.txt -l mutation_list.txt


                                                                                                                    
