
data 
n=length(data)
n

# Single Moving Average K=diisi (SMAK)
K=x
SMAK <- array(NA,dim=c(n))
SMAK

for (i in 1:n){
  SMAK[i+(k-1)]=mean(data[i:(i+(k-1))])
}

SMAK

# Single Moving Average K=diisi (DMAK)
m=x
DMAK <- array(NA,dim=c(n))
DMAK

for(i in 1:n){
  DMAK[i+(m-1)+(k-1)]=mean(SMAK[(i+(k-1)):(i+(m-1)+(k-1))])
}

DMAK

# Mencari nilai a
a=array(NA,dim=c(n))

for(i in 1:n){
  a[i+(m-1)+(k-1)]=2*SMAK[i+(m-1)+(k-1)]-DMAK[i+(m-1)+(k-1)]
}

a

# Mencari Nilai B
b=array(NA,dim=c(n))

for(i in 1:n){
  b[i+(m-1)+(k-1)]=(2/(m-1))*(SMAK[i+(m-1)+(k-1)]-DMAK[i+(m-1)+(k-1)])
}

# Forecast
Forecast <- function(h){
  a[n]+b[n]*h
}

ramalan = Forecast(h)
ramalan

# Mencari Akurasi 
prediksi = array(NA,dim=c(n))
for (i in 1:n) {
  prediksi[i+(m-1)+(k-1)]=a[i+(m-1)+(k-1)]+b[i+(m-1)+(k-1)]
}
prediksi

# Error
e= array(NA,dim=c(n))
for (i in 1:n){
  e[i]=(x[i]-prediksi[i])^2
}
e

# MSE
MSE=mean(e,na.rm=TRUE)

# RMSE
RMSE=sqrt(MSE)
