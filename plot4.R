

source("loadData_final.r")
png("plot4.png")
#########################################################################################

#  Across the United States, 
#  how have emissions from coal combustion-related sources changed from 1999-2008?




#  contain coal  and  
SCC.coal <-grepl(pattern = "*Coal*", SCC$SCCLevelFour, ignore.case = TRUE)
#extract
NIE.Coal.Comb<- NEI[ NEI$SCC %in% SCC[SCC.coal ,]$SCC ,]
NIE.Coal.Combu.Total <-aggregate(Emissions~year,  NIE.Coal.Comb, sum)

#  Plotting the subset of NEI data with SCC matched with coal  
g<-ggplot(aes(x = year, y = Emissions, fill="red" ) , data=NIE.Coal.Combu.Total)
g+geom_bar(stat="identity")+
     labs(x="year", y=expression("Total   Emission  ")) + 
     labs(title="Total Emissions for NEI data with SCC matched with coal.") +
     guides(fill=FALSE)


dev.off()