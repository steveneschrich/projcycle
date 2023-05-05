#' Import data to project
#'
#' @param target
#' @param dest
#' @param import_dir
#'
#' @return
#' @export
#'
#' @examples
dvc_import <- function(url, dest = NULL, import_dir = "data-raw/imports") {
  if (  is.null(dest) ) {
    dest <- here::here(import_dir, basename(url))
  } else {
    import_dir <- dirname(dest)
  }

  # Create destination dir if it doesn't exist.
  if ( !fs::dir_exists(import_dir) ) {
    fs::dir_create(import_dir)
    cli::cli_alert_success("Created destination directory {import_dir}.")
  }

  # Import file if it's not already present
  if ( !file.exists(dest)) {
    cli::cli_alert_info("Importing {dest} from {url}.")
    res <- system2(
      "dvc",
      args = c(
        "import-url",
        url,
        dest
      )
    )
  } else
  # Else update the existing file
  {
    cli::cli_alert_info("Checking for updates to {dest} from {url}.")
    res <- system2(
      "dvc",
      args = c(
        "update",
        paste0(dest, ".dvc")
      )
    )
  }
  invisible(res)
}

