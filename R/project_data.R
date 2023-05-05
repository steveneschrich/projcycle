#' Title
#'
#' @return
#' @export
#'
#' @examples
project_data <- function() {
  desc::description$new(usethis::proj_get())
}

#' Title
#'
#' @return
#' @export
#'
#' @examples
project_data_as_list <- function() {
  p <- project_data()
  as.list(p$get(p$fields()))
}
