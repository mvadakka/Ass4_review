
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
  readline(prompt = "enter your guess: ")
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

#Initialize variables
blank_vector <- c(rep("_", word_length))
word_list <- strsplit(word, "")
split_word <- word_list[[1]]
incorrect_letters <- c()

while (lives > 0) {
  input <- user_enter()
  
  for (i in seq_along(split_word)) {
    if (identical(split_word[i], input)) { 
      blank_vector[i] <- input
    }
  }
  
  if (identical(split_word[i], input)) {
    print(blank_vector)
    print(paste("Correct! You have", lives, "lives left"))
  } else {
    lives <- lives - 1 
    incorrect_letters <- c(incorrect_letters, input)
    
    if (lives == 5) {
      screen_1()
    }
    if (lives == 4) {
      screen_2()
    }
    if (lives == 3) {
      screen_3()
    }
    if (lives == 2) {
      screen_4()
    }
    if (lives == 1) {
      screen_5()
    }
  }
}

if (identical(blank_vector, split_word)) {
  print("Congrats!")
}

if (lives == 0) {
  screen_6()
}
      
   
  
