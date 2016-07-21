

source("loadData_final.r")



####################### Error: cannot allocate vector of size 49.6 Mb
png("plot1.png")

totalforyear <-aggregate(Emissions ~ year, NEI , sum)
plot(totalforyear, type="l")

#
###################### for that replace the code with the following

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

dev.off()