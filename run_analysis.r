run_analysis <- function() {

##  1. Upload files from working directory

test_x <- read.table("X_test.txt")
test_y <- read.table("y_test.txt")
test_subject <- read.table("subject_test.txt")

test_body_acc_x <- read.table("body_acc_x_test.txt")
test_body_acc_y <- read.table("body_acc_y_test.txt")
test_body_acc_z <- read.table("body_acc_z_test.txt")
test_body_gyro_x <- read.table("body_gyro_x_test.txt")
test_body_gyro_y <- read.table("body_gyro_y_test.txt")
test_body_gyro_z <- read.table("body_gyro_z_test.txt")
test_total_acc_x <- read.table("total_acc_x_test.txt")
test_total_acc_y <- read.table("total_acc_y_test.txt")
test_total_acc_z <- read.table("total_acc_z_test.txt")

train_x <- read.table("X_train.txt")
train_y <- read.table("y_train.txt")
train_subject <- read.table("subject_train.txt")

train_body_acc_x <- read.table("body_acc_x_train.txt")
train_body_acc_y <- read.table("body_acc_y_train.txt")
train_body_acc_z <- read.table("body_acc_z_train.txt")
train_body_gyro_x <- read.table("body_gyro_x_train.txt")
train_body_gyro_y <- read.table("body_gyro_y_train.txt")
train_body_gyro_z <- read.table("body_gyro_z_train.txt")
train_total_acc_x <- read.table("total_acc_x_train.txt")
train_total_acc_y <- read.table("total_acc_y_train.txt")
train_total_acc_z <- read.table("total_acc_z_train.txt")

features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

##  2. Set Variable Names

names(test_subject) = c("subjectid")
names(train_subject) = c("subjectid")
names(test_y) = c("activity")
names(train_y) = c("activity")

colnames(train_x) = as.character(features[,2])
colnames(test_x) = as.character(features[,2])

colnames(train_body_acc_x) = paste("bodyaccx", 1:128, sep="")
colnames(train_body_acc_y) = paste("bodyaccy", 1:128, sep="")
colnames(train_body_acc_z) = paste("bodyaccz", 1:128, sep="")

colnames(train_body_gyro_x) = paste("bodygyrox", 1:128, sep="")
colnames(train_body_gyro_y) = paste("bodygyroy", 1:128, sep="")
colnames(train_body_gyro_z) = paste("bodygyroz", 1:128, sep="")

colnames(train_total_acc_x) = paste("totalaccx", 1:128, sep="")
colnames(train_total_acc_y) = paste("totalaccy", 1:128, sep="")
colnames(train_total_acc_z) = paste("totalaccz", 1:128, sep="")

colnames(test_body_acc_x) = paste("bodyaccx", 1:128, sep="")
colnames(test_body_acc_y) = paste("bodyaccy", 1:128, sep="")
colnames(test_body_acc_z) = paste("bodyaccz", 1:128, sep="")

colnames(test_body_gyro_x) = paste("bodygyrox", 1:128, sep="")
colnames(test_body_gyro_y) = paste("bodygyroy", 1:128, sep="")
colnames(test_body_gyro_z) = paste("bodygyroz", 1:128, sep="")

colnames(test_total_acc_x) = paste("totalaccx", 1:128, sep="")
colnames(test_total_acc_y) = paste("totalaccy", 1:128, sep="")
colnames(test_total_acc_z) = paste("totalaccz", 1:128, sep="")

##  3. Merge the training and the test sets to create one data set.

## create new variable called subjecttype so we know which group the subject belongs to

test_set = cbind(test_subject,"test",test_y,test_x,test_body_acc_x,test_body_acc_y,test_body_acc_z,test_body_gyro_x,test_body_gyro_y,test_body_gyro_z,test_total_acc_x,test_total_acc_y,test_total_acc_z)
train_set = cbind(train_subject,"train",train_y,train_x,train_body_acc_x,train_body_acc_y,train_body_acc_z,train_body_gyro_x,train_body_gyro_y,train_body_gyro_z,train_total_acc_x,train_total_acc_y,train_total_acc_z)

names(test_set)[2] = "subjecttype"
names(train_set)[2] = "subjecttype"

complete_set = rbind(train_set, test_set)

##  4. Extracts only the measurements on the mean and standard deviation for each measurement. 


mean_std_analysis = complete_set[,c("subjectid","subjecttype","activity",grep("mean()",features[,2],value=TRUE, fixed=TRUE),grep("std()",features[,2],value=TRUE, fixed=TRUE))]

##  5. Uses descriptive activity names to name the activities in the data set

## create new column that will describe the activity by subject based on activityid

mean_std_analysis = cbind(mean_std_analysis[,1:69],1)

colnames(mean_std_analysis)[70]="activitydesc"

for (i in 1:length(mean_std_analysis[,1])) {

	if (mean_std_analysis[i,3]==1) { 
		mean_std_analysis[i,70]="WALKING"
	} else if (mean_std_analysis[i,3]==2) { 
		mean_std_analysis[i,70]="WALKING_UPSTAIRS"
	} else if (mean_std_analysis[i,3]==3) { 
		mean_std_analysis[i,70]="WALKING_DOWNSTAIRS"
	} else if (mean_std_analysis[i,3]==4) { 
		mean_std_analysis[i,70]="SITTING"
	} else if (mean_std_analysis[i,3]==5) { 
		mean_std_analysis[i,70]="STANDING"
	} else if (mean_std_analysis[i,3]==6) { 
		mean_std_analysis[i,70]="LAYING"
	} 
}



##  6. Appropriately labels the data set with descriptive activity names. 


	## a. lower case

	clean_names = tolower(names(mean_std_analysis))

	## b. remove underscores

	clean_names =gsub("_","",clean_names,)

	## c. remove hyphens
	
	clean_names =gsub("-","",clean_names,) 

	## d. remove parenthesis

	clean_names =gsub("\\(","",clean_names,) 
	clean_names =gsub("\\)","",clean_names,) 
	
	## update column names
	names(mean_std_analysis) = clean_names

	## reorder columns to clean things up.
	mean_std_analysis = cbind(mean_std_analysis[,c(1:3,70,4:69)])


##  7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

	agg_data <-aggregate(mean_std_analysis, by=list(mean_std_analysis$subjectid,mean_std_analysis$activitydesc), FUN=mean, na.rm=TRUE)

	agg_data=agg_data[c(1,5,2,7:72)]

	colnames(agg_data)[1] = "subjectid"
	colnames(agg_data)[2] = "activityid"
	colnames(agg_data)[3] = "activitydesc"
	
	agg_data = agg_data[order(agg_data$subjectid,agg_data$activityid),]


## 8. Write out tidy data set to working directory

	write.table(agg_data, "subject_activity_mean_tiday_data.txt", sep="\t",row.names=FALSE)

## 9. Return data frame 

	return(agg_data)

}

