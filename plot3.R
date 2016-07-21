

source("loadData_final.r")

png("plot3.png")
# Of the four types of sources indicated by the 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen 
# decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases 
# in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.


dim( NEI.24510)
head(NEI.24510)
library(ggplot2)

NEI.24510.type.year<- aggregate( Emissions  ~   ( type+year),data= NEI.24510,  sum)

qplot   (       year,Emissions,data= NEI.24510.type.year,color=type ,facets = .~type ,
                geom="density",xlab = "year",ylab ="Emissions",
                main = "Emissions, Baltimore City  Classified" )  

#OR

g<-ggplot(aes(x = year, y = Emissions, fill=type), data=NEI.24510.type.year)
g+geom_bar(stat="identity")+
     facet_grid(.~type)+
     labs(x="year", y=expression("Total   Emission  ")) + 
     labs(title="Emissions, Baltimore City  Classified..") +
     guides(fill=FALSE)

dev.off()