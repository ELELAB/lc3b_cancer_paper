setwd("/Users/ele/Dropbox (ELELAB)/lc3b_burcu/cancermuts_20181012/")
library(dplyr)
library(tidyr)

#reading cancermuts metatable
metatable_lc3b <- read.csv("metatable.csv", header = TRUE,sep =";")

#subset the metatable to retain only mutations 
mutations_lc3b <- subset(metatable_lc3b, Sources == "COSMIC" | Sources == "cBioPortal" | Sources == "cBioPortal,COSMIC")

#subset the metatabel to retain only the list of mutations
mutations_lc3b_list <- select (mutations_lc3b, Position,WT.residue,Mutated.residue)
mutation_lc3b_list2<- mutations_lc3b_list %>% 

    unite(mutations_lc3b, WT.residue,Position, Mutated.residue, sep = "", remove = FALSE)
class(mutation_lc3b_list2$mutations_lc3b)
mutation_lc3b_list_only <- as.data.frame(mutation_lc3b_list2[,1], drop=FALSE)
write.table(mutation_lc3b_list_only, file="mutation_list.txt", sep=" ",quote=FALSE)
