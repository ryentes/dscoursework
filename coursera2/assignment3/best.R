best <- function(state, outcome) {
    ## Read ouctome data
    data <- read.csv("data/outcome-of-care-measures.csv", colClasses = "character")
    
    
    ## Validation section
    
    # Find the variable name of the outcome
    outcome <- getOutcomeName(outcome)
    
    # Dies if an invalid outcome was passed
    if(is.na(outcome)) {
        stop("invalid outcome")
    }
    
    # Check to see if state is a valid state
    validState <- is.element(state, state.abb)
    
    # Dies if an invalid state was passed.
    if(!validState) {
        stop("invalid state")
    }
    
    ## Return hospital name of the state with lowest 30-day death rate
    # Subset to only hospitals matching state
    use <- data[,"State"] == state
    in.state <- data[use,]
    
    # Subset again to only hospitals whose mortaility rate is equivalent to the minimum
    use2 <- !is.na(in.state[,outcome]) & as.numeric(in.state[,outcome]) == min(as.numeric(in.state[,outcome]), na.rm=TRUE)
    is.min <- in.state[use2,]
    
    # Just strip out the names
    names <- is.min[, "Hospital.Name"]
    
    # Put them in Alphabetical order
    ordered.names <- names[order(names)]
    
    # Return the first one in the list.
    ordered.names[1]
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
        vname = NA
    }
    
    return(vname)
}

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



