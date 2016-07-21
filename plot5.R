

source("loadData_final.r")

png("plot5.png")
#5.How have emissions from motor vehicle sources changed from 1999 2008 in Baltimore City
head( SCC$EI.Sector)
str(SCC)
class( NEI.24510$SCC )
unique(SCC$EI.Sector)

#   SCC<-SCC[complete.cases(SCC),]
#   SCC$EI.Sector[ ]
#  str(SCC)

#mobile types
SCC.mobilev <- unique(   grep("*mobile*", SCC$EISector, ignore.case=TRUE , value=TRUE )  )
#focus on gasoline one
Gas_Gasoline<-subset(SCC, EISector %in% SCC.mobilev[1]) 
Gas_Diesel<-subset(SCC, EISector %in% SCC.mobilev[3]) 
Gas_Vessels<-subset(SCC, EISector %in% SCC.mobilev[9]) 
#subset for mobile vehicles in the city of Baltimore  

gasGasoline.24510 <-subset(NEI.24510, NEI.24510$SCC %in% Gas_Gasoline$SCC) 

gasDiesel.24510 <-subset(NEI.24510, NEI.24510$SCC %in% Gas_Diesel$SCC) 

gasVessels.24510 <-subset(NEI.24510, NEI.24510$SCC %in% Gas_Gasoline$SCC) 

gasGasoline.24510 <- cbind(gasGasoline.24510,V= "Gasoline" )
gasDiesel.24510 <-cbind(gasDiesel.24510,V= "Diesel" )
gasVessels.24510<-cbind(gasVessels.24510,V= "Vessels" )

all_gas<- rbind( gasGasoline.24510,  gasDiesel.24510,gasVessels.24510 )
head( all_gas)
plot( all_gas)

qplot   (       year,  Emissions, data =all_gas ,   color=V,facets = .~V, 
                xlab = "year",ylab ="Emissions",
                main = "Emissions, Baltimore City  Gasoline" )  

#OR  OR  OR 

ggplot(data=all_gas, aes(x= year , y=Emissions, fill=V)) +
     geom_bar(stat="identity" ) +
     facet_grid(.~V ) +
     guides(fill=FALSE)  +
     labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
     ggtitle("Motor Vehicle- Emissions in Baltimore")


dev.off()