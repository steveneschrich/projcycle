#' Title
#'
#' @param x
#' @param filename
#'
#' @return
#' @export
#'
#' @examples
#'
tbl_maker <- function(x, label = "@fig-fig1", filename = knitr::current_input(), output=c("word","excel")) {

  refs <- purrr::map_chr(output, \(.f) {tbl_maker_(x, label = label, filename=filename, output=.f)})
  cat("<b>",label,"</b>:", stringr::str_flatten(refs, collapse = " | "))
}

tbl_maker_ <- function(x, label = "@fig-fig1", filename = knitr::current_input(), output = "word") {

  filename <- stringr::str_remove(filename, ".markdown$")
  output_filename <- paste0(
    ifelse(is.null(filename), "output", filename),
    stringr::str_remove(label, "@")
  )

  # Create markdown output (regardless of input type)
  if ( output == "excel" ) {
    if ( ! endsWith(output_filename, ".xlsx") )
      output_filename <- paste0(output_filename, ".xlsx")
    md_output <- glue::glue("[{{{{< fa file-excel >}}}}]({output_filename})")
    export_tbl_as_excel(x, output_filename)
  } else if ( output == "word") {
    if ( ! endsWith(output_filename, ".docx") )
      output_filename <- paste0(output_filename, ".docx")

    md_output <- glue::glue("[{{{{< fa file-word >}}}}]({output_filename})")
    export_tbl_as_word(x, output_filename)
  }

  md_output
}

export_tbl_as_excel <- function(x, file) {
  if ( !endsWith(file, ".xlsx"))
    file <- paste0(file, ".xlsx")

  if (methods::is(x, "tbl_summary") ) {
    gtsummary::as_hux_xlsx(x, file = file)
  } else if ( methods::is(x, "data.frame") ) {
    openxlsx::write.xlsx(x, file = file)
  } else if (methods::is(x, "flextable") ) {
    openxlsx::write.xlsx(x$body$dataset, file = file)
  } else {
    cli::cli_abort("Could not find a handler for type {class(x)} of table to write to {file}.")
  }


}

export_tbl_as_word <- function(x, file) {
  if ( !endsWith(file, ".docx"))
    file <- paste0(file, ".docx")

  if (methods::is(x, "tbl_summary") ) {
    gtsummary::as_flex_table(x) |>
      flextable::save_as_docx(path = file)
  } else if ( methods::is(x, "data.frame") ) {
    flextable::flextable(x) |>
      flextable::save_as_docx(path = file)
  } else if (methods::is(x, "flextable") ) {
    flextable::save_as_docx(x, path = file)
  } else {
    cli::cli_abort("Could not find a handler for type {class(x)} of table to write to {file}.")
  }

}


#' Title
#'
#' @param x
#' @param label
#' @param filename
#' @param output
#'
#' @return
#' @export
#'
#' @examples
fig_maker <- function(x, label = "@fig-fig1", filename = knitr::current_input(), output=c("png","pdf"),
                      width=NA, height=NA) {

  refs <- purrr::map_chr(output, \(.f) {fig_maker_(x, label = label, filename=filename, output=.f, width=width, height=height)})
  cat("<b>",label,"</b>:", stringr::str_flatten(refs, collapse = " | "))
}

fig_maker_ <- function(x, label = "@fig-fig1", filename = knitr::current_input(), output = "word", width=NA, height=NA) {

  filename <- stringr::str_remove(filename, ".markdown$")
  output_filename <- paste0(
    ifelse(is.null(filename), "output", filename),
    stringr::str_remove(label, "@")
  )

  # Create markdown output (regardless of input type)
  if ( output == "png" ) {
    if ( ! endsWith(output_filename, ".png") )
      output_filename <- paste0(output_filename, ".png")
    md_output <- glue::glue("[{{{{< fa file-image >}}}}]({output_filename})")
    export_fig_as_png(x, output_filename, width = width, height = height)
  } else if ( output == "pdf") {
    if ( ! endsWith(output_filename, ".pdf") )
      output_filename <- paste0(output_filename, ".pdf")

    md_output <- glue::glue("[{{{{< fa file-pdf >}}}}]({output_filename})")
    export_fig_as_pdf(x, output_filename, width=width, height=height)
  }

  md_output
}



export_fig_as_png <- function(x, file, width= NA, height=NA,dpi=1200) {
  if ( !endsWith(file, ".png"))
    file <- paste0(file, ".png")

  opts <- list(width = width, height= height, dpi = dpi) |>
    purrr::discard(is.na)

  if (methods::is(x, "ggplot") ) {
    suppressMessages(ggplot2::ggsave(plot = x, filename = file, !!!opts))
  } else if ( methods::is(x, "Heatmap")) {
    png(file = file, !!!opts)
    ComplexHeatmap::draw(x)
    dev.off()
  } else if ( methods::is(x, "data.frame") ) {
    openxlsx::write.xlsx(x, file = file)
  } else if (methods::is(x, "flextable") ) {
    openxlsx::write.xlsx(x$body$dataset, file = file)
  } else {
    cli::cli_abort("Could not find a handler for type {class(x)} of figure to write to {file}.")
  }


}

export_fig_as_pdf <- function(x, file, width=NA, height=NA, dpi=1200) {
  if ( !endsWith(file, ".pdf"))
    file <- paste0(file, ".pdf")
  opts <- list(width = width, height= height, dpi = dpi) |>
    purrr::discard(is.na)

  if (methods::is(x, "ggplot") ) {
    suppressMessages(ggplot2::ggsave(plot = x, filename = file, !!!opts))
  } else if ( methods::is(x, "Heatmap")) {
    pdf(file = file, !!!(opts[setdiff(names(opts), "dpi")]))
    ComplexHeatmap::draw(x)
    dev.off()
  } else if ( methods::is(x, "data.frame") ) {
    openxlsx::write.xlsx(x, file = file)
  } else if (methods::is(x, "flextable") ) {
    openxlsx::write.xlsx(x$body$dataset, file = file)

  } else {
    cli::cli_abort("Could not find a handler for type {class(x)} of figure to write to {file}.")
  }


}
