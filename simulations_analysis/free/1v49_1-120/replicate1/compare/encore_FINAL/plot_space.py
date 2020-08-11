import numpy as np
import matplotlib
matplotlib.use("Agg")
import md
import sys
from matplotlib import pyplot as plt

matplotlib.rcParams['font.sans-serif'] = 'Arial'
colors = [ md.colors[s] for s in md.systems ]

data = np.loadtxt(sys.argv[1]).T
plt.scatter(data[0], data[1], s=20, c=colors)
for i,d in enumerate(data.T):
    plt.annotate(md.labels[i], d, d+0.02)
plt.tight_layout()
plt.savefig(sys.argv[1]+'.pdf', bbox_inches="tight")

