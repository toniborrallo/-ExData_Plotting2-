## If NEI loaded in Environment 
if (!"NEI" %in% ls()) {
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("data/summarySCC_PM25.rds")
}

## If SSC loaded in Environment 
if (!"SSC" %in% ls()) {
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

png(filename = "plot4.png", width = 480, height = 480, units = "px")

coalSCC <- grep("coal", SCC$Short.Name, ignore.case = T)
coalSCC <- SCC[coalSCC, ]

coalNEI <- NEI[NEI$SCC %in% coalSCC$SCC, ]  # Get only the rows with SCC corresponding to coal combustion-related 

totalEmissions <- aggregate(coalNEI$Emissions, by=list(coalNEI$year), FUN=sum)
 
plot(totalEmissions, type="l", 
     xlab="Year", ylab=expression(PM[2.5] *" Emissions (tons)"), 
     main="Total Emissions from Coal Combustion-related\n Sources in US from 1999 to 2008")

dev.off()