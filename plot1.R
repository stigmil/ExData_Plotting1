# The data source is found at:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Download this file and unzip it in the working directory. This should 
# create a file called "household_power_consumption.txt"

# The file contains over 2 million observations of 9 variables. Reading the full
# dataset into R will use no more than 150MB of memory. Most modern computers
# will have no problem with this, so no selective import is used.

library(dplyr)

# Read the raw data into a data frame table
rawData <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?")

# Filter rows on Date to reduce the dataset to the days wanted
plotData <- tbl_df(filter(rawData, Date == "1/2/2007" | Date == "2/2/2007"))

# Open the png graphics device. Default plot size is 480*480 px
png(filename = "plot1.png")

# Plot the histogram
hist(plotData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Close the graphics device
dev.off()

