#!/usr/bin/env python
# -*- Mode: python; tab-width: 4; indent-tabs-mode:nil; coding:utf-8 -*-

import re
import argparse
import pandas as pd

def parse_ddg_binding_output(infile, \
                             backrub_steps, \
                             nstruct, \
                             score_function):
    """Parse the output file ("output_result.csv") generated 
     by the analyze_flex_ddG.py script."""
        
    # read the data in a "raw" data frame
    df = pd.read_csv(infile, \
                     index_col = "case_name")
    # set a general query string for the raw dataframe read
    # from the .csv file. All three placeholders are necessary
    # to return one and only one row per case name.
    querystr = \
        "backrub_steps == {:d} & nstruct == {:d} & " \
        "scored_state == 'ddG' & score_function_name == '{:s}'"
    # load and query the dataframe    
    return df.query(querystr.format(backrub_steps, \
                                    nstruct, \
                                    "fa_" + score_function))


def aggregate_saturation_scan(dfs):
    """Aggregate dataframes generated from the outputs
    of a saturation mutagenesis scan.
    """
    
    multiseries = []
    for df in dfs:
        series = df.sum(axis = 1)         
        mutations = series.index.tolist()
        series.index = [mut[-1] for mut in mutations]
        series.name = mutations[0][:-1]
        multiseries.append(series)

    df =  pd.concat(objs = multiseries, axis = 1)
    # add a column containing the residue numbers
    df["sortcol"] = \
        [int(re.search(r"\d+", name).group()) \
         for name in df.index]
    # sort the mutations by residue number and
    # lexicographically
    df.sort_values(by = ["sortcol", "case_name"], inplace = True)
    # drop the sorting column
    df.drop("sortcol", axis = 1, inplace = True)
    # return the dataframe
    return df


def aggregate_single_mutations(dfs):
    """Aggregate dataframes generated from the outputs
    of scans of single mutations.
    """

    # concatenate the single series representing each position 
    # row-wise
    df = pd.concat(objs = dfs, axis = 0).sum(axis = 1).to_frame()
    df.columns = ["scores"]
    # add a column containing the residue numbers
    df["sortcol"] = \
        [int(re.search(r"\d+", name).group()) \
         for name in df.index]
    # sort the mutations by residue number and lexicographically
    df.sort_values(by = ["sortcol", "case_name"], inplace = True)
    # drop the sorting column
    df.drop("sortcol", axis = 1, inplace = True)
    # return the dataframe
    return df


def aggregate_multiple_systems(dfs, sysnames):
    """Aggregate dataframes generated from the outputs of scans
    including the same set of mutations for different systems.
    """

    multiseries = [df.sum(axis = 1) for df in dfs]
    df = pd.concat(objs = multiseries, axis = 1)
    # add a column containing the residue numbers
    df["sortcol"] = \
        [int(re.search(r"\d+", name).group()) \
         for name in df.index]
    # sort the mutations by residue number and 
    # lexicographically
    df.sort_values(by = "sortcol", inplace = True)
    # drop the sorting column
    df.drop("sortcol", axis = 1, inplace = True)
    if sysnames is not None:
        df.columns = sysnames
    return df


def aggregate_contributions(dfs):
    """Aggregate dataframes containing energy contributions.
    """

    # concatenate the dataframes representing each position 
    # row-wise
    df = pd.concat(objs = dfs, axis = 0)
    # add a column containing the residue numbers
    df["sortcol"] = \
        [int(re.search(r"\d+", name).group()) \
         for name in df.index]
    # sort the mutations by residue number and lexicographically
    df.sort_values(by = ["sortcol", "case_name"], inplace = True)
    # drop the sorting column
    df.drop("sortcol", axis = 1, inplace = True)
    return df

    

