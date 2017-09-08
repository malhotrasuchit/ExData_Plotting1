setwd("./Exploratory Data Analysis/Week 1/CourseProject1/")
downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "./Data/household_power_consumption.zip"
householdFile <- "./Data/household_power_consumption.txt"
## Download file for base data if it does not exisit
if (!file.exists(householdFile)) {
  download.file(downloadURL, downloadFile, method = "curl")
  unzip(downloadFile, overwrite = T, exdir = "./Data")
}
##
basedata <- read.table(householdFile,header=T, sep = ";", na.strings = "?")
plotsubsetdata <- subset(basedata, Date %in% c("1/2/2007","2/2/2007"))
SetTime <-strptime(paste(plotsubsetdata$Date, plotsubsetdata$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
plotsubsetdata <- cbind(SetTime, plotsubsetdata)
plotsubsetdata$Date <- as.Date(plotsubsetdata$Date, format="%d/%m/%Y")

columnlines <- c("black", "red", "blue", width=480, height=480)
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

png(file = "plot3.png")
plot(plotsubsetdata$SetTime, plotsubsetdata$Sub_metering_1, type="l", col=columnlines[1], xlab="", ylab="Energy sub metering")
lines(plotsubsetdata$SetTime, plotsubsetdata$Sub_metering_2, col=columnlines[2])
lines(plotsubsetdata$SetTime, plotsubsetdata$Sub_metering_3, col=columnlines[3])
legend("topright", legend=labels, col=columnlines, lty="solid")
dev.off()
