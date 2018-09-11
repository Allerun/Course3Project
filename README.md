### Introduction

The purpose of this script is to take the training and testing datasets from the following location:
[Human Activity Recognition Using Smartphones Dataset Version 1.0](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
and combine them into one master data set.  From there we can create a summary data set that
calculates the means of each variable by the subject and activity group.  

Code comments in the script describe the details of the process.

### Important Note

In order to run this script, the data files need to be extracted to a data directory within the working
directory:
`./data/UCI_HAR_Dataset/test/`
so that the file path looks like:
`./data/UCI_HAR_Dataset/features.txt`

Simply extracting the dataset archive into the `./data/' folder should put the data files in the 
proper location.

### Methodology

The datasets were downloaded and extracted to a file location on the local drive and the script
reads the files from that data location.

1. The script reads in the test data sets (UCI_HAR_Dataset/test/X_test.txt, UCI_HAR_Dataset/test/y_test.txt 
and UCI_HAR_Dataset/test/subject_test.txt) into local variables.  
2. It then reads in the feature labels and activity descriptors for use later in the script.
3. Using the feature list that was read in, it filters the X test data script to variables with 
just the mean() and std() suffixes required for the project per the instruction 
`Extracts only the measurements on the mean and standard deviation for each measurement`.  
4. The script then joins the X, Y and Subject_Test datasets to create one test dataset with all of the
required variables.
5. The same process is applied to the train data sets (UCI_HAR_Dataset/train/X_train.txt, 
UCI_HAR_Dataset/train/y_train.txt and UCI_HAR_Dataset/train/subject_train.txt)
6. The test and train datasets are joined together to create a master data set.
7. Some of the variable labels are modified to make the names easier to read.
8. The master data set is then summarized (averaged) by subject and activity to create the tidy data set.
9. The tidy data set is then written to a csv file (Course3Project/tidydataset.csv)

### Dataset Acknowledgment

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

For more information about this dataset contact: activityrecognition@smartlab.ws