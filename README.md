README for run_analysis.R script
========================================================

#### Assumtpions contained in the script:
* raw data is in subfolder (to the script): "UCI HAR Dataset"
* data in folders "UCI HAR Dataset/test/Inertial Signals" and 
"UCI HAR Dataset/train/Inertial Signals" was ignored as it seems to be a primitive
of the data in higher folders
* the script first reads data for the test version and builds required data set.
This activity includes translating activity code to actual activity label, so it's
easier to read the data set. The same algorithm is applied to the train version
of the data. Once both data sets are ready, they're merged. At the end the merged
data set is written to a file: final-dataset.txt in the same folder where the
script is placed. Finally, means/averages for each numeric variable per subject
per activity is calculated. That output is written to obs-means.txt file.