library(dplyr)
library(magrittr)
rm(list=ls())

if (!file.exists('data')) {
  dir.create('data')
}

link <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(url=link, destfile = 'data/dataset.zip')

unzip('data/dataset.zip', exdir='data/')
data_of_download <- date()

data_path <- "data/UCI HAR Dataset/"

# Merge train and test
## Read features

features <- read.table(paste(data_path, 'features.txt', sep=''), col.names = c('ID', 'Features'), check.names = F)
col_names = features$Features

## Read testset
subject_test <- read.table(paste(data_path, 'test/subject_test.txt', sep=''), col.names = 'Subject')
X_test <- read.table(paste(data_path, 'test/X_test.txt', sep=''), col.names = col_names, check.names = F)
y_test <- read.table(paste(data_path, 'test/y_test.txt', sep=''), col.names = 'Activity')

## Read trainset
subject_train <- read.table(paste(data_path, 'train/subject_train.txt', sep=''), col.names = 'Subject')
X_train <- read.table(paste(data_path, 'train/X_train.txt', sep=''), col.names = col_names, check.names = F)
y_train <- read.table(paste(data_path, 'train/y_train.txt', sep=''), col.names = 'Activity')

## Read activity_labels
activity_labels <- read.table(paste(data_path, 'activity_labels.txt', sep=''), col.names = c('Label', 'Activity'), check.names = F)

## Merge testset and trainset
all_train <- cbind(y_train, subject_train, X_train)
all_test <- cbind(y_test, subject_test, X_test)
all_data <- rbind(all_train, all_test)

# Get mean and Standard deviation
col_mean <- grep('mean\\(\\)', names(all_data), value=T)
col_std <- grep('std\\(\\)', names(all_data), value=T)
mean_and_std_data <- all_data[, c(col_mean, col_std)]

## Re-cbind data
mean_and_std_data <- cbind(all_data[1], all_data[2], mean_and_std_data)

# Rename Activity
mean_and_std_data <- merge(mean_and_std_data, activity_labels, by.x='Activity', by.y='Label')

# Rename columns
pattern <- c('^t', '^f', '-', 'mean\\(\\)', 'std\\(\\)', '-X', '-Y', '-Z', 'AccJerk', 'Acc', 'GyroJerk', 'Gyro', 'Mag')
replacement <- c('Time domain:', 'Frequency domain:', ',', ' mean value', ' standard deviation value', ' on X axis', ' on Y axis', ' on Z axis',
                 ' acceleration jerk', ' accelration', ' angular velocity jerk', ' angular velocity', ' magnitude')
new_col_names <- colnames(mean_and_std_data)
len <- length(pattern)
for (i in 1:len) {
  new_col_names <- sub(pattern[i], replacement[i], new_col_names)
}
colnames(mean_and_std_data) <- new_col_names

# aggregate by Activity and subject
final_data <- aggregate(mean_and_std_data[1:68], by=list(mean_and_std_data$Activity, mean_and_std_data$Subject), mean, na.rm=T)

## Remove columns
final_data <- final_data[, c(3:70)]
final_data <- merge(final_data, activity_labels, by.x='Activity', by.y='Label')
View(final_data)

# Export csv file
write.csv(final_data, 'data/tidy_data.csv', row.names = F)
View(read.csv('data/tidy_data.csv'))
