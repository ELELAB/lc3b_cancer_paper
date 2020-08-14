#!/usr/bin/env python
# -*- Mode: python; tab-width: 4; indent-tabs-mode:nil; coding:utf-8 -*-

import subprocess
import os
import os.path
import sys
import seaborn as sns


#---------------------- Scripts and data options ---------------------#

# Python interpreter
interpreter = "python3.7"
# scripts to be used for data aggregation and plotting
scriptsfolder = os.path.abspath("../../../../scripts")
scriptaggregation = \
    os.path.join(scriptsfolder, "aggregate_ddg_binding_data.py")
scriptcontributions = \
    os.path.join(scriptsfolder, "plot_ddg_contributions.py")

# generic file path to get the output of analyze_flex_ddG.py
filepath = \
    os.path.abspath("../{:s}/{:s}/analysis_output/output-results.csv")
# scoring functions used
scfuncs = ["talaris2014", "ref2015"]
# number of structures in the backrub ensembles
nstruct = 35
# number of backrub steps in the results
bsteps = 25
# tuples of system names representing the name of their
# folder and the name that should appear in the plot
sysnamesandfolders = \
    [("LC3B_ATG4B", \
        "atg4b/atg4b_2ZZPab_6-354_4-122/2ZZPab")]


#-------------------------- Plotting options -------------------------#

# path to a custom font to be used for all texts in the plots
fontpath = os.path.abspath("../../../../fonts/Helvetica.ttf")
# set vmin and vmax to be symmetric, and tickspace so that the ticks
# are not too close to each other. Set the center of the color map
# to 0.
vmax = 20.0
vmin = -20.0
tickspace = 2.0
center = 0.0
# PDF DPI value
dpi = 900
# HUSL palette with 19 colors
palette = sns.husl_palette(19).as_hex()
# Matplotlib named colormap
cmap = "BrBG_r"


#---------------------------- Set folders ----------------------------#

# get the current working directory
cwd = os.getcwd()

# no need to get the absolute paths, since they all start from
# cwd that is already in the form of absolute path

# data aggregation folders
aggregationpath = os.path.join(cwd, "1-aggregation")
aggregationcontrpath = os.path.join(aggregationpath, "contributions")
# plotting folders
plottingpath = os.path.join(cwd, "2-plotting")
plottingcontrpath = os.path.join(plottingpath, "contributions")
# create the folder tree
paths = [aggregationpath, aggregationcontrpath, \
         plottingpath, plottingcontrpath]
for path in paths:
    os.makedirs(path, exist_ok = True)



#------------------- Run aggregation and plotting --------------------#

# general output names for heatmaps and contributions data/plots
ocontr = "contributions_{:s}_{:s}"

# for each score function used
for scfunc in scfuncs:
    # empty list to store the files whose data will be aggregated
    aggrinfiles = []
    sysnames = []
    # for each system
    for sysname, folder in sysnamesandfolders:
        infile = filepath.format(folder, scfunc)
        aggrinfiles.append(infile)
        sysnames.append(sysname)

        #----------------------- Contributions -----------------------#

        # go to the data aggregation folder for contributions
        os.chdir(aggregationcontrpath)
        # set output name
        ocontrdata = os.path.join(\
            aggregationcontrpath, \
            ocontr.format(sysname, scfunc) + ".csv")
        # run the aggregation
        process = subprocess.run(\
            [interpreter, scriptaggregation, \
             "-i", infile, \
             "-o", ocontrdata, \
             "-m", "contributions", \
             "--backrub-steps", str(bsteps), \
             "--nstruct", str(nstruct), \
             "--score-function", scfunc, \
             "--convert"])

        if process.returncode == 0:
            logstr = \
                "AGGREGATION (contributions) - Data aggregated " \
                "successfully for system {:s}, score function {:s}.\n"
        else:
            logstr = \
                "WARNING (contributions) - Something went wrong in " \
                "aggregating data for system {:s}, score function {:s}.\n"
        
        sys.stdout.write(logstr.format(sysname, scfunc))
        sys.stdout.flush()

        # go to the plotting folder for contributions
        os.chdir(plottingcontrpath)
        # set output name
        ocontrplot = ocontr.format(sysname, scfunc) + ".pdf"
        # run the plotting
        process = subprocess.run(\
            [interpreter, scriptcontributions, \
             "-i", ocontrdata, \
             "-o", ocontrplot, \
             "--fontpath", fontpath, \
             "--bottom", str(vmin), \
             "--top", str(vmax), \
             "--yspace", str(tickspace), \
             "--dpi", str(dpi), \
             "--transparent", \
             "--palette", *palette])

        if process.returncode == 0:
            logstr = \
                "PLOTTING (contributions) - Data plotted " \
                "successfully for system {:s}, score function {:s}.\n"
        else:
            logstr = \
                "WARNING (contributions) - Something went wrong in " \
                "plotting data for system {:s}, score function {:s}.\n"
        
        sys.stdout.write(logstr.format(sysname, scfunc))
        sys.stdout.flush()

# go back to the main working directory
os.chdir(cwd)
