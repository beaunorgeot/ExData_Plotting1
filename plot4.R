library(dplyr)

#read in file. Na values are recorded as "?". This is ";" seperated file
power <- tbl_df(read.table("household_power_consumption.txt", header = TRUE, na = "?", sep = ";"))

#Subset the data, taking only the two days of interest
days2 <- power %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007")
days2 <- days2 %>%
  mutate(DateTime = paste(as.Date(days2$Date,format = "%d/%m/%Y"), days2$Time)) %>%
  mutate(posDT = as.POSIXct(DateTime))

#plot4
par(mfrow=c(2,2),mar = c(4,4,2,1), oma = c(0,0,2,0))
plot(days2$posDT, days2$Global_active_power,type="l",xlab="",ylab="Global Active Power")
plot(days2$posDT, days2$Voltage, type="l",xlab="datetime", ylab="Voltage")
plot(days2$posDT, days2$Sub_metering_1, type="l", col="black",xlab="", ylab="Energy sub metering")
lines(days2$posDT, days2$Sub_metering_2, col="red")
lines(days2$posDT, days2$Sub_metering_3, col="blue")
legend("topright",col=c("black", "red", "blue"),c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1,cex=0.5)
plot(days2$posDT, days2$Global_reactive_power, type="n",xlab="datetime", ylab="Global_reactive_power")
lines(days2$posDT, days2$Global_reactive_power)

dev.copy(png, file = "plot4.png", width=400, height=400)  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!