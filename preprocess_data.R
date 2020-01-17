source("preprocess_data_functions.R")

file_names <- c(
  "reviews_Clothing_Shoes_and_Jewelry_5.csv",
  "reviews_Books_5-004.csv",
  "reviews_Electronics_5.csv",
  "reviews_Movies_and_TV_5.csv"
)

for (file_name in file_names) {
  readData(file_name = file_name)
}