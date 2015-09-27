# File: run_analysis.R
#
#
setwd("/Users/carsten/Documents/Coursera/Data_Science_Specialization/03_Getting_and_Cleaning_Data/Coursera_Getting_and_Cleaning_Data_Course_Project/")

#
# 1. Merges the training and the test sets to create one data set.
#
trainData <- read.table("./data/train/X_train.txt")
trainLabel <- read.table("./data/train/y_train.txt")
trainSubject <- read.table("./data/train/subject_train.txt")

testData <- read.table("./data/test/X_test.txt")
testLabel <- read.table("./data/test/y_test.txt") 
testSubject <- read.table("./data/test/subject_test.txt")

joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)

#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#
features <- read.table("./data/features.txt")
# creating logicalvector of mean and standard deviation measurements
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
# removing all columns exept meanStdIndices columns
joinData <- joinData[, meanStdIndices]

# tidy column names
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 

#
# 3. Uses descriptive activity names to name the activities in the data set
#
activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))

# replace labels by descriptive activity names
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

#
# 4. Appropriately labels the data set with descriptive variable names. 
#
names(joinSubject) <- "subject"
# combine subject, 
cleanedData <- cbind(joinSubject, joinLabel, joinData)
write.table(cleanedData, "tidy_data.txt")

#
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
subjectLen <- length(table(joinSubject))
activityLen <- dim(activity)[1]
columnLen <- dim(cleanedData)[2]

# prepare result data.frame
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)

# transfer colnames to result
colnames(result) <- colnames(cleanedData)
# start at first row
row <- 1
# iterate through subjects
for(i in 1:subjectLen) {
  # iterate through acitivities
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    isSubject <- i == cleanedData$subject
    isActivity <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[isSubject & isActivity, 3:columnLen])
    row <- row + 1
  }
}
# write dataset to file
write.table(result, "subject_activity_average.txt") 