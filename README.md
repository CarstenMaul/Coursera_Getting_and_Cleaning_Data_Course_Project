# Getting and Cleaning Data Course Project with Peer Assessment

This project will analyse activity data from the Human Activity Recognition Using Smartphones Data Set  
  
## Prerequisites
Please download and unzip the needed zip file containing the data filesto a directory "data" in the repro directory:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* the data files must be directly in the "data" directory!

## Performing the analysis
* run source("run_analysis.R") in RStudio
* the script will create two data files:
 1. The file "tidy_data.txt" containing the cleaned data
 2. The file "subject_activity_average.txt" containing the average of each variable for each activity and each subject
