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

power_consumption <- read_powerconsumption()
# Transparent background
par(bg=NA) 
hist(power_consumption$Global_active_power, col="red", 
     main="Global Active Power", xlab="Global Active Power (kilowatts)")
# Save to PNG default 480x480
dev.copy(png, "plot1.png")
dev.off()