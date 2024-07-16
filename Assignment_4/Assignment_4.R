file_path <- c("/Users/zachery/BTC1855/Assignment_4/ufo_subset.csv")
data <- read.csv(file_path)

summary()


data1 <- data
data1$state_alt <- factor(data1$state)

data1$state_alt
#address missing 

data1$state_alt[data1$state_alt == ""] <- NA
#remove empry bin 

data1$country_alt[data1$country_alt == ""] <- NA
#remove empry bin 

#address missing 



#' strucutrals iisues
#' convert dates using posex
#' convert states ans countries into factors 
#' 
#' 
#' data issues (identify) 
#' check for NAs 
#' check for missing (blanks)
#' check for extreme values 
#' check for duplicates 