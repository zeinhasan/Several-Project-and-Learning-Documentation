# Panggil library yang dibutuhkan
library(rvest)
library(tidyverse)

# Salin URL dan Read HTML dari URL
url <- "https://sidata-ptn.ltmpt.ac.id/ptn_sn.php?ptn=361"
webpage <- read_html(url)

# Scraping kolom kode
kode <- webpage %>%
  html_nodes('td:nth-child(2)') %>%
  html_text() %>%
  as.integer()

# Scraping kolom nama prodi
nama <- webpage %>% 
  html_nodes("td:nth-child(3)") %>% 
  html_text()

# Scraping kolom jenjang
jenjang <- webpage %>% 
  html_nodes("td:nth-child(4)") %>% 
  html_text()

# Scraping kolom daya tampung 2022
Daya_Tampung <- webpage %>% 
  html_nodes("td:nth-child(5)") %>% 
  html_text()

# Scraping kolom peminat 2021
Peminat <- webpage %>% 
  html_nodes("td:nth-child(6)") %>% 
  html_text() %>% 
  as.integer()

# Scraping kolom jenis portofolio
Jenis_Portofolio <- webpage %>% 
  html_nodes("td:nth-child(7)") %>% 
  html_text()
  
# gabungkan kedalam satu data frame
Snmptn_UGM <- data.frame(nama,jenjang,Daya_Tampung,Peminat,Jenis_Portofolio)

# write ke dalam excel
library(openxlsx)
write.xlsx(Snmptn_UGM,"D:\\Kuliah\\Pengantar Data Sains\\Tugas Scraping\\Snmptn UGM.xlsx")

