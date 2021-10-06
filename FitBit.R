#Importing libraries
library(tidyverse) 
library(reshape2)
library(scales)
library(lubridate)
library(ggplot2)
dailyActivity <- read.csv("/Users/pallavideolal/Documents/Case Studies/FitBit/dailyActivity_merged.csv")
dailyCalories <-read.csv("/Users/pallavideolal/Documents/Case Studies/FitBit/dailyCalories_merged.csv")
dailyIntensities <-read.csv("/Users/pallavideolal/Documents/Case Studies/FitBit/dailyIntensities_merged.csv")
dailySteps <-read.csv("/Users/pallavideolal/Documents/Case Studies/FitBit/dailySteps_merged.csv")
sleepDay <-read.csv("/Users/pallavideolal/Documents/Case Studies/FitBit/sleepDay_merged.csv")
weightLog <-read.csv("/Users/pallavideolal/Documents/Case Studies/FitBit/weightLogInfo_merged.csv")
# Finding duplicate entries
any(duplicated(sleepDay))
# Finding empty entries
any(is.na(sleepDay))
sleepDay <- distinct(sleepDay)
any(duplicated(sleepDay))
#Reviwing the number of ID's in our Dataset
n_distinct(dailyActivity$Id)
n_distinct(sleepDay$Id)
dailyActivity %>%  
  select(TotalSteps,
         TotalDistance,
         SedentaryMinutes) %>%
  summary() 
sleepDay %>%  
  select(TotalSleepRecords,
         TotalMinutesAsleep,
         TotalTimeInBed) %>%
  summary()

merge_1 <- merge(dailyActivity, dailyCalories, by = c("Id","Calories"))
merge_2 <- merge(dailyIntensities, dailyIntensities, by = c("Id","ActivityDay","SedentaryMinutes", "LightlyActiveMinutes","FairlyActiveMinutes","VeryActiveMinutes", "SedentaryActiveDistance", "LightActiveDistance", "ModeratelyActiveDistance", "VeryActiveDistance"))
merge_daily <- merge(merge_1, merge_2, by = c("Id","ActivityDay","SedentaryMinutes", "LightlyActiveMinutes","FairlyActiveMinutes","VeryActiveMinutes", "SedentaryActiveDistance", "LightActiveDistance", "ModeratelyActiveDistance", "VeryActiveDistance"))
daily_data <- merge(merge_daily, sleepDay, by = "Id",all=TRUE) %>% drop_na() %>% select(-SleepDay, -TrackerDistance)
summary(daily_data)

