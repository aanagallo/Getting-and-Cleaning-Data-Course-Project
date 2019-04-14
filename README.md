# Getting-and-Cleaning-Data-Course-Project
This Project is submitted for the partial fulfillment of the course Getting and Cleaning Data Course
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.
The goal is to prepare tidy data that can be used for later analysis.

# The code was written based on the instruction of this assignment
Read training and test dataset into R environment. Read variable names into R envrionment. Read subject index into R environment.

* Merges the training and the test sets to create one data set. Use command rbind to combine training and test set
* Extracts only the measurements on the mean and standard deviation for each measurement. Use grep command to get column indexes for variable name contains "mean()" or "std()"
* Uses descriptive activity names to name the activities in the data set Convert activity labels to characters and add a new column as factor
* Appropriately labels the data set with descriptive variable names. Give the selected descriptive names to variable columns
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. Use pipeline command to create a new tidy dataset with command group_by and summarize_each in dplyr package

## The following files are:
* CodeBook.md <- shows the variables and elements in the tidydata.txt
* tidydata.txt <- shows the result of the code from run_analysis.R
* run_analysis.R <- shows the computation in cleaning data
