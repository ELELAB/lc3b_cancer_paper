#!/usr/bin/env python
# -*- Mode: python; tab-width: 4; indent-tabs-mode:nil; coding:utf-8 -*-

import argparse
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import matplotlib.font_manager as fm
import seaborn as sns
import pandas as pd

def plot_ddg_contributions(df, \
                           outfile, \
                           ddgunit, \
                           palette, \
                           xticklabels, \
                           fontpath, \
                           top, \
                           bottom, \
                           yspace, \
                           dpi, \
                           transparent, \
                           axlabelsize, \
                           ticklabelsize, \
                           legendlabelsize, \
                           annotsize):
    """Plot the energy contributions to the ΔΔG of binding.
    """
   
    # close any current figure window
    plt.close()
    # retrieve the color palette
    palette = \
        palette if type(palette) == list \
        else sns.color_palette(palette)

    #-------------------------- Input data ---------------------------#

    # retrieve the sum of all positive contributions
    # and of all negative contributions per each case
    # (= row). Will be used to position the labels over
    # the stacked bars and to set the y axis limits.
    pos_sum = []
    neg_sum = []
    scores = []
    for casename, data in df.iterrows():
        pos_sum.append(data[data>0].sum())
        neg_sum.append(data[data<0].sum())
        scores.append(data.sum())

    #------------------------- Font settings -------------------------#

    # set font properties
    fp_axlabels = fm.FontProperties(fname = fontpath, \
                                    size = axlabelsize)
    fp_ticklabels = fm.FontProperties(fname = fontpath, \
                                      size = ticklabelsize) 
    fp_legend = fm.FontProperties(fname = fontpath, \
                                  size = legendlabelsize)
    fp_annot = fm.FontProperties(fname = fontpath, \
                                 size = annotsize)

    #----------------- Max/min values and tick space -----------------#

    # set y-axis limits and tick space. If not
    # provided, bottom and top values are the
    # minimum and maximum value of the contributions
    # rounded to the nearest integer.
    absmax = abs(np.ceil(max(pos_sum)*2)/2)
    absmin = abs(np.floor(min(neg_sum)*2)/2)
    absval = absmax if absmax > absmin else absmin
    bottom = bottom if bottom is not None else -absval
    top = top if top is not None else absval

    if yspace is not None:
        yticks = np.arange(bottom, top + yspace, yspace)
    else:
        yticks = np.linspace(bottom, top, 10)
        yspace = yticks[1] - yticks[0]

    #-------------------- Create figure and axes ---------------------#   
    
    # draw a stacked bar plot in which positive contributions are
    # stacked on the positive semiaxis and negative contributions are
    # stacked on the negative semiaxis
    ax = df.plot(kind = "bar", \
                 stacked = True, \
                 color = palette, \
                 width = 0.6, \
                 figsize = (10,4))  

    #------------------- X- and Y-axis and legend --------------------#

    # set x-axis graphical bounds
    ax.spines["bottom"].set_bounds(0, len(df)-1)
    # what to be used as x ticks labels
    xticklabels = xticklabels if xticklabels is not None else df.index 
    # set x-axis tick labels       
    ax.set_xticklabels(xticklabels, \
                       rotation = 90, \
                       fontproperties = fp_ticklabels)
    # set x-axis label
    ax.set_xlabel("Mutations", fontproperties = fp_axlabels)
    # set y-axis graphical bounds
    ax.spines["left"].set_bounds(bottom, top)  
    # plot y-axis ticks
    plt.yticks(yticks, yticks)
    # set y-axis tick labels
    ax.set_yticklabels(ax.get_yticklabels(), \
                       fontproperties = fp_ticklabels)
    # set y-axis label
    ylabel = "ΔΔG energy contributions\n({:s})".format(ddgunit)
    ax.set_ylabel(ylabel, fontproperties = fp_axlabels)
    # add labels representing the total score over the bars
    for patch, psum, score in zip(ax.patches, pos_sum, scores):
        ax.text(patch.get_x() + patch.get_width()/2.0, \
                psum + yspace/10, \
                round(score,3), \
                fontproperties = fp_annot, \
                ha = "center")
    # draw the legend
    handles, labels = ax.get_legend_handles_labels()
    ax.legend(handles = handles, \
              labels = labels, \
              frameon = False, \
              bbox_to_anchor = (1.05, 0.5), \
              loc = "center right", 
              bbox_transform = plt.gcf().transFigure, \
              prop = fp_legend)
    # hide top and right spine
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    # plot a horizontal line at 0 REUs to better
    # discriminate between positive and negative
    # contributions
    xmax = (len(df)-0.25)/len(df)
    plt.axhline(y = 0, \
                color = "black", \
                linewidth = 0.6, \
                xmax = xmax, \
                linestyle = "--")

    #------------------------ Save the figure ------------------------#

    plt.savefig(outfile, \
                bbox_inches = "tight", \
                dpi = dpi, \
                transparent = transparent)


