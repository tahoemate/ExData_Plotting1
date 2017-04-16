# Class Exploratory Data Analysis - Week1
# Plot 4: Four plots on same chart in 2 rows of 2 columns
# Date Range:  2/1/2007 = 2/2/2007

# Step 0.  
# Download from remote source if needed

overwriteData <- FALSE   # set to TRUE to download data even if it exists (used to refresh data)
zipfile <- "week1_dataset.zip"  # 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datafile <- "household_power_consumption.txt"

if (overwriteData | !file.exists(datafile)) { 
  if (overwriteData | !file.exists(zipfile)) {
    # download.file(fileUrl, zipfile, method="curl")  # non-windows version
    download.file(fileUrl, zipfile)  
  }
  unzip(zipfile) 
  if (!file.exists(datafile)) {
    stop("Unable to locate data!")
  }
}

# Helpful: https://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html
# downsize to dates in range 2/1/2007 and 2/2/2007
alldata <- read.csv(datafile,header=TRUE,sep=";",na.strings=c("?"),as.is=TRUE)
data <- subset(alldata, as.Date(Date,"%d/%m/%Y") >= as.Date("2007-02-01") & as.Date(Date,"%d/%m/%Y") <= as.Date("2007-02-02") )

# Compute once and use for all charts where needed
dates = as.POSIXct(paste(strptime(as.Date(data$Date,"%d/%m/%Y"), "%Y-%m-%d"),data$Time))

png(file="plot4.png")   # works better if draw straight to file

par(mfrow=c(2,2))    # Setup a plot grid 2x2


###############################
# Plot 1: Global Active Power vs Time

# Plot Global Active Power vs Date/Time.  Use type="l" or you'll get a scatterplot.
plot( x=dates,y=data$Global_active_power,ylab="Global Active Power",xlab="",type="l")

###############################
# Plot 2: Voltage vs Time

plot( x=dates,y=data$Voltage,ylab="Voltage",xlab="datetime",type="l")

###############################
# Plot 3: Sub Metering

plot( x=dates,y=data$Sub_metering_1,ylab="Energy sub metering",xlab="",type="l")
lines( x=dates,y=data$Sub_metering_2,type="l",col="red")
lines( x=dates,y=data$Sub_metering_3,type="l",col="blue")

legend("topright", c("Sub_meeting_1","Sub_meeting_2","Sub_meeting_3"),lwd=1,col=c("black","red","blue"))

###############################
# Plot 4: Global Reactive Power

plot( x=dates,y=data$Global_reactive_power,ylab="Global Reactive Power",xlab="datetime",type="l")


#dev.copy(png, "plot4.png")
dev.off()

print("Done Plot 4.")
