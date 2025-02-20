rm(list=ls())

myFiles <- list.files(path="bank-data/", pattern="bank-full.csv")

file <- read.csv(paste("bank-data/", myFiles, sep=""), sep=";", header = FALSE)
variables <-file[c(1),]
colnames(file)<-variables
dataset<-file[-c(1),]
row.names(dataset) <- NULL
write.csv(dataset, file = "bank.csv",row.names = FALSE)
