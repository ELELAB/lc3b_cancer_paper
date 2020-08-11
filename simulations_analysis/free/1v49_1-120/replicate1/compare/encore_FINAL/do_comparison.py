# coding: utf-8
import MDAnalysis as mda
from MDAnalysis.analysis import encore
import numpy as np
import matplotlib
matplotlib.use("Agg")
from matplotlib import pyplot as plt
import md
import pickle

frameskip=100

universes = [mda.Universe(t, md.trajs[i], in_memory=True, in_memory_step=frameskip) for i,t in enumerate(md.tops)]
nframes = len(universes[0].trajectory) * len(md.systems)

dat_file="rmsd.dat"
dat = np.fromfile(dat_file, dtype=np.float32)
dat_sq = dat.reshape((nframes,nframes))
dat_tril = dat_sq[np.tril_indices_from(dat_sq)]*10.0

mat = encore.utils.TriangularMatrix(size=nframes)
mat._elements = dat_tril

runs = [encore.AffinityPropagation(preference=-150.0,  max_iter=1000)]
out, details = encore.ces(universes, distance_matrix=mat, clustering_method=runs)
ces_mat = out[0]
np.savetxt('ces.dat', ces_mat, fmt='%.5f')

methods=[encore.StochasticProximityEmbeddingNative(dimension=2, ncycle=10000, nstep=1000000)]
out, details = encore.dres(universes, distance_matrix=mat, dimensionality_reduction_method=methods)
dres_mat = out[0]
np.savetxt('dres.dat', dres_mat, fmt='%.5f')
np.savetxt('dres_projection.dat', details['dimensionality_reduction_details']['reduced_coordinates'][0].T)

