library(readr)
library(tidyverse)

file_names <- 
  list.files(path = "prepared_data/metadata_parts", 
             pattern = "_part_")

meta_books <- tibble()
meta_movies <- tibble()
meta_electronics <- tibble()
meta_fashion <- tibble()

for (file_name in file_names) {
  
  one_meta <- file.path("prepared_data/metadata_parts", file_name) %>%
    read_rds(.)
  
  sprintf("file: %s was loaded", file_name) %>% 
    message()
  
  meta_books <-
    meta_books %>%
    bind_rows(one_meta %>%
                filter(category == "Books" |
                         category2 == "Books"))
  meta_movies <-
    meta_movies %>%
    bind_rows(one_meta %>%
                filter(category == "Movies & TV" |
                         category2 == "Movies & TV"))
  
  meta_electronics <-
    meta_electronics %>%
    bind_rows(one_meta %>%
                filter(category == "Electronics" |
                         category2 == "Electronics"))
  
  sprintf("file: %s was added", file_name) %>% 
    message()
}


meta_books %>% 
  unique() %>% 
  write_rds(path = "prepared_data/metadata_books.Rds", compress = "gz")

meta_movies %>% 
  unique() %>% 
  write_rds(path = "prepared_data/metadata_movies.Rds", compress = "gz")

meta_electronics %>% 
  unique() %>% 
  write_rds(path = "prepared_data/metadata_electronics.Rds", compress = "gz")

