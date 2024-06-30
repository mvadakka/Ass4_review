#' BTC1855 - Assignment 2, Zachery Chan
#' R version: Version 2024.04.2+764 (2024.04.2+764)
#' Code dated to: June 30

#' Setting functions for use in the script

# Function for display first artwork & opening screen 
screen_1 <- function() {
  #Using cat here for better displaying than print()
  cat ("Current game: \n   +---+ \n   |   | \n       | \n       | \n       | \n       | \n ============")
  cat (paste("Hi there! Lets play game and see if you can save a life? The chosen word is", word_length, "characters long."))
  print ("You will get 6 lives in this game of Hangman, choose carefully")
  cat("This is the rules of rhe game: 
  EACH GUESS CONSISTS OF A SINGLE LETTER EACH TIME
      AFTER EACH GUESS, A LIFE IS LOST. WHEN LIVES = 0 YOU HAVE LOST")
} #Using a similar logic and function for all functions to display screens

# Function for displaying screen when lost 1 life 
screen_2 <- function() {
  cat ("Current game: \n   +---+ \n   |   | \n   O   | \n       |   \n       | \n       | \n ============")
  cat (blank_vector)
  print (paste("Incorrect. You have", lives, "lives left"))
  print ("the letters you have guesses so far are: ")
  # Vector displays list of incorrect letters/numbers
  print (incorrect_letters)
}

# Function for displaying screen when lost 2 lives 
screen_3 <- function() {
  cat ("Current game: \n   +---+ \n   |   | \n   O   | \n   |   |   \n       | \n       | \n ============")
  cat (blank_vector)
  cat (paste("Incorrect. You have", lives, "lives left"))
  print ("the letters you have guesses so far are: ")
  print (incorrect_letters)
}

# Function for displaying screen when lost 3 life 
screen_4 <- function() {
  cat ("Current game: \n   +---+ \n   |   | \n   O   | \n  /|   |   \n       | \n       | \n ============")
  cat (blank_vector)
  cat (paste("Incorrect. You have", lives, "lives left"))
  print ("the letters you have guesses so far are: ")
  print (incorrect_letters)
}

# Function for displaying screen when lost 4 life 
screen_5 <- function() {
  cat ("Current game: \n   +---+ \n   |   | \n   O   | \n  /|\\  | \n       | \n       | \n ============")
  cat (blank_vector)
  cat (paste("Incorrect. You have", lives, "lives left"))
  print ("the letters you have guesses so far are: ")
  print (incorrect_letters)
}

# Function for displaying screen when lost 5 life 
screen_6 <- function() {
  cat ("Current game: \n   +---+ \n   |   | \n   O   | \n  /|\\  | \n  /    | \n       | \n ============")
  cat (blank_vector)
  cat (paste("Incorrect. You have", lives, "lives left"))
  print ("the letters you have guesses so far are: ")
  print (incorrect_letters)
}
# Function for displaying final screen when user has lost 
screen_7 <- function() {
  cat ("Current game: \n   +---+ \n   |   | \n   O   | \n  /|\\  | \n  / \\  | \n       | \n ============")
  print (paste("Incorrect. You have no lives left. The secret word was: ", word))
}

# Function for capturing user input 
user_enter <- function() {
  readline(prompt = "Enter your guess: ")
}

# Function for displaying screen when winning the game
congrats <- function() {
  cat("

████████████████████████▀█████████████████████████
█─▄▄▄─█─▄▄─█▄─▀█▄─▄█─▄▄▄▄█▄─▄▄▀██▀▄─██─▄─▄─█─▄▄▄▄█
█─███▀█─██─██─█▄▀─██─██▄─██─▄─▄██─▀─████─███▄▄▄▄─█
▀▄▄▄▄▄▀▄▄▄▄▀▄▄▄▀▀▄▄▀▄▄▄▄▄▀▄▄▀▄▄▀▄▄▀▄▄▀▀▄▄▄▀▀▄▄▄▄▄▀

      ")
  print(paste("You did it! The secret word was: ", word))
}


# --------------------------------------------------------------------------------
# Actual code begins:

# Defining file path to txt file for list of words
file_path <- "/Users/zachery/BTC1855/Assignment 3/ListofWords.txt"
# Please adjust this code to match where you will download the txt file

# Calling word list using readlines(), used suppressWarnings() to disregard message about incomplete final line in txt file
word_list <- suppressWarnings(readLines(file_path))

# Sampling random word
word <- sample(word_list,1)

# Getting character count of sampled word 
word_length <- nchar(word)

#Displaying inital screen
screen_1()

# Initializing variables
# Set lives to 6 for player 
lives <- 6

# creating blank vector for displaying the word & correct guesses, repeating "_" as fillers 
blank_vector <- c(rep("_", word_length))

# Create vector to store incorrect guesses 
incorrect_letters <- c()

# Splitting word into individual characters, stored in vector
split_word <- toupper(strsplit(word, "")[[1]])
# Using toupper() here to disregard lower/upper case for words in the txt file 
# The use of strsplit() here was very finicky, had to set this all in 1 line 

#` -----------------------------------------------------------------------------------`
#' RULES OF THE GAME: 
#' 6 LIVES (MATCHING TO TYPICAL ARTWORK FOR HANGMAN)
#' EACH GUESS CONSISTS OF A SINGLE LETTER EACH TIME
#' AFTER EACH GUESS, A LIFE IS LOST. WHEN LIVES = 0, YOU AHVE LOST (OUT OF GUESSES)
#` -----------------------------------------------------------------------------------`

#' Using while loop to ask for user input as long as lives =/= 0  
while (lives > 0) {
  # Calling user_enter() function (defined earlier), using toupper() to disregard typecase like in the txt file
  input <- toupper(user_enter())
  # Set default to no match 
  match <- F
  
  # Using for loop to compare single character input to all elements in split_word while keeping index count 
  for (i in seq_along(split_word)) {
    # IF the user guesses correctly, using if statement to set match = TRUE and place letter in 
    #' respective place in blank vector (dashes)
    if (split_word[i] == input) { 
      blank_vector[i] <- input
      match <- T
    }
  }
  
  # if match = TRUE, print dashes (and correct), and congratulate 
  if (match) {
    print(blank_vector)
    print(paste("Correct! You have", lives, "lives left"))
  } else {
    # IF user is incorrect (match = FALSE), use of else here computes this code 
    
    # Redefine lives (reduce by 1)
    lives <- lives - 1 
    
    #Appends incorrect guess to list of incrroect letters 
    incorrect_letters <- c(incorrect_letters, input)
    
    # Set of if-else statements to determine which screen is displayed 
    if (lives == 6) {
      screen_1()
    } else if (lives == 5) {
      screen_2()
    } else if (lives == 4) {
      screen_3()
    } else if (lives == 3) {
      screen_4()
    } else if (lives == 2) {
      screen_5()
    } else if (lives == 1) {
      screen_6()
    } else if ( lives == 0) {
      screen_7()
      break ()
      } 
   }
  # If statement to display screen upon winning 
  if (identical(blank_vector, split_word)) {
    congrats()
    break()
  }
} # Closes while loop 

