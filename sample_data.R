source("preprocess_data_functions.R")

review_data <-
  read_rds("prepared_data/reviews_Electronics_5.csv_all_200118_021758.Rds")
dim(review_data)

review_data_sample <- getSample(review_data, 10000)
dim(review_data_sample)

write_rds(review_data_sample, path = "prepared_data/reviews_Electronics_5_10000.Rds")


#######################

review_data <-
  read_rds("prepared_data/reviews_Books_5-004.csv_all_200118_014248.Rds")
dim(review_data)

review_data_sample <- getSample(review_data, 10000)
dim(review_data_sample)

write_rds(review_data_sample, path = "prepared_data/reviews_Books_5_10000.Rds")


#######################

review_data <-
  read_rds("prepared_data/reviews_Movies_and_TV_5.csv_all_200118_023830.Rds")
dim(review_data)

review_data_sample <- getSample(review_data, 10000)
dim(review_data_sample)

write_rds(review_data_sample, path = "prepared_data/reviews_Movies_and_TV_5_10000.Rds")

