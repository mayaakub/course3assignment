##
##You will be required to submit: 
##  1) a tidy data set as described below, 
##  2) a link to a Github repository with your script for performing the analysis, and 
##  3) a code book that describes the variables, the data, and any transformations or 
##     work that you performed to clean up the data called CodeBook.md. 
##
##     You should also include a README.md in the repo with your scripts. 
##     This repo explains how all of the scripts work and how they are connected.

## You should create one R script called run_analysis.R that does the following. 
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

library(data.table)
library(dplyr)
library(tidyr)

## Prepare train dataset with mean and std only
x.train <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE, sep="")
y.train <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE, sep="")
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE, sep="")
feature.name <- as.data.frame(read.table("UCI HAR Dataset/features.txt", header=FALSE, sep="")[,2])

names(y.train) <- "activity.label"
names(subject.train) <- "subject"
names(feature.name) <- "feature.name"

## need to provide comment for the values 
new.x <- select(x.train,V1:V6, V41:V46, V81:V86, V121:V126, V161:V166, V201:V202, V214:V215, V227:V228, V240:V241, V253:V254, V266:V271, V345:V350, V424:V429, V503:V504, V516:V517, V529:V530, V542:V543)
names(new.x) <- feature.name[grep("-mean\\()|-std()",feature.name$feature.name),]

new.train <- cbind(subject.train,y.train)

set.name <- as.data.frame(rep("TRAINING",nrow(new.x)))
names(set.name) <- "set.name"

new.train <- cbind(new.train,set.name)

## complete train dataset for mean and std
new.train <- cbind(new.train,new.x)

rm(x.train,y.train,subject.train,new.x,set.name)

## Prepare test dataset with mean and std only
x.test <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE, sep="")
y.test <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE, sep="")
subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE, sep="")
feature.name <- as.data.frame(read.table("UCI HAR Dataset/features.txt", header=FALSE, sep="")[,2])

names(y.test) <- "activity.label"
names(subject.test) <- "subject"
names(feature.name) <- "feature.name"

## need to provide comment for the values 
new.x <- select(x.test,V1:V6, V41:V46, V81:V86, V121:V126, V161:V166, V201:V202, V214:V215, V227:V228, V240:V241, V253:V254, V266:V271, V345:V350, V424:V429, V503:V504, V516:V517, V529:V530, V542:V543)
names(new.x) <- feature.name[grep("-mean\\()|-std()",feature.name$feature.name),]

new.test <- cbind(subject.test,y.test)

set.name <- as.data.frame(rep("TEST",nrow(new.x)))
names(set.name) <- "set.name"

new.test <- cbind(new.test,set.name)

## complete test dataset for mean and std
new.test <- cbind(new.test,new.x)

rm(x.test,y.test,subject.test,new.x,set.name)

combine.ds <- rbind(new.train,new.test)

## lazy to fix code above.  So, this step remove training/test data column category
new.ds <- select(combine.ds,-3)

rm(combine.ds)

by.sub.act.var <- group_by(new.ds,subject,activity.label)

