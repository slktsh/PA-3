## Course Project / Getting and Cleaning the Data
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following. 

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###The content of this repo
1. README.md (this file)
2. CodeBook.md - the description of the raw and tidy data and the transformation that were performed
3. run_analysis.R - the script that performs the transformation

The data should be unzipped into the working directory.
The explanations of how the script "run_analysis.R" works can be found inside the script file as commentaries and CodeBook.md file. 
The description of the variables, the data, and the transformations or work performed to clean up the data are in the file CodeBook.md.

#### Script
The test and the training sets were imported from the unzipped data and merged. (Step 1)
The index file was created to exclude the variables with the names not contatining "std" or "mean" for standart deviation and mean values respectively. (Step 2)

The activity labels were transformed from 1-6 to the descriptive ones: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS. (Step 3)

The variable names were changed to the more decriptive one in the following way: 
t -> TimeDomain
f -> FrequncyDomain
Acc -> Acceleration
Mag -> Magnitude
GyroJerk -> AngularAcceleration
Gyro -> AngularSpeed 
etc.
the parenthesis were removed
This completes the Step 4 to give tbl_s4 (intermediate data set required by the Step 4)

The obtained data set was grouped by the subject and activity and the mean values of the variables for each group were calculated. The variables in final data set (tbl_s5) were given the new names by the addition of "Mean" in the beginning of each column name.
This completes the Step 5.

The code to view the resulting tidy data file is 

data <- read.table(file_path, header = TRUE)
View(data)
