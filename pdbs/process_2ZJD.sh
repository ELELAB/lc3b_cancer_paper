#!/bin/bash

in_pdb=2ZJD.pdb
out_pdb=2ZJD_CD_processed.pdb

python remove_heteroatoms.py -i $in_pdb -o tmp1.pdb
python remove_residues.py -i tmp1.pdb -o tmp2.pdb --chain A --start 2 --end 275
python remove_residues.py -i tmp2.pdb -o tmp3.pdb --chain B --start 335 --end 350
python remove_residues.py -i tmp3.pdb -o tmp4.pdb --chain C --start 126 --end 250
python remove_residues.py -i tmp4.pdb -o $out_pdb --chain D --start 345 --end 346

rm tmp1.pdb tmp2.pdb tmp3.pdb tmp4.pdb
