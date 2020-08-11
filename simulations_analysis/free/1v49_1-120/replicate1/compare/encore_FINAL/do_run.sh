. /usr/local/gromacs-5.1.5/bin/GMXRC

labels=$(python -c 'import md; print(" ".join(md.labels), end="")')

# generate filtered and merged trajetory
python merge_trajs.py

# calculate RMSD matrix on merged trajectory
echo -e "0\n0" | gmx rms -s topology.pdb -f merged.xtc -m -bin -fitall

# calulate similarity measures
python do_comparison.py

# calculate 2D projection from ensemble similarities
Rscript do_tpe.R ces.dat
Rscript do_tpe.R dres.dat
