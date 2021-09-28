rm(list=ls())
library(readr)
hdp_data <- read_delim("~/My R Work/R Studio Default/data/Individual household electric power consumption Data Set/household_power_consumption.txt",
                       delim = ";", escape_double = FALSE, trim_ws = TRUE)
library(lubridate)
hdp_data$Date<-dmy(hdp_data$Date)
my_data<-rbind(subset(hdp_data, Date == "2007-02-01"),
               subset(hdp_data, Date == "2007-02-02"))#Only two days required

cols2num<- c("Global_active_power","Sub_metering_1","Sub_metering_2","Sub_metering_3",
             "Voltage","Global_reactive_power")
my_data[,cols2num]<-sapply(my_data[,cols2num], as.numeric)
my_data$Index<-1:nrow(my_data)
rm(hdp_data,cols2num)
par(mfcol = c(2,2))

# Plot 1
with(my_data,plot(Index,Global_active_power, type="l", xaxt = "n",
                  ylab = "Global Active Power", xlab = ""))
axis(side=1, labels = c("Thu","Fri","Sat"),
     at = c(min(my_data$Index),mean(my_data$Index),max(my_data$Index)))

# Plot 2

with(my_data,plot(Index,Sub_metering_1, type="l", xaxt = "n",
                  ylab = "Energy Sub Metering", xlab = ""))
with(my_data,lines(Index,Sub_metering_2, type="l", xaxt = "n",
                   ylab = "", xlab = "", col = "red"))
with(my_data,lines(Index,Sub_metering_3, type="l", xaxt = "n",
                   ylab = "", xlab = "", col = "blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col= c("black", "red", "blue"), lty = 1, lwd = 2, cex = 0.5)
axis(side=1, labels = c("Thu","Fri","Sat"),
     at = c(min(my_data$Index),mean(my_data$Index),max(my_data$Index)))

# Plot 3

with(my_data,plot(Index,Voltage, type="l", xaxt = "n",
                  ylab = "Voltage", xlab = "datetime"))
axis(side=1, labels = c("Thu","Fri","Sat"),
     at = c(min(my_data$Index),mean(my_data$Index),max(my_data$Index)))

# Plot 4

with(my_data,plot(Index,Global_reactive_power, type="l", xaxt = "n",
                  xlab = "datetime"))
axis(side=1, labels = c("Thu","Fri","Sat"),
     at = c(min(my_data$Index),mean(my_data$Index),max(my_data$Index)))

dev.copy(png, "plot4.png")

dev.off()
