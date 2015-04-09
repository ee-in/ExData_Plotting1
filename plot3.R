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
# # rm(data)???
      
# change format of date variable
days$Date <- as.Date(days$Date, format="%d/%m/%Y")
      
# convert date and time variables from character class to date//time in POSIX
date_time <- paste(as.Date(days$Date, format = "%d%m%Y"), days$Time)
days$Datetime <- as.POSIXlt(date_time)
dysdf <- tbl_df(days)
      
# # return resulting tables (second for dplyr for further exploration, if necessary)
return(days)
return(dysdf)
      

# # create plot
plot(days$Datetime, 
     days$Sub_metering_1, 
     type = "l",
     ylab = "Energy sub metering",
     xlab = "",
     col = "Black",
     cex.axis = .75,
     family = "HersheySans")
lines(days$Datetime,
      days$Sub_metering_2,
      col = 'Red')
lines(days$Datetime,
      days$Sub_metering_3,
      col = 'Blue')
      
# # create legend
      
legend("topright",
       col=c("black", "red", "blue"),
       lty = 1,
       lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = .6)

# # copy to PNG file
dev.copy(device = png, file = "plot3.png", width=480, height=480)

# # turn dev off
dev.off()