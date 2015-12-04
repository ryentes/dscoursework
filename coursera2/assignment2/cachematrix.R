## This file contains two functions. The first function (makeCacheMatrix) takes
## a matrix as input and creates a special "matrix" that has the abilityt to 
## cache its inverse. 

## The second function cacheSolve takes a special "matrix" that was created by 
## makeCacheMatrix and returns its inverse. First it checks to see if the 
## inverse is already cached, and if not, it computes it and caches it as well.

## This is a funciton 

makeCacheMatrix <- function(matrix = matrix()) {
    inverse <- NULL 
    
    #Method used to change a matrix created using this function. If used
    #will delete any previously cached matrix.
    set <- function(y) {
        matrix <<- y
        inverse <<- NULL
    }
    
    #Returns a matrix object matching the value of matrix
    get <- function() {
        return(matrix)
    }
    
    #Stores a matrix, by intention the inverse of matrix)
    setinverse <- function(newInverse) {
        inverse <<- newInverse
    }
    
    #Returns the matrix stored by inverse
    getinverse <- function() {
        return(inverse)
    }
    
    
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}


## This function takes a special "matrix" x and returns its inverse.
## It first checks to see if the inverse has previously been computed
## and cached. If so it retrieves the cached inverse matrix and returns
## that. Otherwise, it computes the inverse of x, caches it, and returns
## it. 

cacheSolve <- function(x, ...) {
    # Return a matrix that is the inverse of 'x'
    inverse <- x$getinverse() 
    #Returns the cached inverse matrix if one is present
    if(!is.null(inverse)) { 
        message("getting cached matrix")
        return(inverse)
    }
    
    # Otherwise it Grabs the actual matrix and computes it inverse. Caches and 
    # returns the computed inverse.
    matrix <- x$get() 
    inverse <- solve(a=matrix, ...) 
    x$setinverse(inverse) #Caches the inverse for future use 
    return(inverse) #returns the inverse of matrix x
}