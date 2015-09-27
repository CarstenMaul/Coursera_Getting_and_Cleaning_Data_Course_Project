# CodeBook for Coursera Getting and Cleaning Data Course Project

* Source of data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* Data used: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Description of run_analyses.R data processing steps:
 1. Merges the training and the test sets to create one data set  
 1.1 Reading "train" data: "X_train.txt" -> trainData table, "y_train.txt" -> trainLabel table, "subject_train.txt" -> trainSubject table
 1.2 Reading "test" data: "X_test.txt" -> testData, "y_test.txt" -> testLabel table, "subject_test.txt" table -> testSubject table
 1.3 Combine the data sets from "train" and "test":  
     trainData and testData to joinData  
     trainLabel and testLabel to joinLabel  
     trainSubject and testSubject to joinSubject  
 2. Extracting only the measurements on the mean and standard deviation for each measurement  
 2.1 Reading features.txt file to features table  
 2.2 Getting mean and standard deviation measurements columns to logical vector meanStdIndices  
 2.3 Applying logical vector meanStdIndices of mean and standard deviation measurements columns joinData to remove all uneeded data columns  
 2.4 Tidy column names of joinData  
 3. Apply descriptive activity names activities in the data set  
 3.1 Reading activity_labels.txt to activity table  
 3.2 tidy the activity names and store them to activityLabel, apply to joinLabel  
 4. Apply descriptive names to data  
 4.1 Merging descriptive names, subjects and data to table cleanedData  
 4.2 Write tidy data to "tidy_data.txt"  
 5. Create tidy data set with the average of each variable for each activity and each subject  
 5.1 Create data frame "result"
 5.1 For each subject (iterate by subjectLen) and each activity (iterate by activityLen) calculate the mean by processing cleanedData table
 5.2 Write data to file "subject_activity_average.txt"
  
