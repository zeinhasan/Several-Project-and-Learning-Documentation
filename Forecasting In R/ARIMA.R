#Loading the required library
library(ggplot2)
library(forecast)
library(tseries)
library(lmtest)

#Importing the data
data<-read.delim("clipboard", header = F)
data<-ts(data$V1,start = c(1993,1),freq=12)

#Creating the plot
autoplot(data)+xlab("Waktu (Tahun)") + 
  ylab("Jumlah Produksi") + 
  ggtitle("Plot Data Asli") + geom_point()

#Stationarity Test
adf.test(data)

#Transforming data
##Checking the number of differences required
ndiffs(log(data),"adf")

##Diff 1
ddif1 = diff(data, differences=1)
adf.test(ddif1)
autoplot(ddif1)

#Diff 1 with Log-Trans
dtrans1 = diff(log(data), differences=1)
adf.test(dtrans1)
autoplot(dtrans1)

#Identifying the model
#Membuat plot ACF dan PACF
ggAcf(dtrans1,lag.max = 40) + ggtitle("ACF")
ggPacf(dtrans1,lag.max = 40) + ggtitle("PACF")
##ARIMA(2,1,1)##

#Underfitting
c211<-Arima(data,order=c(2,1,1),include.constant = T, lambda = 0)
coeftest(c211)
c210<-Arima(data,order=c(2,1,0),include.constant = T, lambda = 0)
coeftest(c210)
c111<-Arima(data,order=c(1,1,1),include.constant = T, lambda = 0)
coeftest(c111)
c110<-Arima(data,order=c(1,1,0),include.constant = T, lambda = 0)
coeftest(c110)
c011<-Arima(data,order=c(0,1,1),include.constant = T, lambda = 0)
coeftest(c011)

tc211<-Arima(data,order=c(2,1,1),include.constant = F, lambda = 0)
coeftest(tc211)
tc210<-Arima(data,order=c(2,1,0),include.constant = F, lambda = 0)
coeftest(tc210)
tc111<-Arima(data,order=c(1,1,1),include.constant = F, lambda = 0)
coeftest(tc111)
tc110<-Arima(data,order=c(1,1,0),include.constant = F, lambda = 0)
coeftest(tc110)
tc011<-Arima(data,order=c(0,1,1),include.constant = F, lambda = 0)
coeftest(tc011)

#Diagnostic Checking
Box.test(c210$residuals,type="Ljung")
jarque.bera.test(c210$residuals)
checkresiduals(c210)

Box.test(c011$residuals,type="Ljung")
jarque.bera.test(c011$residuals)
checkresiduals(c011)

Box.test(tc210$residuals,type="Ljung")
jarque.bera.test(tc210$residuals)
checkresiduals(tc210)

Box.test(tc110$residuals,type="Ljung")
jarque.bera.test(tc110$residuals)
checkresiduals(tc110)

Box.test(tc011$residuals,type="Ljung")
jarque.bera.test(tc011$residuals)
checkresiduals(tc011)

#Best model selection
c210
c011
tc210
tc110
tc011

#Best model
##Plot##
autoplot(c011$x, col="darkblue") + 
  autolayer(fitted(c011), series = "Data Ramalan") + 
  ylab("Jumlah Produksi") + 
  ggtitle("Plot Data Asli vs Ramalan")
##Forecast and Accuracy##
accuracy(c011)
forecast(c011,3)
autoplot(forecast(c011,3))

##AUTO ARIMA###
auto.arima(data)
accuracy(auto.arima(data))
