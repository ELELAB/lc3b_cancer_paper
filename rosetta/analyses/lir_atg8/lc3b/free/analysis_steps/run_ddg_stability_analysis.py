#!/usr/bin/env python
# -*- Mode: python; tab-width: 4; indent-tabs-mode:nil; coding:utf-8 -*-

import subprocess
import os
import os.path
import sys
import pandas as pd
import seaborn as sns


#---------------------- Scripts and data options ---------------------#

# Python interpreter
interpreter = "python3.7"
# scripts to be used for data aggregation and plotting
scriptsfolder = os.path.abspath("../../../../scripts")
scriptanalysis = \
    os.path.join(scriptsfolder, "analyze_ddg_stability_data.py")
scriptaggregation = \
    os.path.join(scriptsfolder, "aggregate_ddg_stability_data.py")
scriptsaturation = \
    os.path.join(scriptsfolder, "plot_ddg_stability_saturation_heatmap.py")
scriptcontributions = \
    os.path.join(scriptsfolder, "plot_ddg_contributions.py")

# absolute path to the raw data
rawdatafolder = \
    os.path.abspath(\
        "../../../../../scan/lir_atg8/lc3b/free/{:s}/exp/{:s}/{:s}")
# name of the raw output file containing scores and contributions
ddgfile = "mutation.ddg"
# name of the file containing the list of mutations performed for
# each position
mutfile = "mutfile.txt"
# generic name for the analysis output file
outfile = "ddgs_{:s}.txt"
# scoring functions used
scfuncs = ["talaris2014", "ref2015"]
# all scanned positions
allpositions = \
    ["S3", "R16", "D19", "R21", "P28", "T29", "P32", "I35", "R37", \
     "Y38", "K39", "K49", "D56", "M60", "K65", "R70", "L82", \
     "V89", "V91", "V98", "Y113", "G120"]
# all cancer mutations
cancermuts1v49 = \
    ["S3W", "R16G", "D19Y", "R21G", "R21Q", "P28L", "T29A", "P32Q", \
     "I35V", "R37Q", "Y38H", "K39R", "K49N", "D56N", "M60I", "M60V", \
     "K65E", "R70C", "R70H", "L82F", "V89F", "V91I", "V98A", "Y113C", \
     "G120R", "G120V"]
cancermuts3vtu = \
    [m[0] + str(int(m[1:-1])-1) + m[-1] for m in cancermuts1v49[1:-2]]
# all mutations performed for each position
allmutations = \
    ["A", "C", "D", "E", "F", "G", "H", "I", "K", "L", \
     "M", "N", "P", "Q", "R", "S", "T", "V", "W", "Y"]
# which positions have been scanned for each system
system_positions_cancermuts = \
    [("1v49_1-120", allpositions, cancermuts1v49), \
     ("3vtu_2-119", allpositions[1:-1], cancermuts3vtu)]


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

# get the absolute path of the current working directory
cwd = os.getcwd()

# no need to get the absolute paths, since they all start from
# cwd that is already in the form of absolute path

# data analysis folders
analysispath = os.path.join(cwd, "1-analysis")
singleanalysispath = os.path.join(analysispath, "{:s}/exp/{:s}")
# data aggregation folders
aggregationpath = os.path.join(cwd, "2-aggregation")
aggregationcontrpath = os.path.join(aggregationpath, "contributions")
aggregationheatpath = os.path.join(aggregationpath, "heatmaps")
# plotting folders
plottingpath = os.path.join(cwd, "3-plotting")
plottingcontrpath = os.path.join(plottingpath, "contributions")
plottingheatpath = os.path.join(plottingpath, "heatmaps")
# create the folder tree
paths = [aggregationpath, aggregationcontrpath, aggregationheatpath, \
         plottingpath, plottingcontrpath, plottingheatpath]
for path in paths:
    os.makedirs(path, exist_ok = True)


#-------------- Run analysis, aggregation and plotting ---------------#

# N.B. do not convert to kcal/mol since they are already in kcal/mol

