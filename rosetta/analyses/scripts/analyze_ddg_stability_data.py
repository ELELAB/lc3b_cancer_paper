#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import os.path
import math
import argparse
import warnings
import pandas as pd

def parse_output_ddg_stability(ddgoutfile, \
                               listcontributions, \
                               abstol):
    """Parse the output file of the ΔΔG of stability calculation.

    Parameters
    ----------
    ddgoutfile : `str`
        Path to the output file.

    listcontributions : `list`
        List of energy contributions present in the output file.

    abstol : `float`
        Absolute tolerance to evalutate if the sum of the
        mean contributions to the ΔΔG is within an acceptable
        range from the reported total ΔΔG.

    Returns
    -------
    ddgseries : `pandas.Series`
       ΔΔG score and energy contributions as Pandas Series.
    """

    with open(ddgoutfile, "r") as f:
        wtdgs = []
        mutdgs = []
        for line in f:
            if line.startswith("COMPLEX:"):
                # ddg_stability output
                line = \
                    [item for item in line.strip("\n").split(" ") \
                     if item != ""]
                # WT or MUT
                mutstatus = line[2]
                # total ΔG
                dg = float(line[3])
                # energy contributions
                contributions = [float(item) for item in line[5::2]]
                # store the data in a dictionary
                dgdata = dict(zip(listcontributions, contributions))
                dgdata.update({"ddg" : dg})           
                if mutstatus.startswith("WT"):
                    wtdgs.append(dgdata)
                elif mutstatus.startswith("MUT"):
                    mutdgs.append(dgdata)

        # the protocol must have run the same number
        # of rounds for both WT and MUT
        if len(wtdgs) != len(mutdgs):
            errstr = \
                "The number of rounds run for the wild-type " \
                "structure must be equal to those run for the " \
                "mutant, while the file you provided ({:s}) " \
                "seems to contain {:d} rounds for the wild-type " \
                "and {:d} for the mutant. Please check your run."
            raise ValueError(errstr.format(ddgoutfile, \
                                           len(wtdgs), \
                                           len(mutdgs)))
        # convert data into dataframes
        dfwt = pd.DataFrame(wtdgs)
        dfmut = pd.DataFrame(mutdgs)     
        # The difference between the averages (over the rounds)
        # of each contribution or the total score is computed
        ddgseries = dfmut.mean(axis = 0) - dfwt.mean(axis = 0)
        # evaluate if the sum of the mean energy contributions
        # is within a reasonable range with respect to the mean
        # total score
        sumcontr = ddgseries[listcontributions].sum()
        totalinfile = ddgseries["ddg"]
        iswithintol = \
            math.isclose(a = sumcontr, \
                         b = totalinfile, \
                         abs_tol = abstol)
        # inform the user if the contributions do not sum up
        # to the reported total ΔΔG score
        if not iswithintol:
            warnstr = \
                "The sum of the mean contributions to the ΔΔG " \
                "is different from the mean ΔΔG by more than " \
                "{:f} in {:s}." 
            warnings.warn(warnstr.format(abstol, ddgoutfile))
        # the total score reported will be the one calculated
        # by summing over the energy contributions
        ddgseries["ddg"] = sumcontr
        return ddgseries


def parse_mutlistfile_ddg_stability(mutlistfile):
    """Get the name of the folders with the output files
    from the file containing the list of mutations
    performed (for `ddg_stability` protocols).

    Parameters
    ----------
    mutlistfile : `str`
        Path to the file containing the list of 
        mutations performed.

    Returns
    -------
    `list`
        Name of the folders that should contain the output files.
    """

    return [line.strip("\n") for line in open(mutlistfile, "r")]


