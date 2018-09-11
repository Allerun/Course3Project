## This script takes the dataset found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## and merges the x, y, and subject data for both test and train scenarios, then extracts the mean and standard deviation
## measurements, pretties up the variable names and makes them more descriptive, and finally exports a csv data set with
## each variable averaged for each activity and subject.

### Loading the data.table library to speed up some data loads, and the dplyr to make summarization easier.
library(data.table)
library(dplyr)

### Loading up our test data sets.
xtest <- fread("./data/UCI_HAR_Dataset/test/X_test.txt")
ytest <- read.delim("./data/UCI_HAR_Dataset/test/y_test.txt", header = FALSE, col.names = "activity")
subtest <- read.delim("./data/UCI_HAR_Dataset/test/subject_test.txt", header = FALSE, col.names = "subject")

### Loading up and manipulating the labels we will use for our variables.
features <- read.delim("./data/UCI_HAR_Dataset/features.txt", sep = " ", header = FALSE)
activities <- read.delim("./data/UCI_HAR_Dataset/activity_labels.txt", sep = " ", header = FALSE)
featurelist <- tolower(features$V2)
measurelist <- grep("mean\\(\\)|std\\(\\)", featurelist)

### Getting rid of the variables in xtest that aren't related to mean or standard deviation, and labeling the measures.
xtest <- xtest[,measurelist, with = FALSE]
names(xtest) <- gsub("[^A-Za-z0-9]", "", featurelist[measurelist])

### Combining all the test data into a single data frame.
joinedtest <- cbind(subtest, ytest, xtest)

### A little house keeping, a clean environment is a happy environment.
rm(xtest, ytest, subtest)

### Second verse, same as the first.  Loading up our train data sets.
xtrain <- fread("./data/UCI_HAR_Dataset/train/X_train.txt")
ytrain <- read.delim("./data/UCI_HAR_Dataset/train/y_train.txt", header = FALSE, col.names = "activity")
subtrain <- read.delim("./data/UCI_HAR_Dataset/train/subject_train.txt", header = FALSE, col.names = "subject")

### Getting rid of the variables in xtest that aren't related to mean or standard deviation, and labeling the measures.
xtrain <- xtrain[, measurelist, with = FALSE]
names(xtrain) <- gsub("[^A-Za-z0-9]", "", featurelist[measurelist])

### Combining all the test data into a single data frame.
joinedtrain <- cbind(subtrain, ytrain, xtrain)

### A little more house keeping.
rm(xtrain, ytrain, subtrain)

### Combining the train and test data sets for our master data set.
masterdataset <- rbind(joinedtest, joinedtrain)

masterdataset <- merge(masterdataset, activities, by.x = "activity", by.y = "V1", all=TRUE, sort = FALSE) %>% mutate(activity = NULL) %>% rename(activity = V2)

### Prettying up the names a little bit to make them more readable.
names(masterdataset) <- gsub("^t", "time", names(masterdataset))
names(masterdataset) <- gsub("^f", "fft", names(masterdataset))

### Create the summarized tidy dataset group by subject and activity.
tidydataset <- masterdataset %>% group_by_at(vars(subject, activity)) %>% summarize_all(funs(mean))

### Write the tidy dataset to a csv called tidydataset.csv.
write.csv(tidydataset, "./Course3Project/tidydataset.csv")
