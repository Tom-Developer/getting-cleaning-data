### Custom functions ###
# Convert activity code to a character label
# Args: 1st: activity code vector, 2nd: activity labels
# Return: acivity vector with labels
labelActivity <- function(activities, activity.labels) {
  
  for( i in seq_len( nrow(activities) ) ) {
    res <- activity.labels[ activities[i, ], ][, 2]
    res <- as.character(res)
    activities[i, ] <- res
  }
  activities
}

# Build a data frame only w/ columns which contain "-mean()" and
# "-std()" substring in their names. Column names are sourced from
# features.txt file.
# Args: 1st: data.frame sourced from features.txt 2nd: all data from X_text.txt
# or X_train.txt
# Return: data.frame containing only predefined columns along w/ their observation
# values
filterData <- function(features, data) {
  
  res <- NULL
  colNames <- character()
  for( i in seq_len( nrow(features) ) ) {
    if( grepl("-mean()", features[i, 2], fixed=T) ||
        grepl("-std()", features[i, 2], fixed=T)  ) {
      res <- cbind(res, data[, features[i, 1] ])
      colNames <- c(colNames, features[i, 2])
    } 
  }
  colnames(res) <- colNames
  res
}


### Main Program ###

# Read in the given data. It's assumed that this data (in test and train folders)
# is derived from "Inertial Signals" folder data and the latter doesn't add
# any value vs. the data being read in. 
# Assume that all data is in subdirectory (of this program): "UCI HAR Dataset"
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# Read features or column names for variables in features vector.
# Convert to non-factor type for matching substring.
features <- read.table("UCI HAR Dataset/features.txt")
features[, 1] <- as.numeric(features[, 1])
features[, 2] <- as.character(features[, 2])

test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test.activity <- read.table("UCI HAR Dataset/test/y_test.txt")
test.data <- read.table("UCI HAR Dataset/test/X_test.txt")

train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train.activity <- read.table("UCI HAR Dataset/train/y_train.txt")
train.data <- read.table("UCI HAR Dataset/train/X_train.txt")

# create a final data frame; add individual columns to the data frame
test.df <- cbind(test.subject)
train.df <- cbind(train.subject)

# convert activity numbers to strings
test.activity <- labelActivity(test.activity, activity.labels)
train.activity <- labelActivity(train.activity, activity.labels)
test.df <- cbind(test.df, test.activity)
train.df <- cbind(train.df, train.activity)
colnames(test.df) <- c("subject", "activity")
colnames(train.df) <- c("subject", "activity")

# add data.type column indicating origin of the data: test or training
test.df <- cbind(test.df, data.type="test")
train.df <- cbind(train.df, data.type="train")

# add measurement data w/ some of the columns from the data set
test.filtered <- filterData(features, test.data)
train.filtered <- filterData(features, train.data)
test.df <- cbind(test.df, test.filtered)
train.df <- cbind(train.df, train.filtered)

# merge training and test data
final.df <- rbind(train.df, test.df)

# write file with the merged dataset
write.table(final.df, "final-dataset.txt")

# produce the mean of each variables for each activity and each subject
# previous output must be data.table for this method to work
library(data.table)
final.df <- data.table(final.df)
mean.df <- final.df[, lapply(.SD, mean), by=c("subject", "activity"), .SDcols=4:ncol(final.df) ]
mean.df <- mean.df[ order(mean.df$subject), ]

# write file with the observation means
write.table(mean.df, "obs-means.txt")



# remove temporary objects from memory
remove(test.subject, test.activity, test.data)
remove(train.subject, train.activity, train.data)
remove(activity.labels, features, test.filtered, train.filtered)
remove(train.df, test.df)


