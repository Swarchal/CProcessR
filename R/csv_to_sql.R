csv_to_sql <- function(x, db_name = "db", single_table = FALSE, table_name = "exp"){

	if (is.list(x)) csv_to_sqlite_list_(x,
		db_name,
		single_table,
		table_name)

	if (is.character(x)) csv_to_sqlite_path_(x,
		db_name
		single_table,
		table_name)
}