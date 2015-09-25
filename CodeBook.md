
ORIGINAL DATA =========================================================================
The following data was downloaded to create the file average.txt:

Name file			Description of the file:
features.txt 			List of all features
x_train.txt			Training set with all the features measured
y_train.txt			Training set with the id of the activity
x_test.txt			Test set with all the features measured	
y_test.txt			Test labels with the id of the activity
subject_train.txt		Each row identifies the subject who performed the activity for each window sample.
subject_test.txt		Each row identifies the subject who performed the activity for each window sample.
actity_levels			Description of every activity


DATA AND TRANSFORMATIONS PERFORMED===================================================
The following data was created during the execution of the script run_analisys.R:

Name file:			Description:
x_merge				This data is the result of the merge with rbind of the x_train and x_test
y_merge				This data is the result of the merge with rbind of the y_train and y_test
subject_merge			This data is the result of the merge of the subject_train and subject_test

only_mean_and_std		This data contains only the features standard and average
x_merge_only_mean_and_std	This data contains only the columns of the x_merge with the standard and average

all_together			This data is the merge of the x_merge_only_mean_and_std, y_merge and subject_merge


FINAL DATA ===========================================================================
The file average.txt contains the average of each variable for each activity and each subject as demanded