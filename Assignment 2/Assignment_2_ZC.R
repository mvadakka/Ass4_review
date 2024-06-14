#' BTC1855 - Assignment 2, Zachery Chan
#' R version: Version 2024.04.2+764 (2024.04.2+764)
#' Code dated to: June 14th

# Taking user input using readline(), didnt use scan() as scan() 
# specifies file path while readline() just goes through console commands
user_input <- readline(prompt = "Hey, play a game with me? Think of 3, single-digit, positive numbers and put'em together. Enter your number here please: ")

#----------------------------------------

# Please input your number here now 

#---------------------------------------

#' Now converting user input to numeric to compare
user_numeric <- as.numeric(user_input)


# Using if() and logical statements to combine conditions 
# Seeing if input is not numeric OR if input is negative, if so, it stops
if (is.na(as.numeric(user_input)) == T | user_numeric <= 0) {
  stop ("ERROR! ERROR! THAT DOES NOT FOLLOW THE INSTRUCTIONS, SILLY! \n See any NA warnings? I was forced to do this :( \n Run it again and please put in a number, I will be watching...")
} 


#' Splitting user input into 3 numbers (uses character string as 
#' strsplit() uses characters not strings)
split_input <- strsplit(user_input, "")

input_string <- split_input[[1]]

#Checking to see if number is greater than 3 digits using logical 
if (length(input_string) > 3) {
  stop ("ERROR! ERROR! THAT IS A NOT A 3 DIGIT NUMBER, SILLY! \n Please follow the instructions this time. \n Run it again and please put in a number, I will be watching...")
} 

first_number <- as.numeric(input_string[1])

second_number <- as.numeric(input_string[2])

third_number <- as.numeric(input_string[3])

#'Calculating if input is an Armstrong number or not
armstrong <- first_number^3 + second_number^3 + third_number^3

#' Using conditional to determine which message is given
#' Using else if here because, honestly, I just wanted to... 
if (user_numeric == armstrong ) {
  print (paste(user_input, "is a narcissistic number, you self-lover you :). Now either go look at your reflection in a lake ;)"))
 } else if (is_armstrong == F) {
    print (paste(user_input, "is a NOT a narcissistic number. Maybe we should talk about your self image?"))
  }
