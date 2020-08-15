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
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data2<- subset(data, Date >= as.Date("2007-02-01")) %>%
        subset(Date<=as.Date("2007-02-02")) %>%
        filter(!is.na(Sub_metering_1)) %>%
        filter(!is.na(Sub_metering_2)) %>%
        filter(!is.na(Sub_metering_3))
date_time<-strptime(paste(data2$Date,data2$Time,sep = " "), "%Y-%m-%d %H:%M:%S" )

## Plot data

png("plot3.png",width=480,height=480)
plot(date_time, data2$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering", col="black")
lines(date_time, data2$Sub_metering_2,col="red")
lines(date_time, data2$Sub_metering_3,col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"),lwd=1)
dev.off()
