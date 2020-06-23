#!/usr/bin/python
# -*- coding: utf-8 -*-

import argparse
from Bio.PDB import PDBParser, PDBIO, Select

argparser = argparse.ArgumentParser()
argparser.add_argument("-i", \
                       dest = "in_pdb_file", \
                       type = str, \
                       help = "Input PDB file")
argparser.add_argument("-o", \
                       dest = "out_pdb_file", \
                       type = str, \
                       help = "Output PDB file")
argparser.add_argument("--chain", \
                       dest = "chain", \
                       type = str, \
                       help = "Chain to be renumbered")
argparser.add_argument("--new-start", \
                       dest = "new_start", \
                       type = int, \
                       help = "New starting number")

# Get the arguments
args = argparser.parse_args()
in_pdb_file = args.in_pdb_file
out_pdb_file = args.out_pdb_file
chain = args.chain
new_start = args.new_start
# Create a PDB parser
parser = PDBParser()
# Parse the structure
name = in_pdb_file.replace(".pdb", "")
structure = parser.get_structure(name, in_pdb_file)
# Renumber the chain (for all models)
for mod in structure:
    for ch in mod:
        if ch.id == chain:
            i = new_start
            for res in ch:
                resid = res.id
                res.id = (resid[0], i, resid[2])
                i += 1
# Save the processed structure
w = PDBIO()
w.set_structure(structure)
w.save(out_pdb_file)
