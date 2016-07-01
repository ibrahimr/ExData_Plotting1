#project 1
#read Data
# setwd(" \\ExData_Plotting1")
# setwd("./dataExp")
# data <-   read.table (".\\data\\household_power_consumption.txt",header=TRUE,sep=';')
# 
# data <-   read.table ("./data/household_power_consumption.txt",header=TRUE,sep=';')
data<-read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")


## Combine Date and Time column
dateTime <- paste(data$Date,data$Time)

## Remove incomplete observation
data <- data[complete.cases(data),]

## Combine Date and Time column
data$dateTime <- paste(data$Date, data$Time)
 
## Format dateTime Column
data$dateTime <- as.POSIXct(dateTime)

## Format dateTime Column
data$dateTime <- as.POSIXct(data$dateTime) #representing calendar dates and times.

 
#plot 1 x= global active power, y= freq, hist
 
#first
png("plot1.png")

 hist(data$Global_active_power  , freq=TRUE, col="red" , xlab="Global active power (kilowates)"     ,main="Global_active_power",xlim=c(0,6)    ) 
 dev.off()
 # plot 2
 png("plot2.png")
 #subset the  data set from Feb. 1, 2007 to Feb. 2, 2007
 dat <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
 plot(dat$Global_active_power~dat$dateTime, type="l", ylab="Global Active Power (kilowatts)")
dev.off()

#plot 3
## Combine Date and Time column
 png("plot3.png")
 plot(  dat$Sub_metering_1, type = "l",  ylab="Energy Sub metering" )
 lines(dat$Sub_metering_2,type = "l",col="red")
 lines(dat$Sub_metering_3,type = "l",col="blue")
  legend("topright" ,  col = c("black", "red","blue"),  lwd=c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3") )
  dev.off()
#lwd line type#
 #plot 4
 
  #  Set up plotting in two rows and 4 columns, plotting along rows first.
  png("plot4.png")
  par( mfrow = c( 2, 2 ) )
  
  ##  The first plot is located in row 1, column 1:
 plot( dat$Global_active_power~ dat$dateTime,  type="l", ylab="Global_active_power")
 
 ##  The 2nd plot is located in row 1, column 2:
 plot( dat$Voltage ~ dat$dateTime, type="l", ylab="Voltage",xlab="datetime")
 #3rd
 plot(  dat$Sub_metering_1, type = "l",  ylab="Energy Sub metering" )
 lines(dat$Sub_metering_2,type = "l",col="red")
 lines(dat$Sub_metering_3,type = "l",col="blue")
 legend("topright" ,  col = c("black", "red","blue"),  lwd=c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3") )
 # 4th
 plot(  dat$ Global_active_power, type = "l",  ylab=" Global_active_power" )
 dev.off()
 