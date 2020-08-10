#setwd("/Users/burcu/Desktop/atg8-proteins_lc3b/CS_pred_ppm_exp/ppm_sliced_atoms")
setwd("/data/user/shared_projects/atg8_proteins/md/lc3b/free/1v49/analyses/CS_pred_ppm_exp/ppm_sliced_atoms")

library(stringi)


# get the file names with *dat extension in the folder, 
# the ppm output file bb_predict.dat for each FF were renamed as bb_predict_ff1.dat,bb_predict_ff2.dat ... and put together in the working dir
filelist<-list.files(pattern="dat")

# read the file names with *dat extension for each FF in a loop (for slicing the dat file acc. to atoms)
for (filenumber in 1:length(filelist)) {
  
  mydata <- read.fwf(filelist[filenumber], skip = 0, widths=c(8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8)) 
  

  # slice the data frame according to atoms
  mydata_ca<-subset(mydata, select = c(V1, V2, V3, V4))
  mydata_cb<-subset(mydata, select = c(V1, V2, V5, V6))
  mydata_c<-subset(mydata, select = c(V1, V2, V7, V8))
  mydata_h<-subset(mydata, select = c(V1, V2, V9, V10))
  mydata_n<-subset(mydata, select = c(V1, V2, V11, V12))
  mydata_ha<-subset(mydata, select = c(V1, V2, V13, V14))
  

  
  # write the sliced atom files for each FF in a loop
  write.table(mydata_ca, file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"ca",sep = ""), quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)
  write.table(mydata_cb, file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"cb",sep = ""), quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)
  write.table(mydata_c, file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"c",sep = ""), quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)
  write.table(mydata_h, file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"h",sep = ""), quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)
  write.table(mydata_n, file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"n",sep = ""), quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)
  write.table(mydata_ha, file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"ha",sep = ""), quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)
  
}

#### functions needed ####
# Function that returns Root Mean Squared Error
rmse <- function(error)
{
  sqrt(mean(error^2))
}

# Function that returns Mean Absolute Error
mae <- function(error)
{
  mean(abs(error))
}
##########################

# create empty data frames in the size of (number of FFs) * (number of atom types+1), here 10*7
rmse_df <- data.frame(matrix(ncol = 7, nrow = 10))
names(rmse_df) = c("C", "CA", "CB", "N", "H", "HA","FF")

mae_df <- data.frame(matrix(ncol = 7, nrow = 10))
names(mae_df) = c("C", "CA", "CB", "N", "H", "HA","FF")


# read the file names with *dat extension for each FF in a loop (for error calculation)
for (filenumber in 1:length(filelist)) {

  #### reading sliced data and removing non available CS (i.e. CS=999.000) ###
  C <- read.table(file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"c",sep = ""), header = T)
  C <- as.data.frame(C)
  C.sel<- subset(C, (pre_c!=999.000 & exp_c!=999.000))
  
  CA <- read.table(file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"ca",sep = ""), header = T)
  CA <- as.data.frame(CA)
  CA.sel<- subset(CA, (pre_ca!=999.000 & exp_ca!=999.000))
  
  CB <- read.table(file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"cb",sep = ""), header = T)
  CB <- as.data.frame(CB)
  CB.sel<- subset(CB, (pre_cb!=999.000 & exp_cb!=999.000))
  
  N <- read.table(file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"n",sep = ""), header = T)
  N <- as.data.frame(N)
  N.sel<- subset(N, (pre_n!=999.000 & exp_n!=999.000))
  
  H <- read.table(file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"h",sep = ""), header = T)
  H <- as.data.frame(H)
  H.sel<- subset(H, (pre_h!=999.000 & exp_h!=999.000))
  
  HA <- read.table(file = paste(stri_trim_right(filelist[filenumber], "\\p{P}"),"ha",sep = ""), header = T)
  HA <- as.data.frame(HA)
  HA.sel<- subset(HA, (pre_ha!=999.000 & exp_ha!=999.000))
  
  #calculate error 'experimental - predicted'
  error_c <- C.sel$exp_c - C.sel$pre_c
  error_ca <- CA.sel$exp_ca - CA.sel$pre_ca
  error_cb <- CB.sel$exp_cb - CB.sel$pre_cb
  error_n <- N.sel$exp_n - N.sel$pre_n
  error_h <- H.sel$exp_h - H.sel$pre_h
  error_ha <- HA.sel$exp_ha - HA.sel$pre_ha
  
  
  
  ff=substr(sub("\\.dat", "", filelist[filenumber]),12,30)
  
  rmse_df$FF[filenumber] <- ff
  mae_df$FF[filenumber] <- ff
  
  #rmse and mse
  rmse_df$C[filenumber] <- rmse(error_c) 
  mae_df$C[filenumber] <- mae(error_c)
  
  rmse_df$CA[filenumber] <- rmse(error_ca) 
  mae_df$CA[filenumber] <- mae(error_ca) 
  
  rmse_df$CB[filenumber] <- rmse(error_cb) 
  mae_df$CB[filenumber] <- mae(error_cb)
  
  rmse_df$N[filenumber] <- rmse(error_n) 
  mae_df$N[filenumber] <- mae(error_n)
  
  rmse_df$H[filenumber] <- rmse(error_h) 
  mae_df$H[filenumber] <- mae(error_h)
  
  rmse_df$HA[filenumber] <- rmse(error_ha) 
  mae_df$HA[filenumber] <- mae(error_ha)
  
}


export.tab <- as.matrix(rmse_df)
write.table(export.tab,"rmse_table.txt",quote = FALSE, sep = ";", row.names = FALSE, col.names = TRUE)

export.tab <- as.matrix(mae_df)
write.table(export.tab,"mae_table.txt",quote = FALSE, sep = ";", row.names = FALSE, col.names = TRUE)

