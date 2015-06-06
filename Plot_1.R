fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile="exdata_data_household_power_consumption.zip",method="libcurl")
unzip("exdata_data_household_power_consumption.zip")
library(sqldf)
data<-read.csv.sql("household_power_consumption.txt",sep=";",sql="select * from file where Date in ('1/2/2007','2/2/2007')")
datacopy<-data
library(lubridate)
datacopy$Date<-dmy(datacopy$Date)
datacopy$Time<-strptime(datacopy$Time,format="%T")
png("plot1.png", width=480, height=480)
hist(datacopy[,3],col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
##par(mar=c(w, x, y, z))
dev.off()
