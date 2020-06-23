#!/usr/bin/python
# -*- coding: utf-8 -*-

import argparse
from Bio.PDB import PDBParser, PDBIO, Select

class NotInRangeResSelect(Select):
    def __init__(self, chain, start, end):
        self.chain = chain
        self.start = start
        self.end = end
    def accept_residue(self, residue):
        resstruc, resmod, reschain, resid = residue.get_full_id()
        if reschain == self.chain \
        and (resid[1] >= self.start and resid[1] <= self.end):
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
argparser.add_argument("--chain", \
                       dest = "chain", \
                       type = str, \
                       help = "Chain from which residues should be removed")
argparser.add_argument("--start", \
                       dest = "start", \
                       type = int, \
                       help = "First residue to be removed from the chain")
argparser.add_argument("--end", \
                       dest = "end", \
                       type = int, \
                       help = "Last residue to be removed from the chain")

# Get the arguments
args = argparser.parse_args()
in_pdb_file = args.in_pdb_file
out_pdb_file = args.out_pdb_file
chain = args.chain
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
w.save(out_pdb_file, \
       NotInRangeResSelect(chain = chain, \
                           start = start, \
                           end = end))
