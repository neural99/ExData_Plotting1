## Function for reading the power consumption data in "household_power_consumption.txt"
read_powerconsumption <- function() {
    # Read power consumption data. 
    power_consumption <- read.csv("household_power_consumption.txt", 
                                  na.strings = "?", sep=";", stringsAsFactors = F,
                                  nrows=73323)
    # Parse dates and times 
    power_consumption <- transform(power_consumption, 
                                   Date = as.Date(strptime(Date, "%d/%m/%Y")),
                                   DateTime = strptime(paste(Date, Time), 
                                                       "%d/%m/%Y %H:%M:%S"))
    fday <- as.Date("2007-02-01")
    sday <- as.Date("2007-02-02")
    
    power_consumption <- power_consumption[fday <= power_consumption$Date 
                                           & power_consumption$Date <= sday,]
    # Return data
    power_consumption
}

## Code below produces plot1.png

# Force Enlgish locale to get weekday labels right
Sys.setlocale("LC_ALL","English")

power_consumption <- read_powerconsumption()
png(filename = "plot3.png")
# Transparent background
par(bg=NA) 
plot(power_consumption$Sub_metering_1 ~ power_consumption$DateTime, 
     type="l", xlab="", ylab="Energy sub metering")
lines(power_consumption$Sub_metering_2 ~ power_consumption$DateTime, col="red")
lines(power_consumption$Sub_metering_3 ~ power_consumption$DateTime, col="blue")
# Add legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1), col=c("black", "red", "blue"))
# Save to PNG
dev.off()