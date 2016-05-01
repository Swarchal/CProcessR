#' Converts directory or list of .csv files into an SQLite database
#'
#' Produces an SQLite database from either a directory or a list of .csv files
#'
#' @param x list of files or directory containing files
#' @param ... additional arguments to be passed to \code{csv_to_sqlite_x}
#' @export


csv_to_sql <- function(x, ...){

	if (is.list(x)) csv_to_sqlite_list_(x, ...)

	if (is.character(x)) csv_to_sqlite_path_(x, ...)
}
