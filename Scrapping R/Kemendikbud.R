# Panggil library yang dibutuhkan
library(tidyverse)
library(rvest)
library("stringi")

# Salin URL dan Read HTML dari URL
url <- "https://pd.data.kemdikbud.go.id/RekapIdentitas/index.php/rangkuman/rekap_nas/"
webpage <- read_html(url)

# Scraping Nomor
No<- webpage %>% 
  html_nodes("#table_nasional_all td:nth-child(1)") %>% 
  html_text() %>% 
  stri_replace_all_charclass("\\p{WHITE_SPACE}", "")

# Scraping nama provinsi
Provinsi <- webpage %>% 
  html_nodes("#table_nasional_akhir a") %>% 
  html_text()

# Scraping kolom total
Total<- webpage %>% 
  html_nodes("#table_nasional_all td:nth-child(3)") %>% 
  html_text() %>% 
  stri_replace_all_charclass("\\p{WHITE_SPACE}", "")

# Scraping kolom belum edit
Belum_edit <- webpage %>% 
  html_nodes("#table_nasional_all td:nth-child(4)") %>% 
  html_text() %>% 
  stri_replace_all_charclass("\\p{WHITE_SPACE}", "")

# Scraping kolom sudah edit
Sudah_edit <- webpage %>% 
  html_nodes("#table_nasional_all td:nth-child(5)") %>% 
  html_text() %>% 
  stri_replace_all_charclass("\\p{WHITE_SPACE}", "")

# Scraping kolom Persetujuan antrian
Persetujuan_antrian <- webpage %>% 
  html_nodes("#table_nasional_all td:nth-child(6)") %>% 
  html_text() %>% 
  stri_replace_all_charclass("\\p{WHITE_SPACE}", "")

# Scraping kolom Persetujuan disetujui  
Persetujuan_disetujui <- webpage %>% 
  html_nodes("#table_nasional_all td:nth-child(7)") %>% 
  html_text() %>% 
  stri_replace_all_charclass("\\p{WHITE_SPACE}", "")

# Scraping kolom Persetujuan ditolak
Persetujuan_ditolak <- webpage %>% 
  html_nodes("#table_nasional_all td:nth-child(8)") %>% 
  html_text() %>% 
  stri_replace_all_charclass("\\p{WHITE_SPACE}", "")

# Masukan ke dalam 1 data frame
datakemendikbud <- data.frame(No,Provinsi,Total,Belum_edit,Sudah_edit,
                              Persetujuan_antrian,Persetujuan_disetujui,
                              Persetujuan_ditolak)

# Write ke dalam Excel
library(openxlsx)
write.xlsx(datakemendikbud,"D:\\Kuliah\\Pengantar Data Sains\\Tugas Scraping\\datakemendikbud.xlsx")