if __name__ == "__main__":

    # set the argument parser
    parser = argparse.ArgumentParser()

    # add arguments
    i_helpstr = "Input file"
    parser.add_argument("-i", \
                        dest = "infile", \
                        type = str, \
                        required = True, \
                        help = i_helpstr)
    
    o_helpstr = "Output file"
    parser.add_argument("-o", \
                        dest = "outfile", \
                        type = str, \
                        required = True, \
                        help = o_helpstr)

    ddgunit_default = "kcal/mol"
    ddgunit_helpstr = \
        "Energy units for the ΔΔG scores. Default is " \
        "{:s}.".format(ddgunit_default)
    parser.add_argument("--ddgunit", \
                        dest = "ddgunit", \
                        type = str, \
                        default = ddgunit_default, \
                        required = False, \
                        help = ddgunit_helpstr)

    palette_default = "colorblind"
    palette_helpstr = \
        "Color palette. Default is {:s}".format(palette_default)
    parser.add_argument("--palette", \
                        dest = "palette", \
                        type = str, \
                        default = palette_default, \
                        required = False, \
                        nargs = "+")
    
    xticklabels_helpstr = "Custom labels for X-axis ticks."
    parser.add_argument("--xticklabels", \
                        dest = "xticklabels", \
                        type = str, \
                        default = None, \
                        required = False, \
                        nargs = "+", \
                        help = xticklabels_helpstr)

    top_helpstr = \
        "Upper limit of the Y-axis. Determined automatically " \
        "if not passed."
    parser.add_argument("--top", \
                        dest = "top", \
                        type = float, \
                        default = None, \
                        required = False, \
                        help = top_helpstr)
    
    bottom_helpstr = \
        "Lower limit of the Y-axis. Determined automatically " \
        "if not passed."
    parser.add_argument("--bottom", \
                        dest = "bottom", \
                        type = float, \
                        default = None, \
                        required = False, \
                        help = bottom_helpstr)
    
    yspace_helpstr = \
        "Tick spacing on the Y-axis. Determined automatically " \
        "if not passed."
    parser.add_argument("--yspace", \
                        dest = "yspace", \
                        type = float, \
                        default = None, \
                        required = False, \
                        help = yspace_helpstr)
    
    fontpath_helpstr = \
        "Path to a custom font to be used while plotting."
    parser.add_argument("--fontpath", \
                        dest = "fontpath", \
                        type = str, \
                        default = None, \
                        required = False, \
                        help = fontpath_helpstr)
    
    dpi_default = 900
    dpi_helpstr = \
        "DPI of the figure. Default is {:d}".format(dpi_default)
    parser.add_argument("--dpi", \
                        dest = "dpi", \
                        type = int, \
                        default = dpi_default, \
                        required = False, \
                        help = dpi_helpstr)
    
    transparent_helpstr = "Set transparent background."
    parser.add_argument("--transparent", \
                        dest = "transparent", \
                        action = "store_true", \
                        default = False, \
                        help = transparent_helpstr)

    # parse the arguments
    args = parser.parse_args()

    # read the energy contributions as a dataframe from the input file
    df = pd.read_csv(args.infile, sep = ",", index_col = 0)

    # plot the energy contributions
    plot_ddg_contributions(\
        df = df, \
        outfile = args.outfile, \
        ddgunit = args.ddgunit, \
        palette = args.palette, \
        xticklabels = args.xticklabels, \
        fontpath = args.fontpath, \
        top = args.top, \
        bottom = args.bottom, \
        yspace = args.yspace, \
        dpi = args.dpi, \
        transparent = args.transparent, \
        axlabelsize = 11, \
        ticklabelsize = 9, \
        legendlabelsize = 9, \
        annotsize = 5)