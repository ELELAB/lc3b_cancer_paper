# coding: utf-8
import MDAnalysis as mda
import sys
import numpy as np
import sys
u = mda.Universe(sys.argv[1], sys.argv[1])
sel = u.select_atoms("segid %s and resnum %s"% (sys.argv[2], sys.argv[3]))
assert(len(sel.residues) == 1)
sys.stdout.write("%s%d" % (sel.residues[0].resname, sel.residues[0].resindex+1))


