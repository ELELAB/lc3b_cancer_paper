# Introduction

This folder contains the ENCORE ensemble similarity analysis. It calculates
for each pair of ensembles a measure of how much such ensembles differ. The
scores are then represented on a bidimensional plane as calculate by 
Tree Proximity Embedding, and 2D projections of the RMSD matrix upon
stochastic proximity embedding dimensionality reduction are also plotted.

# Requirements

This folder provides Python scripts that perform the analysis and plotting.
Please see the environment.txt file for the necessary Python packages - the
scripts have been run using Python 3.7.5.

You also need to have R and the "tpe" package installed. The scripts have been
run usin R 3.6.2 and tpe 1.0.1.

Finally, you need to have a GROMACS installation available.

# Running

In this folder we have a number of data files that correspond to the data in the
publication. If you want to reproduce plotting of such data, please just run
do_plot.sh. If you want to repeat the calculation please run do_run.sh, and then
do_plot.sh in case you want to generate the corresponding plots. Run clean.sh
to remove the data files.

# Notes

Since dimensionality reduction ensemble similarity (DRES) has a stochastical 
component, you shouldn't expect to obtain exactly the same values that are 
in the folder right now - however they should be comparable
