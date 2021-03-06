# The data source is found at:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Download this file and unzip it in the working directory. This should 
# create a file called "household_power_consumption.txt"

dataFile <- "household_power_consumption.txt"

# The file contains over 2 million observations of 9 variables. Reading the full
# dataset into R will use no more than 150MB of memory. Most modern computers
# will have no problem with this, so no selective import is used.

library(dplyr)

# Read the raw data into a data frame
rawData <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?")

# Filter rows on Date to reduce the dataset to the days wanted
plotData <- tbl_df(filter(rawData, Date == "1/2/2007" | Date == "2/2/2007"))

# Convert character variables "Date" and "Time" into a date variable
plotData$dateTime = strptime(paste(plotData$Date, plotData$Time), "%d/%m/%Y %H:%M:%S")

# Open the png graphics device. Default plot size is 480*480 px
png(filename = "plot4.png")

# set the plot rows 
par(mfrow = c(2,2))

with(plotData, {
# Plot the first data series
          plot(dateTime, Global_active_power, type = "l", xlab = "", 
          ylab = "Global Active Power")

# and the second
     plot(dateTime, Voltage, type = "l", xlab = "datetime")
     
# and the third (composite)
     plot(dateTime, Sub_metering_1, type = "l",  
                    xlab = "", ylab = "Energy sub metering")
     lines(dateTime, Sub_metering_2, col = "red")
     lines(dateTime, Sub_metering_3, col = "blue")
     legend("topright", bty = "n", lty = c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# and the fourth
     plot(dateTime, Global_reactive_power, type = "l",
                    xlab = "datetime")
})

# Close the graphics device
dev.off()

