corr <- function(directory, threshold = 0) {
  
  output <- vector(mode="numeric")
  
  filelist <- list.files(directory)
  
  for (file in 1:length(filelist)) {
	filename <- paste(directory, "/", filelist[file], sep="")
	
	monitor <- read.csv(filename)
  
    number_complete <- sum(complete.cases(monitor))
    meets_threshold = (number_complete > threshold)
  
    if (meets_threshold) {
      correlation <- cor(monitor[,'sulfate'], monitor[,'nitrate'], use="complete.obs")
	  output <- append(output, correlation)
    }
  }
  
  return(output)
  
}