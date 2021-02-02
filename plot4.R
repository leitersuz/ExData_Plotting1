### Plot 4

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
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

### Plot 4
png(file = "plot4.png")
par(mfrow= c(2, 2))
with(data, {
  # Top left
  plot(data$dateAndTime, data$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")
  # Top right
  plot(data$dateAndTime, data$Voltage, type="l", xlab = "datetime", ylab = "Voltage")
  # Botton left
  plot(data$dateAndTime, data$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
  lines(data$dateAndTime, data$Sub_metering_1, type="l", col = "black")
  lines(data$dateAndTime, data$Sub_metering_2, type="l", col = "red")
  lines(data$dateAndTime, data$Sub_metering_3, type="l", col = "blue")
  legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  # Bottom right
  with(data, plot(dateAndTime, Global_reactive_power, type="l", xlab = "datetime"))
})
dev.off()
