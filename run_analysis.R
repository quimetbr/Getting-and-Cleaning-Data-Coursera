#You should create one R script called run_analysis.R that does the following. 
#  1 - Merges the training and the test sets to create one data set.
#  2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
#  3 - Uses descriptive activity names to name the activities in the data set
#  4 - Appropriately labels the data set with descriptive variable names. 
#  5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# ----------------------------------------------------

#  1 - Merges the training and the test sets to create one data set.
# Define the directory work where i have the originals files
setwd("D:/UOC/Coursera/Getting and Cleaning Data/Course project")

# I load the files for training and test using read.table:
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Now using rbind I merge the files (x_train with x_test, y_train with y_test and subject_train with subject_test)

x_merge <- rbind(x_train, x_test)
y_merge <- rbind(y_train, y_test)
subject_merge <- rbind(subject_train, subject_test)

#  2 - Extracts only the measurements on the mean and standard deviation for each measurement. 

# The merge files have a lot of diferent variables, I need only the variables with mean and standard desviation. 
# The merge files don't have the name of every variable, the name of every variable is V1, V2,... 
# The name of all the 561 variables in the file  "features.txt". 
# To get only the variables with mean (mean in the name of the variable) and 
#   standard (std in the name of the variable) I use the function grep to search this characters in the data.frame "features".
# With the result of the grep function I can subset the variables in merge data for only mean and standard.

features <- read.table("UCI HAR Dataset/features.txt")
only_mean_and_std <- grep("-(mean|std)\\(\\)", features[, 2])

x_merge_only_mean_and_std <- x_merge[, only_mean_and_std]



#  3 - Uses descriptive activity names to name the activities in the data set

# The file y_merge have a number to identify the activity.
# The file activity_labels.txt define what means every number (1 = WALKING, 2 = WALKING_UPSTAIRS,... )
# With thefunction names I change the names of every label in Y_merge (1, 2, 3,...) for the corresponding name (walking, ...)

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
y_merge[, 1] <- activity_labels[y_merge[, 1], 2]


#  4 - Appropriately labels the data set with descriptive variable names. 

# Rename the variable ofy_merge to "activity"
names(y_merge) <- "activity"

# Rename every variable in x_merge for the corresponding name in features.txt
names(x_merge_only_mean_and_std) <- features[only_mean_and_std, 2]

# Rename variable in subject_merge
names(subject_merge) <- "subject"

# rbind all the data for the next step:
all_together <- cbind(x_merge_only_mean_and_std, y_merge, subject_merge)

#  5 - From the data set in step 4, creates a second, independent tidy data set with the 
#      average of each variable for each activity and each subject.

# With the function ddply I can find the average of the variables grouping by subject and activity. 
library(plyr)
average <- ddply(all_together, .(subject, activity), function(x) colMeans(x[, 1:66]))


# I write the average.txt with the result
write.table(average, "average.txt", row.name=FALSE)





