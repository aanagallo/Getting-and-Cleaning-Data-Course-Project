#Getting and Cleaning Data Course Project
#Anthony Oliver Jr. A. Nagallo

#Load Libraries
library(data.table)
library(dplyr)
#Set working directory
setwd("./UCI HAR Dataset")
#Read MetaData
FeaturesNames <- read.table("features.txt")
ActivityLabels <- read.table("activity_labels.txt", header = FALSE)
#Read Training data
SubjectTrain <- read.table("train/subject_train.txt", header = FALSE)
ActivityTrain <- read.table("train/y_train.txt", header = FALSE)
FeaturesTrain <- read.table("train/X_train.txt", header = FALSE)
#Read Test Data
SubjectTest <- read.table("test/subject_test.txt", header = FALSE)
ActivityTest <- read.table("test/y_test.txt", header = FALSE)
FeaturesTest <- read.table("test/X_test.txt", header = FALSE)
#Merge training and test 
Subject <- rbind(SubjectTrain, SubjectTest)
Activity <- rbind(ActivityTrain, ActivityTest)
Features <- rbind(FeaturesTrain, FeaturesTest)
#Naming Columns
colnames(Features) <- t(FeaturesNames[2])
#Merge all data 
colnames(Activity) <- "Activity"
colnames(Subject) <- "Subject"
MergeData <- cbind(Features,Activity,Subject)
#Extracting only the measurements on the mean 
#and standard deviation
ColWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(MergeData), ignore.case=TRUE)
ReqCol <- c(ColWithMeanSTD, 562, 563)
ExtractedData <- MergeData[,ReqCol]
#Uses descriptive activity names to name the activities 
#in the data set
ExtractedData$Activity <- as.character(ExtractedData$Activity)
for (i in 1:6){
  ExtractedData$Activity[ExtractedData$Activity == i] <- as.character(ActivityLabels[i,2])
}
ExtractedData$Activity <- as.factor(ExtractedData$Activity)
# Appropriately labels the data set with descriptive variable names
names(ExtractedData)<-gsub("Acc", "Accelerometer", names(ExtractedData))
names(ExtractedData)<-gsub("Gyro", "Gyroscope", names(ExtractedData))
names(ExtractedData)<-gsub("BodyBody", "Body", names(ExtractedData))
names(ExtractedData)<-gsub("Mag", "Magnitude", names(ExtractedData))
names(ExtractedData)<-gsub("^t", "Time", names(ExtractedData))
names(ExtractedData)<-gsub("^f", "Frequency", names(ExtractedData))
names(ExtractedData)<-gsub("tBody", "TimeBody", names(ExtractedData))
names(ExtractedData)<-gsub("-mean()", "Mean", names(ExtractedData), ignore.case = TRUE)
names(ExtractedData)<-gsub("-std()", "STD", names(ExtractedData), ignore.case = TRUE)
names(ExtractedData)<-gsub("-freq()", "Frequency", names(ExtractedData), ignore.case = TRUE)
names(ExtractedData)<-gsub("angle", "Angle", names(ExtractedData))
names(ExtractedData)<-gsub("gravity", "Gravity", names(ExtractedData))
##Create an independent tidy data set with the average of each variable
#for each activity and each subject
ExtractedData$Subject <- as.factor(ExtractedData$Subject)
ExtractedData <- data.table(ExtractedData)
tidyData <- aggregate(. ~Subject + Activity, ExtractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "TidyData.txt", row.names = FALSE)
