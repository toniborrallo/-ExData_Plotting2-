## If NEI loaded in Environment 
if (!"NEI" %in% ls()) {
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("data/summarySCC_PM25.rds")
}

png(filename = "plot2.png", width = 480, height = 480, units = "px")

baltimoreNEI <- NEI[NEI$fips=="24510", ]

totalEmissions <- aggregate(baltimoreNEI$Emissions, by=list(baltimoreNEI$year), FUN=sum)

plot(totalEmissions, type="l", 
     xlab="Year", ylab=expression(PM[2.5] *" Emissions (tons)"), 
     main="Total Emissions in Baltimore from 1999 to 2008")

dev.off() 