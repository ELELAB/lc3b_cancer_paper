#!/bin/bash
. /usr/local/gromacs-5.1.5/bin/GMXRC.bash


gmx anaeig -f ../../conc_trjs/lc3b_free_combined_a99sbdisp_noCNter.xtc -b 1 -e 100000 -skip 50 -v ../eigenvec.trr -eig ../eigenval.xvg -s ../average.pdb -extr extreme_noCNter_charmm22st_.pdb -first 1 -last 2  -nframes 50 

gmx anaeig -f ../../conc_trjs/lc3b_free_combined_a99sbdisp_noCNter.xtc -b 100001 -e 200000 -skip 50 -v ../eigenvec.trr -eig ../eigenval.xvg -s ../average.pdb -extr extreme_noCNter_charmm27_.pdb -first 1 -last 2 -nframes 50 

gmx anaeig -f ../../conc_trjs/lc3b_free_combined_a99sbdisp_noCNter.xtc -b 200001 -e 300000 -skip 50 -v ../eigenvec.trr -eig ../eigenval.xvg -s ../average.pdb -extr extreme_noCNter_charmm36_.pdb -first 1 -last 2 -nframes 50


gmx anaeig -f ../../conc_trjs/lc3b_free_combined_a99sbdisp_noCNter.xtc -b 300001 -e 400000 -skip 50 -v ../eigenvec.trr -eig ../eigenval.xvg -s ../average.pdb -extr extreme_noCNter_amber99star-ildn-q_.pdb -first 1 -last 2 -nframes 50

gmx anaeig -f ../../conc_trjs/lc3b_free_combined_a99sbdisp_noCNter.xtc -b 400001 -e 500000 -skip 50 -v ../eigenvec.trr -eig ../eigenval.xvg -s ../average.pdb -extr extreme_noCNter_amber99star-nmr_.pdb -first 1 -last 2 -nframes 50 

gmx anaeig -f ../../conc_trjs/lc3b_free_combined_a99sbdisp_noCNter.xtc -b 500001 -e 600000 -skip 50 -v ../eigenvec.trr -eig ../eigenval.xvg -s ../average.pdb -extr extreme_noCNter_a14_.pdb -first 1 -last 2 -nframes 50 

gmx anaeig -f ../../conc_trjs/lc3b_free_combined_a99sbdisp_noCNter.xtc -b 600001 -e 700000 -skip 50 -v ../eigenvec.trr -eig ../eigenval.xvg -s ../average.pdb -extr extreme_noCNter_rsff1_.pdb -first 1 -last 2 -nframes 50 

gmx anaeig -f ../../conc_trjs/lc3b_free_combined_a99sbdisp_noCNter.xtc -b 700001 -e 800000 -skip 50 -v ../eigenvec.trr -eig ../eigenval.xvg -s ../average.pdb -extr extreme_noCNter_rsff2_.pdb -first 1 -last 2 -nframes 50

gmx anaeig -f ../../conc_trjs/lc3b_free_combined_a99sbdisp_noCNter.xtc -b 800001 -e 900000 -skip 50 -v ../eigenvec.trr -eig ../eigenval.xvg -s ../average.pdb -extr extreme_noCNter_amber99sb-disp_.pdb -first 1 -last 2 -nframes 50 


