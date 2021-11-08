test_that("plot_wordcloud() | general test", {
    suppressMessages(suppressWarnings(
        expect_message(plot_wordcloud(
        word_frequency(head(friends::friends[[1]], 100))))
    ))
    suppressMessages(suppressWarnings(
    expect_null(plot_wordcloud(
        word_frequency(head(friends::friends[[1]], 100))))
    ))
})

test_that("plot_wordcloud() | error test", {
    data <- word_frequency(head(friends::friends[[1]], 100))

    expect_error(plot_wordcloud(1, min_freq = 1, max_words = 1,
                                random_order = TRUE, rot_per = 1,
                                colors = "#440154FF"),
                 "Assertion on 'data' failed")

    expect_error(plot_wordcloud(data, min_freq = "a", max_words = 1,
                                random_order = TRUE, rot_per = 1,
                                colors = "#440154FF"),
                 "Assertion on 'min_freq' failed")

    expect_error(plot_wordcloud(data, min_freq = 1, max_words = "a",
                                random_order = TRUE, rot_per = 1,
                                colors = "#440154FF"),
                 "Assertion on 'max_words' failed")

    expect_error(plot_wordcloud(data, min_freq = 1, max_words = 1,
                                random_order = 1, rot_per = 1,
                                colors = "#440154FF"),
                 "Assertion on 'random_order' failed")

    expect_error(plot_wordcloud(data, min_freq = 1, max_words = 1,
                                random_order = TRUE, rot_per = "a",
                                colors = "#440154FF"),
                 "Assertion on 'rot_per' failed")

    expect_error(plot_wordcloud(data, min_freq = 1, max_words = 1,
                                random_order = TRUE, rot_per = 1,
                                colors = 1),
                 "Assertion on 'colors' failed")

    expect_error(plot_wordcloud(data, min_freq = 1, max_words = 1,
                                random_order = TRUE, rot_per = 1,
                                colors = "440154FF"),
                 "Assertion on 'colors' failed")
})
