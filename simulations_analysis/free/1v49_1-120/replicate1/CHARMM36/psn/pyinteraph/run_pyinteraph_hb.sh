#!/bin/bash
. /usr/local/gromacs-5.1.5/bin/GMXRC.bash

. /usr/local/envs/pyinteraph/bin/activate

export PYINTERAPH=/usr/local/envs/pyinteraph/pyinteraph/
export PATH=$PATH:$PYINTERAPH


traj=center_traj.xtc
gro=confout_filtered.gro
pdb=frame0.pdb
dat=hb-graph.dat
datfilt=hb-graph_filt.dat


#hydrogen bond network 
cd hb/all/
pyinteraph -s ../../../../frames/$pdb -t ../../../../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/CHARMM36/md/Mol_An/$traj -r ../../../../frames/$pdb -y --hb-graph hb-graph.dat --ff-masses charmm27  --hb-dat hb-dat --hb-class all > hb_all_c36.log 
#filtering 
filter_graph -d $dat -o $datfilt -t 20.0 > hb_all_filter_c36.log
#calculating hubs
graph_analysis -a $datfilt -r ../../../../frames/$pdb -u -ub hubs_c36_hb_all.pdb -k 3 > c36_hb_all_hubs.log 
#calculate_connected components
graph_analysis -a $datfilt -r ../../../../frames/$pdb -c -cb con_comp_c36_hb_all.pdb > c36_hb_all_cc.log

cd ../../hb/sc/
pyinteraph -s ../../../../frames/$pdb -t ../../../../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/CHARMM36/md/Mol_An/$traj -r ../../../../frames/$pdb -y --hb-graph hb-graph.dat --ff-masses charmm27  --hb-dat hb-dat --hb-class sc-sc > hb_sc_c36.log 

#filtering 
filter_graph -d $dat -o $datfilt -t 20.0 > hb_sc_filter_c36.log
#calculating hubs
graph_analysis -a $datfilt -r ../../../../frames/$pdb -u -ub hubs_c36_hb_sc.pdb -k 3 > c36_hb_sc_hubs.log
#calculate_connected components
graph_analysis -a $datfilt -r ../../../../frames/$pdb -c -cb con_comp_c36_hb_sc.pdb > c36_hb_sc_cc.log

