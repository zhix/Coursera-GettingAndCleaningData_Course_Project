library(reshape2)

#clean up workspace and set working dir
rm(list=ls())
setwd('C:/Users/User/Dropbox/Personal/Coursera/DataScience/3_GettingAndCleaningData/Course_Project/UCI HAR Dataset/')


#1) Merges the training and the test sets to create one data set.
testSubject <- read.table("test/subject_test.txt")
testLabel <- read.table("test/y_test.txt")
testFeat <- read.table("test/X_test.txt")

trainSubject <- read.table("train/subject_train.txt")
trainLabel <- read.table("train/y_train.txt")
trainFeat <- read.table("train/X_train.txt")

mainDat1 <- cbind(testSubject, testLabel, testFeat)
mainDat2 <- cbind(trainSubject, trainLabel, trainFeat)
mainDat <- rbind(mainDat1, mainDat2)


#2) Extracts only the measurements on the mean and standard deviation for each measurement.
##storing "activity" factors as characters in a new (third) column in feat dataset.
feat <- read.table("features.txt")
for (i in 1:nrow(feat)) {
  feat[i,3] <- as.character(feat[i,2])
}

##find the corresponding row num (in feat) and col num (in mainDat) embedding the mean and std measures
rownum_mean <- grep("mean()",feat[,3])
colnum_mean <- rownum_mean + 2

rownum_std <- grep("std()",feat[,3])
colnum_std <- rownum_std + 2

#Combining data into file
meanDat <- mainDat[,colnum_mean]
stdDat <- mainDat[,colnum_std]
mainDat <- cbind(mainDat[,1:2], meanDat, stdDat)


#3) Uses descriptive activity names to name the activities in the data set
##Labeling the columns (column names)
colnames(mainDat) <- c("subject", "activity", feat[rownum_mean,3],feat[rownum_std,3])

##mapping Labels according to the "activity_labels.txt" file
mapLabel <- read.table("activity_labels.txt")

for (i in 1:nrow(mapLabel)) {
  mainDat$activity[mainDat$activity == i] <- as.character(mapLabel[i,2])
}


#4) Appropriately labels the data set with descriptive variable names. 
##Cleaning up column names
colName <- colnames(mainDat)
colName <- gsub("\\()", "",colName)
colName <- gsub("-std", "_StdDev",colName)
colName <- gsub("-mean", "_Mean",colName)
colName <- gsub("^(f)", "freq_",colName)
colName <- gsub("^(t)", "time_",colName)
colnames(mainDat) <- colName


#5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- melt(mainDat, id.vars=c("subject", "activity"))
tidyData <- dcast(tidyData, subject + activity ~ variable, mean)

#write tidyData into text file
write.table(tidyData, "../tidyData.txt", row.name=FALSE)