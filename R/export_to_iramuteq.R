#' Export a vector to an IRaMuTeQ formatted corpus file
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' `export_to_iramuteq()` export atomic vectors to files with the format
#' required by IRaMuTeQ for text corpuses (a collection of documents containing
#' text).
#'
#' @param x An [atomic vector][base::is.atomic()] (usually a
#'   [character][character()] object) with a corpus (a collection of documents
#'   containing text). Each element of `x` will represent a document (e.g., a
#'   response from a survey).
#' @param dir (optional) a string indicating the directory on where the
#' corpus files must be saved (default: `utils::choose.dir()`).
#' @param file_name (optional) a string indicating the file name of the corpus.
#' @param var_name (optional) a string indicating the variable name for each
#' document. This is required by IRaMuTeQ for distinguish each document inside
#' a corpus (default: `"respondent"`).
#'
#' @return An invisible `NULL`. This function don't aim to return values.
#'
#' @family Utility functions
#' @export
#'
#' @examples
#' \dontrun{
#' if (requireNamespace("friends", quietly = TRUE)) {
#'     export_to_iramuteq(head(friends::friends[[1]], 100),
#'                        dir = tempdir(), file_name = "test.txt")
#' }
#' }
export_to_iramuteq <- function(x, dir = utils::choose.dir(),
                               file_name = paste0(deparse(substitute(x)),
                                                  ".txt"),
                               var_name = "respondent") {
    checkmate::assert_atomic(x, min.len = 1)
    checkmate::assert_directory_exists(dir)
    checkmate::assert_string(file_name, min.chars = 1)
    checkmate::assert_string(var_name, min.chars = 1,
                             pattern = "^[A-Za-z0-9.-_]+$")

    if (stringr::str_detect(file_name, "^[\\w\\-. ]+$", negate = TRUE)) {
        file_name <- "corpus.txt"

        cli::cli_alert_info(paste0(
            "The {.strong {cli::col_red('file_name')}} argument ",
            "have an invalid value. The file was named as ",
            "{.strong {cli::col_blue(file_name)}}."
        ))
    }

    file <- file.path(dir, file_name)

    readr::write_lines(iramuteq_format(x, var_name),
                       file, sep = "")

    readr::read_lines(file, skip_empty_rows = TRUE) %>%
        readr::write_lines(file)

    invisible(NULL)
}

iramuteq_format <- function(x, var_name = "respondent") {
    checkmate::assert_atomic(x, min.len = 1)
    checkmate::assert_string(var_name, min.chars = 1)

    # R CMD Check variable bindings fix (see: https://bit.ly/3z24hbU) -----
    . <- NULL

    x %>% as.character() %>%
        gutils:::na_replace() %>%
        tidy_case() %>%
        paste(paste0("**** *", var_name, "_", seq_along(.), "*"),
              ., sep = "\n", collapse = "\n")
}

tidy_case <- function(x) {
    checkmate::assert_character(x, min.len = 1)

    x %>% stringr::str_trim() %>%
        stringr::str_replace_all("\\n\\n|\\n\\n\\n|\\n\\n\\n\\n", "\n")
}
