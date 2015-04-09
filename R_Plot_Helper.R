# # use lubridate
library(lubridate)
library(plyr)
library(dplyr)

# # data retrieval, cleaning function

plot_helper <- function(file) {
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
      
      # cange format of date variable
      days$Date <- as.Date(days$Date, format="%d/%m/%Y")
      
      # convert date and time variables from character class to date//time in POSIX
      date_time <- paste(as.Date(days$Date, format = "%d%m%Y"), days$Time)
      days$Datetime <- as.POSIXlt(date_time)
      dysdf <- tbl_df(days)
      
      # # return resulting tables (second for dplyr for further exploration, if necessary)
      return(days)
      return(dysdf)
}