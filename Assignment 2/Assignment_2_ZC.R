#' BTC1855 - Assignment 2, Zachery Chan
#' R version: Version 2024.04.1+748 (2024.04.1+748)

#Taking user input using readline(), didnt use scan() as scan() 
#   specifies file path while readline() just goes through console commands
user_input <- readline("Let's play a game, think of 3, single-digit, positive numbers and put'em together. Enter your number here please: ")

#----------------------------------------

#Please input your number here now 

#---------------------------------------

#Using if() to see if input is numeric, if it is a character, returns NA and stops
if (is.numeric(c(as.numeric(user_input))) == T) {
  stop ("THAT IS NOT A NUMBER, SILLY! Run it again and please put in a number, I will be watching...")
  quit ()
}

#'Splitting user input into 3 numbers (uses character string as 
#'   strsplit() uses characters not strings)
split_input <- strsplit(user_input, "")

input_string <- split_input[[1]]

first_number <- as.numeric(input_string[1])

second_number <- as.numeric(input_string[2])

third_number <- as.numeric(input_string[3])

#'Calculating if input is an Armstrong number or not
armstrong <- first_number^3 + second_number^3 + third_number^3

#' Now converting user input to numeric (didn't need to earlier) to compare
user_numeric <- as.numeric(user_input) 

is_armstrong <- user_numeric == armstrong 

#' Using conditional to determine which message is given
if (is_armstrong == T) {
  print (paste(user_input, "is a narcissistic number, you self-lover you :)"))
 } else if (is_armstrong == F) {
    print (paste(user_input, "is a NOT a narcissistic number. Maybe we should talk about your self image?"))
  }
