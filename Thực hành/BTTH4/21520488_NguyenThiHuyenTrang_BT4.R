rm(list=ls())
library('dplyr')
library('tidyr')
library('magrittr')
library('tidyverse')
library('lubridate')
library('ggplot2')

data <- read.csv("data/covid_19_data.csv")
data$ObservationDate <- as.Date(data$ObservationDate, tz = "UTC", "%m/%d/%Y")

#Bai 1
#a

data %>% select(ObservationDate, Country.Region, Confirmed, Deaths)

data %>% select(ObservationDate, Country.Region, Recovered)

sum(data %>% select(Confirmed))

head(data %>% select(ObservationDate, Country.Region, Confirmed, Deaths), 10)

data %>% filter(Country.Region == "Mainland China")

data %>% filter(Country.Region == "Vietnam" & ObservationDate >= "2020-03-01" & ObservationDate <= "2020-04-30")

data %>% filter(Country.Region == "Mainland China") %>%
  summarise(
    Mean=mean(Confirmed, na.rm = TRUE),
    Median = median(Confirmed, na.rm = TRUE),
    Variance = var(Confirmed, na.rm = TRUE),
    SD = sd(Confirmed, na.rm = TRUE)
  )

data %>% filter( 
    Country.Region == "Vietnam" &
    ObservationDate >= "2020-03-01" &
    ObservationDate <= "2020-04-30") %>%
  group_by(ObservationDate)

data %>% filter(
  Country.Region == "Vietnam" &
    ObservationDate >= "2020-03-01" &
    ObservationDate <= "2020-04-30") %>%
  group_by(ObservationDate) %>%
  arrange(Confirmed)

data %>% filter(
  Country.Region == "Vietnam" &
    ObservationDate >= "2020-03-01" &
    ObservationDate <= "2020-04-30") %>%
  group_by(ObservationDate) %>%
  arrange(desc(Confirmed))

data %>% filter(
  Country.Region == "Vietnam" &
    ObservationDate >= "2020-03-01" &
    ObservationDate <= "2020-04-30") %>%
  group_by(ObservationDate) %>%
  arrange(desc(Confirmed)) %>%
  mutate(Patient = Confirmed - Recovered)


data <- read.csv("data/mtcars.csv")

gathered <- data %>% gather(attribute, value, -model)

set.seed(1)
date_fake <- as.Date('2016-01-01') + 0:14
hour <- sample(1:24, 15)
min <- sample(1:60, 15)
second <- sample(1:60, 15)
event <- sample(letters, 15)
data_fake <- data.frame(date, hour, min, second, event)

fullTime <- data %>%
  unite(datehour, date, hour, sep = ' ') %>%
  unite(datetime, datehour, min, second, sep = ':')

fullTime %>%
  separate(datetime, c('date', 'time'), sep = ' ') %>%
  separate(time, c('hour', 'min', 'second'), sep = ':')

data <- read.csv("data/covid_19_data.csv")
data$ObservationDate <- as.Date(data$ObservationDate, tz = "UTC", "%m/%d/%Y")


print(data[1,])
leap_year(data$ObservationDate[1])

year(data$ObservationDate[1])

month(data$ObservationDate[1])

day(data$ObservationDate[1])

make_difftime(day=5)

data %>% filter(Country.Region == "Vietnam" &month(ObservationDate) %in% c(1,3))

data %>% filter(Country.Region == "Vietnam" &wday(ObservationDate, label=TRUE) == "Wed")


data <- read.csv("data/covid_19_data.csv")

data$ObservationDate <- as.Date(data$ObservationDate, "%m/%d/%Y")

#Bai 1 b

jp<-data %>% filter(
  Country.Region == "Japan" &
    ObservationDate >= "2021-03-02" &
    ObservationDate <= "2021-03-15") %>%
  group_by(ObservationDate)


temp <-data.frame(day=unique(jp$ObservationDate), num=c(0))
for (i in 1:length(temp$day)){
  
  for (j in 1:length(jp$ObservationDate)){
    
    if(temp$day[i]==jp$ObservationDate[j]){
      temp$num[i]=temp$num[i]+jp$Confirmed[j]
    }
  }
}

plot(x=temp$day,y=temp$num,type="l",xlab="day",ylab="number")

#bài 1 c

usa<-data %>% filter(
  Country.Region == "US" &
    ObservationDate >= "2021-03-15" &
    ObservationDate <= "2021-04-15") %>%
  group_by(ObservationDate)

