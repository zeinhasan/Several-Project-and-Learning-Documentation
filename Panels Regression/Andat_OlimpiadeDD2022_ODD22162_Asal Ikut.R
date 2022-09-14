### Andat_OlimpiadeDD2022_ODD22162_Asal Ikut


### Mengimpor library yang diperlukan
library(tidyverse)
library(plm)
library(lmtest)
library(readxl)
library(psych)
library(car)


### Mengimport data
path = "E:/Data Transaksi Saham per Bulan Juni Tahun 2019-2022 Cleaned.xlsx"
data = read_excel(path)


### Merapikan data dengan membuat variabel Year dan Code sebagai faktor
data$Year = as.factor(data$Year)
data$Code = as.factor(data$Code)
str(data)
view(data)


### Membuat data2 yang berisi variabel-variabel terpilih untuk dianalisis lebih lanjut
data2 = data[,c(7:17,5)] 


### Membuat variabel dummy pada variabel Sharia
data2$Sharia = ifelse(data2$Sharia == 'S', 1, 0)
str(data2)


### Uji untuk memilih model ce, fe, atau re
#Membentuk model ce (common effect) dan fe (fixed effect) untuk selanjutnya diuji Chow
ce = plm(data2$Total.Volume~data2$Sharia+data2$Market.Cap+
           data2$Regular.Volume+data2$Regular.Value+
           data2$Regular.Freq+data2$Regular.Days+
           data2$Total.Value+data2$Total.Freq+
           data2$Total.Days,data=data2,model="pooling",index=c("Code","Year"))

fe = plm(data2$Total.Volume~data2$Sharia+data2$Market.Cap+
           data2$Regular.Volume+data2$Regular.Value+
           data2$Regular.Freq+data2$Regular.Days+
           data2$Total.Value+data2$Total.Freq+
           data2$Total.Days,data=data2,model="within",index=c("Code","Year"))

#Uji Chow
pooltest(ce,fe) 
#Diperoleh hasil bahwa p-value > 0.05 sehingga akan dipakai model common effect (ce)


### Uji Asumsi Klasik 
#Uji linearitas pada variabel kuantitatif
win.graph()
pairs.panels(data[,c(8:11,13)], 
             method = "pearson",
             hist.col = "#00AFBB",
             density = TRUE,
             ellipses = TRUE)

win.graph()
pairs.panels(data[,c(12,15,16,14,13)], 
             method = "pearson",
             hist.col = "#00AFBB",
             density = TRUE,
             ellipses = TRUE)

#Uji no-autokorelasi
model1 = lm(data2$Total.Volume~data2$Sharia+data2$Market.Cap+
              data2$Regular.Volume+data2$Regular.Value+
              data2$Regular.Freq+data2$Regular.Days+
              data2$Total.Value+data2$Total.Freq+
              data2$Total.Days,data=data2)
dwtest(model1)
#Uji no-autokorelasi tidak bisa dilakukan pada model ce karena akan menghasilkan p-value berupa NA

#cek multikolinearitas model ce
vif(ce)

#Mengexport data2 [untuk dilakukan (first) differencing di SPSS]
file.data2 <- writexl::write_xlsx(data2, 'Data Untuk First Differencing.xlsx') 

### Melakukan first differencing di SPSS karena data memiliki multikolinearitas
#Mengimpor data hasil first differencing
path2 = "E:/Data Hasil First Differencing.xlsx"
data3 = read_excel(path2)


### Membentuk model dari data hasil first differencing
#Membuat model ce2 
ce2=plm(data3$DifTVol~data3$DifShria+data3$DifMCap+
         data3$DifRVol+data3$DifRVal+
         data3$DifRFreq+data3$DifRDay+
         data3$DifTVal+data3$DifTFreq+
         data3$DifTDays,data=data3,model="pooling",index=c("Code","Year"))
#Cek multikolinearitas model ce2
round(vif(ce2),5)

#Membuat model ce3 dari data first differencing dengan mengeluarkan variabel DifTFreq
ce3=plm(data3$DifTVol~data3$DifShria+data3$DifMCap+
          data3$DifRVol+data3$DifRVal+
          data3$DifRFreq+data3$DifRDay+
          data3$DifTVal+
          data3$DifTDays,data=data3,model="pooling",index=c("Code","Year"))
#Cek multikolinearitas model ce3
round(vif(ce3),5)

#Membuat model ce4 dari data first differencing dengan mengeluarkan variabel DifTDays
ce4=plm(data3$DifTVol~data3$DifShria+data3$DifMCap+
          data3$DifRVol+data3$DifRVal+
          data3$DifRFreq+data3$DifRDay+
          data3$DifTVal,data=data3,model="pooling",index=c("Code","Year"))
#Cek multikolinearitas model ce4
round(vif(ce4),5)

#Membuat model ce5 dari data first differencing dengan mengeluarkan variabel DifRVal
ce5=plm(data3$DifTVol~data3$DifShria+data3$DifMCap+
          data3$DifRVol+
          data3$DifRFreq+data3$DifRDay+
          data3$DifTVal,data=data3,model="pooling",index=c("Code","Year"))
#Cek multikolinearitas model ce5
round(vif(ce5),5)

#Homoskedastistas
bptest(ce5)


### Uji Wald
#Model ce5
summary(ce5)

#Membuat model ce6 dengan mengeluarkan variabel DifShria
ce6=plm(data3$DifTVol~data3$DifMCap+
          data3$DifRVol+
          data3$DifRFreq+data3$DifRDay+
          data3$DifTVal,data=data3,model="pooling",index=c("Code","Year"))
summary(ce6)

#Membuat model ce6 dengan mengeluarkan variabel konstanta
ce7=plm(data3$DifTVol~data3$DifMCap+
          data3$DifRVol+
          data3$DifRFreq+data3$DifRDay+
          data3$DifTVal+0,data=data3,model="pooling",index=c("Code","Year"))
summary(ce7)


### Diagnostic Checking
#Uji Korelasi Serial
pdwtest(ce5)
pdwtest(ce6)
pdwtest(ce7)

#Uji Homoskedastisitas
bptest(ce5)
bptest(ce6)
bptest(ce7)