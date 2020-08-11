# coding: utf-8
import MDAnalysis as mda
from MDAnalysis.analysis import encore
import md

dstep = 100
selection = "resnum 6-115"

universes = [mda.Universe(t, md.trajs[i], in_memory=True, in_memory_step=dstep) for i,t in enumerate(md.tops)]
merged_uni = encore.utils.merge_universes(universes)
selected_uni = merged_uni.select_atoms(selection)
with mda.Writer("merged.xtc", selected_uni.atoms) as W:
    for ts in merged_uni.trajectory:
        W.write(selected_uni)
with mda.Writer("topology.pdb", selected_uni.atoms) as W:
    W.write(selected_uni)


