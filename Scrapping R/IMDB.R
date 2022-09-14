# Panggil library yang dibutuhkan
library(rvest)
library(tidyverse)

# Salin URL dan Read HTML dari URL
url <- "https://www.imdb.com/chart/top/?ref_=nv_mv_250"
webpage <- read_html(url)

# Scraping Nama film
Nama_Film <- webpage %>% 
  html_nodes(".titleColumn a") %>% 
  html_text()

# Scraping Rating Film
Rating <- webpage %>% 
  html_nodes("strong") %>% 
  html_text() %>% 
  as.numeric()

# Scraping Movie Link
Movie_link <- webpage %>% 
  html_nodes(".titleColumn a") %>% 
  html_attr("href") %>% 
  paste("https://www.imdb.com", .,sep="")

# Masukan ke dalam 1 data frame
TOP250_IMDB <- data.frame(Nama_Film,Rating,Movie_link)

# Write ke dalam Excel
library(openxlsx)
write.xlsx(TOP250_IMDB,"D:\\Kuliah\\Pengantar Data Sains\\Tugas Scraping\\TOP250_IMDB.xlsx")


  