test_that("word_frequency() | general test", {
    x <- word_frequency(head(friends::friends[[1]], 100))

    checkmate::expect_tibble(x, ncols = 2, col.names = "unique")
    checkmate::assert_names(names(x), identical.to = c("word", "freq"))

    x <- word_frequency(stringi::stri_rand_lipsum(5),
                        other_stopwords = "test")

    checkmate::expect_tibble(x, ncols = 2, col.names = "unique")
    checkmate::assert_names(names(x), identical.to = c("word", "freq"))
})

test_that("word_frequency() | error test", {
    expect_error(word_frequency(list(1), language = "a", stopwords = "en",
                                other_stopwords = NULL),
                 "Assertion on 'x' failed")

    expect_error(word_frequency(1, language = 1, stopwords = "a",
                                other_stopwords = NULL),
                 "Assertion on 'language' failed")

    expect_error(word_frequency(1, language = "a", stopwords = 1,
                                other_stopwords = NULL),
                 "Assertion on 'stopwords' failed")

    expect_error(word_frequency(1, language = "a", stopwords = "a",
                                other_stopwords = 1),
                 "Assertion on 'other_stopwords' failed")
})
