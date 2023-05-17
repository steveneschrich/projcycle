create_project <- function(path, rstudio = rstudioapi::isAvailable(),
                           roxygen = TRUE,
                           open = rlang::is_interactive()) {

  # This is from usethis package, expand in case of ~
  # and verify directory exists
  path <- fs::path_expand(path)
  if ( !fs::dir_exists(fs::path_dir(path)) )
    cli::cli_abort("Directory {usethis::ui_path(path)} does not exist or is not a directory.")
  if ( fs::file_exists(path) )
    cli::cli_abort("Directory {path} exists but is not a directory.")
  name <- fs::path_file(fs::path_abs(path))

  # Create project directory
  fs::dir_create(path)
  cli::cli_alert_success("Created {path}")
  usethis::proj_set(path, force = TRUE)

  # Create a package first?
  #usethis::create_package/project(...)

  # Create directories in project
  usethis::use_directory("data")
  usethis::use_directory("data-raw")
  usethis::use_directory("data-raw/imports")
  usethis::use_directory("data-raw/work")
  usethis::use_directory("data-raw/R.d")
  usethis::use_directory("R")

  # Create descripton file
  #usethis::use_description(fields, check_name = FALSE, roxygen = roxygen)
  usethis::use_namespace(roxygen = roxygen)
  if ( rstudio ) {
    usethis::use_rstudio()
  } else {
    cli::cli_alert_info("Writing a sentinel file {ui_path('.here')}")
    fs::file_create(usethis::proj_path(".here"))
  }
  install_templates()
  if (open) {
    if (usethis::proj_activate(usethis::proj_get())) {
      withr::deferred_clear()
    }
  }
  invisible(usethis::proj_get())
}

data<-NULL

PI = "Monteiro_Alvaro"
project = "Mouse Ovarian SingleCell"
package="foobar" # Should this be cleaned project name? MouseOvarianSingleCell
ssh_hostname="red.moffitt.org"
shiny_remotedir="/share/dept_bbsr/Projects/Eschrich_Steven/Shiny_Reports"

install_templates <- function(data) {


  usethis::use_template("_quarto.yml", save_as = "_quarto.yml", data = data,
                        ignore = FALSE, package = "projcycle")
  usethis::use_template("about.qmd", save_as = "about.qmd", data = data,
                        ignore = FALSE, package = "projcycle")

  usethis::use_template("Makefile", save_as = "Makefile", data = data,
                        ignore = FALSE, package = "projcycle")
  usethis::use_template("index.qmd", save_as = "index.qmd", data = data,
                        ignore = FALSE, open = TRUE, package = "projcycle.Rproj")
  usethis::use_template("NEWS.md", data = project_data_as_list(), open = FALSE)
}
