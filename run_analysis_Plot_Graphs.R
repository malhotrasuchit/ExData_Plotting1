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

par(mfrow=c(1,1))
png(file = "plot1.png", width=480, height=480)
hist(plotsubsetdata$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

png(file = "plot2.png", width=480, height=480)
plot(plotsubsetdata$SetTime, plotsubsetdata$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

columnlines <- c("black", "red", "blue", width=480, height=480)
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
png(file = "plot3.png")
plot(plotsubsetdata$SetTime, plotsubsetdata$Sub_metering_1, type="l", col=columnlines[1], xlab="", ylab="Energy sub metering")
lines(plotsubsetdata$SetTime, plotsubsetdata$Sub_metering_2, col=columnlines[2])
lines(plotsubsetdata$SetTime, plotsubsetdata$Sub_metering_3, col=columnlines[3])
legend("topright", legend=labels, col=columnlines, lty="solid")
dev.off()

png(file = "plot4.png")
par(mfrow=c(2,2))
plot(plotsubsetdata$SetTime, plotsubsetdata$Global_active_power, type="l", col="green", xlab="", ylab="Global Active Power")
plot(plotsubsetdata$SetTime, plotsubsetdata$Voltage, type="l", col="orange", xlab="datetime", ylab="Voltage")
plot(plotsubsetdata$SetTime, plotsubsetdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(plotsubsetdata$SetTime, plotsubsetdata$Sub_metering_2, type="l", col="red")
lines(plotsubsetdata$SetTime, plotsubsetdata$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", legend=labels, lty=1, col=columnlines)
plot(plotsubsetdata$SetTime, plotsubsetdata$Global_reactive_power, type="l", col="blue", xlab="datetime", ylab="Global_reactive_power")
dev.off()
