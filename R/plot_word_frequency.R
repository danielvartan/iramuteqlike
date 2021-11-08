#' Plot word frequencies
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' `plot_word_frequency()` plots word frequencies charts related to an output of
#' [word_frequency()].
#'
#' @param data A [`tibble`][tibble::tibble()] object with two columns: `word`
#'   (with an unique set of words) and `freq` (with the absolute frequency of a
#'   word in `word`). Use [word_frequency()] to generate this value.
#' @param min_freq (optional) A number indicating the minimum frequency that a
#'   word can have to be plotted (default: `1`).
#' @param max_words (optional) A number indicating the maximum number of words
#'   to be plotted (default: `100`).
#' @param dist (optional) A [`logical`][base::logical()] value
#'   indicating if the function must plot a frequency _versus_ range chart
#'   for visualizing the whole distribution (default: `FALSE`).
#' @param color (optional) A string with a Hex color code indicating the color
#'   of the data (default: `viridis::viridis(1)`).
#'
#' @return An invisible `NULL`. This function don't aim to return values.
#'
#' @family Plot functions
#' @export
#'
#' @examples
#' if(interactive()) {
#' if (requireNamespace("friends", quietly = TRUE)) {
#'     data <- word_frequency(head(friends::friends[[1]], 100))
#'     plot_word_frequency(data)
#'     plot_word_frequency(data, dist = TRUE)
#' }
#'
#' if (requireNamespace("stringi", quietly = TRUE)) {
#'     data <- word_frequency(stringi::stri_rand_lipsum(5))
#'     plot_word_frequency(data)
#'     plot_word_frequency(data, dist = TRUE)
#' }
#' }
plot_word_frequency <- function(data, min_freq = 1, max_words = 10,
                                dist = FALSE, color = viridis::viridis(1)) {
    checkmate::assert_data_frame(data, min.rows = 1, min.cols = 2)
    checkmate::assert_names(names(data), identical.to = c("word", "freq"))
    checkmate::assert_number(min_freq, lower = 1)
    checkmate::assert_number(max_words, lower = 1)
    checkmate::assert_flag(dist)
    checkmate::assert_string(color, pattern = "^#")

    # R CMD Check variable bindings fix (see: https://bit.ly/3z24hbU) -----
    word <- freq <- NULL

    if (isTRUE(dist)) {
        cli::cat_line()
        cli::cli_alert_info(paste0(
            "When {.strong {cli::col_blue('dist = TRUE')}} ",
            "{.strong {cli::col_red('min_freq')}} and ",
            "{.strong {cli::col_red('max_words')}} are ignored."
        ))
        cli::cat_line()

        plot <- data %>%
            dplyr::add_count(freq) %>%
            dplyr::mutate(range = seq(length(word))) %>%
            ggplot2::ggplot(ggplot2::aes(x = range, y = freq)) +
            ggplot2::geom_point(colour = color) +
            ggplot2::scale_x_log10() +
            ggplot2::scale_y_log10() +
            ggplot2::labs(x = "log(range)", y = "log(frequencies)")

        print(plot)
    } else {
        if (max_words > nrow(data)) max_words <- nrow(data)

        plot <- data %>%
            dplyr::filter(freq >= min_freq) %>%
            dplyr::slice(seq(1, max_words)) %>%
            ggplot2::ggplot(ggplot2::aes(x = freq,
                                         y = stats::reorder(word, freq))) +
            ggplot2::geom_col(fill = color) +
            ggplot2::labs(x = "Frequency", y = "Words")

        print(plot)
    }

    invisible(NULL)
}
