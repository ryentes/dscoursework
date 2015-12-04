library("plyr")
library("dplyr")
library("Hmisc")

# Helper function to ready each of the data sets
getData <- function(directory, features, activity_labels) {
    #Get test activity ids
    path <- paste(directory, "/y_", directory, ".txt", sep="")
    x <- read.table(path, header=FALSE)
    activityID <- factor(as.vector(unlist(x)), labels=activity_labels)
    
    # Get test subject ids
    path <- paste(directory, "/subject_", directory, ".txt", sep="")
    y <- read.table(path, header=FALSE)
    subjectID <- as.vector(y)
    
    # Read in the test data set
    path <- paste(directory, "/x_", directory, ".txt", sep="")
    data <- read.table(path , header=FALSE)
    
    # Combine subject and activity id with the data
    result <- cbind(subjectID, activityID, data)
    # Name variables
    colnames(result) = c("subjectID", "activityID", features)
    
    return(result)
}

#Get Activity labels
y <- read.table("activity_labels.txt", header=FALSE)
activity_labels <- tolower(as.vector(y[,2]))


## Get column labels
x <- read.table("features.txt", header=FALSE)
features <- as.vector(x[,2])

# Read the data sets and prep them for merging
test <- getData("test", features, activity_labels)
train <- getData("train", features, activity_labels)

# 1- Merge the data sets
all <- rbind(test, train)

# 2- Drop all the variables but subject id, activity id,
# and means and std deviations
names <- colnames(all)
isin <- grepl("std()", names, fixed=TRUE) | grepl("mean()", names, fixed=TRUE)
isin[1:2]=TRUE
all <- all[,isin]

# 3 Labels were applied to the factor in the function earlier

# 4 Clean up the variable names
names <- colnames(all)

for (i in 3:length(names)) {
  if(grepl("-mean()-", names[i], fixed=TRUE)) {
    names[i] <- gsub("-mean()-", names[i], fixed=TRUE, replacement="Mean")
  }
  if(grepl("-mean()", names[i], fixed=TRUE)) {
    names[i] <- gsub("-mean()", names[i], fixed=TRUE, replacement="Mean")
  }
  if(grepl("-std()-", names[i], fixed=TRUE)) {
    names[i] <- gsub("-std()-", names[i], fixed=TRUE, replacement="Std")
  }
  if(grepl("-std()", names[i], fixed=TRUE)) {
    names[i] <- gsub("-std()", names[i], fixed=TRUE, replacement="Std")
  }
}

colnames(all) <- names

# 5 Calculate means for each variable for each subject and  activity
final <- ddply(all, .(subjectID, activityID), summarise_each, funs(mean), -subjectID, -activityID)
# Write out the tidy dataset
write.table(final, "output.txt", row.name=FALSE)