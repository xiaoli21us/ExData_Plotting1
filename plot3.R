## read in household_power_consumption data

raw_data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
raw_data$Date <- as.Date(raw_data$Date, format="%d/%m/%Y")

## Subset the data to February 2007 1st
subdata <- subset(raw_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(raw_data)

## Convert date
datetime <- paste(as.Date(subdata$Date), subdata$Time)
subdata$Datetime <- as.POSIXct(datetime)

## Plot 3
with(subdata, {
 plot(Sub_metering_1~Datetime, type="l",
      ylab="Global Active Power (kilowatts)", xlab="")
 lines(Sub_metering_2~Datetime,col='Red')
 lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving the png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()