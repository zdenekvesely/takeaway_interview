source("preprocess_metadata_functions.R")

empty_data <- 
  big_fread1(
    file = "raw_data/metadata-003.csv",
    every_nlines = 10^6,
    .transform = transferMetadata,
    .combine = bind_rows
  )

# metadata_raw <- readr::read_csv("raw_data/metadata-003.csv", n_max = 10^6)
# 
# t_meta <- transferMetadata(metadata_raw) 