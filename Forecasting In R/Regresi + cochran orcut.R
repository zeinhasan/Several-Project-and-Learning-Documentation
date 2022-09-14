#Memanggil data textbook 3.9
library(readxl)
data3.9 <- read_excel(file.choose())
head(data3.9)

# Model Regresi
model1 = lm(Anomaly ~ CO2,data=data3.9)
model1
9
##Uji autokorelasi Metode Durbin Watson Test
library(car)
dwt(model1, alternative="positive")

##Uji autokorelasi Metode Cochrane-Orcut
library(orcutt)
coch=cochrane.orcutt(model1)
coch

#Uji Normalitas
residuals(model1)
shapiro.test(residual)

#Uji homokedastisitas
bptest(model1)

# Uji multikolinearitas
vif(model1)

# Uji Autokorelasi
dwtest(model1)

