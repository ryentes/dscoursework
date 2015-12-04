rankhospital <- function(state, outcome, num) {
    ##
    data <- read.csv("data/outcome-of-care-measures.csv", colClasses = "character")
    
    outcome <- getOutcomeName(outcome)
    stateData <- getState(data, state)
    
    if(num == "best") {
        name <- getBest(stateData, outcome)
    } else if(num == "worst") {
        name <- getWorst(stateData, outcome)
    } else if(is.numeric(num)) {
        if(num > nrow(stateData)) {
            return(NA)
        } else {
            name <- getSpecRank(stateData, outcome, num)
        }
    } else {
        return(stop("invalid number"))
    }
    return(name)
}

# Helper function to identify the outcome variable name
getOutcomeName <- function(outcome) { 
    if(outcome == "heart attack") {
        vname = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    } else if(outcome == "heart failure") {
        vname = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    } else if(outcome == "pneumonia") {
        vname = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    } else {
        vname = stop("invalid outcome")
    }
    
    return(vname)
}

# Helper function to get data from just the requested state.
getState <- function(data, state) {
    # Check to see if state is a valid state
    validState <- is.element(state, state.abb)
    
    # Dies if an invalid state was passed.
    if(!validState) {
        return(stop("invalid state"))
    } else {
        ## Return hospital name of the state with lowest 30-day death rate
        # Subset to only hospitals matching state
        use <- data[,"State"] == state
        in.state <- data[use,]
        return(in.state)
    }
}

getBest <- function(data, outcome) {
    # Subset again to only hospitals whose mortaility rate is equivalent to the minimum
    use2 <- !is.na(data[,outcome]) & as.numeric(data[,outcome]) == min(as.numeric(data[,outcome]), na.rm=TRUE)
    is.min <- data[use2,]
    
    # Sort names alphabetically and return the first one.
    # Just strip out the names
    names <- is.min[, "Hospital.Name"]
    
    # Put them in Alphabetical order
    ordered.names <- names[order(names)]
    
    # Return the first one in the list.
    ordered.names[1]
}

getWorst <- function(data, outcome) {
    # Subset again to only hospitals whose mortaility rate is equivalent to the minimum
    use2 <- !is.na(data[,outcome]) & as.numeric(data[,outcome]) == max(as.numeric(data[,outcome]), na.rm=TRUE)
    is.max <- data[use2,]
    
    # Sort names alphabetically and return the first one.
    # Just strip out the names
    names <- is.max[, "Hospital.Name"]
    
    # Put them in Alphabetical order
    ordered.names <- names[order(names)]
    # Return the first one in the list.
    ordered.names[1]
}

getSpecRank <- function(data, outcome, num) {
    use <- !(data[,outcome] == "Not Available")
    data <- data[use,]
    
    data <- data[order(as.numeric(data[,outcome]), data[,"Hospital.Name"]),]
    name <- data[num, "Hospital.Name"]
    return(name)
}