We calculated the backbone rmsd relative to the starting structure
gmx_mpi make_ndx -f 1V49.pdb -o index.ndx
gmx_mpi rms -s ../../../../../../../../../../../../pdbs/1V49.pdb -f /data/user/shared_projects/simulations_data/lir_atg8/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate2/CHARMM36/md/Mol_An/center_traj.xtc -o rmsd.xvg -n index.ndx
