# Course 4 - Exploratory Data Analysis Project 1
# Plot 1: Global Active Power (Historgram of Global Active Power)

## The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
## Date: Date in format dd/mm/yyyy
## Time: time in format hh:mm:ss
## Global_active_power: household global minute-averaged active power (in kilowatt)
## Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
## Voltage: minute-averaged voltage (in volt)
## Global_intensity: household global minute-averaged current intensity (in ampere)
## Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
## Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
## Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# Load libraries
library(lubridate)


# Load datasets
epc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Convert Date to DateTime
x <- paste(as.character(epc$Date), as.character(epc$Time))
epc$DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")

# Subset data to dates Feb. 01, 2007 & Feb. 02, 2007
d1 <- dmy("01/02/2007")
d2 <- dmy("02/02/2007")

l1 <- as.Date(epc$DateTime) == as.Date(d1)
l2 <- as.Date(epc$DateTime) == as.Date(d2)
feb2days <- epc[l1 | l2,]

# Convert Global active power to numberic values
feb2days$Global_active_power_N <- as.numeric(as.character(feb2days$Global_active_power))
feb2days$Sub_metering_1N <- as.numeric(as.character(feb2days$Sub_metering_1))
feb2days$Sub_metering_2N <- as.numeric(as.character(feb2days$Sub_metering_2))
feb2days$Sub_metering_3N <- as.numeric(as.character(feb2days$Sub_metering_3))
feb2days$Global_reactive_power_N <- as.numeric(as.character(feb2days$Global_reactive_power))

# Plot line graph
png(file = "plot4.png")
par(mfrow = c(2,2))

# Plot 1
hist(feb2days$Global_active_power_N, col = "red", xlab = "Global Active Power (kilowatts)", main = "")

# Plot 2
plot(feb2days$DateTime, feb2days$Global_active_power_N, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# Plot 3
plot(feb2days$DateTime, feb2days$Sub_metering_1N, type = "l", ylab = "Energy sub metering", xlab = "")
lines(feb2days$DateTime, feb2days$Sub_metering_2N, type = "l", col = "red")
lines(feb2days$DateTime, feb2days$Sub_metering_3N, type = "l", col = "blue")
legend("topright", col = c("black", "blue", "red"), lty = c(1, 1, 1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot 4
plot(feb2days$DateTime, feb2days$Global_reactive_power_N, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()