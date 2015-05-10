#SCRIPT REQUIREMENT
#household_power_consumption.txt file must be present (and unzipped) in the same directory
#zipped file can be found at https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

plot1 <- function() {
  ##package sqldf is required
  if (!require(sqldf)){ 
    install.packages(pkg)
  }
  library(sqldf)
  
  file <- "household_power_consumption.txt"
  print("Reading household_power_consumption.txt - this might take a while...")
  data <- read.csv.sql(file, sep=";", header=TRUE, sql="select * from file where Date='1/2/2007' or Date='2/2/2007'")
  ##NOTE: this data source records NA fields as '?' - read.csv.sql will record
  ##0.000 values for '?'
  print("File reading done.")

  ##plot to PNG file
  print("Creating the plot PNG file...")
  png(file="plot1.png")
  hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
  devR <- dev.off() ##setting to a variable so that it doesn't show on screen
  
  print("All done!")
}