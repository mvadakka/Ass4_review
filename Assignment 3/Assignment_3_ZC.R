
#Functions 

#Displaying Artwork 

#Display first artwork & opening screen 
screen_1 <- function() {
  cat("Current game: \n   +---+ \n   |   | \n       | \n       | \n       | \n       | \n ============")
  print(paste("The chosen word is", word_length, "characters long."))
  print("You will get 5 lives in this game of hangman")
}

screen_2 <- function() {
  cat("Current game: \n   +---+ \n   |   | \n   O   | \n       |   \n       | \n       | \n ============")
  print(paste("Incorrect. You have", lives, "lives left"))
  print("the letters you have guesses so far are: ")
  print (incorrect_letters)
}

screen_3 <- function() {
  cat("Current game: \n   +---+ \n   |   | \n   O   | \n   |   |   \n       | \n       | \n ============")
  print(paste("Incorrect. You have", lives, "lives left"))
  print("the letters you have guesses so far are: ")
  print (incorrect_letters)
}

screen_4 <- function() {
  cat("Current game: \n   +---+ \n   |   | \n   O   | \n  /|   |   \n       | \n       | \n ============")
  print(paste("Incorrect. You have", lives, "lives left"))
  print("the letters you have guesses so far are: ")
  print (incorrect_letters)
}

screen_5 <- function() {
  cat("Current game: \n   +---+ \n   |   | \n   O   | \n  /|\\  | \n       | \n       | \n ============")
  print(paste("Incorrect. You have", lives, "lives left"))
  print("the letters you have guesses so far are: ")
  print (incorrect_letters)
}

screen_6 <- function() {
  cat("Current game: \n   +---+ \n   |   | \n   O   | \n  /|\\  | \n  / \\  | \n       | \n ============")
  print(paste("Incorrect. You have no lives left. The secret word was: ", word))
}

user_enter <- function() {
  user_input <- readline(prompt = "enter your guess: ")
}



#Set File path to word list 
file_path <- "/Users/zachery/BTC1855/Assignment 3/ListofWords.txt"

#Calling word list using readlines 
word_list <- readLines(file_path)

#Sampling word 
word <- sample(word_list,1)

#getting char count 
word_length <- nchar(word)

#Message to player 
print(paste("The chosen word is", word_length, "characters long."))
print("You will get 5 lives in this game of hangman")

#Dsiplay artwork
screen_1()

lives <- 6

blank_vector <- c(rep("_", word_length))
word_list <- strsplit(word, "")
split_word <- word_list[[1]]

while (lives > 0) {
  user_enter()
  
  for (i in seq_along(split_word)) {
    if (identical(split_word[i], user_input)) { 
      blank_vector[i] <- user_input
      
      print(blank_vector)
      print(paste("Correct! You have", lives, "lives left"))
    } else {
      lives <- lives - 1 
      print(paste("Incorrect. You have", lives, "lives left"))
      print(blank_vector)
    }
  }
}
