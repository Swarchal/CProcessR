csv_to_sqlite_path_ <- function(path, dir = NULL, db_name = "db", single_table = FALSE, table_name = "exp"){

	# if not given a path for `dir` will set
	# the working directory to the path given
	if (is.null(dir)){
	setwd(path)
	warning("Working directory not given, setting directory to that given in'path'")
	} else setwd(dir)

	# check `path` is at least characters
	if (!is.character(path)){
		stop("Argument 'path' has to be a filepath", call. = FALSE)
	}

	# create connection to an SQLite database with the name `db_name`
	con <- RSQLite::dbConnect(SQLite(), paste0(db_name, ".sqlite3")

	# warn that table_name has no effect when creating multiple tables
	if (!single_table & table_name != "exp"){
		warning("Single table is set to FALSE,\ntables will be named after the original filenames",
			call. = FALSE)
	}

	for (file in list.files(path, pattern = ".csv")){
		tmp <- read.csv(file)

		if (single_table == FALSE){
			RSQLite::dbWriteTable(
				con,
				value = tmp,
				name = strsplit(file, "\\.")[[1]][1])

		} else if (single_table == TRUE){
			RSQLite::dbWriteTable(
				con,
				value = tmp,
				name = table_name,
				append = TRUE)

		} else stop("single_table requires either TRUE or FALSE")
	}
}