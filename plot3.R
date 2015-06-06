library(dplyr)

#read in file. Na values are recorded as "?". This is ";" seperated file
power <- tbl_df(read.table("household_power_consumption.txt", header = TRUE, na = "?", sep = ";"))

#Subset the data, taking only the two days of interest
days2 <- power %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007")

days2 <- days2 %>%
  mutate(DateTime = paste(as.Date(days2$Date,format = "%d/%m/%Y"), days2$Time)) %>%
  mutate(posDT = as.POSIXct(DateTime))

#plot3
with(days2, {
  plot(Sub_metering_1 ~ posDT, type = "l", 
       ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2 ~ posDT, col = 'Red')
  lines(Sub_metering_3 ~ posDT, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.copy(png, file = "plot3.png", width=400, height=400)  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device! 