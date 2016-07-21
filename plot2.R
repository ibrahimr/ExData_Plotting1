


source("loadData_final.r")

png("plot2.png")


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




dev.off()
