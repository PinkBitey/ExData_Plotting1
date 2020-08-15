## Load libraries

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

data$Global_active_power<-as.numeric(data$Global_active_power)
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data$Time<-strptime(data$Time,format="%H:%M:%S")
data2<- subset(data, Date >= as.Date("2007-02-01")) %>%
        subset(Date<=as.Date("2007-02-02")) %>%
        filter(!is.na(Global_active_power))
date_time<-strptime(paste(data2$Date,data2$Time,sep = " "), "%Y-%m-%d %H:%M:%S" )

## Plot data

png("plot2.png",width=480,height=480)
plot(date_time, data2$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
