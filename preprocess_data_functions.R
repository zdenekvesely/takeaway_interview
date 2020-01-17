library(tidyverse)
library(readr)
library(lubridate)
library(tokenizers)
library(bigreadr)

STOPWORDS = stopwords::stopwords("en")

tokenizeReview <- function(review_text) {
  review_text %>% 
    gsub(pattern = "[^a-zA-Z\\s']",replacement = " ", x =  .) %>% 
    #tokenize_words(
    tokenize_word_stems(
    stopwords = STOPWORDS,
    #strip_numeric = TRUE,
    simplify = TRUE
  ) %>% 
    unique()
}

transformData <- function(input_data) {
  prepared_data <-
    input_data %>%
    as_tibble() %>% 
    mutate(
      reviewTime = as.POSIXct(unixReviewTime, origin = "1970-01-01"),
      helpful_positive = map(
        helpful,
        ~ sub(
          pattern = "\\[([0-9]+), [0-9]+\\]",
          replacement = "\\1",
          x = .,
          perl = TRUE
        )
      ) %>% as.numeric(),
      helpful_total = map(
        helpful,
        ~ sub(
          pattern = "\\[[0-9]+, ([0-9]+)\\]",
          replacement = "\\1",
          x = .,
          perl = TRUE
        )
      ) %>% as.numeric(),
      review_words = count_words(reviewText),
      review_tokens = map(reviewText, tokenizeReview)
    ) %>%
    select(
      reviewTime,
      reviewerID,
      asin,
      overall,
      helpful_positive,
      helpful_total,
      review_words,
      review_tokens,
      summary
    )
  
  write_rds(
    prepared_data,
    path = file.path("prepared_data",
                     str_c(
                       file_name,
                       format(Sys.time(), "_%y%m%d_%H%M%S"),
                       ".Rds"
                     )),
    compress = "gz"
    )
  return(prepared_data)

}


readData <- function(file_name) {
  tmp <- big_fread1(
    file = file.path("raw_data", file_name),
    every_nlines = 2 ^ 17,
    .transform = transformData,
    .combine = bind_rows
  )
  file.path("prepared_data", str_c(
    file_name,
    "_all_",
    format(Sys.time(), "%y%m%d_%H%M%S"),
    ".Rds"
  )) %>%
    write_rds(x = tmp,
              path = .,
              compress = "gz")
}