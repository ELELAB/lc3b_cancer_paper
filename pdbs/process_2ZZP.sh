#!/bin/bash

in_pdb=2ZZP.pdb
out_pdb=2ZZP_processed.pdb

python remove_heteroatoms.py -i $in_pdb -o $out_pdb
