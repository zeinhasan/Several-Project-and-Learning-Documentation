library(ggplot2)
library(forecast)
library(tseries)

# Read data
data <- read.delim('clipboard')

# Make Time serie plot
datats<- ts(data[,2],start = c(2015,1), frequency = 12)
autoplot(datats)+
  ylab("value")+
  xlab("time")+
  ggtitle("Data Asli")

# Double Exponential Smoothing method
Holt <- holt(datats,h=5)
summary(Holt)
autoplot(Holt)

