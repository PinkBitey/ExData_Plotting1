## Load libraries

library(data.table)

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
data2<- subset(data, Date >= as.Date("2007-02-01")) %>%
        subset(Date<=as.Date("2007-02-02"))

## Plot data

png("plot1.png",width=480,height=480)
hist(data2$Global_active_power, breaks=12,col="red",main="Global Active Power", 
        xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
