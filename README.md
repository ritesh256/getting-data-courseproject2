getting-data-courseproject2
===========================

~Ritesh Gandhi
==================================================================

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. Project is using dataset provided 
as part of this project 
Following activities has been performed to clean up data
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 



Github repo includes following file
=========================================

- 'README.md'

- 'CodeBook.md': describes the variables, the data, and any transformations or work that you performed to clean up the data

- 'run_analysis.R': Script to perform to clean up data 


How run_analysis scripts works
=========================================
  
  
  ## Ques 1: Code for merging Data starts
  
	   First part of code reads training dataset and test data including activities and subject text files. 
	   1. Compined the columns for test dataset (x_text, y_test and subject_test)
	   2. Compined the columns for Trianing dataset x_train, y_train and subject_train)
	   Merged the rows created in above steps

  
  ## Ques 4: Assigning label to all columns (variable names)
  
      features.text files has all the feature value available (dimension 561) in the second column, 
      Used this column, transposed it and assigned to column name for merge dataset created in 
     in above step
     Also added column name for subject and activity column 


  ## Ques 2: Extracts only Mean and STD columns

     used Grep function to extract the column having string mean and Std for mean and standard columns
     created subset of dataset for above extracted column names


  ## Ques 3: Uses descriptive activity names to name the activities in the data set  
  
     Read activitiy_labels.txt file available in dataset zip to assign descriptive value to 
     activity list activity_labels.txt has 6 activity listed
  

  ## Ques 5: Creates a second, independent tidy data set with the average of each 
     variable for each activity and each subject
  
     created tidy dataset with the average of each variable using "melt" and "dcast"
     function using library reshape2
     scripts writes final output to finaldata.txt file using write.table command

