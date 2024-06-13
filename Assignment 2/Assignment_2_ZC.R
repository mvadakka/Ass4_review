#'Assignment 2 Instructions:
#'Prompt the user to enter a three digit positive number

#'Check if the user input is numeric. If not, print an error message and quit.

#'Check if the number is narcissistic. A narcissistic number, or an Armstrong number,
#' - is a number that is equal to the sum of the cubes of its own digits. 153, 370, 371, 407 
#' - are three digit Armstrong numbers.

#'Display the result with an appropriate message, e.g. “127 is not an Armstrong number” 
#'- or “370 is a narcissistic number” or any additional fun text you may want to add.
#'- This is a test commit for assignment 2 for BTC1855


user_input <- readline("Enter your number here please: ")

#Please input your number here now 

user_numeric <- as.numeric (user_input)

if (is.na(user_numeric) == T) {
  print (paste("Test"))
  #use quit function here? 
}

#splitting user input into 3 numbers (uses character string as strsplit() uses chracters not strings)
split_input <- strsplit(user_input, "")

input_string <- split_input[[1]]

first_number <- as.numeric(input_string[1])

second_number <- as.numeric(input_string[2])

third_number <- as.numeric(input_string[3])

armstrong <- first_number^3 + second_number^3 + third_number^3

is_armstrong <- c(armstrong == user_numeric)

if (is_armstrong == T) {
  print (paste(user_input, "is a narcissistic number, you self-lover you. Wanna try again?"))
 } else if (is_armstrong == F) {
    print (paste(user_input, "is a not a narcissistic number. "))
  }
