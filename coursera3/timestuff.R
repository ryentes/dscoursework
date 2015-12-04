system.time(mean(DT$pwgtp15,by=DT$SEX))
tapply(DT$pwgtp15,DT$SEX,mean)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
sapply(split(DT$pwgtp15,DT$SEX),mean)
DT[,mean(pwgtp15),by=SEX]
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)

test <- function() {
    return(mean(DT$pwgtp15,by=DT$SEX))
}

test2 <- function() {
    return(tapply(DT$pwgtp15,DT$SEX,mean))
}

test3 <- function() {
    return({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
}

test4 <- function() {
    return(sapply(split(DT$pwgtp15,DT$SEX),mean))
}

test5 <- function() {
    return(DT[,mean(pwgtp15),by=SEX])
}

test6 <- function() {
    return((mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)))
}