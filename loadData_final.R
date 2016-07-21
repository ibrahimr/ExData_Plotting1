#project 2
#read Data
setwd("C:\\DataScinceTrack\\exploratory-data-analysis\\CoursePRoject2")

#read Data
# for wondows
NEI <- readRDS(".\\data\\summarySCC_PM25.rds")
SCC <- readRDS(".\\data\\Source_Classification_Code.rds")
# read.big.matrix
# for linux
NEI <-read.table ("./project2/data/summarySCC_PM25.rds")
SCC <- read.table ("./project2/data/Source_Classification_Code.rds")
# Explore whats in variabels

str(NEI)
dim(NEI)
head(NEI)
tail(NEI)

str(SCC)
dim(SCC)
head(SCC)
tail(SCC)
NEI[10:20,]
SCC[10:20,]
# 
# Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, make a plot 
#showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.


## Converting "year", "type", "Pollutant", "SCC", "fips" to factor
colToFactor <- c("year", "type", "Pollutant","SCC","fips")
NEI[,colToFactor] <- lapply(NEI[,colToFactor], factor)
head(levels(NEI$fips))
#converting that level back to NA
levels(NEI$fips)[1] = NA
NEI<-NEI[complete.cases(NEI),]
colSums(is.na(NEIdata))


## making the names in the SCC dataframe   by removing \\.  
names(SCC) <- gsub("\\.", "", names(SCC))

#  DO not work to save memroy too

# save(NEI, file="NEI1.Rdat")
# save(SCC, file="SCC1.Rdat")
# 
# load("NEI1.Rdat")
# #### did not work out of memorry
####################### Error: cannot allocate vector of size 49.6 Mb

totalforyear <-aggregate(Emissions ~ year, NEI , sum)
plot(totalforyear, type="l")

####################### for that replace the code with the following

NEI <- NEI[complete.cases(NEI),]
plot1dataframe<-data.frame()

data199<- NEI[NEI$year ==1999,]
newrow<-cbind(1999, sum(data199$Emissions))
plot1dataframe<-rbind(plot1dataframe,newrow )

data100<- NEI[NEI$year ==2002,]
newrow<-cbind(2002, sum(data100$Emissions))
plot1dataframe<-rbind(plot1dataframe,newrow )


data105<- NEI[NEI$year ==2005,]
newrow<-cbind(2005, sum(data105$Emissions))
plot1dataframe<-rbind(plot1dataframe,newrow )

data108<- NEI[NEI$year ==2008,]
newrow<-cbind(2008, sum(data108$Emissions))
plot1dataframe<-rbind(plot1dataframe,newrow )

colnames(plot1dataframe)<-c("year","Emissions")

barplot(
     (plot1dataframe$Emissions) ,
     xlab="Year",
     ylab="PM2.5 Emissions ",
     main="Total PM2.5 Emissions From All"
)
 

####################### #################################################################33
# Have total emissions from PM2.5 decreased in the Baltimore 
# City, Maryland (fips == “24510”) from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

 
  
  NEI.24510 <- NEI[which(NEI$fips == "24510"), ]
  ggregate.24510 <- with(NEI.24510, aggregate(Emissions, by = list(year), sum))
  colnames(ggregate.24510) <- c("year", "Emissions")

barplot((ggregate.24510$Emissions), 
        ylab = expression("Total Emissions, PM"[2.5]), 
        xlab = "Year",
        main = "Total Emissions for Baltimore " 
       )

######################################################################## 
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
 
 ####################################################################################3
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
 #############################################################################################
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
   
   