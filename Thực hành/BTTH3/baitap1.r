rm(list=ls())
library(xml2)
library(dplyr)
library(httr)
library(stringr)
data <- GET("https://www.worldometers.info/coronavirus/#countries")
content <- content(data, as="text")

html_data <- read_xml(content, as_html = TRUE)

table_data <- xml_text(xml_find_all(html_data,"//table[@id='main_table_countries_today']//tbody//tr//td"))

table_head <- xml_text(xml_find_all(html_data,"//table[@id='main_table_countries_today']//thead//tr//th"))

dataset <- matrix(ncol=length(table_head), nrow =(length(table_data)/ length(table_head) ))

data_col = length(table_head)

count = 1
i = 1

while(i<=length(table_data) - data_col) {
  dataset[count, ] <- c(table_data[i:(i -1 + data_col)])
  i = i + data_col;
  count = count + 1
}

dataset <- as.data.frame(dataset)

dataset <- na.omit(dataset)


names(dataset) <- c(table_head)

new_data <- dataset[-c(237:243),]
new_data <- new_data[-c(1:8),]

#loai bo cac dau , trong gia tri total cases va totalrecovered
for(i in 1:length(new_data$`Country,Other`)){
  
  new_data$TotalCases[i] <- as.numeric(gsub(",", "", new_data$TotalCases[i]))
  new_data$TotalRecovered[i] <- as.numeric(gsub(",", "", new_data$TotalRecovered[i]))
}

#a) tim 5 quoc gia co so ca nhiem nhieu nhat
new_data_sorted <-new_data[order(-as.integer(new_data$TotalCases)),]
cau_a <- new_data_sorted[,1:3][1:5,]

#b) tim quoc gia co so ca nhiem moi nhieu nhat
cau_b <- new_data[which(new_data$NewCases==max(new_data$NewCases)),]

#c)tinh ti le so ca binh phuc tren tong so ca nhiem

#vi co nhung ca co gia tri N/a nen, bo cac nuoc co gia tri nhu the
new_data1 <- new_data[which(new_data$TotalRecovered!='N/A'),]

#tao ra cot ratio va dat tat ca gia tri =0
new_data1$ratio <- c(0)

#tinh ratio
for(i in 1:length(new_data1$`Country,Other`)){
  new_data1$ratio[i]=as.integer(new_data1$TotalRecovered[i]) /as.integer(new_data1$TotalCases[i])
}
p <-new_data1[order(-new_data1$ratio),]
cau_c <-p[1:3,]

