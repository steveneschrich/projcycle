#' Title
#'
#' @return
#' @export
#'
#' @examples
create_news <- function() {
  usethis::use_template("NEWS.md", data = project_data_as_list(), open = FALSE)
}


#' Title
#'
#' @return
#' @export
#'
#' @examples
edit_news <- function() {
  usethis::edit_file(usethis::proj_path("NEWS.md"))
}

git_commit_news <- function() {}

