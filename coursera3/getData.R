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
