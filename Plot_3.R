fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile="exdata_data_household_power_consumption.zip",method="libcurl")
unzip("exdata_data_household_power_consumption.zip")
library(sqldf)
data<-read.csv.sql("household_power_consumption.txt",sep=";",sql="select * from file where Date in ('1/2/2007','2/2/2007')")
datacopy<-data
library(lubridate)
datacopy$Date<-dmy(datacopy$Date)
datacopy$datetime<-as.POSIXct(paste(datacopy$Date, datacopy$Time), format="%Y-%m-%d %H:%M:%S")
png("plot3.png", width=480, height=480)

plot(datacopy$datetime,datacopy$Sub_metering_1,
                   type="l",ylab="Energy sub metering",sub="",xlab=NA)
lines(datacopy$datetime,datacopy$Sub_metering_2,col="red")
lines(datacopy$datetime,datacopy$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd=2, pch=c(NA,NA,NA)
       )

dev.off()