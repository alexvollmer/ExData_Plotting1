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

# Now let's combine $Date and $Time into a more sensible DateTime format
household_data$DateTime <-
    strptime(paste(household_data$Date, household_data$Time),
             format="%d/%m/%Y %H:%M:%S")

# Now write a line plot to a PNG file
png("plot2.png")
plot(household_data$DateTime, household_data$Global_active_power,
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
