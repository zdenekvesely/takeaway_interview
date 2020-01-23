library(tidyverse)
library(readr)
library(lubridate)

reviews_data <- read_rds("prepared_data/reviews_Books_5_10000.Rds")
metadata <- read_rds("prepared_data/metadata_books.Rds")


reviews_data %>% 
  nrow()

# missing some products
reviews_data <-
  reviews_data%>% 
  inner_join(metadata, by = "asin") 

write_rds(reviews_data, path = "prepared_data/reviews_enriched_books_10000.Rds",
          compress = "gz")

