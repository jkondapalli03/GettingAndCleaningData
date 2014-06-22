##########################################################################################################
## Title : RunAnalysis.R
## Author : Jagannath Venkata Kondapalli
## Date Created : 06-22-2014
## Breif Description : 
  ## Following steps are performed on the UCI HAR Dataset downloaded from link mentioned in the Project 
    ## 1. Merge the training and the test sets to create one data set.
    ## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
    ## 3. Use descriptive activity names to name the activities in the data set
    ## 4. Appropriately label the data set with descriptive activity names. 
    ## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##########################################################################################################

##########################################################################################################
# 1 BEGIN
##########################################################################################################

#set working directory 
setwd("C:/BigData/R Working Dir/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset/UCI HAR Dataset/");

#Read the training data from files
features     = read.table('./features.txt',header=FALSE); #imports features.txt
activityLabels = read.table('./activity_labels.txt',header=FALSE); #imports activity_labels.txt
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt
xTrain       = read.table('./train/x_train.txt',header=FALSE); #imports x_train.txt
yTrain       = read.table('./train/y_train.txt',header=FALSE); #imports y_train.txt

#Attach Colnames to the datasets created above.
colnames(activityLabels)  = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";

#Column bind the datasets above
trainingData = cbind(yTrain,subjectTrain,xTrain);

#Read the test data from files
subjectTest = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
xTest       = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
yTest       = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt

#Attach Colnames to the datasets created above.
colnames(subjectTest) = "subjectId";
colnames(xTest)       = features[,2]; 
colnames(yTest)       = "activityId";


#column bind the datasets above.
testData = cbind(yTest,subjectTest,xTest);


#Merge Training and Test datasets.
mergedData = rbind(trainingData,testData);

#Vector of column names
colNames  = colnames(mergedData); 

##########################################################################################################
## 1 END
##########################################################################################################

##########################################################################################################
# 2 BEGIN
##########################################################################################################

#LogicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for the rest of the columns
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

#Subset mergedData table based on the logicalVector
mergedData = mergedData[logicalVector==TRUE];

##########################################################################################################
# 2 END
##########################################################################################################


##########################################################################################################
# 3 BEGIN
##########################################################################################################

# Merge the mergedData set with the acitivityLabels. 
mergedData = merge(mergedData,activityLabels,by='activityId',all.x=TRUE);

colNames  = colnames(mergedData); 


##########################################################################################################
# 3 END
##########################################################################################################


##########################################################################################################
# 4 BEGIN
##########################################################################################################

# Cleaning up the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

colnames(mergedData) = colNames;

##########################################################################################################
# 4 END
##########################################################################################################



##########################################################################################################
# 5 BEGIN
##########################################################################################################

# New dataset without the activityType column
FinalData  = mergedData[,names(mergedData) != 'activityType'];

# Summarizing the FinalData table to include just the mean of each variable for each activity and each subject
tidyData    = aggregate(FinalData[,names(FinalData) != c('activityId','subjectId')],by=list(activityId=FinalData$activityId,subjectId = FinalData$subjectId),mean);

# Merging the tidyData with activityLabels to include descriptive acitvity names
tidyData    = merge(tidyData,activityLabels,by='activityId',all.x=TRUE);

# Export the tidyData set 
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');



##########################################################################################################
# 5 END
##########################################################################################################
