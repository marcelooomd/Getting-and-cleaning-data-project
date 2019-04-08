#INSTALLING AND LOADING THE "RESHAPE2" PACKAGE:
install.packages("reshape2")
library(reshape2)


#DOWNLOAD THE dataframe:
zipfile <- "getdata_dataset.zip"

if (!file.exists(zipfile)) {
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl, zipfile, method="curl")
}

#UNZIP THE FILE:
datapath <- "UCI HAR Dataset"
if (!file.exists(datapath)) {
  unzip(zipfile)
}


#READING THE DATA (features and activity):
feature <- read.table("./UCI HAR Dataset/features.txt")   #list with all of the features
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")   #link between the the class labels and the activity name

#READING THE TRAINING DATA:
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt") #training set (features data)
colnames(x_train) <- feature$V2   #column names
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt") #training labels (activity labels)
x_train$activity <- y_train$V1
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") #each row represents an individual who performed the activity
x_train$subject <- factor(subject_train$V1)

#READING TEST DATA:
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")   #list with the test sets
colnames(x_test) <- feature$V2   #column names
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")   #list with the test labels
x_test$activity <- y_test$V1
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test$subject <- factor(subject_test$V1)


#PART 1 - "Merges the training and the test sets to create one data set":
dataframe <- rbind(x_test, x_train)


#PART 2 - "Extracts only the measurements on the mean and standard deviation for each measurement":
column.names <- colnames(dataframe)

column.names.meansd <- grep("std\\(\\)|mean\\(\\)|activity|subject", column.names, value=TRUE)
dataframe.meansd <- dataframe[, column.names.meansd]


#PART 3 - "Uses descriptive activity names to name the activities in the data set":
dataframe.meansd$activitylabel <- factor(dataframe.meansd$activity, labels= c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))


#PART 4 - "Appropriately labels the data set with descriptive variable names":
features.colnames = grep("std\\(\\)|mean\\(\\)", column.names, value=TRUE)
dataframe.melt <-melt(dataframe.meansd, id = c('activitylabel', 'subject'), measure.vars = features.colnames)
dataframe.tidy <- dcast(dataframe.melt, activitylabel + subject ~ variable, mean)


#PART 5 - "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject":
write.table(dataframe.tidy, file = "tidy_data.txt", row.names = FALSE)