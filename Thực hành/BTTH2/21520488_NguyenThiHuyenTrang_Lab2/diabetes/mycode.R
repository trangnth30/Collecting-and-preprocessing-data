rm(list=ls())
myFiles <- list.files(path="diabetes-data", pattern="data")
data <- read.csv('diabetes-data/data-01', sep='\t',header = FALSE)

k = TRUE
# Tien hanh doc tung file
for (f in myFiles) {
  if (k==TRUE) {
    file <- read.csv(paste("diabetes-data/", f, sep=""), sep="\t",
                     header = FALSE)
    k = FALSE
  }
  else {
    file <- rbind(file, read.csv(paste("diabetes-data/", f,
                                       sep=""), sep="\t", header = FALSE))
  }
}
dataset <- file
variables <- c("Date", "Time", "Code", "Value")
# Dat ten cho cot trong bo du lieu
colnames(dataset) <- variables
write.csv(dataset, file = "diabetes.csv")

