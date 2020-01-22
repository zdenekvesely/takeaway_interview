library(bigreadr)
library(readr)
library(tidyverse)
library(jsonlite)


getRelatedJson <- function(related) {
  if (is.na(related) | related == "") {
    return(list())
  }
  related %>%
    gsub("\'", "\"", .) %>%
    fromJSON()
}

transferMetadata <- function(metadata_raw) {
  time_start <- Sys.time()

  tmp <-
    metadata_raw %>%
    as_tibble() %>% 
    #rename(salesRank = salesrank) %>% 
    mutate(
      category = map(
        salesRank,
        ~ sub(
          pattern = "\\{\\'(.*)\\': [0-9]+\\}",
          replacement = "\\1",
          x = .,
          perl = TRUE
        )
      ) %>% as.character(),
      category_rank = map(
        salesRank,
        ~ sub(
          pattern = "\\{\\'.*\\': ([0-9]+)\\}",
          replacement = "\\1",
          x = .,
          perl = TRUE
        )
      ) %>% as.character(),
      category2 = map(
        categories,
        ~ sub(
          pattern = "\\[\\[\\'(.*)\\'.*",
          replacement = "\\1",
          x = .,
          perl = TRUE
        )
      ) %>% as.character(),
      related_json = map(related, getRelatedJson),
      also_viewed = map(related_json, ~ .$also_viewed),
      buy_after_viewing = map(related_json, ~ .$buy_after_viewing),
      also_bought = map(related_json, ~ .$also_bought),
      bought_together = map(related_json, ~ .$bought_together)
    ) %>%
    mutate(brand = ifelse(brand == "", NA, brand),
           category = ifelse(brand == "", NA, category),
           category_rank = ifelse(category_rank),
           category2 = ifelse(brand == "", NA, category2),
           category2 = ifelse(title == "", NA, title)) %>% 
    select(
      asin,
      category,
      category_rank,
      category2,
      price,
      title,
      brand,
      also_viewed,
      buy_after_viewing,
      also_bought ,
      bought_together
    )
  
  time_end <- Sys.time()
  
  msg <-
    difftime(time_end, time_start, units = "mins") %>%
    round(2) %>%
    sprintf("this part took %s minutes", .)
  
    message(msg)
  
  file.path("prepared_data/metadata_parts",
            str_c("metadata_part_",
                  format(Sys.time(), "%y%m%d_%H%M%S"),
                  ".Rds")) %>%
    write_rds(x = tmp,
              path = .,
              compress = "gz")
  
  tibble(msg = msg)
  
}


