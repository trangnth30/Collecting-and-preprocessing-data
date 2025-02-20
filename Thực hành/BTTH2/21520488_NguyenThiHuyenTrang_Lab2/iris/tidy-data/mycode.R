rm(list=ls())

myFiles <- list.files(path="iris-data/", pattern="iris.data")

file <- read.csv(paste("iris-data/", myFiles, sep=""), sep=",",header = FALSE)
dataset <- file
variables <- c("sepal length", "sepal width", "petal length", "petal width", "class")
s
colnames(dataset) <- variables
write.csv(dataset, file = "iris.csv",row.names = TRUE)

