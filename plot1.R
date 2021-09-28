rm(list=ls())
library(readr)
hdp_data <- read_delim("~/My R Work/R Studio Default/data/Individual household electric power consumption Data Set/household_power_consumption.txt",
                       delim = ";", escape_double = FALSE, trim_ws = TRUE)
library(lubridate)
hdp_data$Date<-dmy(hdp_data$Date)
my_data<-rbind(subset(hdp_data, Date == c("2007-02-01")),
                subset(hdp_data, Date == c("2007-02-02")))#Only two days required
my_data$Global_active_power<-as.numeric(my_data$Global_active_power)
png(filename = "plot1.png")
hist(my_data$Global_active_power, col = "red", main = "Global Active Power",
                xlab = "Global Active Power (kilowatts)")
dev.off()
