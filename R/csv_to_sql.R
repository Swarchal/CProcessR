#' Converts directory or list of .csv files into an SQLite database
#'
#' Produces an SQLite database from either a directory or a list of .csv files
#'
#' @param x list of files or directory containing files
#' @param dir Directory to save database in, otherwise will save in the
#' 		current working directory.
#' @param db_name Name given to the database.
#' @param single_table Whether to place all .csv files in a single table,
#' 		otherwise will produce a table per file.
#' @param table_name Only useful if `single_table = TRUE`, what to call the table.
#'
#' @export


csv_to_sql <- function(x, ...){

	if (is.list(x)) csv_to_sqlite_list_(x, ...)

	if (is.character(x)) csv_to_sqlite_path_(x, ...)
}
