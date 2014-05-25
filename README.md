### Getting and Cleaning Data Course Project

=====================================

This is a guide for the Coursera John Hopkins Data Science Track Course Getting and Cleaning Data project.  


### Project Objectives

* Using data from University of California, Irvine (UCI), learn about wearables technology and how data science is helping improve this technology.
* Put into practice some of the techniques learned in the course using R (downloading raw files, uploading files, transforming data, and analyzing/summarizing data).
* Create a tidy dataset with aggregate analysis and submit to Cousera along with link to Git Hub repo of R code.


### Key Resources

* Article that provides an overview of how data science is helping build better smart wearables [link](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/)
* University of California, Irvine (UCI) Machine Learning Human Activity Recognition Using Smartphones Data Set overview [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* UCI Data Set [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


### Deliverables of the Project

* run_analysis.r - Write R code file called run_analysis.r to upload UCI files from working directory to R, run some data transformation and summarization steps, and create tidy data set of aggregate analysis. 
* subject_activity_mean_tidy_dat.txt - Create a text file from tidy set from run_analysis.r that provides aggregate means for various variables described in the project spec for each subject and activity groups


### Steps

-1. Download raw data from from the University of California, Irvine [website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

-2. Extract zip file to working directory

-3. Read README.txt to get an overview of the file and folder structure.  This is absolutely critical as there are many files and they are broken out in two groups: test and train sets.

(from the README.txt file.  I would suggest following this order in examining the files.)
* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

-4. Figure out data frame naming convention

-5. Write R code to process files, transform data, run analysis, and create needed tidy dataset.

-6. Validate R code and resulting tidy data set deliverable

-7. Push to Git Hub and submit project on Coursera website.


### R Code Specs

(from course website)
You should create one R script called run_analysis.R that does the following. 

-1. Merges the training and the test sets to create one data set.

-2. Extracts only the measurements on the mean and standard deviation for each measurement. 

-3. Uses descriptive activity names to name the activities in the data set

-4. Appropriately labels the data set with descriptive activity names. 

-5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

My implementation:

-1. Upload files from working directory to new data frames.

I generally tried to prefix files with "test_" and "train_" so the files would be grouped together based on the set they belonged to.  This was helpful for me down the road when trying to understand the file contents.  I just used the file names appended to their groups to finish the file naming.

-2. Set column names

The data files themselves do not have headers so we have to use supporting files to understand what the column headers should be.  Refer to README.txt, features.txt, and features_info.txt.

My column name mappings:
* subject_test, subject_train: "subjectid"
* y_test, y_train: "activity"
* X_test, X_train: features.txt
* body_acc_(x, y, z)_test/_train: "bodyaccx1..bodyaccx128" (for x)
* body_gyro_(x, y, z)_test/_train: "bodygyrox1..bodygyrox128" (for x)
* total_acc_(x, y, z)_test/_train: "totalaccx1..totalaccx128" (for x)

The paste function came in real handy to generate sequential labels for the reading files.

-3. Merge training and test sets to create one data set

For this, I created a new variable to track which set the subject came from ("test" or "train") as subjecttype.

* Create separate merged datasets for test and training with the following structure: subjectid, subjecttype, activity, features, and readings from body_acc_x, body_acc_y, body_acc_z, body_gyro_x,body_gyro_y,body_gyro_z,total_acc_x,total_acc_y,total_acc_z
* Create a complete data set using rbind() function to merge test and training sets.

-4. Extracts only the measurements on the mean and standard deviation for each measurement. 

Using grep function to look for column names with "mean()" or "std()", I created a new data set called mean_std_analysis that included subjectid, subjecttype, and activity.

-5. Uses descriptive activity names to name the activities in the data set

For this part, you will need to leverage the activity_labels.txt file that has a mapping of the activity labels integer values to their description.

Here's the mapping:

	1 WALKING
	2 WALKING_UPSTAIRS
	3 WALKING_DOWNSTAIRS
	4 SITTING
	5 STANDING
	6 LAYING

I used a for loop to set a new variable called activitydesc using the mapping above.  I'm sure there is a better way to do this that will yield better performance.

-6.  Appropriately labels the data set with descriptive activity names. 

This part is a bit subjective since this is implementing a style guide.  I used Week 4's first lecture as a guide.

Things I cleaned up:

* Make all variable names lower case: used tolower() function.
* Remove underscores (I generally like underscores though): used gsub() function.
* Remove hyphens: used gsub() function.
* Remove parenthesis: used gsub() function.

This is important since the features.txt has many parenthesis.

* Reorder columns to make cleaner

I wanted to move the new variable activitydesc next to activityid.

-7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

For this, I used the aggregate() function using subjectid and activitydesc as my groups while using mean as the function.

-8. Write out tidy data set to working directory

I created a tab delimited file to the working directory.  It's important to set row.names=FALSE so you don't get the row.names column in the first column of the text file.

-9. Return data frame 

