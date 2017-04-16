
# Step 0.  
# Download from remote source to file week4_dataset.zip and unzip data to folder 'UCI HAR Dataset'.
# Use variable 

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

# https://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html
# downsize to dates in range 2/1/2007 and 2/2/2007
# alldata <- read.csv(datafile,header=TRUE,sep=";",na.strings=c("?"),as.is=TRUE)
# alldata <- read.csv(datafile,header=TRUE,sep=";",na.strings=c("?"),as.is=TRUE,colClasses = c("Date","character",rep(c("numeric"),7)))
# For colClasses can also do colClasses=c("Date"="Date") for just one column.
alldata <- read.csv(datafile,header=TRUE,sep=";",na.strings=c("?"),as.is=TRUE,colClasses = c("Date","character",rep(c("numeric"),7)))
data <- subset(alldata, as.Date(Date,"%d/%m/%Y") >= as.Date("2007-02-01") & as.Date(Date,"%d/%m/%Y") <= as.Date("2007-02-02") )
