#!/bin/bash
#bash script for the analysis of the solvent accessible surface area of mutation sites and residues in the HP1 and HP2 pocket of LC3B keeping in consideration or not the presence of the membrane i.e. calculating the masking effects of the membrane  
#always remember to have the right residuetypes.dat file in the local folder
#define the name of the reference xtc and tpr file
residuetypes=../../../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/prot_memb/residuetypes.dat
xtc_memb=../../../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/prot_memb/center_traj_prot_memb.xtc
tpr_memb=../../../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/prot_memb/md_prot_memb.tpr
gro_prot=../../../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/Mol_An/update.gro
xtc_prot=../../../../../../../../../../../../../simulations/lc3b/membrane_bound/1v49_1-120/model_bilayer/homogeneous/pc/popc/replicate3/CHARMM36/md/Mol_An/center_traj.xtc
# To do the calculation we use a for cycle and the gromacs tool gmx sasa
# Mutation sites residues resnr S3,R16,D19,R21,P28,T29,P32,I35,R37,Y38,K39,K49,D56,M60,K65,R70,L82,V89,V91,V98,Y113,G120 
# HP1 residues resnr D19,I23,P32,I34,K51,L53,F108
# HP2 residues resnr F52,V54,P55,L63,I66,I67
# LDK residues resnr L47,D48,K49
# Ub patch residues resnr L8,I44,V70
# for the G120 we considered atoms name N HN CA HA1 HA2 C
mkdir with_membrane
cd with_membrane
cp $residuetypes .
gmx_mpi sasa -f $xtc_memb -s $tpr_memb -surface -output  -or -o  <<eof
0
resnr 3
resnr 16
resnr 19
resnr 21
resnr 28
resnr 29
resnr 32
resnr 35
resnr 37
resnr 38
resnr 39
resnr 49
resnr 56
resnr 60
resnr 65
resnr 70
resnr 82
resnr 89
resnr 91
resnr 98
resnr 113
resnr 120 and name N HN CA HA1 HA2 C
resnr 19
resnr 23
resnr 32
resnr 34
resnr 51
resnr 53
resnr 108
resnr 52
resnr 54
resnr 55
resnr 63
resnr 66
resnr 67 
resnr 47
resnr 48
resnr 49
resnr 8
resnr 44
resnr 70
eof


