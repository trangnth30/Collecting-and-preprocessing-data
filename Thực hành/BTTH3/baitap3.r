rm(list=ls())
library(gsheet)
link_patien <- "https://docs.google.com/spreadsheets/d/1XEFg047aSbg3OsEVx9PzmgSxGbCvCidfLiHfsgRS3R0/edit?usp=sharing"
dataset <- gsheet2tbl(link_patien)

# so ca nhiem theo ngay
data_by_date <- table(dataset$Date.Announced)
barplot(data_by_date)

#a:
infected_by_prefecture <- table(dataset$Detected.Prefecture)
View(infected_by_prefecture)

#b:
# Tao dataframe la so ca nhiem theo tuoi
infected_by_age <- table(dataset$Age.Bracket)
infected_by_age <- as.data.frame(infected_by_age)

#Xoa nhung gia tri gay nhieu. VD: F, M, Unspecifed, Unspecified,...
new_infected_by_age <- infected_by_age
new_infected_by_age <- new_infected_by_age[-c(1, c(15:18), c(20:25)),]

#Gop tat ca ca gia tri "over 90", "above 90", "100",,... thanh 1 dong. Sau do thua hien xoa cac gia tri du thua
over_90 <- new_infected_by_age$Freq[[2]] + new_infected_by_age$Freq[[4]] + new_infected_by_age$Freq[[13]] + new_infected_by_age$Freq[[14]]
new_infected_by_age <- new_infected_by_age[-c(2, 4, 13),]
new_infected_by_age$Freq[[11]] <- over_90

# Ve bieu do
barplot(new_infected_by_age$Freq, names.arg=new_infected_by_age$Var1, 
        ylab = "Infected", xlab = "Age")

#csss:
hokkaido_date_by_day <- table(dataset[which(dataset$Detected.Prefecture=='Hokkaido'),]$Date.Announced)
View(hokkaido_date_by_day)
barplot(hokkaido_date_by_day,
        xlab='Date', ylab='Infected')

