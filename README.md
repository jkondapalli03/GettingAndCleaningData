## Course: Getting and Cleaning Data
## Course Project
## Author: Jagannath Venkata Kondapalli
## Code File Name : run_analysis.R


### Description About Repository
This Repository contains CodeBook and run_analysis R script. This was generated to suffice the course requirements in Coursera.

### Description About Source Data

###Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


###Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


### Goal of the Project
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### 1. Merge the training and the test sets to create one data set.
Set the Working Directory to the UnZiped Data Directory
Read the following training files into the datatable objects:
1. features.txt
2. activity_labels.txt
3. subject_train.txt
4. x_train.txt
5. y_train.txt
Assign appropriate Column Names
Column Bind the above datatables
Repeating the same as above steps for test files
1. subject_test.txt
2. x_test.txt
3. y_test.txt
Row Bind to create single dataset.

### 2. Extract only the measurements on the mean and standard deviation for each measurement. 
Create a logical vector that contains TRUE values for the ID, mean and stdev columns and FALSE values for the others.
Subset this data to keep only the necessary columns. -> Above LogicalVector == TRUE.

### 3. Use descriptive activity names to name the activities in the data set
Merge the mergedData set with the acitivityType.
The Merge is done by = activityId


### 4. Appropriately label the data set with descriptive activity names.
Use gsub function to clean up the data labels.
Example: tBodyAcc-mean()-X is changed to tBodyAccMeanX

### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
Creating tidy dataset as per the project. The Dataset is created in .txt format.
