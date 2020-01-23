rmarkdown::render("helpfulness_electronics.Rmd",
                  output_file = "electronics_all.html",
                  params = list(data_size = "big")
                  )

rmarkdown::render("helpfulness_movies.Rmd",
                  output_file = "movies_all.html",
                  params = list(data_size = "big"))

rmarkdown::render("helpfull_books.Rmd",
                  output_file = "books_big.html",
                  params = list(data_size = "big"))


# rmarkdown::render("helpfulness_electronics.Rmd",
#                   output_file = "electronics_small.html",
#                   params = list(data_size = "small")
# )
# 
# rmarkdown::render("helpfulness_movies.Rmd",
#                   output_file = "movies_small.html",
#                   params = list(data_size = "small"))
# 
# rmarkdown::render("helpfull_books.Rmd",
#                   output_file = "books_small.html",
#                   params = list(data_size = "small"))