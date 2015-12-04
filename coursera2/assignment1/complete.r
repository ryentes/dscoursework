complete <- function(directory, id=1:332) {
  filelist <- list.files(directory)
  
  output <- data.frame(id = integer(0), nobs=integer(0), stringsAsFactors = FALSE)
  
  for (file in 1:length(id)) {
    filename <- paste(directory, "/", filelist[id[file]], sep="")
    monitor <- read.csv(filename)
    
	number_complete <- sum(complete.cases(monitor))
	
    output[file, 'id'] = id[file]
    output[file, 'nobs'] = number_complete
  }
  return(output)
}