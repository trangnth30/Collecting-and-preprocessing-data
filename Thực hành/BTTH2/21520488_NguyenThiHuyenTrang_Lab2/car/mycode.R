rm(list=ls())

myFiles <- list.files(path="car-data/", pattern="car.data")

file <- read.csv(paste("car-data/", myFiles, sep=""), sep=",",header = FALSE)
dataset <- file
variables <- c("buying", "maint", "doors", "persons","lug_boot","safety", "class")

colnames(dataset) <- variables
write.csv(dataset, file = "car.csv",row.names = TRUE)

