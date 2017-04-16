# Class Exploratory Data Analysis - Week1
# Plot 2: Plot of Global Active Power
# Date Range:  2/1/2007 = 2/2/2007

# Step 0.  
# Download from remote source


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

# Plot Global Active Power vs Date/Time.  Remember to use type="l" or you'll get a scatterplot.
plot( x=as.POSIXct(paste(strptime(as.Date(c$Date,"%d/%m/%Y"), "%Y-%m-%d"),c$Time)),y=c$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",type="l")

dev.copy(png, "plot2.png")
dev.off()

print("Done Plot 2.")
