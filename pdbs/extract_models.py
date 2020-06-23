#!/usr/bin/python
# -*- coding: utf-8 -*-

import argparse
from Bio.PDB import PDBParser, PDBIO, Select

class ModelInRangeSelect(Select):
    def __init__(self, start, end):
        self.start = start
        self.end = end
    def accept_model(self, model):
        # using serial numbers instead of ids because
        # models are numbered from 1 but ids start from 0
        if model.serial_num < self.start or model.serial_num > self.end:
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
argparser.add_argument("--start", \
                       dest = "start", \
                       type = int, \
                       help = "First model to keep")
argparser.add_argument("--end", \
                       dest = "end", \
                       type = int, \
                       help = "Last model to keep")
    

# Get the arguments
args = argparser.parse_args()
in_pdb_file = args.in_pdb_file
out_pdb_file = args.out_pdb_file
start = args.start
end = args.end
# Create a PDB parser
parser = PDBParser()
# Parse the structure
name = in_pdb_file.replace(".pdb", "")
structure = parser.get_structure(name, in_pdb_file)
# Save the processed structure
w = PDBIO()
w.set_structure(structure)
w.save(out_pdb_file, ModelInRangeSelect(start = start, end = end))
