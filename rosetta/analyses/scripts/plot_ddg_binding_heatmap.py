#!/usr/bin/env python
# -*- Mode: python; tab-width: 4; indent-tabs-mode:nil; coding:utf-8 -*-

import argparse
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import matplotlib.font_manager as fm
import seaborn as sns
import pandas as pd

def plot_ddg_binding_heatmap(df, \
                             outfile, \
                             cmap, \
                             sysnames,
                             ddgunit, \
                             vmax, \
                             vmin, \
                             vspace, \
                             center, \
                             annot, \
                             annotcolor, \
                             linecolor, \
                             linewidths, \
                             fontpath, \
                             dpi, \
                             transparent, \
                             axlabelsize, \
                             ticklabelsize, \
                             cbarlabelsize, \
                             annotsize):
    """Plot scores from ΔΔG of binding scans as a heatmap. 
    """

    # close any current figure window
    plt.close()
    # get the color map
    cmap = plt.get_cmap(cmap)

    #-------------------------- Input data ---------------------------#

    # get score and case names
    scores = df.to_numpy()
    casenames = df.index

    #------------------------- Font settings -------------------------#

    # set font properties
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
    absmax = abs(np.ceil(np.amax(scores)*2)/2)
    absmin = abs(np.floor(np.amin(scores)*2)/2)
    absval = absmax if absmax > absmin else absmin
    vmax = vmax if vmax is not None else absval
    vmin = vmin if vmin is not None else -absval
    # center of the color map
    center = (vmax + vmin)/2 if center is not None else center
    
    if vspace is not None:
        cbar_ticks = np.arange(vmin, \
                               vmax + vspace, \
                               vspace)
    else:
        cbar_ticks = np.linspace(vmin, vmax, 10)
        vspace = cbar_ticks[1] - cbar_ticks[0]

    #-------------------------- Annotations --------------------------#

    # if no annotation is required, leave the dictionary
    # for the annotation properties empty
    annot_kws = {}
    if annot:
        # shorten the scores to only two decimals to
        # save space
        annot_transform = np.vectorize(lambda x : round(x, 2))
        annot = annot_transform(scores.transpose())     
        annot_kws = dict(color = annotcolor, 
                         fontproperties = fp_annot)

    #-------------------- Create figure and axes ---------------------#

    # plot the heatmap without the colorbar
    # fmt = g so that it does not display big numbers
    # in scientific notation
    scores_toplot = \
        scores.transpose() if scores.shape[1] != 1 else [scores]
    ax = sns.heatmap(data = scores_toplot, \
                     mask = np.isnan(scores_toplot), \
                     square = True, \
                     cbar = False, \
                     cmap = cmap, \
                     vmin = vmin, \
                     vmax = vmax, \
                     center = center, \
                     linecolor = linecolor, 
                     linewidths = linewidths, \
                     annot = annot, \
                     annot_kws = annot_kws, \
                     fmt = "g")
    
    # for each cell whose value is NaN
    for nan_cell in np.argwhere(np.isnan(scores)):
        # get the indexes of the NaN cell
        x, y = nan_cell
        ax.add_patch(\
            mpatches.Rectangle(xy = (x,y), \
                               width = 1, \
                               height = 1, \
                               fill = False, \
                               linewidth = 0, \
                               hatch = "////////", \
                               color = "gray"))

    #--------------------------- Color bar ---------------------------#

    # plot the colorbar from the matplotlib interface
    # in order to have more control over it
    cbar_label = u"ΔΔG ({:s})".format(ddgunit)
    cbar = plt.colorbar(mappable = ax.get_children()[0], \
                        extend = "both", \
                        orientation = "horizontal")
    # set colorbar ticks and ticks labels
    cbar.set_ticks(cbar_ticks)
    cbar.ax.set_xticklabels(labels = cbar_ticks, \
                            fontproperties = fp_ticklabels)
    cbar.set_label(label = cbar_label, \
                   fontproperties = fp_cbar)

    #------------------------- X- and Y-axis -------------------------#

    # hide ticks but preserve tick labels for both axes
    ax.tick_params(axis = "both", \
                   which = "both", \
                   length = 0)
    # set X-axis tick labels
    ax.set_xticklabels(labels = casenames, \
                       rotation = 90, \
                       fontproperties = fp_ticklabels)
    # set custom labels for the Y axis ticks if provided by the user
    yticklabels = \
        sysnames if sysnames is not None else ax.get_yticklabels()
    # set Y-axis tick labels
    ax.set_yticklabels(labels = yticklabels, \
                       rotation = 0, \
                       fontproperties = fp_ticklabels)

    #------------------------ Save the figure ------------------------#
    
    # save the figure
    plt.savefig(fname = outfile, \
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
    
    cmap_default = "BrBg_r"
    cmap_helpstr = \
        "Matplotlib color map. Default: {:s}.".format(cmap_default)
    parser.add_argument("--cmap", \
                        dest = "cmap", \
                        type = str, \
                        default = cmap_default, \
                        required = False, \
                        help = cmap_helpstr)

    sysnames_helpstr = \
        "Name of the systems for which the same set of " \
        "mutations was run."
    parser.add_argument("--sysnames", \
                        dest = "sysnames", \
                        type = str, \
                        default = None, \
                        required = False, \
                        nargs = "+", \
                        help = sysnames_helpstr)

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
                        required = False)
    
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

    args = parser.parse_args()

    # read the scores as a dataframe from the input file
    df = pd.read_csv(args.infile, sep = ",", index_col = 0)

    # plot the heatmap
    plot_ddg_binding_heatmap(df = df, \
                             outfile = args.outfile, \
                             cmap = args.cmap, \
                             sysnames = args.sysnames, \
                             ddgunit = args.ddgunit, \
                             vmax = args.vmax, \
                             vmin = args.vmin, \
                             vspace = args.vspace, \
                             center = args.center, \
                             annot = args.annot, \
                             annotcolor = args.annotcolor, \
                             linecolor = args.linecolor, \
                             linewidths = args.linewidths, \
                             fontpath = args.fontpath, \
                             dpi = args.dpi, \
                             transparent = args.transparent, \
                             axlabelsize = 11, \
                             ticklabelsize = 5.5, \
                             cbarlabelsize = 9, \
                             annotsize = 5)
