 
#load Data
source("loadData.R")

 
#first
png("plot1.png")

hist(dat$Global_active_power  , freq=TRUE, col="red" , xlab="Global active power (kilowates)"     ,main="Global_active_power",xlim=c(0,6)    ) 
dev.off()