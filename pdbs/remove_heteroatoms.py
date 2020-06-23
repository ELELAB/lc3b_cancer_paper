#!/usr/bin/python
# -*- coding: utf-8 -*-

import argparse
from Bio.PDB import PDBParser, PDBIO, Select

class NotHetResSelect(Select):
    def accept_residue(self, residue):
        if residue.id[0] != " ":
            return 0
        return 1

argparser = argparse.ArgumentParser()
argparser.add_argument("-i", \
                       dest = "in_pdb_file", \
                       type = str, \
                       help = "Input PDB file")
argparser.add_argument("-o", \
                       dest = "out_pdb_file", \
                       type = str, \
                       help = "Output PDB file")

# Get the arguments
args = argparser.parse_args()
in_pdb_file = args.in_pdb_file
out_pdb_file = args.out_pdb_file
# Create a PDB parser
parser = PDBParser()
# Parse the structure
name = in_pdb_file.replace(".pdb", "")
structure = parser.get_structure(name, in_pdb_file)
# Save the processed structure
w = PDBIO()
w.set_structure(structure)
w.save(out_pdb_file, NotHetResSelect())
