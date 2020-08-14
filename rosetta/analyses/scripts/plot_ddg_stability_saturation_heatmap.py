#!/usr/bin/env python
# -*- Mode: python; tab-width: 4; indent-tabs-mode:nil; coding:utf-8 -*-

import argparse
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm
import matplotlib.cm as cm
import numpy as np
import seaborn as sns
import pandas as pd


def plot_stability_saturation_heatmap(df, \
                                      posony, \
                                      outfile, \
                                      fontpath, \
                                      xticklabels, \
                                      ddgunit, \
                                      cmap, \
                                      vmin, \
                                      vmax, \
                                      center, \
                                      vspace, \
                                      annot, \
                                      annotcolor, \
                                      linecolor, \
                                      linewidths, \
                                      dpi, \
                                      transparent, \
                                      axlabelsize, \
                                      ticklabelsize, \
                                      cbarlabelsize, \
                                      annotsize):
    """Plot scores from ΔΔG of stability scans as a heatmap. 
    """

    # close any current figure window
    plt.close()
    # get the color map
    cmap = plt.get_cmap(cmap)

    #-------------------------- Input data ---------------------------#

    # transpose the dataframe if you want mutations on the Y-axis
    df = df if posony else df.transpose()

    #------------------------- Font settings -------------------------#

    fp_axlabels = fm.FontProperties(fname = fontpath, \
                                    size = axlabelsize)
    fp_ticklabels = fm.FontProperties(fname = fontpath, \
                                      size = ticklabelsize)     
    fp_cbar = fm.FontProperties(fname = fontpath, \
                                size = cbarlabelsize)  
    fp_annot = fm.FontProperties(fname = fontpath, \
                                 size = annotsize)

    #----------------- Max/min values and tick space -----------------#

    # set default maximum and minimum value for the colormap 
    # if not provided by the user
    minval = np.floor(df.values.min())
    maxval = np.ceil(df.values.max())
    abslim = abs(maxval) if abs(maxval) > abs(minval) else abs(minval)     
    vmax = abslim if vmax is None else vmax
    vmin = -abslim if vmin is None else vmin
    # center of the color map
    center = (vmax + vmin)/2 if center is not None else center

    #-------------------------- Annotations --------------------------#

    # if no annotation is required, leave the dictionary
    # for the annotation properties empty
    annot_kws = {}   
    if annot:
        # shorten the scores to only two decimals to save space
        annot_transform = np.vectorize(lambda x : np.around(x,2))
        annot = annot_transform(df.values)
        annot_kws = dict(color = annotcolor, \
                         fontproperties = fp_annot)

    #-------------------- Create figure and axes ---------------------#

    # plot the heatmap without the colorbar
    # fmt = g so that it does not display big numbers
    # in scientific notation
    ax = sns.heatmap(data = df, \
                     square = True, \
                     cbar = False, \
                     cmap = cmap, \
                     vmin = vmin, \
                     vmax = vmax, \
                     center = center, \
                     linecolor = linecolor, \
                     linewidths = linewidths,
                     annot = annot,
                     annot_kws = annot_kws, \
                     fmt = "g")

    #--------------------------- Color bar ---------------------------#

    # plot the colorbar from the matplotlib interface
    # in order to have more control over it
    cbar_label = u"ΔΔG ({:s})".format(ddgunit)      
    cbar = plt.colorbar(mappable = ax.get_children()[0], \
                        extend = "both")  
    cbar.ax.set_ylabel(ylabel = cbar_label, \
                       fontproperties = fp_cbar)
    # set colorbar ticks and ticks labels
    cbar_ticks = np.arange(vmin, \
                           vmax + vspace, \
                           vspace)
    cbar.set_ticks(ticks = cbar_ticks)       
    cbar.ax.set_yticklabels(labels = cbar_ticks, \
                            fontproperties = fp_ticklabels)

    #------------------------- X- and Y-axis -------------------------#

    # hide ticks but preserve tick labels for both axes
    ax.tick_params(axis = "both", \
                   which = "both", \
                   length = 0)
    # set custom X-axis tick labels
    xticklabels = \
        ax.get_xticklabels() if xticklabels is None else xticklabels
    # set X-axis tick labels
    ax.set_xticklabels(labels = xticklabels, \
                       rotation = 90, \
                       fontproperties = fp_ticklabels)
    # set Y-axis tick labels
    ax.set_yticklabels(labels = ax.get_yticklabels(), \
                       rotation = 0, \
                       fontproperties = fp_ticklabels)

    #------------------------ Save the figure ------------------------#

    # save the figure
    plt.savefig(fname = outfile, \
                dpi = dpi, \
                transparent = transparent, \
                bbox_inches = "tight")


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
    
    posony_helpstr = \
        "Residue positions on the Y-axis, mutations on " \
        "the X-axis."
    parser.add_argument("--posony", \
                        dest = "posony", \
                        action = "store_true", \
                        default = False, \
                        help = posony_helpstr)
    
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
    
    cmap_default = "BrBg_r"
    cmap_helpstr = \
        "Matplotlib color map. Default: {:s}.".format(cmap_default)
    parser.add_argument("--cmap", \
                        dest = "cmap", \
                        type = str, \
                        default = cmap_default, \
                        required = False, \
                        help = cmap_helpstr)
    
    xticklabels_helpstr = "Custom labels for X-axis ticks."
    parser.add_argument("--xticklabels", \
                        dest = "xticklabels", \
                        type = str, \
                        default = None, \
                        required = False, \
                        nargs = "+", \
                        help = xticklabels_helpstr)

    vmax_helpstr = \
        "Upper limit of the color map. Determined automatically " \
        "if not passed."
    parser.add_argument("--vmax", \
                        dest = "vmax", \
                        type = float, \
                        default = None, \
                        required = False, \
                        help = vmax_helpstr)
    
    vmin_helpstr = \
        "Lower limit of the color map. Determined automatically " \
        "if not passed."
    parser.add_argument("--vmin", \
                        dest = "vmin", \
                        type = float, \
                        default = None, \
                        required = False, \
                        help = vmin_helpstr)
    
    vspace_helpstr = \
        "Tick spacing on the color bar. Determined " \
        "automatically if not passed."
    parser.add_argument("--vspace", \
                        dest = "vspace", \
                        type = float, \
                        default = None, \
                        required = False, \
                        help = vspace_helpstr)
    
    center_helpstr = \
        "Center of the color map. Determined automatically " \
        "if not passed."
    parser.add_argument("--center", \
                        dest = "center", \
                        type = float, \
                        default = None, \
                        required = False, \
                        help = center_helpstr)
    
    annot_helpstr = \
        "Annotate the heatmap cells with the " \
        "corresponding ΔΔG scores."
    parser.add_argument("--annot", \
                        dest = "annot", \
                        action = "store_true", \
                        default = False, \
                        help = annot_helpstr)

    annotcolor_default = "black"
    annotcolor_helpstr = \
        "Color of the annotations. Default is " \
        "{:s}.".format(annotcolor_default)
    parser.add_argument("--annotcolor", \
                        dest = "annotcolor", \
                        type = str, \
                        default = annotcolor_default, \
                        required = False, \
                        help = annotcolor_helpstr)
    
    linecolor_helpstr = \
        "Color of the lines delimiting the cells. " \
        "Default is no color."
    parser.add_argument("--linecolor", \
                        dest = "linecolor", \
                        type = str, \
                        default = None, \
                        required = False, \
                        help = linecolor_helpstr)
    
    linewidths_helpstr = \
        "Width of the lines delimiting the cells. " \
        "Default is 0.0 (no line)."
    parser.add_argument("--linewidths", \
                        dest = "linewidths", \
                        type = float, \
                        default = 0.0, \
                        required = False, \
                        help = linewidths_helpstr)
    
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

    # create the dataframe. The index column is 
    # assumed to be the first one, as well as the
    # first row is assumed to be the header.
    df = pd.read_csv(args.infile, \
                     sep = ",", \
                     index_col = 0, \
                     header = 0)

    # plot the heatmap
    plot_stability_saturation_heatmap(\
        df = df, \
        posony = args.posony, \
        outfile = args.outfile, \
        ddgunit = args.ddgunit, \
        cmap = args.cmap, \
        xticklabels = args.xticklabels, \
        vmin = args.vmin, \
        vmax = args.vmax, \
        vspace = args.vspace, \
        center = args.center, \
        annot = args.annot, \
        annotcolor = args.annotcolor, \
        linecolor = args.linecolor, \
        linewidths = args.linewidths, \
        fontpath = args.fontpath, \
        dpi = args.dpi, \
        transparent = args.transparent, \
        axlabelsize = 9, \
        ticklabelsize = 9, \
        cbarlabelsize = 9, \
        annotsize = 4)