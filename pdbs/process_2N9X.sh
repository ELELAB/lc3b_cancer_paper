#!/bin/bash

in_pdb=2N9X.pdb
out_pdb=2N9X_processed.pdb

python extract_models.py -i $in_pdb -o $out_pdb --start 1 --end 1
