file_path <- "/Users/zachery/BTC1855/Assignment 3/ListofWords.txt"

word_list <- readLines(file_path)

word <- sample(word_list,1)

word_length <- nchar(word)

print
