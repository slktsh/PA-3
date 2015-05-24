path.expand("~/")
test<-read.table("~/UCI HAR Dataset/test/X_test.txt") # reads the test set
train<-read.table("~/UCI HAR Dataset/train/X_train.txt") # reads the traning set
data<-rbind(test, train) # merges both sets together
subject_test<- read.table("~/UCI HAR Dataset/test/subject_test.txt") # reads subject id's for the test set
subject_train<- read.table("~/UCI HAR Dataset/train/subject_train.txt") # reads subject id's for the training set
subject<- rbind(subject_test, subject_train) # merges both sets together

act_test<-read.table("~/UCI HAR Dataset/test/y_test.txt") #reads activities for the test set
act_train<-read.table("~/UCI HAR Dataset/train/y_train.txt") #reads activities for the training set
act<- rbind (act_test, act_train) # merges both sets together

##on this stage we should leave the columns containing "mean" or "std" only,
##then add subject and activity label columns and the appropriate names 

features<-read.table("~/UCI HAR Dataset/features.txt")
names_all<-as.vector(features[,2])

index_mean<- grep("mean", names_all, ignore.case = TRUE) 
## an integer vector with the indices of the elements, containing "mean" case-insensitive
names_mean<- grep("mean", names_all, ignore.case = TRUE, value=TRUE) 
## a character vector with the names of the variables containing "mean" case-insensitive
index_std<- grep("std", names_all, ignore.case = TRUE)
## an integer vector with indices of the elements, containing "std" case-insensitive
names_std<- grep("std", names_all, ignore.case = TRUE, value=TRUE)
## a character vector with the names of the variables containing "std" case-insensitive


index<-c(index_mean, index_std) # a combined index for the columns, containing "mean" or "std" in their names
names<-c("subject", "activity", names_mean, names_std) # the same for the names
data<-data[index] # only the columns, containing "mean" or "std" in their names are left

# here we should modify the names vector using the descriptive and more readable variable names
names <- gsub('\\(|\\)',"", names, perl = TRUE)
names <- gsub('Acc',"Acceleration",names)
names <- gsub('GyroJerk',"AngularAcceleration",names)
names <- gsub('Gyro',"AngularSpeed",names)
names <- gsub('Mag',"Magnitude",names)
names <- gsub('^t',"TimeDomain.",names)
names <- gsub('^f',"FrequencyDomain.",names)
names <- gsub('\\.mean',".Mean",names)
names <- gsub('\\.std',".StandardDeviation",names)
names <- gsub('Freq\\.',"Frequency.",names)
names <- gsub('Freq$',"Frequency",names)

act_vect<- act[ ,1] # activities vector
act_vect<- as.vector(act_vect) # activities vector of integers
act_vect<- as.character(act_vect) # activities vector of characters

act_vect<-gsub("1", "WALKING", act_vect)  ## changes 1-6 labels for the activities to the descriptive ones
act_vect<-gsub("2", "WALKING_UPSTAIRS", act_vect)
act_vect<-gsub("3", "WALKING_DOWNSTAIRS", act_vect)
act_vect<-gsub("4", "SITTING", act_vect)
act_vect<-gsub("5", "STANDING", act_vect)
act_vect<-gsub("6", "LAYING", act_vect)

data<- cbind(subject, act_vect, data) # binds together values data set with the subject and activities
names(data)<- names # assigns the names to the data set

library(dplyr) # calls dplyr package

tbl<- tbl_df(data) # converts data set into a format suitable for dplyr-manipulations
tbl_s4<-arrange(tbl, subject, activity) 
# arranges the columns in ascending order by subject, then by the activity label
# tbl_s4 is a table required in the Step 4

tbl_s4<- group_by(tbl_s4, subject, activity) # groups tbl_s4 by subject and then by activities
tbl_s5<-summarise_each(tbl_s4, funs(mean))     # computes mean() for each group
names<-names(tbl_s5)[3:length(names)]
new_names<-paste("Mean(", names, ")", sep="")  # creates a vector with the correct names
names(tbl_s5)<-c("subject", "activity", new_names) 
# assigns the columns the correct names now tbl_s5 is a tbl required in the Step 5
write.table(tbl_s5, file = "tbl_s5.txt", row.name=FALSE, col.names = TRUE)
