#' BTC1855 - Assignment 4, Zachery Chan
#' R version: Version 2024.04.2+764 (2024.04.2+764)
#' Code dated to: July 18

#` ---------------------------------------------------------------
# DEFINING FUNCTIONS 

empty_string <- function(col) {
  any(col == "")
}

na_check <- function(col) {
  anyNA(col)
}

#` ---------------------------------------------------------------
# Setting file path to read UFO data 
file_path <- c("/Users/zachery/BTC1855/Assignment_4/ufo_subset.csv")

# Reading and storing raw data into dataframe
data <- read.csv(file_path)

# Setting libraries 
library(lubridate)
library(stringr)
library(dplyr)

# Creating new data frame for manipulation 
data1 <- data

# Examining data
summary(data)
# Identified the following issues:
#' - no NAs, likely coded as something else, found NAs to be coded as "" AKA empty string
#' - dates are coded as character not as numeric or POSIX
#' - factor-able variables are stored as strings (state, country, etc.)

# Renaming datetime variable to sighttime
data1 <- data1 %>%
  select(sighttime = datetime,
         city,
         state,
         country, 
         shape, 
         duration.seconds, 
         duration.hours.min, 
         comments,
         date_posted,
         latitude, 
         longitude)

#checking which variables have ""
empty_chk <- apply(data1, 2, empty_string)
empty_chk

#checking which variables have NA
na_chk <- apply(data1, 2, na_check)
na_chk

# Factoring state variable
# Factoring state, storing as new variable
data1$state_fctr <- factor(data1$state)

# Addressing "", redefining as NA 
data1$state_fctr[data1$state_fctr == ""] <- NA

#' Redefining levels of state factor to remove "" bin as it is empty 
state_lvls <- levels(data1$state_fctr)
state_lvls <- state_lvls[state_lvls != ""]

#' Redefining state factor with new levels 
data1$state_fctr <- factor(data1$state, levels = state_lvls)

# Factoring country variable 
# Factoring country, storing new variable
data1$country_fctr <- factor(data1$country)

#' Addressing missing, redefining as NA 
data1$country_fctr[data1$country_fctr == ""] <- NA

#' Redefining levels of state factor to remove "" bin as it is empty 
country_lvls <- levels(data1$country_fctr)
country_lvls <- country_lvls[country_lvls != ""]

#' Redefining state factor with new levels 
data1$country_fctr <- factor(data1$country, levels = country_lvls)



#' Converting date to a date type 
data1$date_posted_alt <- strptime(data1$date_posted, format = "%d-%m-%Y")
#data1$date_posted_alt <- dmy(data1$date_posted)


#' ------------------------
# data1$duration.hours.min[str_detect(duration.hours.min, "sec")] <- c(">1 min")
#' ------------------------
#Converting sighttime into Posix 
data1$sighttime_alt <- ymd_hm(data1$sighttime)
#data1$sighttime_alt <- strptime(data1$sighttime, format = "%Y-%m-%d %H:%M", tz = "UTC")


factoring <- function(data, column_name) {
  data[paste0(column_name, "_fctr")] <- factor(data[column_name])
  
  data[paste0(column_name, "_fctr")][data[paste0(column_name, "_fctr")] ==""] <- NA 
  
  new_lvls <- levels(data[paste0(column_name, "_fctr")])
  new_lvls <-   new_lvls[new_lvls != ""] 
  
  data[paste0(column_name, "_fctr")] <- factor(data[paste0(column_name, "_fctr")], levels =   new_lvls)
  
  data[paste0(column_name, "_fctr")]
}
shape_tst <- factoring(data1, "shape")

# Factoring state, storing new cariable
data1$shape_fctr <- factor(data1$shape)

# Addressing missing, redefining as NA 
data1$shape_fctr[data1$shape_fctr == ""] <- NA

# Redefining levels of state factor to remove "" bin as it is empty 
shape_lvls <- levels(data1$shape_fctr)
shape_lvls <- shape_lvls[shape_lvls != ""]

# Redefining state factor with new levels 
data1$shape_fctr <- factor(data1$shape, levels = shape_lvls)

# Using EST as tz but shouldnt matter as measuring duration
data1$duration.seconds_alt <- as.POSIXct(duration.seconds, tz = "UTC")

# Setting missing comments as NA 
data1$comments_alt <- data1$comments
data1$comments_alt[data1$comments_alt == ""] <- NA

# Making new dataframe with corrected structural issues 
data2 <- data.frame(data1$sighttime_alt, data1$city, data1$state_fctr, data1$country_fctr, 
                    data1$shape_fctr, data1$duration.seconds_alt, data1$duration.hours.min, 
                    data1$comments_alt, data1$date_posted_alt, data1$latitude, data1$longitude)

colnames(data2) <- c("sighttime", "city", "state", "country",
                     "shape", "duration.seconds", "duration.hours.min", 
                     "comments", "date_posted", "latitude", "longitude")

# Checking for any blanks 
column_blnk <- apply(data2, 2, function(col) any(col == ""))
#Checking for NAs
column_na <- apply(data2, 2,  function(col) any(is.na(col)))
# Checking for exact duplicates 
anyDuplicated(data2)

#' Check for extreme values??? 

#' Adding duration in seconds for clarity 
data3 <- data.frame(data2$country, data2$shape, data2$duration.seconds, data1$duration.seconds,
                    data2$comments, data2$sighttime, data2$date_posted)
colnames(data3) <- c("country", "shape", "duration.seconds.pos", "duration.seconds", 
                     "comments", "sighttime", "date_posted")


std_dev_seconds <- sd(data3$duration.seconds, na.rm = TRUE)

#' Dealing with outliers, filtering to keep any sightings longer than 0.5 seconds 
#' and less than 100 days (using 100 days a 3 std devs included )
data3 <- data3 %>%
  filter(duration.seconds > 0.5) %>%
  mutate(duration.mutate = duration.seconds / (60 * 60 * 24)) %>%
  filter(duration.mutate < 100) %>%
  #Using just "((" as some commments were clearly indictaing potential reasons for hoax but was not indicated with "NUFORC NOTE"
  filter(!str_detect(comments, "\\(\\("))

data3$report_delay_days <- (data3$date_posted - data3$sighttime)/(60*60*24)
data3 <- data3 %>%
  filter(report_delay_days > 0)

data4 <- data.frame(data3$country, data3$report_delay_days)
colnames(data4) = c("country", "report_delay")

data4$report_delay <- round(as.numeric(data4$report_delay), 5)

data4_summary <- data4 %>%
  filter(!is.na(data4$country)) %>%
  group_by(country) %>%
  summarise(Mean_Report_Delay = round(mean(report_delay, na.rm = TRUE), 3))

data4_summary



