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

# Now write a histogram to disk as a PNG image file
png("plot1.png")
hist(household_data$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
