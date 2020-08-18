#!/bin/bash
. /usr/local/gromacs-5.1.5/bin/GMXRC.bash

. /usr/local/envs/pyinteraph/bin/activate

export PYINTERAPH=/usr/local/envs/pyinteraph/pyinteraph/
export PATH=$PATH:$PYINTERAPH

traj=center_traj.xtc
gro=confout_filtered.gro
pdb=frame0.pdb
#dat=hb-graph.dat
datfilt=hb-graph_filt.dat

#Declare a string array consisting of LIR binding residues
RES1='SYSTEM-10ARG SYSTEM-11ARG SYSTEM-49LYS SYSTEM-51LYS SYSTEM-53LEU SYSTEM-57HIS SYSTEM-70ARG'

for i in $RES1;do
RES=${i:7:9}

echo "$RES"


cd hb/all
mkdir -p paths/$RES-3SER/allpath
cd paths/$RES-3SER/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-3SER -l 10 -p -d > path.log

mkdir -p ../../$RES-16ARG/allpath
cd ../../$RES-16ARG/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-16ARG -l 10 -p -d > path.log

mkdir -p ../../$RES-19ASP/allpath
cd ../../$RES-19ASP/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-19ASP -l 10 -p -d > path.log

mkdir -p ../../$RES-21ARG/allpath
cd ../../$RES-21ARG/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-21ARG -l 10 -p -d > path.log

mkdir -p ../../$RES-28PRO/allpath
cd ../../$RES-28PRO/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-28PRO -l 10 -p -d > path.log

mkdir -p ../../$RES-29THR/allpath
cd ../../$RES-29THR/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-29THR -l 10 -p -d > path.log

mkdir -p ../../$RES-32PRO/allpath
cd ../../$RES-32PRO/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-32PRO -l 10 -p -d > path.log

mkdir -p ../../$RES-35ILE/allpath
cd ../../$RES-35ILE/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-35ILE -l 10 -p -d > path.log

mkdir -p ../../$RES-37ARG/allpath
cd ../../$RES-37ARG/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-37ARG -l 10 -p -d > path.log

mkdir -p ../../$RES-38TYR/allpath
cd ../../$RES-38TYR/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-38TYR -l 10 -p -d > path.log

mkdir -p ../../$RES-39LYS/allpath
cd ../../$RES-39LYS/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-39LYS -l 10 -p -d > path.log

mkdir -p ../../$RES-49LYS/allpath
cd ../../$RES-49LYS/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-49LYS -l 10 -p -d > path.log

mkdir -p ../../$RES-56ASP/allpath
cd ../../$RES-56ASP/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-56ASP -l 10 -p -d > path.log

mkdir -p ../../$RES-60MET/allpath
cd ../../$RES-60MET/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-60MET -l 10 -p -d > path.log

mkdir -p ../../$RES-65LYS/allpath
cd ../../$RES-65LYS/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-65LYS -l 10 -p -d > path.log

mkdir -p ../../$RES-70ARG/allpath
cd ../../$RES-70ARG/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-70ARG -l 10 -p -d > path.log

mkdir -p ../../$RES-82LEU/allpath
cd ../../$RES-82LEU/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-82LEU -l 10 -p -d > path.log

mkdir -p ../../$RES-89VAL/allpath
cd ../../$RES-89VAL/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-89VAL -l 10 -p -d > path.log

mkdir -p ../../$RES-91VAL/allpath
cd ../../$RES-91VAL/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-91VAL -l 10 -p -d > path.log

mkdir -p ../../$RES-98VAL/allpath
cd ../../$RES-98VAL/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-98VAL -l 10 -p -d > path.log

mkdir -p ../../$RES-113TYR/allpath
cd ../../$RES-113TYR/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-113TYR -l 10 -p -d > path.log

mkdir -p ../../$RES-120GLY/allpath
cd ../../$RES-120GLY/allpath
graph_analysis -a ../../../$datfilt -r ../../../../../../../frames/$pdb -r1 $i -r2 SYSTEM-120GLY -l 10 -p -d > path.log

cd ../../../../../

done


