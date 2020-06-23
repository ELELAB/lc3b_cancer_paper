#!/bin/bash

in_pdb=2LUE.pdb
out_pdb=2LUE_processed.pdb

python extract_models.py -i $in_pdb -o $out_pdb --start 1 --end 1
