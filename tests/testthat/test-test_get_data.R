

data <- httr::RETRY(
  "GET",
  "https://randomuser.me/api/?seed=123&results=10&format=csv",
  times = 5)


text <- httr::content(data, as = "text")

data <- readr::read_csv(text)

names(data) <- gsub(".", "_", names(data), fixed = TRUE)

final <- data


test_that("testing identical results", {

  testthat::expect_identical(final,get_data(n = 10, seed = "123"))

  testthat::expect_s3_class(final, "data.frame")

  testthat::expect_equal(ncol(final), ncol(get_data(n = 10)))


})
