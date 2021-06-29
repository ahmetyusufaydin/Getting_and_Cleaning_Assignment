#install.packages("dplyr")

## Read feature data
features <- read.table("./data/UCI HAR Dataset/features.txt")

## Read test data
xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt",
                    col.names = features[,2])
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt",
                    col.names = "activity")
subjecttest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",
                          col.names = "subjectID")

## Read training data
xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt",
                     col.names = features[,2])
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt",
                     col.names = "activity")
subjecttrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",
                           col.names = "subjectID")

############# Step-1
## Merges the training and the test sets to create one data set

# Merge within test and training data
test <- cbind(subjecttest, ytest, xtest)
train <- cbind(subjecttrain, ytrain, xtrain)

# merge training and test data
data <- rbind(test,train)


############# Step-2
## Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr)

# remove features other than mean and std
data <- data %>% select(subjectID, activity,
                        contains(".mean.") | 
                        contains(".std.")) 


############# Step-3
## Uses descriptive activity names to name the activities in the data set
# Read activity labels from data file
actlabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                        col.names = c("actNo","actLabel"))

# Merge activity labels with main data
data <- merge(data,actlabels,by.x="activity",by.y="actNo")

# Drop activity numbers and rename actLabel
data <- data %>% select(-activity)
data <- data %>% rename(activity = actLabel)

# Convert activity to factor
data$activity <- as.factor(data$activity)

# Reorder data
data <- data %>% select(subjectID,activity,everything())
data <- data %>% arrange(subjectID,activity)



############# Step-4
## Appropriately labels the data set with descriptive variable names. 

# Already done


############# Step-5
## From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

avData <- data %>% group_by(subjectID,activity) %>%
        summarise_all(list(name = mean))

# Save the data
write.table(avData, file = "./finalData.txt", row.name=FALSE)




