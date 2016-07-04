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



#plot 1 x= global active power, y= freq, hist

#first
png("plot1.png")

hist(dat$Global_active_power  , freq=TRUE, col="red" , xlab="Global active power (kilowates)"     ,main="Global_active_power",xlim=c(0,6)    ) 
dev.off()