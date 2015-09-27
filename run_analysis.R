setwd("~/Desktop/datascience/GetandCleanData/Courseproject")

# read in all required tables
traindatax <- read.table("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
dim(traindatax) # shows rows and columns
traindatay <- read.table("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
traindatasub <- read.table("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

testdatax <- read.table("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
dim(testdata)# shows rows and columns
testdatay <- read.table("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testdatasub <- read.table("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

actlabels <- read.table("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

features <- read.table("UCI HAR Dataset/features.txt", sep="", header=FALSE)

# merge training and testing data sets
datax <- rbind(traindatax, testdatax)
datay <- rbind(traindatay, testdatay)
datasub <- rbind(traindatasub, testdatasub)

# extract data on mean and std only
meanstdfeat <- grep(".*mean.*|.*std.*", features[, 2])

datax <- datax[ , meanstdfeat]
names(datax) <- features[meanstdfeat, 2]

# use descriptive activity names

datay[ ,1] <- actlabels[datay[, 1], 2]
names(datay) <- "activity"

# label with descriptive variable names

names(datasub) <- "subject"

completedata <- cbind(datax, datay, datasub)

# second tidy data set with avarage of variable for each activity/subset

tidydata <- ddply(completedata, c("subject", "activity"), numcolwise(mean))
tidydata$subject <- NULL
tidydata$activity <- NULL
write.table(tidydata, "tidy.txt", row.name = FALSE)





