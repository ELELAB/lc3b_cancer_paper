#!/bin/bash

in_pdb=3VTU.pdb
out_pdb=3VTU_processed.pdb

python remove_heteroatoms.py -i $in_pdb -o tmp1.pdb
python remove_residues.py -i tmp1.pdb -o tmp2.pdb --chain A --start 2 --end 5
python renumber_chain.py -i tmp2.pdb -o $out_pdb --chain A --new-start 2

rm tmp1.pdb tmp2.pdb 
