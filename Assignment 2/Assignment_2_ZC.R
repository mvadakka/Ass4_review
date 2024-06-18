#' BTC1855 - Assignment 2, Zachery Chan
#' R version: Version 2024.04.2+764 (2024.04.2+764)
#' Code dated to: June 14th

# Taking user input using readline(), didnt use scan() as scan() 
# specifies file path while readline() just goes through console commands
user_input <- readline(prompt = "Hey, play a game with me? Think of 3, single-digit, positive numbers and put'em together. Enter your number here please: ")

#----------------------------------------

# Please input your number here now through the console 

#---------------------------------------

#' Now converting user input to numeric to compare
user_numeric <- as.numeric(user_input)


# Using if() and logical OR statement to combine conditions 
if (is.na(as.numeric(user_input)) == T | user_numeric <= 0) {
  #If input is not numeric OR if input is negative OR is "000" (0 is not a positive number), then
  stop ("ERROR! ERROR! THAT DOES NOT FOLLOW THE INSTRUCTIONS, SILLY! \n That is not a set of positive numbers \n See any NA warnings? I was forced to do this :( \n Run it again and please put in a number, I will be watching...")
} 


#' Splitting user input into 3 numbers (uses character string as 
#' strsplit() uses characters not strings)
split_input <- strsplit(user_input, "")

input_string <- split_input[[1]]

number_length <- length

# Checking to see if number is 3 digits
if (length(input_string) > 3) {
  # Checking to see if length of list from user input is number is greater than 3 
  # digits using logical 
  stop ("ERROR! ERROR! THAT IS A NOT A 3 DIGIT NUMBER, SILLY! \n Please follow the instructions this time. \n Run it again and please put in a number, I will be watching...")
} 

# Seperating the elements from list to calculate armstrong
first_number <- as.numeric(input_string)

#'Calculating if input is an Armstrong number or not
armstrong <- first_number^3 + second_number^3 + third_number^3

#' Using conditional to determine if the number is an armstrong number and 
#' which message is given
if (user_numeric == armstrong ) {
  #If user input matches the armstrong calculation, then
  print (paste(user_input, "is a narcissistic number, you self-lover you :). Now either go look at your reflection in a lake ;)"))
 } else {
   #If it does not match, then
    print (paste(user_input, "is a NOT a narcissistic number. Maybe we should talk about your self image?"))
}
