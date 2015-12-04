pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
		
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!
		
		filelist <- list.files(directory)	
		
		datapoints <- vector(mode="numeric")
		
		for (name in 1:length(id)) {
		  filename <- paste(directory, "/", filelist[id[name]], sep="")
		  info <- read.csv(filename)
		  datapoints <- append(datapoints, info[,pollutant])
		}
		
		avg = mean(datapoints, na.rm=TRUE)
		
		return(avg)
}