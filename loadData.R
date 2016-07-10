#project 1
#read Data
setwd("C:\\DataScinceTrack\\exploratory-data-analysis\\ExData_Plotting1")
# setwd("./dataExp")
 #data <-   read.table (".\\data\\household_power_consumption.txt",header=TRUE,sep=';', na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
# 
# data <-   read.table ("./data/household_power_consumption.txt",header=TRUE,sep=';',, na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
data<-read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

dim(data)
head(data)
tail(data)
## Format date to Type Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")
 head( data$Date )
#subset the  data set from Feb. 1, 2007 to Feb. 2, 2007
dat <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
#subset(data, data$Date >= as.Date(as.character("01/02/2007") ) & data$Date <= as.Date(as.character("02/02/2007"))    )
dim(dat)



## Combine Date and Time column
dat$dateTime <- paste(dat$Date, dat$Time)

 
 
dim( dat  )

# 
#  
 
# dat$dateTime <- as.POSIXct(dat$dateTime )
# why I got different dataset (bigger one ) of the data when I format the date as
# 
# as.Date(data$Date, "%d/%m/%Y")
# 
# and subset data as
# 
# subset(data, data$Date >= as.Date(as.character("01/02/2007") ) & data$Date <= as.Date(as.character("02/02/2007")) )
# 
# why different data set when using as.POSIXct ?