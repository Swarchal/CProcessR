csv_to_sqlite_list_ <- function(files, db_name = "db", single_table = FALSE, table_name = "exp"){

	if (!is.list(files)){
		stop("Argument 'files' has to be a list.", call. = FALSE)
	}

	# create connection to an SQLite database with the name `db_name`
	con <- RSQLite::dbConnect(SQLite(), paste0(db_name, ".sqlite3")

	# warn that table_name has no effect when creating multiple tables
	if (!single_table & table_name != "exp"){
		warning("Single table is set to FALSE,\ntables will be named after the original filenames",
			call. = FALSE)
	}

	for (file in files){
		tmp <- read.csv(file)

		if (single_table == FALSE){
			RSQLite::dbWriteTable(
				con,
				value = tmp,
				name = strsplit(filen,"\\.")[[1]][1])

		} else if (single_table == TRUE){
			RSQLite::dbWriteTable(
				con,
				value = tmp,
				name = table_name,
				append = TRUE)

		} else stop("single_table requires either TRUE or FALSE")
	}
}