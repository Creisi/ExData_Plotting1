fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile="exdata_data_household_power_consumption.zip",method="libcurl")
unzip("exdata_data_household_power_consumption.zip")
library(sqldf)
data<-read.csv.sql("household_power_consumption.txt",sep=";",sql="select * from file where Date in ('1/2/2007','2/2/2007')")
datacopy<-data
library(lubridate)
datacopy$Date<-dmy(datacopy$Date)
datacopy$datetime<-as.POSIXct(paste(datacopy$Date, datacopy$Time), format="%Y-%m-%d %H:%M:%S")
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
## Plot 2, first plot
with(datacopy,plot(datetime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",sub="",xlab=NA))
## Second Plot
with(datacopy,plot(datetime,Voltage,type="l"))
## Plot 3, third plot
plot(datacopy$datetime,datacopy$Sub_metering_1,
     type="l",ylab="Energy sub metering",sub="",xlab=NA)
lines(datacopy$datetime,datacopy$Sub_metering_2,col="red")
lines(datacopy$datetime,datacopy$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd=2,bty="n", pch=c(NA,NA,NA)
)
## Fourth Plot
with(datacopy,plot(datetime,Global_reactive_power,type="l",lwd=1))

dev.off()