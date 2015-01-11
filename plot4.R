plot4 <- function() {
  
  ## First check the working directory for the data file
  ## and download if necessary.
  
  if(!file.exists("household_power_consumption.txt")){
    message("Downloading data")
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="pwrconsumption.zip")
    unzip("powerconsumption.zip")
  }
  
  ## Read the data file into R.
  
  pwr_cons <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses="character")
  
  ## Create variable DT to hold the date ant time in 
  ## Date/Time classes in R.
  
  pwr_cons$DT <- strptime(paste(pwr_cons$Date, pwr_cons$Time), format="%d/%m/%Y %H:%M:%S")
  
  ## Create an abbreviated data table that contains only
  ## data for the dates of interest.
  
  pwr_cons_abbr <- subset(pwr_cons, pwr_cons$Date=="1/2/2007" | pwr_cons$Date=="2/2/2007")
  
  ## Convert Global_active_power to a numeric variable.
  
  pwr_cons_abbr$Global_active_power <- as.numeric(pwr_cons_abbr$Global_active_power)
  
  ## Initialize graphics device.
  
  png(filename="plot4.png", width=480, height=480)
  
  ## Specify multiple plots.
  par(mfrow=c(2,2))
  
  ## Create first plot.
  plot(pwr_cons_abbr$DT, pwr_cons_abbr$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
  ## Create second plot.
  plot(pwr_cons_abbr$DT, pwr_cons_abbr$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  ## Create third plot.
  plot(pwr_cons_abbr$DT, pwr_cons_abbr$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  points(pwr_cons_abbr$DT, pwr_cons_abbr$Sub_metering_2, col="red", type="l")
  points(pwr_cons_abbr$DT, pwr_cons_abbr$Sub_metering_3, col="blue", type="l")
  legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)
      
  ## Create fourth plot.
  plot(pwr_cons_abbr$DT, pwr_cons_abbr$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  ## Turn of graphics device.
  
  dev.off()
  
}