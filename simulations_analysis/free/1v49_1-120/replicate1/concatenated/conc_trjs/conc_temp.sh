#!/bin/bash
. /usr/local/gromacs-5.1.5/bin/GMXRC.bash

xtc=ca
xtc2=noCNter

#xtc filtered removing C and N term - CA atoms (-2 force field)
#gmx trjcat -f ../../CHARMM27/filt_trjs/$xtc2.xtc ../../CHARMM36/filt_trjs/$xtc2.xtc ../../ff99SBstar-ILDN-Q/filt_trjs/$xtc2.xtc ../../ff99SBnmr1/filt_trjs/$xtc2.xtc ../../ff14SB/filt_trjs/$xtc2.xtc ../../RSFF1/filt_trjs/$xtc2.xtc ../../RSFF2/filt_trjs/$xtc2.xtc ../../a99SB-disp/filt_trjs/$xtc2.xtc -o lc3b_free_combined_a99sbdisp_noCNter_noc22st_a99stildn.xtc -settime <<eof

#xtc filtered removing C and N term - CA atoms (-4 force field)
gmx trjcat -f ../../CHARMM27/filt_trjs/$xtc2.xtc ../../CHARMM36/filt_trjs/$xtc2.xtc ../../ff99SBstar-ILDN-Q/filt_trjs/$xtc2.xtc ../../ff99SBnmr1/filt_trjs/$xtc2.xtc ../../RSFF1/filt_trjs/$xtc2.xtc ../../a99SB-disp/filt_trjs/$xtc2.xtc -o lc3b_free_combined_a99sbdisp_noCNter_no6FF.xtc -settime <<eof
0
1000000
2000000
3000000
4000000
5000000
6000000
eof


