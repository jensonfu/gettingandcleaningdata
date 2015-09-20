#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
directoryname <- getwd()
directoryname <- paste0(directoryname,"/R/Datacleaning/getdataset/UCI HAR Dataset")
#1.Get Data
trainset <- read.table(paste0(directoryname,"/train/X_train.txt"), header=FALSE)
trainlabel <- read.table(paste0(directoryname,"/train/y_train.txt"), header=FALSE)
trainsubject <- read.table(paste0(directoryname,"/train/subject_train.txt"), header=FALSE)
testset <- read.table(paste0(directoryname,"/test/X_test.txt"), header=FALSE)
testlabel <- read.table(paste0(directoryname,"/test/y_test.txt"), header=FALSE)
testsubject <- read.table(paste0(directoryname,"/test/subject_test.txt"), header=FALSE)
features <- read.table(paste0(directoryname,"/features.txt"), as.is=TRUE)$V2
activity <- read.table(paste0(directoryname,"/activity_labels.txt"), as.is=TRUE)
#colnames(activities)[1] <- "Key"
#colnames(activities)[2] <- "Text"
colnames(activity) <- c("Key", "Text")
f_getactivityname<-function(key) {
  activity[activity$Key==key,]$Text
}
f_formatdata <- function(trainsubject, trainset, trainlabel, activity, features) {
  #formatdata <- data.frame(trainsubject, trainset, lapply(trainlabel$V1,function(key){activity[activity$Key==key,]$Text}))
  #trainlabel1 <- sapply(trainlabel, f_getactivityname)
  #formatdata <- data.frame(trainsubject, trainset, trainlabel1)
  formatdata <- data.frame(trainsubject, trainset, sapply(trainlabel$V1,f_getactivityname))
  #Change names to more meaningful
  columnheader <- make.names(c("Subject", features, "Activity"),unique = TRUE)
  colnames(formatdata)<-columnheader
  #Return only mean and standard deviations
  formatdata<-formatdata[(columnheader[grep("(Subject)|(.mean)|(.std)|(Activity)", columnheader)])]
  return(formatdata)
}
traindata<-f_formatdata(trainsubject, trainset, trainlabel, activity, features)
testdata<-f_formatdata(testsubject, testset, testlabel, activity, features)
finaldata<-rbind(traindata, testdata)
averagedata <- suppressWarnings(aggregate(finaldata, by=list(finaldata$Activity, finaldata$Subject), FUN="mean"))
averagedata <- averagedata[!grepl("Subject",colnames(averagedata))]
averagedata <- averagedata[!grepl("Activity",colnames(averagedata))]
colnames(averagedata)[1] <- "Activity"
colnames(averagedata)[2] <- "Subject"
write.table(averagedata, file=paste0(directoryname,"/tidydata.txt"), row.names=FALSE)