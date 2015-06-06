library(dplyr)

#read in file. Na values are recorded as "?". This is ";" seperated file
power <- tbl_df(read.table("household_power_consumption.txt", header = TRUE, na = "?", sep = ";"))

#Subset the data, taking only the two days of interest
days2 <- power %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007")

#plot2
days2 <- days2 %>%
  mutate(DateTime = paste(as.Date(days2$Date,format = "%d/%m/%Y"), days2$Time)) %>%
  mutate(posDT = as.POSIXct(DateTime))

plot(days2$posDT, days2$Global_active_power, type = "l",ylab = "Global Active Power (kilowatts)", xlab ="")
dev.copy(png, file = "plot2.png", width=400, height=400)  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!