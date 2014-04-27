Code Book for Accelerometer Mean Data
========================================================

The raw data was collected from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Two data sets for training and test were merged together. As per assignment instructions only some of the variables
were extracted, i.e., only concerning to mean() and std(). 69 variables are included.

### subject 
    subject ID
      1..30 unique identifier given to a person performing activity whose accelerometer data was collected
      
### activity
    activity name a subject performed
      WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
    
### data.type
    source of data from which observation came from
      train, test

### mean() and std()
    The features selected for this dataset come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions. The data set contains 33 means of these variables and 33 standard deviations for every X, Y, and Z direction.


