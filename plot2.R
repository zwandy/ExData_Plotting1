#SCRIPT REQUIREMENT
#household_power_consumption.txt file must be present (and unzipped) in the same directory
#zipped file can be found at https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

plot2 <- function() {
  ##package sqldf is required
  if (!require(sqldf)){ 
    install.packages(pkg)
  }
  library(sqldf)
  
  file <- "household_power_consumption.txt"
  print("Reading household_power_consumption.txt - this might take a while...")
  data <- read.csv.sql(file, sep=";", header=TRUE, sql="select * from file where Date='1/2/2007' or Date='2/2/2007'")
  ##NOTE: this data source records NA fields as '?' - read.csv.sql will
  ##record 0.000 values for '?'
  print("File reading done.")
  
  ##need both Date and Time plotted, both are currently of class 'chr' and
  ##need to be a date class
  data$DateTime <- as.POSIXct(strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S"))
  
  ##plot to PNG file
  print("Creating the plot PNG file...")
  png(file="plot2.png")
  plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  devR <- dev.off() ##setting to a variable so that it doesn't show on screen
  
  print("All done!")
}