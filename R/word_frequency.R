#' Map terms from a corpus and compute its word frequency
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' `word_frequency()` map terms from a vector using the [tm][tm::Corpus()]
#' package system and outputs a [tibble][dplyr::tibble()] summarizing word
#' frequencies.
#'
#' Please note that `word_frequency()` is required for other `iramuteqlike`
#' functions.
#'
#' @param x An [atomic vector][base::is.atomic()] (usually a
#'   [character][character()] object) with a corpus (a collection of documents
#'   containing text). Each element of `x` will represent a document (e.g., a
#'   response from a survey).
#' @param language (optional) a string indicating the corpus language. See
#'   [tm::SimpleCorpus()][tm::SimpleCorpus()] to learn more (default: `"en"`).
#' @param stopwords (optional) a string indicating the corpus language to be
#'   pass to [tm::stopwords()]. [tm::stopwords()] return various kinds of words
#'   related to a specific language to help clean a text analysis (default:
#'   `"en"`).
#' @param other_stopwords (optional) a string indicating other stop words to be
#' removed from the text analysis.
#'
#' @return A [`tibble`][tibble::tibble()] object with two columns:
#'
#' * `word`: with an unique set of words mapped from `x`.
#' * `freq`: with the absolute frequency of a word in `word`.
#'
#' @family Mapping functions
#' @export
#'
#' @examples
#' if (requireNamespace("friends", quietly = TRUE)) {
#'     word_frequency(head(friends::friends[[1]], 100))
#' }
#'
#' if (requireNamespace("stringi", quietly = TRUE)) {
#'     word_frequency(stringi::stri_rand_lipsum(5))
#' }
word_frequency <- function(x, language = "en", stopwords = language,
                           other_stopwords = NULL) {
    checkmate::assert_atomic(x, min.len = 1)
    checkmate::assert_string(language)
    checkmate::assert_string(stopwords, null.ok = TRUE)
    checkmate::assert_character(other_stopwords, min.chars = 1, min.len = 1,
                                null.ok = TRUE)

    # R CMD Check variable bindings fix (see: https://bit.ly/3z24hbU) -----
    . <- NULL

    # toSpace <- tm::content_transformer(
    #     function (x, pattern) gsub(pattern, " ", x))

    out <- data.frame(doc_id = seq_along(x), text = as.character(x)) %>%
        tm::DataframeSource() %>%
        tm::SimpleCorpus(control = list(language = language)) %>%
        tm::tm_map(tolower) %>%
        tm::tm_map(tm::removeNumbers) %>%
        tm::tm_map(tm::removePunctuation) %>%
        tm::tm_map(tm::stripWhitespace)

    if (!is.null(stopwords)) {
        out <- out %>%
            tm::tm_map(tm::removeWords, tm::stopwords(stopwords))

        if (!is.null(other_stopwords)) {
            out <- out %>%
                tm::tm_map(tm::removeWords, other_stopwords)
        }
    }

    out <- out %>%
        tm::TermDocumentMatrix() %>%
        as.matrix()

    sort(rowSums(out), decreasing = TRUE) %>%
        dplyr::tibble(word = names(.), freq = .)
}