# general output names for heatmaps and contributions data/plots
ocontr = "contributions_{:s}_{:s}_{:s}"
oheat = "heatmap_{:s}_{:s}"
# for each score function used
for scfunc in scfuncs:
    # for each system scanned
    for system, positions, cancermuts in system_positions_cancermuts:
        # empty list storing the aggregated contribution data for each
        # position (to be processed later to aggregate only data regarding)
        # the cancer mutations
        ocontrouts = []
        # list to be filled with paths to files containing analyzed
        # data for subsequent aggregation
        aggrinfiles = []
        # for each scanned position
        for position in positions:

            #------------------- Raw data analysis -------------------#
            
            # create (if needed) and go to the analysis folder
            # corresponding to the current system and scoring function
            thisanalysispath = singleanalysispath.format(system, scfunc)
            os.makedirs(thisanalysispath, exist_ok = True)
            os.chdir(thisanalysispath)
            # set the protocol name
            protocol = "park2016_{:s}".format(scfunc)
            # set the directory where the current position was run
            rundir = rawdatafolder.format(system, scfunc, position)
            # set the mutfile name used for the run
            posmutfile = os.path.join(rundir, mutfile)
            # set the output file name
            posoutfile = os.path.join(thisanalysispath, \
                                       outfile.format(position))
            # run the analysis of the raw data
            process = subprocess.run(\
                [interpreter, scriptanalysis, \
                 "-p", protocol, \
                 "-d", ddgfile, \
                 "-m", posmutfile, \
                 "-r", rundir, \
                 "-o", posoutfile])
            # log about success
            if process.returncode == 0:
                sys.stdout.write(\
                    f"ANALYSIS - Data analyzed successfully for " \
                    f"system {system}, score function {scfunc}, " \
                    f"position {position}.\n")
            # log about failure
            else:
                sys.stdout.write(\
                    f"WARNING (analysis) - Something went wrong in " \
                    f"analyzing data for system {system}, score " \
                    f"function {scfunc}, position {position}.\n")         
            # flush the standard output
            sys.stdout.flush()        
            # add the output file to the list of files for data
            # aggregation
            aggrinfiles.append(posoutfile)
            
            #------------ Data aggregation (contributions) -----------#

            # go to the data aggregation folder for contributions
            os.chdir(aggregationcontrpath)
            # set output name
            ocontraggr = os.path.join(\
                aggregationcontrpath, \
                ocontr.format(system, scfunc, position) + ".csv")
            # set x-axis tick labels
            xticklabelscontr = [position + mut for mut in allmutations]
            # aggregate energy contributions data
            process = subprocess.run(\
                [interpreter, scriptaggregation, \
                 "-i", posoutfile, \
                 "-o", ocontraggr, \
                 "-m", "contributions", \
                 "--score-function", scfunc])
            # log about success
            if process.returncode == 0:
                sys.stdout.write(\
                    f"AGGREGATION (contributions) - Data aggregated " \
                    f"successfully for system {system}, score " \
                    f"function {scfunc}, position {position}.\n")
                # store the file containing the aggregated data for
                # further processing
                ocontrouts.append(ocontraggr)
            # log about failure        
            else:
                sys.stdout.write(\
                    f"WARNING (contributions) - Something went " \
                    f"wrong in aggregating data for system {system}, " \
                    f"score function {scfunc}, position {position}.\n")
            # flush the standard output
            sys.stdout.flush()

            #--------------- Plotting (contributions) ----------------#

            # go to the plotting folder for contributions
            os.chdir(plottingcontrpath)
            # set output name
            ocontrplot = ocontr.format(system, scfunc, position) + ".pdf"
            # plot the contributions
            process = subprocess.run(\
                [interpreter, scriptcontributions, \
                 "-i", ocontraggr, \
                 "-o", ocontrplot, \
                 "--fontpath", fontpath, \
                 "--bottom", str(vmin), \
                 "--top", str(vmax), \
                 "--yspace", str(tickspace), \
                 "--dpi", str(dpi), \
                 "--transparent", \
                 "--palette", *palette, \
                 "--xticklabels", *xticklabelscontr])
            # log about success
            if process.returncode == 0:
                sys.stdout.write(\
                    f"PLOTTING (contributions) - Data plotted " \
                    f"successfully for system {system}, score " \
                    f"function {scfunc}, position {position}.\n")
            # log about failure
            else:
                sys.stdout.write(\
                    f"WARNING (contributions) - Something went " \
                    f"wrong in plotting data for system {system}, " \
                    f"score function {scfunc}, position {position}.\n")          
            # flush the standard output
            sys.stdout.flush()

        #--------------- Data aggregation (heatmaps) -----------------#

        # go to the data aggregation folder for heatmaps
        os.chdir(aggregationheatpath)
        # set output name
        oheataggr = os.path.join(\
            aggregationheatpath, \
            oheat.format(system, scfunc) + ".csv")
        # aggregate saturation scan data
        process = subprocess.run(\
            [interpreter, scriptaggregation, \
             "-i", *aggrinfiles, \
             "-o", oheataggr, \
             "-m", "saturation_scan", \
             "--score-function", scfunc])
        # log about success
        if process.returncode == 0:
            sys.stdout.write(\
                f"AGGREGATION (heatmaps) - Data aggregated " \
                f"successfully for system {system}, score " \
                f"function {scfunc}.\n")
        # log about failure
        else:
            sys.stdout.write(\
                f"WARNING (heatmaps) - Something went wrong in " \
                f"aggregating data for system {system}, score " \
                f"function {scfunc}.\n")
        # flush the standard output
        sys.stdout.flush()
        
        #------------------- Plotting (heatmaps) ---------------------#
        
        # go to the plotting folder for contributions
        os.chdir(plottingheatpath)
        # set output name (no need for absolute path here)
        oheatplot = oheat.format(system, scfunc) + ".pdf"    
        # plot the heatmaps
        process = subprocess.run(\
            [interpreter, scriptsaturation, \
             "-i", oheataggr, \
             "-o", oheatplot, \
             "--fontpath", fontpath, \
             "--cmap", cmap, \
             "--xticklabels", *positions, \
             "--vmin", str(vmin), \
             "--vmax", str(vmax), \
             "--center", str(center), \
             "--vspace", str(tickspace), \
             "--dpi", str(dpi), \
             "--transparent", \
             "--annot"])
        # log about success
        if process.returncode == 0:
            sys.stdout.write(\
                f"PLOTTING (heatmaps) - Data plotted successfully " \
                f"for system {system}, score function {scfunc}.\n")
        # log about failure
        else:
            sys.stdout.write(\
                f"WARNING (heatmaps) - Something went wrong in " \
                f"plotting data for system {system}, score function " \
                f"{scfunc}.\n")
        # flush the standard output
        sys.stdout.flush()

        #------------- Aggregation (cancer mutations) ----------------#

        allcontrdfs = \
            [pd.read_csv(o, index_col = 0) for o in ocontrouts]
        allcontrdf = pd.concat(allcontrdfs, axis = 0)
        cmdf = allcontrdf[allcontrdf.index.isin(cancermuts)]
        ocontraggrcm = os.path.join(\
            aggregationcontrpath, \
            ocontr.format(system, scfunc, "cancermuts") + ".csv")
        cmdf.to_csv(ocontraggrcm, sep = ",")
        # log about success
        if process.returncode == 0:
            sys.stdout.write(\
                f"AGGREGATION (contributions) - Data aggregated " \
                f"successfully for system {system}, score function " \
                f"{scfunc}, cancer mutations.\n")
        # log about failure
        else:
            sys.stdout.write(\
                f"WARNING (contributions) - Something went wrong " \
                f"in aggregating data for system {system}, score " \
                f"function {scfunc}, cancer mutations.\n")              
        # flush the standard output
        sys.stdout.flush()

        #--------------- Plotting (cancer mutations) -----------------#

        # go to the plotting folder for contributions
        os.chdir(plottingcontrpath)
        # set output name
        ocontrplotcm = \
            ocontr.format(system, scfunc, "cancermuts") + ".pdf"
        # plot the contributions
        process = subprocess.run(\
            [interpreter, scriptcontributions, \
             "-i", ocontraggrcm, \
             "-o", ocontrplotcm, \
             "--fontpath", fontpath, \
             "--bottom", str(vmin), \
             "--top", str(vmax), \
             "--yspace", str(tickspace), \
             "--dpi", str(dpi), \
             "--transparent", \
             "--palette", *palette, \
             "--xticklabels", *cancermuts])
        # log about success
        if process.returncode == 0:
            sys.stdout.write(\
                f"PLOTTING (contributions) - Data plotted " \
                f"successfully for system {system}, score function " \
                f"{scfunc}, cancer mutations.\n")
        # log about failure
        else:
            sys.stdout.write(\
                f"WARNING (contributions) - Something went wrong " \
                f"in plotting data for system {system}, score " \
                f"function {scfunc}, cancer mutations.\n")              
        # flush the standard output
        sys.stdout.flush()

# go back to the main working directory
os.chdir(cwd)
