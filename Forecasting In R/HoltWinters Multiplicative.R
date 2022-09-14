library(ggplot2)
library(forecast)
library(tseries)

# Read data
data <- read.delim('clipboard')

# Make Time serie plot
datats<- ts(data[,2],start = c(1,1), frequency = 12)
autoplot(datats)+
  ylab("value")+
  xlab("time")+
  ggtitle("Data Asli")

# HoltWinters method
model = HoltWinters(datats,seasonal ="multiplicative")
model
ramal <- forecast(model,h=3)
summary(ramal)
autoplot(ramal)
