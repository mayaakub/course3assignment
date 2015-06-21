CodeBook.md
## describes the variables, the data, and any transformations or 
## work that you performed to clean up the data called CodeBook.md

Tidy data is formatted in a standard way that facilitates exploration and 
analysis and works seamlessly with other tidy data tools. 

Specifically, tidy data satisfies three conditions:

 1) Each variable forms a column
 
 2) Each observation forms a row
 
 3) Each type of observational unit forms a table

Transformation steps:

0. script name is run_analysis.R
1. read the training set with mean and std vars only
2. read the test set with mean and std vars only
3. merge the two sets (append two sets together using rbind
4. group_by the combine dataset by subject and activity variables
5. using summarise function, call mean function for all variable
6. name the varibles accordingly
7. write the clean data set to file tidy-data-set.csv

Description of Varibles:

"subject" - the subject or volunteers from 1 to 30
"activity" - the activities performed 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING

## below variables mean and standard deviation as required from the assignment.  
## Don't expect me to explain each one of them coz I don't know what they means

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
"fBodyBodyGyroJerkMag.std"
