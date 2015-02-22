## This file is for loading the large dataset.
## Create directory "data" if not exists
if (!file.exists("data")) {
  dir.create("data")
}
## Download&unzip dataset if no exists
if (!file.exists("data/summarySCC_PM25.rds") || !file.exists("data/Source_Classification_Code.rds")) {
  if(!file.exists("data/exdata_data_NEI_data.zip")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileURL, destfile = "data/exdata_data_NEI_data.zip")
  }
  unzip(zipfile = "data/exdata_data_NEI_data.zip", exdir = "data")
}

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png(filename = "plot4.png", width = 480, height = 480, units = "px")

coalSCC <- grep("coal", SCC$Short.Name, ignore.case = T)
coalSCC <- SCC[coalSCC, ]

coalNEI <- NEI[NEI$SCC %in% coal$SCC, ]  # Get only the rows with SCC corresponding to coal combustion-related 

totalEmissions <- aggregate(coalNEI$Emissions, by=list(coalNEI$year), FUN=sum)

plot(totalEmissions, type="l", 
     xlab="Year", ylab=expression(PM[2.5] *" Emissions (tons)"), 
     main="Total emissions from coal combustion-related sources in US from 1999 to 2008")

dev.off()