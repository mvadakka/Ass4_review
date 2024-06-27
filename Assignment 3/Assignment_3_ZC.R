file_path <- "/Users/zachery/BTC1855/Assignment 3/ListofWords.txt"

word_list <- readLines(file_path)

word <- sample(word_list,1)

word_length <- nchar(word)

print(paste("The chosen word is", word_length, "characters long."))

print("You will get 5 lives in this game of hangman")

lives <- 5

user_input <- readline(prompt = "enter a letter: ")

numeric_check <- ifelse(is.na(as.numeric(user_input))==T, 1, 0)
if (numeric_check == 0) {
  stop ("ERROR! ERROR! THAT DOES NOT FOLLOW THE INSTRUCTIONS, SILLY! \n That is not a letter, silly! \n See any NA warnings? I was forced to do this :( \n Run it again and please put in a letter, I will be watching...")
} 

blank_string <- paste(rep("(_)", word_length), collapse = "")

while (lives <= 1){
  word_list <- strsplit(word, "")
  split_word <- test[[1]]
  
  test <- c()
  
  for (i in seq_along(split_word)) {
    if (identical(split_word, user_input)){ 
      #concatenating blankl vector, so rresult is only a single element vector with the matching index
      index_match <- c(test, i)
    }
}




