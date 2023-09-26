#' Plot a word cloud
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' `plot_wordcloud()` plots a word cloud using an output of [word_frequency()].
#'
#' This function uses [wordcloud()][wordcloud::wordcloud()] to generate
#' word cloud graphics.
#'
#' @param data A [`tibble`][tibble::tibble()] object with two columns: `word`
#'   (with an unique set of words) and `freq` (with the absolute frequency of a
#'   word in `word`). Use [word_frequency()] to generate this value.
#' @param min_freq (optional) a number indicating the minimum frequency that a
#'   word can have to be plotted (default: `2`).
#' @param max_words (optional) a number indicating the maximum number of words
#'   to be plotted (default: `100`).
#' @param random_order (optional) a [`logical`][base::logical()] value
#'   indicating if the function must plot words in random order. If `FALSE`,
#'   the words will be plotted in decreasing frequency. See
#'   [wordcloud()][wordcloud::wordcloud()] to learn more (default: `FALSE`).
#' @param rot_per (optional) a number indicating the proportion words with 90
#'   degree rotation (default: `0.35`).
#' @param colors (optional) a [`character`][base::character()] object with Hex
#'   color codes indicating the color that the words must have, from least to
#'   most frequent. If `NULL`, the [viridis plasma palette][viridis::plasma()]
#'   will be used (default: `NULL`).
#' @param ... (optional) additional parameters to be passed to the
#' [wordcloud()][wordcloud::wordcloud()] function.
#'
#' @return An invisible `NULL`. This function don't aim to return values.
#'
#' @family Plot functions
#' @export
#'
#' @examples
#' if (requireNamespace("friends", quietly = TRUE)) {
#'     data <- word_frequency(head(friends::friends[[1]], 100))
#'     suppressMessages(plot_wordcloud(data))
#'
#'     ## Note that graphics rendered in the documentation may
#'     ## not represent the quality of the output.
#' }
#'
#' if (requireNamespace("stringi", quietly = TRUE)) {
#'     data <- word_frequency(stringi::stri_rand_lipsum(5))
#'     suppressMessages(plot_wordcloud(data))
#'
#'     ## Note that graphics rendered in the documentation may
#'     ## not represent the quality of the output.
#' }
plot_wordcloud <- function(data, min_freq = 2, max_words = 100,
                           random_order = FALSE, rot_per = 0.35,
                           colors = NULL, ...) {
  checkmate::assert_data_frame(data, min.rows = 1, min.cols = 2)
  checkmate::assert_names(names(data), identical.to = c("word", "freq"))
  checkmate::assert_number(min_freq, lower = 1)
  checkmate::assert_number(max_words, lower = 1)
  checkmate::assert_flag(random_order)
  checkmate::assert_number(rot_per)
  checkmate::assert_character(colors, min.len = 1, pattern = "^#",
                              null.ok = TRUE)

  if (is.null(colors)) colors <- viridis::plasma(10, end = 0.75)

  # R CMD Check variable bindings fix (see: https://bit.ly/3z24hbU) -----
  # nolint start: object_usage_linter.
  word <- freq <- NULL
  # nolint end

  cli::cat_line()
  cli::cli_alert_info(paste0(
    "You need to expand your plot window for this function to work. ",
    "If the function produces warnings, try to maximize the plot window ",
    "and running it again."
  ))
  cli::cat_line()

  wordcloud::wordcloud(words = data$word, freq = data$freq,
                       min.freq = min_freq, max.words = max_words,
                       random.order = random_order, rot.per = rot_per,
                       colors = colors, ...)

  invisible(NULL)
}
