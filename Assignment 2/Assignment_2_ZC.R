#' BTC1855 - Assignment 2, Zachery Chan
#' R version: Version 2024.04.2+764 (2024.04.2+764)
#' Code version date: June 14th

#Taking user input using readline(), didnt use scan() as scan() 
#   specifies file path while readline() just goes through console commands
user_input <- readline(prompt = "Hey, play a game with me? Think of 3, single-digit, positive numbers and put'em together. Enter your number here please: ")

#----------------------------------------

#Please input your number here now 

#---------------------------------------

#Using if() to see if input is numeric, if it is a character, stops
if (is.na(as.numeric(user_input)) == T) {
  stop ("ERROR! ERROR! THAT IS NOT A NUMBER, SILLY! \n Run it again and please put in a number, I will be watching...")
} 

#Using if() to see if input is negative, if it is negative, stops
user_numeric <- as.numeric(user_input)

if (user_numeric <= 0) {
  stop ("ERROR! ERROR! THAT IS A NEGATIVE NUMBER, SILLY! \n Please follow the instructions this time. \n Run it again and please put in a number, I will be watching...")
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

#' Now converting user input to numeric to compare
user_numeric <- as.numeric(user_input) 

#' Using conditional to determine which message is given
#' Using else if here because, honestly, I just wanted to... 
if (user_numeric == armstrong ) {
  print (paste(user_input, "is a narcissistic number, you self-lover you :). Now either go look at your reflection in a lake ;)"))
 } else if (is_armstrong == F) {
    print (paste(user_input, "is a NOT a narcissistic number. Maybe we should talk about your self image?"))
  }