if __name__ == "__main__":


    #------------------------ Argument parser ------------------------#

    description = \
        "\nScript to run the analysis of the results provided by " \
        "the Rosetta protocols for the estimation of the ΔΔG of " \
        "stability upon mutation of a monomeric protein.\n"

    # create the argument parser
    parser = argparse.ArgumentParser(description = description)
    group = parser.add_argument_group("Arguments")

    # add arguments to the parser
    m_helpstr = \
        "Name of the file containing the list of mutations " \
        "performed."
    group.add_argument("-m", "--mutlistfile", \
                       type = str, \
                       required = True, \
                       help = m_helpstr)

    d_helpstr = \
        "Name of the file containing ΔΔG data in each mutation " \
        "directory."
    group.add_argument("-d", "--ddgoutfile", \
                       type = str, \
                       required = True, \
                       help = d_helpstr)

    p_helpstr = \
        "Name of the protocol run."
    group.add_argument("-p", "--protocol", \
                       type = str, \
                       required = True, \
                       help = p_helpstr)

    r_helpstr = \
        "Path to the directory where the protocol was run " \
        "(default: current working directory)."
    group.add_argument("-r", "--rundir", \
                       type = str, \
                       required = False, \
                       default = os.getcwd(), \
                       help = r_helpstr)

    o_default = "ddgs.csv"
    o_helpstr = \
        "Name of the file to be written containing the ΔΔGs " \
        "(default: {:s}).".format(o_default)
    group.add_argument("-o", "--outfile", \
                       type = str, \
                       required = False, \
                       default = o_default, \
                       help = o_helpstr)

    # parse the arguments
    args = parser.parse_args()
    rundir = os.path.abspath(args.rundir)
    mutlistfile = os.path.abspath(os.path.join(rundir, args.mutlistfile))
    ddgoutfile = args.ddgoutfile
    protocol = args.protocol
    outfile = args.outfile


    #------------- Conversion factors and contributions --------------#
    
    SCFUNC2CONVFACT = \
        {"park2016_ref2015" : (1.0/2.94), \
         "park2016_talaris2014" : (1.0/1.84)}

    SCFUNC2CONTRIBUTIONS = \
        {"park2016_talaris2014": \
            ["fa_atr", "fa_rep", "fa_sol", "fa_intra_rep", "fa_elec", \
             "hbond_sr_bb", "hbond_lr_bb", "hbond_bb_sc", "hbond_sc", \
             "dslf_fa13", "rama", "omega", "fa_dun", "p_aa_pp", \
             "yhh_planarity", "ref", "cart_bonded"], \
        "park2016_ref2015" : \
            ["fa_atr", "fa_rep", "fa_sol", "fa_intra_rep", \
             "fa_intra_sol_xover4", "lk_ball_wtd", "fa_elec", \
             "hbond_sr_bb", "hbond_lr_bb", "hbond_bb_sc", \
             "hbond_sc", "dslf_fa13", "omega", "fa_dun", "p_aa_pp", \
             "yhh_planarity", "ref", "rama_prepro", "cart_bonded"]}
    

    #--------------------------- Analysis ----------------------------#
    
    # get the names of the single directories (= names of the single
    # mutations)
    dirnames = \
        parse_mutlistfile_ddg_stability(mutlistfile = mutlistfile)
    
    # iterate over the folders to parse the files containing the 
    # scores
    mutwithddg = []
    for dirname in dirnames:
        dirpath = os.path.join(rundir, dirname)
        if os.path.exists(dirpath):
            ddgoutfilepath = os.path.join(dirpath, ddgoutfile)
            if os.path.exists(ddgoutfilepath):
                ddg = \
                    parse_output_ddg_stability(\
                        ddgoutfile = ddgoutfilepath, \
                        listcontributions = SCFUNC2CONTRIBUTIONS[protocol], \
                        abstol = 0.1)
                
                # rescale the ΔΔG scores to kcal/mol. Actual
                # scaling factor are only available if the scoring
                # function used in the protocol was either talaris2014
                # or ref2015. If the scaling factor is 1.0 (no scaling),
                # the score is to be intended in Rosetta Energy Units
                scaledddg = ddg * SCFUNC2CONVFACT[protocol]
                scaledddg.name = dirname
                mutwithddg.append(scaledddg)

    # merge data from different mutations
    df = pd.concat(mutwithddg, axis = 1).transpose()

    # save the dataframe into the output file
    df.to_csv(outfile, sep = ",", float_format = "%.5f")
