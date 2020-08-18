#!/bin/bash
. /usr/local/gromacs-5.1.5/bin/GMXRC.bash

. /usr/local/envs/pyinteraph/bin/activate

export PYINTERAPH=/usr/local/envs/pyinteraph/pyinteraph/
export PATH=$PATH:$PYINTERAPH

traj=center_traj.xtc
gro=confout_filtered.gro
pdb=frame0.pdb
dat=sb-graph.dat
datfilt=sb-graph_filt.dat


#hydrogen bond network 
cd sb/
pyinteraph -s ../../../frames/$pdb -t ../../../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/CHARMM36/md/Mol_An/$traj -r ../../../frames/$pdb --sb-co 4.5 -b --sb-graph sb-graph.dat --ff-masses charmm27 -v --sb-cg-file charged_groups.ini > sb_c36.log

#filtering 
filter_graph -d $dat -o $datfilt -t 20.0 > sb_filter_c36.log
#calculating hubs
graph_analysis -a $datfilt -r ../../../frames/$pdb -u -ub hubs_c36_sb.pdb -k 3 > c36_sb_hubs.log
#calculate_connected components
graph_analysis -a $datfilt -r ../../../frames/$pdb -c -cb con_comp_c36_sb.pdb > c36_sb_cc.log
#
