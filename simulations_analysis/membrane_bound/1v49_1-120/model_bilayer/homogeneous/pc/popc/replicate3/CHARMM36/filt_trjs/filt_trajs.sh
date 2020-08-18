xtc=center_traj
tpr=md_prot
#xtc filtered with no Cterm and Nterm - for all atoms
gmx trjconv -f ../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/Mol_An/$xtc.xtc -s ../filt_tprs/$tpr.tpr -n ../index_files/AAnoCNter.ndx -o AAnoCNter.xtc << eof
1
eof
#xtc filtered with no Cterm and Nterm - for calpha
gmx trjconv -f .../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/Mol_An/$xtc.xtc -s ../filt_tprs/$tpr.tpr -n ../index_files/noCNter.ndx -o noCNter.xtc << eof
1
eof
#xtc filtered the calpha atom 
gmx trjconv -f ../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/Mol_An/$xtc.xtc -s ../filt_tprs/$tpr.tpr -n ../index_files/ca.ndx -o ca.xtc
#xtc filtered the protein atoms
gmx trjconv -f ../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/Mol_An/$xtc.xtc -s ../filt_tprs/$tpr.tpr -n ../index_files/protein.ndx -o protein.xtc
