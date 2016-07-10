# 
# data <-   read.table ("./data/household_power_consumption.txt",header=TRUE,sep=';')
data<-read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))


#subset the  data set from Feb. 1, 2007 to Feb. 2, 2007
dat <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))


## Combine Date and Time column
dateTime <- paste(dat$Date,data$Time)

## Remove incomplete observation
dat <- dat[complete.cases(dat),]

## Combine Date and Time column
dat$dateTime <- paste(dat$Date, dat$Time)

## Format dateTime Column
dat$dateTime <- as.POSIXct(dateTime)

## Format dateTime Column
dat$dateTime <- as.POSIXct(dat$dateTime) #representing calendar dates and times.


## Format date to Type Date
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
 
#plot 3
## Combine Date and Time column
png("plot3.png")
plot(  dat$Sub_metering_1, type = "l",  ylab="Energy Sub metering" )
lines(dat$Sub_metering_2,type = "l",col="red")
lines(dat$Sub_metering_3,type = "l",col="blue")
legend("topright" ,  col = c("black", "red","blue"),  lwd=c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3") )
dev.off()
#lwd line type#
 