if __name__ == "__main__":

    # create an argument parser
    parser = argparse.ArgumentParser()
    
    # add arguments to the parser
    i_helpstr = "Input files."
    parser.add_argument("-i", \
                        dest = "infiles", \
                        type = str, \
                        required = True, \
                        nargs = "+", \
                        help = i_helpstr)
    
    o_helpstr = "Output file containing the dataframe."
    parser.add_argument("-o", \
                        dest = "outfile", \
                        type = str, \
                        required = True, \
                        help = o_helpstr)

    m_choices = \
        ["saturation_scan", "single_mutations", \
         "multiple_systems", "contributions"]
    m_helpstr = \
        "Output data mode. If 'saturation_scan', it will be a " \
        "2D matrix where rows represent sequence positions and " \
        "columns represent mutations. If 'single_mutations' or " \
        "'contributions' it will be a dataframe where each row " \
        "represents a single mutation for a position and columns " \
        "are either the total score or the single contributions. If " \
        "'multiple_systems', it is assumed that the same set of " \
        "mutations was run for multiple systems, and the output " \
        "will be a dataframe where rows represent the system and " \
        "columns represent the mutations."
    parser.add_argument("-m", "--mode", \
                        dest = "mode", \
                        type = str, \
                        choices = m_choices, \
                        required = True, \
                        help = m_helpstr)

    sysnames_helpstr = \
        "Names of the systems for which the same set of mutations " \
        "was performed. The order should correspond to that of the " \
        "input files. Only used when 'multiple_systems' is " \
        "passed to -m."
    parser.add_argument("--sysnames", \
                        dest = "sysnames", \
                        type = str, \
                        default = None, \
                        required = False, \
                        nargs = "+", 
                        help = sysnames_helpstr)

    backrub_steps_default = 25
    backrub_steps_helpstr = \
        "Number of backrub steps used to generate each of the " \
        "structures in the ensemble considered (ΔΔG values of " \
        "structures at different steps are usually present in " \
        "the Flex ddG output file). Default: {:d}."
    parser.add_argument("--backrub-steps", \
                        dest = "backrub_steps", \
                        type = int, \
                        required = False, \
                        default = backrub_steps_default, \
                        help = backrub_steps_helpstr.format(\
                                backrub_steps_default))

    nstruct_default = 35
    nstruct_helpstr = \
        "Number of structures from the Flex ddG backrub ensemble " \
        "on which the final ΔΔG value has been averaged (multiple " \
        "averages on different numbers of structures are usually " \
        "present in the Flex ddG output file). Default: {:d}."
    parser.add_argument("--nstruct", \
                        dest = "nstruct", \
                        type = int, \
                        required = False, \
                        default = nstruct_default, \
                        help = nstruct_helpstr.format(nstruct_default))
    
    score_function_helpstr = \
        "Scoring function used when running any Rosetta protocol. " \
        "Will be used only if --convert is supplied or " \
        "'contributions' is supplied to -m."
    parser.add_argument("--score-function", \
                        dest = "score_function", \
                        type = str, \
                        required = True, \
                        default = None, \
                        help = score_function_helpstr)

    convert_helpstr = \
        "Whether to convert REU values to kcal/mol using scoring " \
        "function-specific conversion factors."
    parser.add_argument("--convert", \
                        dest = "convert", \
                        action = "store_true", \
                        default = False, \
                        help = convert_helpstr)

    sep_default = ","
    sep_helpstr = \
        "Field separator in the output dataframe. Default is {:s}."
    parser.add_argument("--sep", \
                        dest = "sep", \
                        type = str, \
                        required = False, \
                        default = sep_default, \
                        help = sep_helpstr.format(sep_default))

    float_format_default = r"%3.2f"
    float_format_helpstr = \
        "Format for floating point numbers in the output dataframe. " \
        "Default is {:s}."
    parser.add_argument("--float-format", \
                        dest = "float_format", \
                        type = str, \
                        required = False, \
                        default = float_format_default, \
                        help = float_format_helpstr.format(\
                                float_format_default))

    # parse the arguments
    args = parser.parse_args()
    infiles = args.infiles
    outfile = args.outfile
    mode = args.mode
    sysnames = args.sysnames
    backrub_steps = args.backrub_steps
    nstruct = args.nstruct
    score_function = args.score_function
    convert = args.convert
    sep = args.sep
    float_format = args.float_format

    # available conversion factors for Rosetta scoring functions
    SCFUNC2CONVFACT = \
        {"talaris2014" : (1.0/1.84), \
         "ref2015" : (1.0/2.94)}

    # energy contributions to the score
    SCFUNC2CONTRIBUTIONS = \
        {"talaris2014" : \
            ["fa_atr", "fa_elec", "fa_rep", "fa_sol", \
             "hbond_bb_sc", "hbond_lr_bb", "hbond_sc"], \
         "ref2015" : \
            ["fa_atr", "fa_elec", "fa_rep", "fa_sol", \
             "hbond_bb_sc", "hbond_lr_bb", "hbond_sc"]}

    # generate the dataframes
    contributions = SCFUNC2CONTRIBUTIONS[score_function]
    dfs = \
        [parse_ddg_binding_output(\
            infile = infile, \
            backrub_steps = backrub_steps, \
            nstruct = nstruct, \
            score_function = score_function)[contributions] \
         for infile in infiles]
    
    # convert the scores according to the scoring
    # function-specific rescaling factors, if requested
    if convert:
        dfs = [df*SCFUNC2CONVFACT[score_function] for df in dfs]
    
    # select the output data mode
    if mode == "saturation_scan":
        df = aggregate_saturation_scan(dfs = dfs)
    elif mode == "single_mutations":
        df = aggregate_single_mutations(dfs = dfs)
    elif mode == "multiple_systems":
        df = aggregate_multiple_systems(dfs = dfs, \
                                        sysnames = sysnames)
    elif mode == "contributions":
        df = aggregate_contributions(dfs = dfs)

    # save the final dataframe to the output file
    df.to_csv(outfile, \
              sep = sep, \
              float_format = float_format)
