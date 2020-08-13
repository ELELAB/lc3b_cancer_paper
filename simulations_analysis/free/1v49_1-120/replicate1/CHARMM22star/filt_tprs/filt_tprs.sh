tpr=md
#tpr filtered on  protein
gmx convert-tpr -s ../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/CHARMM22star/md/$tpr.tpr -n ../index_files/protein.ndx -o md_prot.tpr
#tpr filtered  with no Cterm and Nterm all atoms
gmx convert-tpr -s ../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/CHARMM22star/md/$tpr.tpr -n ../index_files/AAnoCNter.ndx -o AAnoCNter.tpr << eof
1
eof
#tpr filtered with no Cterm and Nterm - for calpha only
gmx convert-tpr -s ../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/CHARMM22star/md/$tpr.tpr -n ../index_files/noCNter.ndx -o noCNter.tpr << eof
1
eof
#tpr filtered the calpha atom 
gmx convert-tpr -s ../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/CHARMM22star/md/$tpr.tpr -n ../index_files/ca.ndx -o  md_ca.tpr