names(by.sub.act.var) <- c(
  "subject",
  "activity",
  "tBodyAcc.mean.X",
  "tBodyAcc.mean.Y",
  "tBodyAcc.mean.Z",
  "tBodyAcc.std.X",
  "tBodyAcc.std.Y",
  "tBodyAcc.std.Z",
  "tGravityAcc.mean.X",
  "tGravityAcc.mean.Y",
  "tGravityAcc.mean.Z",
  "tGravityAcc.std.X",
  "tGravityAcc.std.Y",
  "tGravityAcc.std.Z",
  "tBodyAccJerk.mean.X",
  "tBodyAccJerk.mean.Y",
  "tBodyAccJerk.mean.Z",
  "tBodyAccJerk.std.X",
  "tBodyAccJerk.std.Y",
  "tBodyAccJerk.std.Z",
  "tBodyGyro.mean.X",
  "tBodyGyro.mean.Y",
  "tBodyGyro.mean.Z",
  "tBodyGyro.std.X",
  "tBodyGyro.std.Y",
  "tBodyGyro.std.Z",
  "tBodyGyroJerk.mean.X",
  "tBodyGyroJerk.mean.Y",
  "tBodyGyroJerk.mean.Z",
  "tBodyGyroJerk.std.X",
  "tBodyGyroJerk.std.Y",
  "tBodyGyroJerk.std.Z",
  "tBodyAccMag.mean",
  "tBodyAccMag.std",
  "tGravityAccMag.mean",
  "tGravityAccMag.std",
  "tBodyAccJerkMag.mean",
  "tBodyAccJerkMag.std",
  "tBodyGyroMag.mean",
  "tBodyGyroMag.std",
  "tBodyGyroJerkMag.mean",
  "tBodyGyroJerkMag.std",
  "fBodyAcc.mean.X",
  "fBodyAcc.mean.Y",
  "fBodyAcc.mean.Z",
  "fBodyAcc.std.X",
  "fBodyAcc.std.Y",
  "fBodyAcc.std.Z",
  "fBodyAccJerk.mean.X",
  "fBodyAccJerk.mean.Y",
  "fBodyAccJerk.mean.Z",
  "fBodyAccJerk.std.X",
  "fBodyAccJerk.std.Y",
  "fBodyAccJerk.std.Z",
  "fBodyGyro.mean.X",
  "fBodyGyro.mean.Y",
  "fBodyGyro.mean.Z",
  "fBodyGyro.std.X",
  "fBodyGyro.std.Y",
  "fBodyGyro.std.Z",
  "fBodyAccMag.mean",
  "fBodyAccMag.std",
  "fBodyBodyAccJerkMag.mean",
  "fBodyBodyAccJerkMag.std",
  "fBodyBodyGyroMag.mean",
  "fBodyBodyGyroMag.std",
  "fBodyBodyGyroJerkMag.mean",
  "fBodyBodyGyroJerkMag.std")

clean.ds <- summarise(by.sub.act.var,
                 mean(tBodyAcc.mean.X),
                 mean(tBodyAcc.mean.Y),
                 mean(tBodyAcc.mean.Z),
                 mean(tBodyAcc.std.X),
                 mean(tBodyAcc.std.Y),
                 mean(tBodyAcc.std.Z),
                 mean(tGravityAcc.mean.X),
                 mean(tGravityAcc.mean.Y),
                 mean(tGravityAcc.mean.Z),
                 mean(tGravityAcc.std.X),
                 mean(tGravityAcc.std.Y),
                 mean(tGravityAcc.std.Z),
                 mean(tBodyAccJerk.mean.X),
                 mean(tBodyAccJerk.mean.Y),
                 mean(tBodyAccJerk.mean.Z),
                 mean(tBodyAccJerk.std.X),
                 mean(tBodyAccJerk.std.Y),
                 mean(tBodyAccJerk.std.Z),
                 mean(tBodyGyro.mean.X),
                 mean(tBodyGyro.mean.Y),
                 mean(tBodyGyro.mean.Z),
                 mean(tBodyGyro.std.X),
                 mean(tBodyGyro.std.Y),
                 mean(tBodyGyro.std.Z),
                 mean(tBodyGyroJerk.mean.X),
                 mean(tBodyGyroJerk.mean.Y),
                 mean(tBodyGyroJerk.mean.Z),
                 mean(tBodyGyroJerk.std.X),
                 mean(tBodyGyroJerk.std.Y),
                 mean(tBodyGyroJerk.std.Z),
                 mean(tBodyAccMag.mean),
                 mean(tBodyAccMag.std),
                 mean(tGravityAccMag.mean),
                 mean(tGravityAccMag.std),
                 mean(tBodyAccJerkMag.mean),
                 mean(tBodyAccJerkMag.std),
                 mean(tBodyGyroMag.mean),
                 mean(tBodyGyroMag.std),
                 mean(tBodyGyroJerkMag.mean),
                 mean(tBodyGyroJerkMag.std),
                 mean(fBodyAcc.mean.X),
                 mean(fBodyAcc.mean.Y),
                 mean(fBodyAcc.mean.Z),
                 mean(fBodyAcc.std.X),
                 mean(fBodyAcc.std.Y),
                 mean(fBodyAcc.std.Z),
                 mean(fBodyAccJerk.mean.X),
                 mean(fBodyAccJerk.mean.Y),
                 mean(fBodyAccJerk.mean.Z),
                 mean(fBodyAccJerk.std.X),
                 mean(fBodyAccJerk.std.Y),
                 mean(fBodyAccJerk.std.Z),
                 mean(fBodyGyro.mean.X),
                 mean(fBodyGyro.mean.Y),
                 mean(fBodyGyro.mean.Z),
                 mean(fBodyGyro.std.X),
                 mean(fBodyGyro.std.Y),
                 mean(fBodyGyro.std.Z),
                 mean(fBodyAccMag.mean),
                 mean(fBodyAccMag.std),
                 mean(fBodyBodyAccJerkMag.mean),
                 mean(fBodyBodyAccJerkMag.std),
                 mean(fBodyBodyGyroMag.mean),
                 mean(fBodyBodyGyroMag.std),
                 mean(fBodyBodyGyroJerkMag.mean),
                 mean(fBodyBodyGyroJerkMag.std))

