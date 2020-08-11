import numpy as np
import matplotlib
matplotlib.use("Agg")
from matplotlib import pyplot as plt
import md
import sys

matplotlib.rcParams['font.sans-serif'] = 'Arial'
matplotlib.rcParams['font.size'] = 8

coords = np.loadtxt(sys.argv[1]).T
xs = np.arange(0, 1001*len(md.systems)+1, 1001)

for i,s in enumerate(md.systems):
        x = np.arange(xs[i], xs[i+1])
        plt.scatter(coords[0, x], coords[1, x], s=2, color=md.colors[s], label=md.labels[i], marker='.')
plt.legend()
plt.savefig('dres_proj2d.pdf')

xlims = (np.min(coords[0])-0.5, np.max(coords[0])+0.5)
ylims = (np.min(coords[1])-0.5, np.max(coords[1])+0.5)

plt.clf()
for i,s in enumerate(md.systems):
    x = np.arange(xs[i], xs[i+1])
    plt.xlim(xlims)
    plt.ylim(ylims)
    plt.title(s)
    plt.scatter(coords[0], coords[1], s=2, color='black')
    plt.scatter(coords[0, x], coords[1, x], s=2, color=md.colors[s], label=md.labels[i], marker='.')
    plt.legend()
    plt.savefig("dres_proj2d_%s.pdf" % s)
    plt.clf()
