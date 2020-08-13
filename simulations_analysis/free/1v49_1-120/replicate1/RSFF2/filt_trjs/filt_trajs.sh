xtc=center_traj
tpr=md_prot
#xtc filtered with no Cterm and Nterm - for all atoms
gmx trjconv -f ../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/RSFF2/md/Mol_An/$xtc.xtc -s ../filt_tprs/$tpr.tpr -n ../index_files/AAnoCNter.ndx -o AAnoCNter.xtc << eof
1
eof
#xtc filtered with no Cterm and Nterm - for calpha
gmx trjconv -f ../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/RSFF2/md/Mol_An/$xtc.xtc -s ../filt_tprs/$tpr.tpr -n ../index_files/noCNter.ndx -o noCNter.xtc << eof
1
eof
#xtc filtered the calpha atom 
gmx trjconv -f ../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/RSFF2/md/Mol_An/$xtc.xtc -s ../filt_tprs/$tpr.tpr -n ../index_files/ca.ndx -o ca.xtc
