path.expand("~/")
test<-read.table("~/UCI HAR Dataset/test/X_test.txt")
train<-read.table("~/UCI HAR Dataset/train/X_train.txt")
data<-rbind(test, train)

subject_test<- read.table("~/UCI HAR Dataset/test/subject_test.txt")
subject_train<- read.table("~/UCI HAR Dataset/train/subject_train.txt")
subject<- rbind(subject_test, subject_train)

act_test<-read.table("~/UCI HAR Dataset/test/y_test.txt")
act_train<-read.table("~/UCI HAR Dataset/train/y_train.txt")
act<- rbind (act_test, act_train)

													##on this stage we should leave the columns containing "mean" or "std" only,
													##then add subject and activity label columns and the appropriate names 
													##from grep() with value=TRUE
													##data_complete<-cbind(subject, act, data)

features<-read.table("~/UCI HAR Dataset/features.txt")
names_all<-as.vector(features[,2])

index_mean<- grep("mean", names_all, ignore.case = TRUE) 	## an integer vector with the indices of the elements, 
															##containing "mean" case-insensitive
names_mean<- grep("mean", names_all, ignore.case = TRUE, value=TRUE) 	## a character vector with the names of the variables
																		##containing "mean" case-insensitive
index_std<- grep("std", names_all, ignore.case = TRUE) 		## an integer vector with indices of the elements, 
															## containing "std" case-insensitive
names_std<- grep("std", names_all, ignore.case = TRUE, value=TRUE)		## a character vector with the names of the variables
																## containing "std" case-insensitive
																

index<-c(index_mean, index_std)
names<-c("subject", "activities", names_mean, names_std)
data<-data[index]

act_vect<- act[ ,1] ##activities data.frame
act_vect<- as.vector(act_vect) ##activities vector of integers
act_vect<- as.character(act_vect) ##activities vector of characters

act_vect<-gsub("1", "WALKING", act_vect)  ## changes 1-6 labeles for the activities to the descriptive ones
act_vect<-gsub("2", "WALKING_UPSTAIRS", act_vect)
act_vect<-gsub("3", "WALKING_DOWNSTAIRS", act_vect)
act_vect<-gsub("4", "SITTING", act_vect)
act_vect<-gsub("5", "STANDING", act_vect)
act_vect<-gsub("6", "LAYING", act_vect)

data<- cbind(subject, act_vect, data)
names(data)<- names 

library(dplyr)

tbl<- tbl_df(data)
tbl_s4<-arrange(tbl, subject, activities) ## arranges the columns in ascending order by subject, 
                                          ## then by the activity label
                                          ## tbl_s4 is a table required in the Step 4

tbl_s4<- group_by(tbl_s4, subject, activities) ## groups tbl_s4 by subject and then by activities
tbl_s5<-summarise_each(tbl_s4, funs(mean))     ## computes mean() for each group
names<-names(tbl_s5)[3:length(names)]
new_names<-paste("Mean(", names, ")", sep="")  ## creates a vector with the correct names
names(tbl_s5)<-c("subject", "activities", new_names) ## assigns the columns the correct names
                                                     ## now tbl_s5 is a tbl required in the Step 5
write.table(tbl_s5, file = "tbl_s5.txt", row.name=FALSE)
