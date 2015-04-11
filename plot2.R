## Coursera - Exploratory Data Analysis - Course Project 1-2
## R code file  plot2.R that constructs the plot plot2.png
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


## Creating the plot with file name "plot2.png" occupying pixels 480x480
png(filename="plot2.png", width=480, height=480)
## Plot type: Generic-X-Y Plotting:  lines, 
## no title for X: y axis lable in "ylab=": colour default

plot(pw_consump$timestamp, pw_consump$Global_active_power, type="l", xlab="",
     ylab="Global Active Power (kilowatts)")
## Exit the device; close plotting device
dev.off()

