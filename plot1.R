### Plot 1

### Load packages
library(data.table)
library(dplyr)

### Load the data
fullData <- fread("household_power_consumption.txt", header = TRUE, sep = ";", 
                  colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

### Subset the data set on the two dates of interest
data <- filter(fullData, Date == "1/2/2007" | Date == "2/2/2007")

### Format the variable for plot
data$Global_active_power <- as.numeric(data$Global_active_power)

### Plot 1
png(file = "plot1.png")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()