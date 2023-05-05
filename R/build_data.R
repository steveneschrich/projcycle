#' Run all scripts to build data
#'
#' @param dir Directory to use for R.d files (default is `data-raw/R.d`).
#' @param verbose Should the files processed be printed as they are executed.
#'
#' @return Logical value (TRUE) invisibly
#' @export
#'
#' @examples
#' \dontrun{
#'  # Source all scripts in data-raw/R.d:
#'  build_data()
#'  # Source all scripts in alternate directory:
#'  build_data(dir = "~/mydir/R.dx")
#' }
build_data <- function(dir = fs::path("data-raw","R.d"), verbose = TRUE) {
  files <- fs::dir_ls(path = dir, regexp = "\\d+-.*\\.R$")

  purrr::walk(files, function(f) {
    if (verbose)
      cli::cli_alert_info("Executing {basename(f)}.")
    source(f, local = new.env())
  })
  invisible(TRUE)
}
