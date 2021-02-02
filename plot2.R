### Plot 2

### Load packages
library(data.table)
library(dplyr)

### Load the data
fullData <- fread("household_power_consumption.txt", header = TRUE, sep = ";", 
                  colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

### Subset the data set on the two dates of interest
data <- filter(fullData, Date == "1/2/2007" | Date == "2/2/2007")

### Format the variables
# Change the time variable from character to time class
data$dateAndTime <- paste(data$Date, data$Time) 
data$dateAndTime <- as.POSIXct(strptime(data$dateAndTime, format = "%d/%m/%Y %H:%M:%S"))

# Create numeric variable needed for plot
data$Global_active_power <- as.numeric(data$Global_active_power)

### Plot 2
png(file = "plot2.png")
plot(data$dateAndTime, data$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()