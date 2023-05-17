
#' Title
#'
#' @param data 	a data object (either a matrix or a data frame)
#' @param ... Other options arguments (see [DT::datatable()]).
#'
#' @return
#' @export
#'
#' @examples
datatable <- function(data, ...) {
  args <- list(...)
  DT::datatable(
    data,
    extensions = 'Buttons',
    options = list(
      !!!args,
      scrollX=TRUE,
      scrollY=TRUE,
      dom = 'Bfrtip',
      buttons = c('copy', 'csv', 'excel', 'pdf'),
      columnDefs = list(
        list(
          targets = "_all",
          render = DT::JS(
            "function(data, type, row, meta) {",
            "return type === 'display' && data != null && data.length > 6 ?",
            "'<span title=\"' + data + '\">' + data.substr(0, 6) + '...</span>' : data;",
            "}")
        ))
    ))
}
