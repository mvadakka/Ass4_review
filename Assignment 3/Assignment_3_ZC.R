




file_path <- "/Users/zachery/BTC1855/Assignment 3/ListofWords.txt"

word_list <- readLines(file_path)

word <- sample(word_list,1)

word_length <- nchar(word)

print(paste("The chosen word is", word_length, "characters long."))

print("You will get 5 lives in this game of hangman")

cat("Current game: \n   +---+ \n   |   | \n       | \n       | \n       | \n       | \n ============")

lives <- 6

while (lives >= 1) {
user_input <- readline(prompt = "enter your guess: ")

#add if statement for if the guess is longer than 1 letter, then check to see if it is right and if not, -1 lives

numeric_check <- ifelse(is.na(as.numeric(user_input))==T, 1, 0)
if (numeric_check == 0) {
  stop ("ERROR! ERROR! THAT DOES NOT FOLLOW THE INSTRUCTIONS, SILLY! \n That is not a letter, silly! \n See any NA warnings? I was forced to do this :( \n Run it again and please put in a letter, I will be watching...")
} 

blank_vector <- c(rep("_", word_length))

word_list <- strsplit(word, "")
split_word <- word_list[[1]]

for (i in seq_along(split_word)) {
  if (identical(split_word[i], user_input)){ 
    test <- c()
    
    #concatenating blankl vector, so rresult is only a single element vector with the matching index
    index_match <- c(test, i)
    
    blank_vector[index_match] <- user_input
    
    print(blank_vector)
    print(paste("Correct! You have", lives, "lives left"))
  } else {
    lives <- lives - 1 
    print(paste("Incorrect. You have", lives, "lives left"))
    print(blank_vector)
    
    incorrect <- c()
    incorrect_letters <- append(incorrect, user_input)
    
    print("the letters you have guesses so far are: ")
    print (incorrect_letters)
    
    if (lives == 5) {
      cat("Current game: \n   +---+ \n   |   | \n   O   | \n       |   \n       | \n       | \n ============")
      print(paste("Incorrect. You have", lives, "lives left"))
      print("the letters you have guesses so far are: ")
      print (incorrect_letters)
    } 
    if (lives == 4) {
      cat("Current game: \n   +---+ \n   |   | \n   O   | \n   |   |   \n       | \n       | \n ============")
      print(paste("Incorrect. You have", lives, "lives left"))
      print("the letters you have guesses so far are: ")
      print (incorrect_letters)
    } 
    if (lives == 3) {
      cat("Current game: \n   +---+ \n   |   | \n   O   | \n  /|   |   \n       | \n       | \n ============")
      print(paste("Incorrect. You have", lives, "lives left"))
      print("the letters you have guesses so far are: ")
      print (incorrect_letters)
    } 
    if (lives == 2) {
      cat("Current game: \n   +---+ \n   |   | \n   O   | \n  /|\\  | \n       | \n       | \n ============")
      print(paste("Incorrect. You have", lives, "lives left"))
      print("the letters you have guesses so far are: ")
      print (incorrect_letters)
    }
    if (lives == 1 ){
      cat("Current game: \n   +---+ \n   |   | \n   O   | \n  /|\\  | \n  /    | \n       | \n ============")
      print(paste("Incorrect. You have", lives, "lives left"))
      print("the letters you have guesses so far are: ")
      print (incorrect_letters)
    }
    if (lives == 0) {
      cat("Current game: \n   +---+ \n   |   | \n   O   | \n  /|\\  | \n  / \\  | \n       | \n ============")
      print(paste("Incorrect. You have no lives left. The secret word was: ", word))
    
    }
    break()
    }
  }
}

