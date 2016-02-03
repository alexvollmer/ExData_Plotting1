# NOTE: edit this variable to point to the right path for the data file
path <- "~/Downloads/household_power_consumption.txt"
data_file <- file(path)

# read in the first line manually to get the headers...
headers <- unlist(strsplit(readLines(data_file, n=1), split = ";"))
close(data_file)

# ...because we skip several rows to only load the two days of data we really want
household_data <-
    read.table(path, sep = ";", col.names = headers, skip = 66638,
               nrows = 2880, na.strings = c("?"))

# Now let's combine $Date and $Time into a more sensible datetime format
household_data$datetime <-
    strptime(paste(household_data$Date, household_data$Time),
             format="%d/%m/%Y %H:%M:%S")

# Write 2x2 set of plots to a single PNG file
png("plot4.png")

par(mfrow = c(2, 2))
## top-left plot
plot(household_data$datetime, household_data$Global_active_power,
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## top-right plot
with(household_data,
     plot(datetime, Voltage, type = "l", ylab = "Voltage"))

## bottom-left plot
with(household_data, plot(datetime, Sub_metering_1,
                          type = "l", xlab = "",
                          ylab = "Energy sub metering"))

with(household_data, points(datetime, Sub_metering_2,
                            type = "l", col = "red"))

with(household_data, points(datetime, Sub_metering_3,
                            type = "l", col = "blue"))

legend("topright", pch = "—", bty = "n",
       col=c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## bottom-right plot
with(household_data, plot(datetime, Global_reactive_power, type = "l"))

dev.off()
