#Loading the required library
library(ggplot2)
library(forecast)
library(tseries)

#Importing the data
data<-read.delim("clipboard",header = F)
Data<-ts(data$V1,start = c(2000,1),freq=12)

#Creating the plot
autoplot(Data)+xlab("Waktu") + 
  ylab("Rainfall (MM)") + 
  ggtitle("Rainfall Data") + geom_point()

#Simple Exponential Smoothing
ses(Data, alpha = 0.2, h=3)
SES<-ses(Data, alpha = 0.2, h=3)
autoplot(SES)
accuracy(SES)