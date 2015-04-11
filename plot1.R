## Coursera - Exploratory Data Analysis - Course Project 1-1

## Calculating Memory Requirements
##I have a data frame with 2,075,259 rows and 9 columns, all of which are numeric data. Roughly, 
##  how much memory is required to store this data frame?
## 149,418,648  bits/numeric
## = 149,418,648 bytes = 149,418,648 / 2^20 bytes/MB = 1,373.29MB = 0.14 GB
## Will need roughly double the memory to read data into R because of the overhead.

## R code file  plot1.R that constructs the plot plot1.png

## download the file using the given link:  If already available, then skip
## destination file:  Base_explodat_Prj1

destfile1 <- "Base_explodat_Prj1.zip"

##  Use download.file() to fetch the file into the destfile1
if (!file.exists(destfile1)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                         destfile = destfile1,
                         method = "auto")
}

###opened URL
###downloaded 19.7 Mb

## Reading the data from the contents of the zipped file destfile1 
## Use unz() to extract the target file[household_power_consumption.txt]
## from the destfile1  and assign to pw_consump

pw_consump = read.csv(unz(destfile1, "household_power_consumption.txt"), header=T,
                    sep=";", stringsAsFactors=F, na.strings="?",
                    colClasses=c("character", "character", "numeric",
                                 "numeric", "numeric", "numeric",
                                 "numeric", "numeric", "numeric"))

## data requirement is for 2 days (2007/02/01 and 2007/02/02) only;
## subset the data as required; 'Date' is in format dd/mm/yyyy

pw_consump$Date = as.Date(pw_consump$Date, format="%d/%m/%Y")
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")
pw_consump = pw_consump[pw_consump$Date >= startDate & pw_consump$Date <= endDate, ]

## Creating the plot with file name "plot1.png" occupying pixels 480x480
## plot type histogram, main title in "main=", x axis lable in "xlab=" and specify colur
png(filename="plot1.png", width=480, height=480)
hist(pw_consump$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
## Exit the device; close plotting device
dev.off()


