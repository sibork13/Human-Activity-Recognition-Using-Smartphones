# Human Activity Recognition Using Smartphones

## Course Project for Getting and Cleaning Data from coursera

For this project, we had to realice 5 steps

  1. Merge the training and the test sets to create one dataset
  2. Extracts only the measurements on the mean and standard deviation for each measuremen
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  To solve the probelm i should make in disorder this steps

### First step, merge training and test sets

In the script first i read all need files 


library(data.table)
xtrain<-fread("train/X_train.txt")
xtest<-fread("test/X_test.txt")
ytrain<-fread("train/y_train.txt")
ytest<-fread("test/y_test.txt")
subtrain<-fread("train/subject_train.txt")
subtest<-fread("test/subject_test.txt")


Then, set names to the y_train,y_test,subject_train and subject_test data frame


names(ytrain)<-c("Activity")
names(ytest)<-c("Activity")
names(subtrain)<-c("Volunteer")
names(subtest)<-c("Volunteer")


Finally, i toke all DF and set into one with cbidn function


Tipe<-rep("train",dim(xtrain)[1])
xtrain<-cbind(xtrain,Tipe,ytrain,subtrain)
Tipe<-rep("test",dim(xtest)[1])
xtest<-cbind(xtest,Tipe,ytest,subtest)
df<-rbind(xtrain,xtest)


### Third part, Use descriptive labels to activities

In this part, ia read "activity_labels" 
Then set column names to easier manipulate
Arfther that, convert integer class to character
Finally, used the sub() function to change "number caracter" into string stored in activity_labels"


aclab<-fread("activity_labels.txt")
names(aclab)<-c("id","activity")
df$Activity<-as.character(df$Activity)
for(i in aclab$id){
  df$Activity<-sub(as.character(i),aclab$activity[i],df$Activity)
}


### Fourth Part, Set descriptible variables labels

To this point, i used "feautres" file to know all label names
i tooked the columns to put the name


fea<-fread("features.txt")
names(fea)<-c("id","label")
names(df)[1:561]<-fea$label



### Second part, extract only aveage and standar desviation data

To this section, i ised dplyr library to use select() function
with grep() i got all columns indices where was mean or std inthe label name
and select these columns


library(dplyr)
me<-grep("mean()",names(df))
st<-grep("std()",names(df))
finales<-c(562,563,564)
me<-append(me,finales)
st<-append(me,st)
df<-select(df,sort(st))


### Fifth section, create a new DF whit mean of the volunteer and activity
To do this, i ised aggregate function, this functions help us to do a dataframe with 
an especific function between 2 labels and the others


nuevo<-aggregate(cbind(df$Volunteer,df$Activity), df,mean)
nuevo<-nuevo[order(nuevo$Volunteer,nuevo$Activity),]
write.table(nuevo, "nuevo.txt", row.name=FALSE)

