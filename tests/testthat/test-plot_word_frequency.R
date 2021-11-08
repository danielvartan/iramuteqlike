test_that("plot_word_frequency() | general test", {
    expect_null(plot_word_frequency(
        word_frequency(head(friends::friends[[1]], 100))))

    expect_null(plot_word_frequency(
        word_frequency(head(friends::friends[[1]], 10)),
        max_words = 10000000))

    suppressMessages(suppressWarnings(
        expect_message(plot_word_frequency(
            word_frequency(head(friends::friends[[1]], 100)), dist = TRUE))
    ))

    suppressMessages(suppressWarnings(
    expect_null(plot_word_frequency(
        word_frequency(head(friends::friends[[1]], 100)), dist = TRUE))
    ))
})

test_that("plot_word_frequency() | error test", {
    data <- word_frequency(head(friends::friends[[1]], 100))

    expect_error(plot_word_frequency(1, min_freq = 1, max_words = 1,
                                     dist = TRUE, color = "#440154FF"),
                 "Assertion on 'data' failed")

    expect_error(plot_word_frequency(data, min_freq = "a", max_words = 1,
                                     dist = TRUE, color = "#440154FF"),
                 "Assertion on 'min_freq' failed")

    expect_error(plot_word_frequency(data, min_freq = 1, max_words = "a",
                                     dist = TRUE, color = "#440154FF"),
                 "Assertion on 'max_words' failed")

    expect_error(plot_word_frequency(data, min_freq = 1, max_words = 1,
                                     dist = 1, color = "#440154FF"),
                 "Assertion on 'dist' failed")

    expect_error(plot_word_frequency(data, min_freq = 1, max_words = 1,
                                     dist = TRUE, color = 1),
                 "Assertion on 'color' failed")

    expect_error(plot_word_frequency(data, min_freq = 1, max_words = 1,
                                     dist = TRUE, color = "440154FF"),
                 "Assertion on 'color' failed")
})
