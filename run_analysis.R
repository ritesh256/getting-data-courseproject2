run_analysis <- function() {
  
  ##----------------------------------------------------------------------------
  ## Ques 1: Code for merging Data starts
  ##----------------------------------------------------------------------------
  ## Reading Test Data
  xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")  
  ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
  subtest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
  
  ## Reading Training Data
  xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")  
  ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
  subtrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
  
  ##Reading Features to assign column name
  features <- read.table("./data/UCI HAR Dataset/features.txt")
  
  ##Add Subject and Activity column for test Data
  xtest <- cbind(xtest, subtest, ytest)
  
  ##Add Subject and Activity column for Training Data
  xtrain <- cbind(xtrain, subtrain, ytrain)
  
  ##Merge Test and Training Data
  mergedata <- rbind(xtest, xtrain)
  ## End----------------------------------------------------------------------------

  ##----------------------------------------------------------------------------
  ## Ques 4: Assigning label to all columns (variable names)
  ##----------------------------------------------------------------------------
  
  ## Assign column names in the merge data set with Features.. assuming features.txt files also
  ## have column in same order (dimension are matching)
  ## feature.txt is two dimensional vector with second column having all the features value 
  ## Transpose of second column of features.txt along with subject and activity value will give 
  ##header value of merge data
  features <- t(features)
  names(mergedata) <- c(features[2,], "subject", "activity")
  ## end----------------------------------------------------------------------------
   
  ##----------------------------------------------------------------------------
  ## Ques 2: Extracts only Mean and STD columns
  ##----------------------------------------------------------------------------
  ## finding the column having mean value and standand deviation value
  ## mean column search should not include columns having name meanFreq as it is not relevant
  mean1col <- grep("*.mean.*", names(mergedata), value=T)
  mean2col <- grep("*.meanFreq.*", names(mergedata), value=T)
  meancol <- setdiff(mean1col,mean2col)
  
  std <- grep("*.std.*", names(mergedata), value=T)
  
  ## subset value with column having mean and standard value along with subject and activity column
  subdata <- mergedata[,c(meancol,std, "subject", "activity")]
  ## end----------------------------------------------------------------------------
  
  
  ##----------------------------------------------------------------------------
  ## Ques 3: Uses descriptive activity names to name the activities in the data set
  ##----------------------------------------------------------------------------
  ## reading activitiy_labels.txt file available in dataset zip to assign descriptive value to 
  ## activity list activity_labels.txt has 6 activity listed
  
  activi <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
  for(i in 1:6) {
    subdata$activity[subdata$activity == as.character(i)] <- as.character(activi[i,2])
  }
  ## end----------------------------------------------------------------------------
  
  ##----------------------------------------------------------------------------
  ## Ques 5: Creates a second, independent tidy data set with the average of each 
  ##         variable for each activity and each subject
  ##----------------------------------------------------------------------------
  ##second independent tidy data set with the average of each variable for 
  ##each activity and each subject
  library(reshape2)
  submelt <- melt(subdata, id=c("activity", "subject"))
  finaldata <- dcast(submelt, activity + subject ~ variable, mean)
  write.table(finaldata, file = "./data/finaldata.txt", row.name=FALSE)
}