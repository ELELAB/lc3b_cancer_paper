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
scriptheatmap = \
    os.path.join(scriptsfolder, "plot_ddg_binding_heatmap.py")
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
    [("LC3B_FYCO1", \
        "fyco1/fyco1_5WRDac_4-120_1235-1253/5WRDac"), \
     ("LC3B_FUNDC1 (2N9X)", \
        "fundc1/fundc1_2N9X_1-120_10-26/2N9X_conformer1"), \
     ("LC3B_FUNDC1 (5GMV AC)", \
        "fundc1/fundc1_5GMV_5-124_16-23/5GMV_ac"), \
     ("LC3B_FUNDC1 (5GMV BD)", \
        "fundc1/fundc1_5GMV_5-124_16-23/5GMV_bd"), \
     ("LC3B_FUNDC1_S-E (5GMV AC)", \
        "fundc1/fundc1_5GMV_S-E_5-124_16-23/5GMV_ac"), \
     ("LC3B_FUNDC1_S-E (5GMV BD)", \
        "fundc1/fundc1_5GMV_S-E_5-124_16-23/5GMV_bd"), \
     ("LC3B_OPTN", \
        "optn/optn_2LUE_1-119_169-185/2LUE_retro_mut"), \
     ("LC3B_5S-E_OPTN", \
        "optn/optn_SX5E_2LUE_1-119_169-185/2LUE_SX5E"), \
     ("LC3B_5pS_OPTN", \
        "optn/optn_5P_2LUE_1-119_169-185/2LUE_5P"), \
     ("LC3B_PLEKHM1_model153", \
        "plekhm1/plekhm1_3X0Wa_1-120_627-643/model153"), \
     ("LC3B_PLEKHM1_model675", \
        "plekhm1/plekhm1_3X0Wb_1-120_627-643/model675"), \
     ("LC3B_SQSTM1", \
        "p62/p62_2ZJD_1_122_338_344/2ZJD_cd")]


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
aggregationheatpath = os.path.join(aggregationpath, "heatmaps")
# plotting folders
plottingpath = os.path.join(cwd, "2-plotting")
plottingcontrpath = os.path.join(plottingpath, "contributions")
plottingheatpath = os.path.join(plottingpath, "heatmaps")
# create the folder tree
paths = [aggregationpath, aggregationcontrpath, aggregationheatpath, \
         plottingpath, plottingcontrpath, plottingheatpath]
for path in paths:
    os.makedirs(path, exist_ok = True)



#------------------- Run aggregation and plotting --------------------#

# general output names for heatmaps and contributions data/plots
ocontr = "contributions_{:s}_{:s}"
oheat = "heatmap_{:s}"

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

    #--------------------------- Heatmaps ----------------------------#

    # go to the data aggregation folder for heatmaps
    os.chdir(aggregationheatpath)
    # set output name
    oheataggr = os.path.join(\
        aggregationheatpath, \
        oheat.format(scfunc) + ".csv")
    # run the aggregation
    process = subprocess.run(\
        [interpreter, scriptaggregation, \
         "-i", *aggrinfiles, \
         "-o", oheataggr, \
         "-m", "multiple_systems", \
         "--sysnames", *sysnames, \
         "--backrub-steps", str(bsteps), \
         "--nstruct", str(nstruct), \
         "--score-function", scfunc, \
         "--convert"])

    if process.returncode == 0:      
        logstr = \
            "AGGREGATION (heatmaps) - Data aggregated " \
            "successfully for score function {:s}.\n"
    else:
        logstr = \
            "WARNING (heatmaps) - Something went wrong in " \
            "aggregating data for score function {:s}.\n"
    
    sys.stdout.write(logstr.format(scfunc))
    sys.stdout.flush()

    # go to the plotting folder for heatmaps
    os.chdir(plottingheatpath)
    # set output name
    oheatplot = oheat.format(scfunc) + ".pdf"
    # run the plotting 
    process = subprocess.run(\
        [interpreter, scriptheatmap, \
         "-i", oheataggr, \
         "-o", oheatplot, \
         "--fontpath", fontpath, \
         "--vmin", str(vmin), \
         "--vmax", str(vmax), \
         "--vspace", str(tickspace), \
         "--sysnames", *sysnames, \
         "--dpi", str(dpi), \
         "--transparent", \
         "--cmap", cmap, \
         "--annot"])

    if process.returncode == 0:
        logstr = \
            "PLOTTING (heatmaps) - Data plotted " \
            "successfully for score function {:s}.\n"
    else:
        logstr = \
            "WARNING (heatmaps) - Something went wrong in " \
            "plotting data for score function {:s}.\n"
    
    sys.stdout.write(logstr.format(scfunc))
    sys.stdout.flush()

# go back to the main working directory
os.chdir(cwd)
