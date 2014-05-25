### Getting and Cleaning Data Course Project

=====================================

This is a guide for the Coursera John Hopkins Data Science Track Course Getting and Cleaning Data project.


### Key Resources

* Article that provides an overview of how data science is helping build better smart wearables [link](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/)
* University of California, Irvine (UCI) Machine Learning Human Activity Recognition Using Smartphones Data Set overview [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* UCI Data Set [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


### Deliverables of the Project

* run_analysis.r - Write R code file called run_analysis.r to upload UCI files from working directory to R, run some data transformation 
* subject_activity_mean_tidy_dat.txt - Create a text file from tidy set from run_analysis.r that provides aggregate means for various variables described in the project spec for each subject and activity groups


### Steps

1. Download raw data from from the University of California, Irvine [website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
2. Examine files

### R Code Specs

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 