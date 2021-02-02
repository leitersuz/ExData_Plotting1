### Plot 3

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

# Create numeric variables needed for plot
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

### Plot 3
png(file = "plot3.png")
plot(data$dateAndTime, data$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
lines(data$dateAndTime, data$Sub_metering_1, type="l", col = "black")
lines(data$dateAndTime, data$Sub_metering_2, type="l", col = "red")
lines(data$dateAndTime, data$Sub_metering_3, type="l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()