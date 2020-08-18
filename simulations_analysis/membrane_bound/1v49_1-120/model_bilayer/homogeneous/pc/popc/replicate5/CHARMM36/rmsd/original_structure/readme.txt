We calculated the backbone rmsd relative to the starting structure
gmx_mpi make_ndx -f 1ugm.pdb -o index_1ugm.ndx <<eof
q
eof
gmx_mpi rms -s 1ugm.pdb -f /data/user/shared_projects/simulations_data/lir_atg8/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate5/CHARMM36/md/Mol_An/center_traj.xtc -o rmsd_1ugm.xvg -n index_1ugm.ndx <<eof
4
4
eof

gmx_mpi make_ndx -f 1V49.pdb -o index_1V49.ndx <<eof
ri 5-120
10 & 4
q
eof
gmx_mpi rms -s 1V49.pdb -f /data/user/shared_projects/simulations_data/lir_atg8/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate5/CHARMM36/md/Mol_An/center_traj.xtc -o rmsd_1V49.xvg -n index_1V49.ndx <<eof
11
11
eof


