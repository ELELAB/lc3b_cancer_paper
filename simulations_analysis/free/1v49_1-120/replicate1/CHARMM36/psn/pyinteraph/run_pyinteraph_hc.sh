#!/bin/bash
. /usr/local/gromacs-5.1.5/bin/GMXRC.bash

. /usr/local/envs/pyinteraph/bin/activate

export PYINTERAPH=/usr/local/envs/pyinteraph/pyinteraph/
export PATH=$PATH:$PYINTERAPH

traj=center_traj.xtc
gro=confout_filtered.gro
pdb=frame0.pdb
dat=hc-graph.dat
datfilt=hc-graph_filt.dat


#cd hc_cluster/5.5/
#pyinteraph -s ../../$gro -t ../../../../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/CHARMM36/md/Mol_An/$traj -f --hc-graph $dat --ff-masses charmm27  --hc-co 5.5 --hc-residues ALA,ILE,LEU,VAL,PHE,TRP,MET,PRO > hc_cluster_5.5_c36.log  
#
##filtering 
#filter_graph -d $dat -o $datfilt -t 20.0 > hc_cluster_5.5_filter_c36.log
##calculating hubs
#graph_analysis -a $datfilt -r ../../../../frames/$pdb -u -ub hubs_c36_hc_cluster5.5.pdb -k 3 > c36_hc_cluster_5.5_hubs.log
##calculate_connected components
#graph_analysis -a $datfilt -r ../../../../frames/$pdb -c -cb con_comp_c36_hc_cluster5.5.pdb > c36_hc_cluster_5.5_cc.log



cd hc_cluster/5.25/
pyinteraph -s ../../$gro -t ../../../../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/CHARMM36/md/Mol_An/$traj -f --hc-graph $dat --ff-masses charmm27  --hc-co 5.25 --hc-residues ALA,ILE,LEU,VAL,PHE,TRP,MET,PRO > hc_cluster_5.25_c36.log  

#filtering 
filter_graph -d $dat -o $datfilt -t 20.0 > hc_cluster_5.25_filter_c36.log
#calculating hubs
graph_analysis -a $datfilt -r ../../../../frames/$pdb -u -ub hubs_c36_hc_cluster5.25.pdb -k 3 > c36_hc_cluster_5.25_hubs.log
#calculate_connected components
graph_analysis -a $datfilt -r ../../../../frames/$pdb -c -cb con_comp_c36_hc_cluster5.25.pdb > c36_hc_cluster_5.25_cc.log



cd ../../hc_cluster/5.125/
pyinteraph -s ../../$gro -t ../../../../../../../../../../simulations/lc3b/free/1v49_1-120/replicate1/CHARMM36/md/Mol_An/$traj -f --hc-graph $dat --ff-masses charmm27  --hc-co 5.125 --hc-residues ALA,ILE,LEU,VAL,PHE,TRP,MET,PRO > hc_cluster_5.125_c36.log  

#filtering 
filter_graph -d $dat -o $datfilt -t 20.0 > hc_cluster_5.125_filter_c36.log
#calculating hubs
graph_analysis -a $datfilt -r ../../../../frames/$pdb -u -ub hubs_c36_hc_cluster5.125.pdb -k 3 > c36_hc_cluster_5.125_hubs.log
#calculate_connected components
graph_analysis -a $datfilt -r ../../../../frames/$pdb -c -cb con_comp_c36_hc_cluster5.125.pdb > c36_hc_cluster_5.125_cc.log

