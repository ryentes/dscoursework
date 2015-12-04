source("rankhospital.R")

rankall <- function(outcome, num) {
    states <- states[order(state.abb)]
    
    output <- data.frame(hospital = character(), state = character(), stringsAsFactors = FALSE)
    
    for(i in 1:length(states)) {
        output[i,"hospital"] = rankhospital(states[i], outcome, num)
        output[i, "state"] = states[i]
    }
    
    return(output)
}