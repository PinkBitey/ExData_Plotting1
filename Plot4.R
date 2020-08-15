# Load libraries

library(data.table)
library(dplyr)

### Download and unzip dataset

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile="dataset.zip")
unzip("dataset.zip")

## Read data into R

data<-read.table("household_power_consumption.txt", sep=";",header=TRUE, 
                 stringsAsFactors = FALSE,na.strings="?")
data<-tbl_df(data)

## Clean and subset data

data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data2<- subset(data, Date >= as.Date("2007-02-01")) %>%
        subset(Date<=as.Date("2007-02-02"))
date_time<-strptime(paste(data2$Date,data2$Time,sep = " "), "%Y-%m-%d %H:%M:%S" )
data3<- filter(data2,!is.na(Sub_metering_1)) %>%
        filter(!is.na(Sub_metering_2)) %>%
        filter(!is.na(Sub_metering_3))
data4<-filter(data2,!is.na(Global_active_power))
data5<-filter(data2,!is.na(Voltage))
data6<-filter(data2,!is.na(Global_reactive_power))

## Plot data

png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))
plot(date_time, data4$Global_active_power,type="l",xlab="",ylab="Global Active Power")
plot(date_time, data5$Voltage,type="l",xlab="datetime",ylab="Voltage")
plot(date_time, data3$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering", col="black")
lines(date_time, data3$Sub_metering_2,col="red")
lines(date_time, data3$Sub_metering_3,col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"),lwd=1)
plot(date_time, data6$Global_reactive_power,type="l",xlab="datetime",ylab="Global_Reactive_Power")
dev.off()
