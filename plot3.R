library(ggplot2)

## If NEI loaded in Environment 
if (!"NEI" %in% ls()) {
  ## This first line will likely take a few seconds. Be patient!
  NEI <- readRDS("data/summarySCC_PM25.rds")
}

png(filename = "plot3.png", width = 480, height = 480, units = "px")

baltimoreNEI <- NEI[NEI$fips=="24510", ]

totalEmissions <- aggregate(baltimoreNEI$Emissions, 
                            by=list(year = baltimoreNEI$year, sources = baltimoreNEI$type), FUN=sum)

g <- ggplot(totalEmissions, aes( year, x , color = sources))
p <- g + geom_line() + 
    labs( title = "Total Emissions in Baltimore from 1999 to 2008") + 
    labs( y = expression(PM[2.5]*" Emissions (tons)")) + 
    labs( x = "Year")
print(p) 
dev.off()
