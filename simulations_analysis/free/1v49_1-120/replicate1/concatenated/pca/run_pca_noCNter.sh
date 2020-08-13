#!/bin/bash
. /usr/local/gromacs-5.1.5/bin/GMXRC.bash


# select group 3
gmx covar -f ../conc_trjs/lc3b_free_combined_a99sbdisp_noCNter.xtc -s ../../CHARMM22star/filt_tprs/noCNter.tpr <<eof
3
3
eof

# select group 3
gmx anaeig -s average.pdb -f ../conc_trjs/lc3b_free_combined_a99sbdisp_noCNter.xtc -2d -first 1 -last 2 <<eof
3
3
eof 

# select group 3
gmx anaeig -f ../conc_trjs/lc3b_free_combined_a99sbdisp_noCNter.xtc -v eigenvec.trr -eig eigenval.xvg -s ../../CHARMM22star/filt_tprs/noCNter.tpr -extr average.pdb -first 1 -last 2 <<eof
3
3
eof

gmx anaeig -v eigenvec.trr -eig eigenval.xvg -s average.pdb -first 1 -last 3 -rmsf rmsf_ev1_3_alltraj.xvg <<eof
3
eof

