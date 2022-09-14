# Data
data2019 <- read.delim("clipboard")
data2020 <- read.delim("clipboard")
data2021 <- read.delim("clipboard")
data2022 <- read.delim("clipboard")


#Add column Year
data2019$Year="2019"
data2020$Year="2020"
data2021$Year="2020"
data2022$Year="2022"

# asfactor
data2019$Code = as.factor(data2019$Code)
data2020$Code = as.factor(data2020$Code)
data2021$Code = as.factor(data2021$Code)
data2022$Code = as.factor(data2022$Code)

# as chr
data2019$Sub.Sector.Code=as.character(data2019$Sub.Sector.Code)
data2020$Sub.Sector.Code=as.character(data2020$Sub.Sector.Code)

# data NA to 0
data2019[is.na(data2019)]=0
data2020[is.na(data2020)]=0
data2021[is.na(data2021)]=0
data2022[is.na(data2022)]=0

# data "" to Tidak
data2019[data2019==""] <-"T"
data2020[data2020==""] <-"T"
data2021[data2021==""] <-"T"
data2022[data2022==""] <-"T"

# DropNA
data2019N=na.omit(data2019)
data2020N=na.omit(data2020)
data2021N=na.omit(data2021)
data2022N=na.omit(data2022)

# Subsetting data
indeks = intersect(data2019N$Code,data2020N$Code) %>% 
  intersect(.,data2021N$Code) %>% 
  intersect(.,data2022N$Code)

indek = as.factor(indeks)
# Filter data
data2019F=data2019N[data2019N$Code %in% indek,]
data2020F=data2020N[data2020N$Code %in% indek,]
data2021F=data2021N[data2021N$Code %in% indek,]
data2022F=data2022N[data2022N$Code %in% indek,]

# bind
data2021F$Year="2021"
data2 =bind_rows(data2019F,data2020F,data2021F,data2022F)

# Export
library(openxlsx)
write.xlsx(data2,"C:/Users/Zein/Downloads/Data Transaksi Saham per Bulan Juni Tahun 2019-2022 Cleaned.xlsx")
