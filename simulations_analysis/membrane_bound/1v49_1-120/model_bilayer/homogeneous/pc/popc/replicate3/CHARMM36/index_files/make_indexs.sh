tpr=md
#create the protein ndx file
gmx make_ndx -f ../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/$tpr.tpr -o protein.ndx << eof
keep 1 
q
eof
#create the no Cterm and Nterm index file for all atoms
gmx make_ndx -f ../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/$tpr.tpr -n protein.ndx -o AAnoCNter.ndx << eof
r 7-116
q
eof
#create the no Cterm and Nterm index file - for calpha only
gmx make_ndx -f ../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/$tpr.tpr -n protein.ndx -o noCNter.ndx << eof
a CA & r 7-116
q
eof
#create the calpha atom index file
gmx make_ndx -f ../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/$tpr.tpr -o ca.ndx << eof
keep 3
q
eof
