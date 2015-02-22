## If NEI loaded in Environment 
if (!"NEI" %in% ls()) {
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("data/summarySCC_PM25.rds")
}
 
## If SSC loaded in Environment 
if (!"SSC" %in% ls()) {
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

png(filename = "plot5.png", width = 480, height = 480, units = "px")

baltimoreNEI <- NEI[NEI$fips=="24510", ]

motorSCC <- grep("motor", SCC$Short.Name, ignore.case = T)
motorSCC <- SCC[motorSCC, ]

motorNEI <- baltimoreNEI[baltimoreNEI$SCC %in% motorSCC$SCC, ]  # Get only the rows with SCC corresponding to coal combustion-related 

totalEmissions <- aggregate(motorNEI$Emissions, by=list(motorNEI$year), FUN=sum)

plot(totalEmissions, type="l", 
     xlab="Year", ylab=expression(PM[2.5] *" Emissions (tons)"), 
     main="Total Emissions from Motor Vehicle\n Sources in Baltimore from 1999 to 2008")

dev.off()