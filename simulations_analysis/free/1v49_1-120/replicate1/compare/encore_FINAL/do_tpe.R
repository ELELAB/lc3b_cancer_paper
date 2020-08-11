#!/usr/bin/env Rscript
library(tpe)
args = commandArgs(trailingOnly=TRUE)
write.table(tpe2d(as.dist(read.table(args[1]))), file=paste("space_", args[1], sep=""), col.names=FALSE, row.names=FALSE)
