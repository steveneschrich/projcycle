#' Title
#'
#' @param src
#' @param dest
#' @param data_dir
#'
#' @return
#' @export
#'
#' @examples
use_data <- function(src, dest = NULL, data_dir = "data", overwrite = TRUE) {

  # If no dest given, use the src basename. But trim out any working prefix (NN-).
  if ( is.null(dest) ) {
    clean_src <- stringi::stri_replace_first(
      basename(src),
      replacement = "",
      regex="^[0-9]{1,2}\\-"
    )
    dest <- here::here(data_dir, clean_src)
  }
  # If just a filename is given for dest, prepend with data_dir.
  if ( basename(dest) == dest ) {
    dest <- fs::path(data_dir, dest)
  }
  res <- fs::file_copy(src, dest, overwrite)
  cli::cli_alert_success("Copied {src} to {dest}.")

  # NB: Add in dvc add or dvc commit

  res
}
