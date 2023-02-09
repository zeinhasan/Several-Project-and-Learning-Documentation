#memanggil library
library(openxlsx)
library(tidyverse)
library(AID)
library(MASS)
library(car)
library(plotly)

#Menyiapkan data
anova<-read.xlsx(file.choose(),sheet=1)

anova1<-anova%>%
  gather(key="jenis.rendaman",value="hasil.pengerasan")

#Cek asumsi
#1. Normalitas data
cek_nor<-boxplot(anova[1:3],col=c("green","yellow","pink"),
                 border="blue",
                 xlab="jenis rendaman",
                 ylab="satuan tertentu",
                 main="Cek Normalitas")

#Transformasi Data
#1. Transformasi Box-cox dengan library AID
out = boxcoxnc(anova1$hasil.pengerasan, method = "mle", 
               lambda = seq(-5,5,0.001), verbose = F, plot = F)
out$lambda.hat

#2. Transformasi Box-cox dengan library MASS
out = boxcox(anova1$hasil.pengerasan~1, lambda = seq(-5,5,0.0001), plotit = F)
out$x[which.max(out$y)]

#3.Transformasi Box-cox dengan library car
out = powerTransform(anova1$hasil.pengerasan, family = "bcPower")
out$lambda

#setiap dantum dipangkatkan dengan 5
transformasi.bc=function(data, lambda){
  for(i in 1:length(data)){
    data[i]=data[i]^lambda
  }
  return(data)
}

#data hasil transformasi
anova2=anova1 %>% 
  mutate(transformasi=transformasi.bc(anova1$hasil.pengerasan,5))%>%
  dplyr::select(-hasil.pengerasan)

#cek normalitas setelah data ditransformasi
cek_norm1<-ggplot(anova2, aes(x=jenis.rendaman,y=transformasi))+
  geom_boxplot(fill="blue",color="pink")+
  ggtitle("Cek Normalitas")+
  xlab("Jenis Rendaman")+
  ylab("Satuan tertentu")
ggplotly(cek_norm1)

#2. Asumsi Kesamaan Variansi
cek_var<-anova2 %>% 
  group_by(jenis.rendaman) %>% 
  summarise(var(transformasi))

#jika var tertinggi > 3 variansi rendah, maka terjadi heterogenitas variansi
max(cek_var$`var(transformasi)`) > 3*min(cek_var$`var(transformasi)`)

#3. Independensi data

#Uji Anova
anova3<-aov(transformasi~jenis.rendaman,data=anova2)
anova3

summary(anova3)

#F tabel
qf(0.95,2,27)


# Latihan 1
data <- chickwts

# Uji Normalitas
x = ggplot(data, aes(x=feed,y=weight,fill=feed))+
  geom_boxplot()+
  ggtitle("data berat badan anak ayam")+
  xlab("Variabel")+
  ylab("Values")

ggplotly(x)

# Transformasi
out = powerTransform(data$weight, family = "bcPower")
out$lambda

# Transformasi
data$weighttf <- (data$weight)^(0.8528872)

# Data hasil transformasi 
y = ggplot(data, aes(x=feed,y=weighttf,fill=feed))+
  geom_boxplot()+
  ggtitle("data berat badan anak ayam hasil transformasi")+
  xlab("Variabel")+
  ylab("Values")
ggplotly(y)

# Uji Kesamaan variansi 
cek_var1<-data %>% 
  group_by(feed) %>% 
  summarise(var(weighttf))
cek_var1

#Uji Anova
anovalat1<-aov(weighttf~feed,data=data)
anovalat1

summary(anovalat1)

# MCA 
TukeyHSD(anovalat1)

# Latihan 2
data2 <- read.delim("clipboard")
library(reshape)

# Melt data
data2reshape <- melt(data2)

# Uji Normalitas 
a = ggplot(data2reshape, aes(x=variable,y=value,fill=variable))+
  geom_boxplot()+
  ggtitle("data hasil kain per menit ")+
  xlab("Variabel")+
  ylab("Values")

ggplotly(a)

# Transformasi
out = powerTransform(data2reshape$value, family = "bcPower")
out$lambda

data2reshape$valuetf <- (data2reshape$value)^16.59178

# Uji boxplot hasil transformasi  
b = ggplot(data2reshape, aes(x=variable,y=valuetf,fill=variable))+
  geom_boxplot()+
  ggtitle("data hasil kain per menit transformed")+
  xlab("Variabel")+
  ylab("Values")

ggplotly(b)

# Uji Kesamaan variansi 
cek_var2<-data2reshape %>% 
  group_by(variable) %>% 
  summarise(var(value))
cek_var2

# Anova 1 arah
#Uji Anova
anovalat2<-aov(value~variable,data=data2reshape)
anovalat2

summary(anovalat2)

# Tukey HSD
