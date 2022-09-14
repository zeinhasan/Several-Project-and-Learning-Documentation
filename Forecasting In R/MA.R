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

x= nrow(data)

MA<- function(MAperiod=2){
  Fxma <- matrix()
  Fyma <- matrix()
  z=MAperiod
  i=1
  while(z<=x){
    Fyma[z+1] <- mean(data$Data.Bunga[i:z])
    z=1+z
    i=i+1
  }
  Yma <- data.frame(Fyma)
  z1=MAperiod+1
  MAEma <-function(){
    valma=(sum(abs(data$Data.Bunga[z1:x]-Yma$Fyma[z1:x])))/(x-MAperiod)
    valma
  }
  MSEma <- function(){
    val1ma=(sum((data$Data.Bunga[z1:x]-Yma$Fyma[z1:x])*(data$Data.Bunga[z1:x]-Yma$Fyma[z1:x])))/(x-MAperiod)
    val1ma
  }
  RMSEma<- function(){
    val1ma=(sum((data$Data.Bunga[z1:x]-Yma$Fyma[z1:x])*(data$Data.Bunga[z1:x]-Yma$Fyma[z1:x])))/(x-MAperiod)
    val2ma=sqrt(val1ma)
    val2ma
  }
  yma  <- nrow(Yma) 
  cat("                     Peramalan Data Stasioner                      \n")
  cat("                      Metode Moving Average                        \n")
  cat("-------------------------------------------------------------------\n")
  cat("                                                                   \n")
  cat("Hasil Peramalan 1 Periode Kedepan Adalah :",Yma$Fyma[yma],"\n")
  cat("Nilai MAE Sebesar :",MAEma(),"\n")
  cat("Nilai MSE Sebesar :",MSEma(),"\n")
  cat("Nilai MSE Sebesar :",RMSEma(),"\n")
  plot(data$Data.Bunga,type="l",col="blue",main="Metode Moving Average",
       ylab="Data.Bunga(%)",xlab=NA)
  lines(Yma$Fyma,col="red")
  legend(legend=c("Data Asli","Data Ramalan"),col=c("blue","red"),'topleft',
         cex=1,fill=c("blue","red"),title="Keterangan")
}
MA(MAperiod = 2)

