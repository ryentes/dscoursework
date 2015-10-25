# dscoursework

This repository contains the scripts I've written for refining Rayez-Ortiz and colleagues' dataset

Human Activity Recognition Using Smartphones Data Set
the original data set is available for download at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The following scripts were written for a working folder set to the top-level directory of the extracted dataset (e.g. /path/to/data/UCI HAR Dataset). getData.R should also be stored in that directory

getData.R is a R script that contains a helper function to prepare the datasets provided by Rayez-Ortiz and colleagues for merging. The function getData() takes a directory, a list of variable names (features), and a list of activity labels as parameters. it then:

1. Reads in the vector of activity numbers from y_<directory>.txt and stores them a as a factor using the activity list (<activity_labels>) for labels (thus providing descriptive values).
2. Reads in the vector of subject identification numbers from subject_test.txt.
3. Reads a matrix of observations from x_<directory>.txt.
4. Combines the subject identification, activity label, and observation values into a new matrix.
5. Gives each column a name for the variable it represents using "subjectID", "activityID", and the list of variable names from <features>
6. Returns the prepared dataset 

run_analysis.R is a script that creates a new, tidy dataset that is a further refinement of the data provided by Rayez-Ortiz and colleagues. It Requires several packages to run, including plyr, dplyr, and Hmisc. Additionally, it sources getData.R from the current working directory. the script then does the following
1. Reads in the vector of activity descriptions from activity_labels.txt
2. Reads in the vector of variable names from features.txt
3. calls getData() once each for the test and train datasets, specifying the directory in which they are contained, the list of features, and the activity labels as arguments
4. drops all columns that don't pertain to mean or standard deviation measurements
5. Renames all variables to be descriptive, consistent, and largely readable, though abbreviated for length.
6. computes the within-person, within-activity mean of each retained measurement
7. writes out the new, tidy dataset into a file called "output.txt"
