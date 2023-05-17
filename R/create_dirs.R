#' Title
#'
#' @param dirs
#'
#' @return
#' @export
#'
#' @examples
create_dirs <- function(dirs = c("data-raw","data-raw/R.d","data-raw/work",
                                 "data","reports")) {

  purrr::map(stats::setNames(dirs, dirs), \(x) {
    fs::dir_create(x)
    cli::cli_alert_success("Created directory {x}")
  })
}
