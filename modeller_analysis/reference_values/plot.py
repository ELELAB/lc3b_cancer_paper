import pandas as pd
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt

cm = plt.get_cmap('gist_rainbow')

data = pd.read_csv('values.dat', sep='\t')
pdbs = sorted(list(set(data['#pdb'])))

headers = ['sasHP1', 'sasHP2']

titles = ['SAS HP1', 'SAS HP2']

xlabels = ['SAS ($nm^2$)',  'SAS ($nm^2$)']

nbins  = dict(zip(headers, [22, 10]))
limits = dict(zip(headers, [(0, 1.1),(0, 0.5)]))

figs = {}
axes = {}

matplotlib.rcParams['axes.prop_cycle'] =  matplotlib.cycler(color=[cm(1.*i/len(pdbs)) for i in range(len(pdbs))])

fig, a = plt.subplots(2, 1)

a = a.flatten()

for i,h in enumerate(headers):
	axes[h] = a[i]
	a[i].set_title(titles[i])
	a[i].set_xlabel(xlabels[i])
	a[i].set_ylabel('number of occurrences')

all_values = dict(zip(headers, [[],[]]))

for pdb in pdbs:
	for h in headers:
		all_values[h].append(data[ data['#pdb'] == pdb][ h ].values[0])
		axes[h].hist(all_values[h][-1], bins=nbins[h], range=limits[h], label=pdb)

axes[headers[0]].legend(prop={'size': 6})

fig.tight_layout()
fig.savefig('values_single.pdf')

f, a = plt.subplots(2, 2, squeeze=True)
a = a.flatten()

for i,h in enumerate(headers):
	a[i].hist(all_values[h], bins=nbins[h], range=limits[h], label=pdb)
	a[i].set_title(titles[i])
	a[i].set_xlabel(xlabels[i])
	a[i].set_ylabel('number of occurrences')
f.tight_layout()
f.savefig('values_all.pdf')

