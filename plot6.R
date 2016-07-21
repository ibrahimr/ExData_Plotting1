
library(ggplot2)
source("loadData_final.r")

png("plot6.png")

#    6.Compare emissions from motor vehicle sources in Baltimore
#    City with emissions from motor vehicle sources in Los Angeles County, 
#    California (fips == “06037”). Which city has seen greater changes over time in motor 
#    vehicle emissions? Calculate total emissions of PM2.5 from each types of vehicles 
#    between 1999 and 2008 in the Baltimore City and Los Angeles

#  Get LA DATA
NEI.06037 <- NEI[which(NEI$fips == "06037"), ]

#subset for mobile vehicles in the city of Baltimore  

gasGasoline.06037 <-subset(NEI.06037, NEI.06037$SCC %in% Gas_Gasoline$SCC) 

gasDiesel.06037 <-subset(NEI.06037, NEI.24510$SCC %in% Gas_Diesel$SCC) 

gasVessels.06037 <-subset(NEI.06037, NEI.06037$SCC %in% Gas_Gasoline$SCC) 

gasGasoline.06037 <- cbind(gasGasoline.06037,V= "Gasoline" )
gasDiesel.06037 <-cbind(gasDiesel.06037,V= "Diesel" )
gasVessels.06037<-cbind(gasVessels.06037,V= "Vessels" )

all_gas_LA<- rbind( gasGasoline.06037,gasDiesel.06037, gasVessels.06037 )


all<- rbind(all_gas,  all_gas_LA)
tail( all)
unique(all$fips ) 

ggplot(data=all, aes(x= year , y=Emissions, fill=V)) +
     geom_bar(stat="identity" ) +
     facet_grid(.~ fips ) +
     labs(x="year", y=expression("Total PM ")) + 
     ggtitle("Compare  Baltimore and LA")




dev.off()