names(clean.ds) <- c(
  "subject",
  "activity",
  "tBodyAcc.mean.X",
  "tBodyAcc.mean.Y",
  "tBodyAcc.mean.Z",
  "tBodyAcc.std.X",
  "tBodyAcc.std.Y",
  "tBodyAcc.std.Z",
  "tGravityAcc.mean.X",
  "tGravityAcc.mean.Y",
  "tGravityAcc.mean.Z",
  "tGravityAcc.std.X",
  "tGravityAcc.std.Y",
  "tGravityAcc.std.Z",
  "tBodyAccJerk.mean.X",
  "tBodyAccJerk.mean.Y",
  "tBodyAccJerk.mean.Z",
  "tBodyAccJerk.std.X",
  "tBodyAccJerk.std.Y",
  "tBodyAccJerk.std.Z",
  "tBodyGyro.mean.X",
  "tBodyGyro.mean.Y",
  "tBodyGyro.mean.Z",
  "tBodyGyro.std.X",
  "tBodyGyro.std.Y",
  "tBodyGyro.std.Z",
  "tBodyGyroJerk.mean.X",
  "tBodyGyroJerk.mean.Y",
  "tBodyGyroJerk.mean.Z",
  "tBodyGyroJerk.std.X",
  "tBodyGyroJerk.std.Y",
  "tBodyGyroJerk.std.Z",
  "tBodyAccMag.mean",
  "tBodyAccMag.std",
  "tGravityAccMag.mean",
  "tGravityAccMag.std",
  "tBodyAccJerkMag.mean",
  "tBodyAccJerkMag.std",
  "tBodyGyroMag.mean",
  "tBodyGyroMag.std",
  "tBodyGyroJerkMag.mean",
  "tBodyGyroJerkMag.std",
  "fBodyAcc.mean.X",
  "fBodyAcc.mean.Y",
  "fBodyAcc.mean.Z",
  "fBodyAcc.std.X",
  "fBodyAcc.std.Y",
  "fBodyAcc.std.Z",
  "fBodyAccJerk.mean.X",
  "fBodyAccJerk.mean.Y",
  "fBodyAccJerk.mean.Z",
  "fBodyAccJerk.std.X",
  "fBodyAccJerk.std.Y",
  "fBodyAccJerk.std.Z",
  "fBodyGyro.mean.X",
  "fBodyGyro.mean.Y",
  "fBodyGyro.mean.Z",
  "fBodyGyro.std.X",
  "fBodyGyro.std.Y",
  "fBodyGyro.std.Z",
  "fBodyAccMag.mean",
  "fBodyAccMag.std",
  "fBodyBodyAccJerkMag.mean",
  "fBodyBodyAccJerkMag.std",
  "fBodyBodyGyroMag.mean",
  "fBodyBodyGyroMag.std",
  "fBodyBodyGyroJerkMag.mean",
  "fBodyBodyGyroJerkMag.std")

write.csv(clean.ds,"tidy-data-set.csv",row.names=FALSE)

