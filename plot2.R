rm(list=ls())
library(readr)
hdp_data <- read_delim("~/My R Work/R Studio Default/data/Individual household electric power consumption Data Set/household_power_consumption.txt",
                       delim = ";", escape_double = FALSE, trim_ws = TRUE)
library(lubridate)
hdp_data$Date<-dmy(hdp_data$Date)
my_data<-rbind(subset(hdp_data, Date == "2007-02-01"),
               subset(hdp_data, Date == "2007-02-02"))#Only two days required
my_data$Global_active_power<-as.numeric(my_data$Global_active_power)
my_data$Index<-1:length(my_data$Date)
png(filename = "plot2.png")
with(my_data,plot(Index,Global_active_power, type="l", xaxt = "n",
                  ylab = "Global Active Power (kilowatts)", xlab = ""))
axis(side=1, labels = c("Thu","Fri","Sat"),
     at = c(min(my_data$Index),mean(my_data$Index),max(my_data$Index)))
dev.off()
