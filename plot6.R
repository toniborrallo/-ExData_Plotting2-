library(ggplot2)
## If NEI loaded in Environment 
if (!"NEI" %in% ls()) {
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("data/summarySCC_PM25.rds")
}

## If SSC loaded in Environment 
if (!"SSC" %in% ls()) {
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

png(filename = "plot6.png", width = 480, height = 480, units = "px")

filterNEI <- NEI[NEI$fips=="24510" | NEI$fips=="06037" , ]

motorSCC <- grep("motor", SCC$Short.Name, ignore.case = T)
motorSCC <- SCC[motorSCC, ]

# Get only the rows with SCC corresponding to motor vehicle in Baltimore
motorNEI <- filterNEI[filterNEI$SCC %in% motorSCC$SCC, ]  


totalEmissions <- aggregate(motorNEI$Emissions, by=list(year = motorNEI$year, fips = motorNEI$fips), FUN=sum)

g <- ggplot(totalEmissions, aes(year, x, color = fips))
p <- g + geom_line() + 
  labs( title = "Comparison Baltimore City vs Los Angeles County\n Total Emissions from Motor Vehicle\n Sources from 1999 to 2008") + 
  labs( y = expression(PM[2.5]*" Emissions (tons)")) + 
  labs( x = "Year") +
  scale_colour_discrete(name = "Series", label = c("Los Angeles","Baltimore"))

print(p)

dev.off()