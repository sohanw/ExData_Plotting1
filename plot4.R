## Coursera - Exploratory Data Analysis - Course Project 1-4
## R code file  plot4.R that constructs the plot plot4.png
## download the file using the given link:  If already available, then skip
## destination file:  Base_explodat_Prj1

destfile1 <- "Base_explodat_Prj1.zip"

##  Use download.file() to fetch the file into the destfile1
if (!file.exists(destfile1)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                         destfile = destfile1,
                         method = "auto")
}

## Reading the data from the contents of the zipped file destfile1 
## Use unz() to extract the target file[household_power_consumption.txt]
## from the destfile1  and assign to pw_consump

pw_consump = read.csv(unz(destfile1, "household_power_consumption.txt"), header=T,
                    sep=";", stringsAsFactors=F, na.strings="?",
                    colClasses=c("character", "character", "numeric",
                                 "numeric", "numeric", "numeric",
                                 "numeric", "numeric", "numeric"))

## data requirement is for 2 days (01/02/2007 and 02/02/2007) only;
## subset the data as required; 'Date and time' is in format dd/mm/yyyy hh:mm:ss
## time zone is taken as, GMT hence "UTC"
pw_consump$timestamp = strptime(paste(pw_consump$Date, pw_consump$Time),
                              format="%d/%m/%Y %H:%M:%S", tz="UTC")
startDate = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
endDate = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")

pw_consump = pw_consump[pw_consump$timestamp >= startDate & pw_consump$timestamp <= endDate, ]


## Creating the plot with file name "plot4.png" occupying pixels 480x480
png(filename="plot4.png", width=480, height=480)
## Plot type: Generic-X-Y Plotting:  lines, 

# Setting space for Multiple (4)plots;  The order of coding: top left, bottom left
# top rignt,  bottom right
par(mfcol=c(2,2))

# First plot in the top left
plot(pw_consump$timestamp, pw_consump$Global_active_power, 
     type="l", 
     xlab="", ylab="Global Active Power")

# Second Plot in the bottom left
plot(pw_consump$timestamp, pw_consump$Sub_metering_1, 
     type="l", xlab="",
     ylab="Energy sub metering")
lines(pw_consump$timestamp, pw_consump$Sub_metering_2, col="red")
lines(pw_consump$timestamp, pw_consump$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=par("lwd"), bty="n")

# Third plot in the top right
plot(pw_consump$timestamp, pw_consump$Voltage, 
     type="l",
     xlab="datetime", ylab="Voltage")

# Fourth plot in the bottom right
plot(pw_consump$timestamp, pw_consump$Global_reactive_power, 
     type="l", 
     xlab="datetime", ylab="Global_reactive_power")

## Exit the device; close plotting device
dev.off()

