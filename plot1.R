# This scripts reads the Household Power Consumption Data found
# at the UC Irvine Machine Learning Repository, http://archive.ics.uci.edu/ml/.
# The link to the zip file of the data is: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip.
# Description of the data is found at https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption.
#

# This script will retrieve the file directly from the repository.
# To read a local file instead comment out the download.file and assign temp the name and path to the power consumption file.

library(data.table)
# Create a temp file and download to the created temp file
# Unzip and load
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest=temp, method="curl")

# Unzip and read in the data
allData <- read.table(unzip(temp), sep=";", stringsAsFactors=FALSE, as.is=TRUE, header=TRUE, na.strings="?")

# Change the date to a Date format. Create a new variable since we are going to combine the Date and Time on a subset of the data.
allData$Date2 <- as.Date(allData$Date, "%d/%m/%Y") 
plotData <- subset(allData, Date2 >= "2007-02-01" & Date2 <= "2007-02-02")

# Free up memory for data not going to be using
rm(allData)

# Combine the Date and Time to make a Date/Time variable
plotData$datetime <- strptime(paste(plotData$Date, plotData$Time), "%d/%m/%Y %H:%M:%S")

# Create 480x480 px png of the historgram of the Global Active Power consumption
# Note: 480x480 is the default size png
png(file = "plot1.png")
hist(plotData$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()

# Delete the temp file and the extracted file to clean up
unlink(temp)
file.remove("household_power_consumption.txt")