# # use packages to view/clean data
library(lubridate)
library(plyr)
library(dplyr)

# # data retrieval, cleaning function


file <- 'household_power_consumption.txt'
data0 <- read.csv(file, 
                  header = TRUE,
                  sep = ";",
                  colClasses=c("character", "character", rep("numeric",7)),
                  na.strings = "?")

data <- data.frame(data0)

# only use data from the dates 2007-02-01 and 2007-02-02
days <- subset(data, subset = (Date == "1/2/2007" | Date == "2/2/2007"))
# # rm(data)??? for efficiency...?

# change format of date variable
days$Date <- as.Date(days$Date, format="%d/%m/%Y")

# convert date and time variables from character class to date//time in POSIX
date_time <- paste(as.Date(days$Date, format = "%d%m%Y"), days$Time)
days$Datetime <- as.POSIXlt(date_time)
dysdf <- tbl_df(days)

# # return resulting tables (second for dplyr for further exploration, if necessary)
return(days)
return(dysdf)


# # create plot space into which to insert four plots, going clockwise
par(mfrow = c(2, 2),
    mar = c(4, 4, 2, 1),
    oma = c(0, 0, 2, 0),
    cex = .8)

# # upper-left plot
plot(days$Datetime, days$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)",
     cex.axis = 1,
     cex.lab = .8,
     family = "HersheySans")

# # top-right plot
plot(days$Datetime,
     days$Voltage,
     type = "l",             
     ylab = "Voltage",
     xlab = "datetime",
     cex.axis = 1,
     cex.lab = .8,
     family = "HersheySans")

# # bottom-left plot... 
plot(days$Datetime, 
     days$Sub_metering_1, 
     type = "l",
     ylab = "Energy sub metering",
     xlab = "",
     col = "Black",
     cex.axis = 1,
     cex.lab = .8,
     family = "HersheySans")
lines(days$Datetime,
      days$Sub_metering_2,
      col = 'Red')
lines(days$Datetime,
      days$Sub_metering_3,
      col = 'Blue')
# # ...and legend for bottom-left plot
legend("topright",
       col=c("black", "red", "blue"),
       lty = 1,
       lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = .6)


# # bottom-right plot
plot(days$Datetime,
     days$Global_reactive_power,
     type = "l",
     ylab = "Global_reactive_power (kilowatts)",
     xlab = "datetime",
     cex.axis = 1,
     cex.lab = .8,
     family = "HersheySans")

# # copy to PNG file
dev.copy(device = png, file = "plot4.png", width=480, height=480)

# # turn dev off
dev.off()