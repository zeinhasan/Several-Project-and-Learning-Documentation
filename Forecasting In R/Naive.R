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

# Naive Method
model <- naive(datats,h=1)
# Summary data
summary(model)
# plot forecast
autoplot(model)
