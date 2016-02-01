#load libraries#
library(dplyr)
library(plyr)

#check if the dataset has already been downloaded, if not, download it and then unzip the file#
if (!file.exists("UCI HAR Dataset/")){
  message("Downloading data")
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","getdata-projectfiles-UCI HAR Dataset.zip")
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

#read in data#
test.data <- read.table("UCI HAR Dataset/test/X_test.txt")
test.sub <- read.table("UCI HAR Dataset/test/subject_test.txt")
test.act <- read.table("UCI HAR Dataset/test/y_test.txt")
names(test.sub) <- "subject"
test.act <- factor(test.act$V1, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
test <- cbind(test.sub, test.act, test.data)
names(test)[2] <- "activity"
rm(test.data, test.sub, test.act)

#read in training data#
train.data <- read.table("UCI HAR Dataset/train/X_train.txt")
train.sub <- read.table("UCI HAR Dataset/train/subject_train.txt")
train.act <- read.table("UCi HAR Dataset/train/y_train.txt")
names(train.sub) <- "subject"
train.act <- factor(train.act$V1, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
train <- cbind(train.sub, train.act, train.data)
names(train)[2] <- "activity"
rm(train.data, train.sub, train.act)

#merge test and train#
merdatest <- rbind(train, test)


#Extracts only the data columns giving mean or standard deviation values#
dat <- select(merdatest, 1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545)

#name and lable the activities in the data set with appropriate descriptions#
names(dat) <- list("subject", "activity", "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z", "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z", "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", "tBodyAccMag-mean()", "tBodyAccMag-std()", "tGravityAccMag-mean()", "tGravityAccMag-std()", "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()", "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z", "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()")

#create a dataset with the average of each variable for each activity and each subject#
avedat <- ddply(dat, c("subject", "activity"), numcolwise(mean))
write.table(avedat, file="HAR_averages.txt", row.names=FALSE)
