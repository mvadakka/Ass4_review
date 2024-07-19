#' BTC1855 - Assignment 4, Zachery Chan
#' R version: Version 2024.04.2+764 (2024.04.2+764)
#' Code dated to: July 18

#` ---------------------------------------------------------------
# DEFINING FUNCTIONS 

# Function for checking any "" in columns 
empty_string <- function(col) {
  any(col == "")
}

# Function for checking any NAs in columns 
na_check <- function(col) {
  anyNA(col)
}

# Function for factoring data and resetting factor levels 
# Not exactly sure why I need double [[...]] here but __ had similar examples and it doesnt work without it 
factoring <- function(data, column_name) {
  # Using paste0 to add _fctr
  data[[paste0(column_name, "_fctr")]] <- factor(data[[column_name]])
  # Setting blanks, "", as NAs
  data[[paste0(column_name, "_fctr")]][data[[paste0(column_name, "_fctr")]] ==""] <- NA 
  #' Redefining levels of factor to remove "" bin as it is empty 
  new_lvls <- levels(data[[paste0(column_name, "_fctr")]])
  new_lvls <- new_lvls[new_lvls != ""] 
  #' Redefining factor with new levels 
  data[[paste0(column_name, "_fctr")]] <- factor(data[[paste0(column_name, "_fctr")]], levels =   new_lvls)
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

# Checking which variables have ""
empty_chk <- apply(data1, 2, empty_string)
empty_chk

#checking which variables have NA
na_chk <- apply(data1, 2, na_check)
na_chk

# From the fucntions, it is apparent that state, country, and shape have ""
# these need to be addressed, no NAs 
# Factoring variables
# Factoring state, storing as new variable
data1$state_fctr <- factoring(data1, "state")
summary(data1$state_fctr)

# Factoring country variable, storing as new variable
data1$country_fctr <- factoring(data1, "country")
summary(data1$country_fctr)

# Factoring state, storing new cariable
data1$shape_fctr <- factor(data1$shape)
summary(data1$shape_fctr)

#' Converting date to a date type, used strptime() as dmy() saved as Date format instead of POSIX 
data1$date_posted_alt <- strptime(data1$date_posted, format = "%d-%m-%Y")

# Converting sighttime into Posix 
data1$sighttime_alt <- ymd_hm(data1$sighttime)

# Converting seconds duration into a POSIX for later calculations
# Using timezone as UTC but does not matter as measuring duration (don't need to keep track of time)
data1$duration.seconds_alt <- as.POSIXct(duration.seconds, tz = "UTC")

# NOTE: didn't convert duration.hours.sec as it is very messy and consists of 
# widely varied comments on time (wide variation in string format)

# Setting missing comments as NA 
data1$comments_alt <- data1$comments
data1$comments_alt[data1$comments_alt == ""] <- NA
# NOTE: didn't use custom function as comments should not be factored, too varied 

# Making new dataframe with corrected structural issues 
data2 <- data.frame(data1$sighttime_alt, data1$city, data1$state_fctr, data1$country_fctr, 
                    data1$shape_fctr, data1$duration.seconds_alt, data1$duration.seconds, data1$duration.hours.min, 
                    data1$comments_alt, data1$date_posted_alt, data1$latitude, data1$longitude)
colnames(data2) <- c("sighttime", "city", "state", "country",
                     "shape", "duration.seconds.POSIX", "duration.seconds", "duration.hours.min", 
                     "comments", "date_posted", "latitude", "longitude")

# Checking for exact duplicates 
anyDuplicated(data2)

#' Check for extreme values??? (CHECK)!!!!!!!!!!!!!!!!!! 

# Dealing with outliers 
# Calculating standard deviations to see what values are extreme 
std_dev_seconds <- sd(data2$duration.seconds, na.rm = TRUE)
std_dev_seconds

# Calculating mean 
avg_seconds <- mean(data2$duration.seconds, na.rm = TRUE)
avg_seconds

# Seeing that the mean is 7891 seconds, it is clear that there is extreme positive 
#' skew in this data. So cannot use standard deviations to calculate small outliers
#' Filtering to keep any sightings longer than 0.5 seconds 
#' (average human reaction time is 0.25 seconds, I assume we need to double 
#' this as the shock of seeing aliens will stun anyone)

# Using standard deviation + mean to calculate positive outlier limit 
outlier_lmt <- avg_seconds+3*std_dev_seconds

# Creating new dataframe with filtered/removed rows
data3 <- data2 %>%
  # Filtering so sightings < 0.5 seconds are removed 
  filter(duration.seconds > 0.5) %>%
  # Creating new column for duration in days (gives better idea as to length)
  mutate(duration.days = duration.seconds/(60 * 60 * 24)) %>%
  # Filtering so sightings > 3*(standard deviations), removes extreme outliers previous had values for 900+ days, 
  filter(duration.seconds < outlier_lmt) %>% 
  #' filtering out likely hoaxes (as commented by NUFORC)
  filter(!str_detect(comments, "\\(\\("))
#' Using just "((" as some comments were clearly indicating potential 
#' reasons for hoax but was not indicated with "((NUFORC NOTE...", just ((..)) 

# Creating new variable of report_delay, dividing as POSIX - POSIX gives difference in seconds 
data3$report_delay_days <- (data3$date_posted - data3$sighttime)/(60*60*24)

# Filtering data for only positive report delays (not reported before sighted)
data3 <- data3 %>%
  filter(report_delay_days > 0)

# Creating new dataframe for creating table of average report delay per country
data4 <- data.frame(data3$country, data3$report_delay_days)
colnames(data4) = c("country", "report_delay") 

# Need to convert report_delay into numeric to average them 
data4$report_delay <- as.numeric(data4$report_delay)

# Filtering dataset to create average table
data4_summary <- data4 %>%
  # Removes NA bin from appearing in table 
  filter(!is.na(data4$country)) %>%
  # Groups  by country 
  group_by(country) %>%
  # Calculates mean by country, using na.rm as there still may be NAs in each country bin
  summarise(Mean_Report_Delay = mean(report_delay, na.rm = TRUE))

data4_summary

# Creating histogram using the 'duration seconds' column with filtered data 
# filtered (non-hoax) data 
# Using log_10 to structure data to make it readable in graph (otherwise range too large) 
log_secs <- log10(data3$duration.seconds)

# Setting tick marks labels to make it easier to understand graph (setting bins)
graph_lbls <- c("0.5secs", "1secs", "10secs", "30secs", "1min", "5min", "30min",
                "1hr", "1day", "1wk", "2wks", "3wks")

# Setting values for x-axis tick marks 
graph_ticks_secs <- c(0.5, 1, 10, 30, 60, 300, 1800, 3600, 86400, 604800, 1209600, 1814400)

# Log_10 values for the respective seconds for chosen bins
graph_ticks_log <- log10(graph_ticks_secs)

# Plotting histogram, using frequency as it reads better to general audience
hist(log_secs, main= "Duration of Reported UFO Sightings, 2010 - 2014",
     xlab = "Log(duration) (secs)", ylab = "Frequency of Sightings", 
     breaks = graph_ticks_log, freq = T, xlim = c(c(min(log_secs)), max(log_secs)),
     ylim = c(0, 10000), xaxt = "n")
axis(side = 1, at = graph_ticks_log,labels = graph_lbls, las = 2, cex.axis = 0.7)
# Using custom axis to set tick marks and make bin ranges more evident







