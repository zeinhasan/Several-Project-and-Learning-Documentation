# Call library
library(tidyverse)
library(rvest)
library("stringr")

# Copy Url and assign to object named url
url <- "https://www.worldometers.info/coronavirus/"

# Begin Scrapping Worldometer
# Read table html
my_table<-url%>%read_html()%>%html_table()%>%.[[1]]

# Check tabel
head(my_table)
view(my_table)

############################# Cleaning data ####################################
# Delete the row at 1-8 and 235-242
# Delete the "#" column
my_tableclean <- my_table[-c(1:8,235:242),-1]
# Delete all special character from string
my_data <- my_tableclean %>%
  mutate_all(funs(gsub("[[:punct:]]", "", .)))

# Convert to numeric  
my_data[,2:21] <- sapply(my_data[,2:21],as.numeric)

# Check data
head(my_data)
view(my_data)

# write ke dalam excel
library(openxlsx)
write.xlsx(my_data,"D:\\Kuliah\\Pengantar Data Sains\\Tugas Scraping\\Worldometer.xlsx")