temp <-data.frame( day=unique(usa$ObservationDate),  num=c(0))

for (i in 1:length(temp$day)){
  for (j in 1:length(usa$ObservationDate)){
    if(temp$day[i]==usa$ObservationDate[j]){
      temp$num[i]=temp$num[i]+usa$Confirmed[j]
    }
  }
}

plot(x=temp$day,y=temp$num,type="l",xlab="day",ylab="number")

temp <-data.frame(  Province.State=unique(usa$Province.State), num=c(0) )

for (i in 1:length(temp$Province.State)){
  for (j in 1:length(usa$Province.State)){
    if(temp$Province.State[i]==usa$Province.State[j]){
      temp$num[i]=temp$num[i]+usa$Confirmed[j]
    }
  }
}

barplot(temp$num,names.arg=temp$Province.State)

#Bai 2

word<-data %>% filter(
  ObservationDate >= "2021-02-01" &
    ObservationDate <= "2021-04-30") %>%
  group_by(ObservationDate)

temp <-data.frame(
  day=unique(word$ObservationDate),num=c(0))

for (i in 1:length(temp$day)){
  
  for (j in 1:length(word$ObservationDate)){
    
    if(temp$day[i]==word$ObservationDate[j]){
      temp$num[i]=temp$num[i]+word$Confirmed[j]
    }
  }
}

plot(x=temp$day,y=temp$num,type='l',xlab="day",ylab="number")

#Bai 3

vn<-data %>% filter(
  Country.Region == "Vietnam"
  & year(ObservationDate)==2021 
)


temp <-data.frame( month=unique(month(vn$ObservationDate)), num=c(0))

for (i in 1:length(temp$month)){
  
  for (j in 1:length(vn$ObservationDate)){
    
    if(temp$month[i]==month(vn$ObservationDate[j])){
      temp$num[i]=temp$num[i]+vn$Confirmed[j]
    }
  }
}
plot(x=temp$month,y=temp$num,type='l',xlab="month",ylab="number")

#bai 4

vn_4<-data %>% filter(
  Country.Region == "Vietnam"
  & year(ObservationDate)==2020 
  & month(ObservationDate)==4
)

temp <-data.frame( day=unique(wday(vn$ObservationDate,label=FALSE)), num=c(0))
temp<-temp[order(temp$day),]

for (i in 1:length(temp$day)){
  
  for (j in 1:length(vn_4$ObservationDate)){
    
    if(temp$day[i]==wday(vn_4$ObservationDate[j],label=FALSE)){
      temp$num[i]=temp$num[i]+vn_4$Confirmed[j]
    }
  }
}

plot(x=temp$day,y=temp$num,type='l',xlab="month",ylab="day of week")

#Bai 5

bai_5_2021<-data %>% filter(
  Country.Region == "Vietnam"
  & ObservationDate>="2021-01-01"
  & ObservationDate<="2021-03-31"
)
quantile(bai_5_2021$Confirmed)

bai_5_2020<-data %>% filter(
  Country.Region == "Vietnam"
  & ObservationDate>="2020-01-01"
  & ObservationDate<="2020-03-31"
)
quantile(bai_5_2020$Confirmed)

#Bai 6

bai_6<-data %>% filter(
  Country.Region == "Vietnam"
  & (year(ObservationDate)==2020 || year(ObservationDate)==2021)
  & month(ObservationDate)==4
)
temp <-data.frame( year=unique(year(bai_6$ObservationDate)), num=c(0))

for (i in 1:length(temp$year)){
  for (j in 1:length(bai_6$ObservationDate)){
    if(temp$year[i]==year(bai_6$ObservationDate[j])){
      temp$num[i]=temp$num[i]+bai_6$Confirmed[j]
    }
  }
}

barplot(temp$num,names.arg=temp$year)

#Bai 7

bai_7_2021<-data %>% filter(
  Country.Region == "Vietnam"
  & ObservationDate>="2021-01-01"
  & ObservationDate<="2021-03-31"
)

bai_7_2020<-data %>% filter(
  Country.Region == "Vietnam"
  & ObservationDate>="2020-01-01"
  & ObservationDate<="2020-03-31"
)

temp_2020 <- bai_7_2020["Confirmed"]
temp_2021 <- bai_7_2021["Confirmed"]


jpeg(filename="boxplot.jpg")
op <- par(mfrow=c(1,2))
boxplot(temp_2020,ylab="Confirmed",xlab="2020")
boxplot(temp_2021,ylab="Confirmed",xlab="2021")
par(op)
dev.off()
