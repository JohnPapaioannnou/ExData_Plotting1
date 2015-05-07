hpc <- "household_power_consumption.txt"
power <- read.table(hpc, header=T, sep=";")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
sub <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
sub$Global_active_power <- as.numeric(as.character(sub$Global_active_power))
sub$Global_reactive_power <- as.numeric(as.character(sub$Global_reactive_power))
sub$Voltage <- as.numeric(as.character(sub$Voltage))
sub <- transform(sub, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
sub$Sub_metering_1 <- as.numeric(as.character(sub$Sub_metering_1))
sub$Sub_metering_2 <- as.numeric(as.character(sub$Sub_metering_2))
sub$Sub_metering_3 <- as.numeric(as.character(sub$Sub_metering_3))

plot4 <- function() {
        par(mfrow=c(2,2))

        plot(sub$timestamp,sub$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        plot(sub$timestamp,sub$Voltage, type="l", xlab="datetime", ylab="Voltage")
        plot(sub$timestamp,sub$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(sub$timestamp,sub$Sub_metering_2,col="red")
        lines(sub$timestamp,sub$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=1) 
        plot(sub$timestamp,sub$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
}
plot4()
