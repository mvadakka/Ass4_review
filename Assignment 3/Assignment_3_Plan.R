
# Functions 

# Displaying Artwork 

# Display first artwork & opening screen 
screen_1 <- function() {
  cat("Current game: \n   +---+ \n   |   | \n       | \n       | \n       | \n       | \n ============\n")
  print(paste("The chosen word is", word_length, "characters long."))
  print("You will get 5 lives in this game of hangman")
}

screen_2 <- function() {
  cat("Current game: \n   +---+ \n   |   | \n   O   | \n       |   \n       | \n       | \n ============\n")
  print(paste("Incorrect. You have", lives, "lives left"))
  print("The letters you have guessed so far are: ")
  print(incorrect_letters)
}

screen_3 <- function() {
  cat("Current game: \n   +---+ \n   |   | \n   O   | \n   |   |   \n       | \n       | \n ============\n")
  print(paste("Incorrect. You have", lives, "lives left"))
  print("The letters you have guessed so far are: ")
  print(incorrect_letters)
}

screen_4 <- function() {
  cat("Current game: \n   +---+ \n   |   | \n   O   | \n  /|   |   \n       | \n       | \n ============\n")
  print(paste("Incorrect. You have", lives, "lives left"))
  print("The letters you have guessed so far are: ")
  print(incorrect_letters)
}

screen_5 <- function() {
  cat("Current game: \n   +---+ \n   |   | \n   O   | \n  /|\\  | \n       | \n       | \n ============\n")
  print(paste("Incorrect. You have", lives, "lives left"))
  print("The letters you have guessed so far are: ")
  print(incorrect_letters)
}

screen_6 <- function(word) {
  cat("Current game: \n   +---+ \n   |   | \n   O   | \n  /|\\  | \n  / \\  | \n       | \n ============\n")
  print(paste("Incorrect. You have no lives left. The secret word was:", word))
}

user_enter <- function() {
  readline(prompt = "Enter your guess: ")
}

# Set file path to word list 
file_path <- "/Users/zachery/BTC1855/Assignment 3/ListofWords.txt"

# Calling word list using readlines 
word_list <- readLines(file_path)

# Sampling word 
word <- sample(word_list, 1)

# Getting character count 
word_length <- nchar(word)

# Message to player 
print(paste("The chosen word is", word_length, "characters long."))
print("You will get 5 lives in this game of hangman")

# Display artwork
screen_1()

# Initialize variables
lives <- 6
incorrect_letters <- c()
blank_vector <- rep("_", word_length)
split_word <- toupper(strsplit(word, "")[[1]])  # Convert word to uppercase for comparison

while (lives > 0) {
  input <- toupper(user_enter())  # Convert user input to uppercase
  
  match_found <- FALSE
  
  for (i in seq_along(split_word)) {
    if (split_word[i] == input) { 
      blank_vector[i] <- substring(word, i, i)  # Keep original case
      match_found <- TRUE
    }
  }
  
  if (match_found) {
    print(blank_vector)
    print(paste("Correct! You have", lives, "lives left"))
  } else {
    lives <- lives - 1
    incorrect_letters <- c(incorrect_letters, input)
    
    if (lives == 5) {
      screen_2()
    } else if (lives == 4) {
      screen_3()
    } else if (lives == 3) {
      screen_4()
    } else if (lives == 2) {
      screen_5()
    } else if (lives == 1) {
      screen_6(word)
    }
  }
  
  if (identical(blank_vector, strsplit(word, "")[[1]])) {  # Check if guessed word matches the original word
    print("Congratulations! You've guessed the word!")
    break
  }
}

if (lives == 0) {
  print("Game over! Better luck next time.")
}

