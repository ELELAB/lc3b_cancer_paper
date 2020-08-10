getwd()
#setwd("/Users/burcu/Desktop/atg8-proteins_lc3b/CS_pred_ppm_exp/ppm_sliced_atoms")
setwd("/data/user/shared_projects/atg8_proteins/md/lc3b/free/1v49/analyses/CS_pred_ppm_exp/ppm_sliced_atoms")

library(stringi)


# get the file names with *dat extension in the folder, 
# the ppm output file bb_predict.dat for each FF were renamed as bb_predict_ff1.dat,bb_predict_ff2.dat ... and put together in the working dir
filelist<-list.files(pattern="dat")

# read the file names with *dat extension for each FF in a loop (for slicing the dat file acc. to atoms)
for (filenumber in 1:length(filelist)) {
  mydata <- read.fwf(filelist[filenumber], skip = 1, widths=c(8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8))


#install.packages("seqinr")
library(seqinr)

library(tools)

# add to the data frame as a new column, 15th column
mydata["AA_1"]<- a(toTitleCase(tolower(trimws(mydata[[2]]))))

mydata_sub<-subset(mydata, select = c(V1, AA_1,V13,V3,V5,V7,V11,V9))


# to clean 999/-999 -> 0. If there was NA or NaN d[is.na(d)] <- 0
mydata_sub$V3 <- replace(as.character(mydata_sub$V3), mydata_sub$V3 == "999", "0")
mydata_sub$V5 <- replace(as.character(mydata_sub$V5), mydata_sub$V5 == "999", "0")
mydata_sub$V5 <- replace(as.character(mydata_sub$V5), mydata_sub$V5 == "-999", "0")
mydata_sub$V7 <- replace(as.character(mydata_sub$V7), mydata_sub$V7 == "999", "0")
mydata_sub$V9 <- replace(as.character(mydata_sub$V9), mydata_sub$V9 == "999", "0")
mydata_sub$V9 <- replace(as.character(mydata_sub$V9), mydata_sub$V9 == "-999", "0")
mydata_sub$V11 <- replace(as.character(mydata_sub$V11), mydata_sub$V11 == "999", "0")
mydata_sub$V13 <- replace(as.character(mydata_sub$V13), mydata_sub$V13 == "999", "0")

## Writing data to file: The server "http://www-mvsoftware.ch.cam.ac.uk/index.php/d2D/d2Drun" requires .txt or another extension 
write.table(mydata_sub, file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"CS_SHIFTY.txt",sep = ""), quote = FALSE, sep = " ", row.names = FALSE, col.names = c("#NUM", "AA", "HA","CA","CB","CO","N","HN"))
}

