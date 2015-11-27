#' Converts directory of .csv files to an SQLite database
#'
#' Called by `csv_to_sql`, can also be used directly. IFf given a
#' filepath, will generate an SQLite database containing either all the 
#' files in a single table, or a table for each file.
#'
#' @param path Filepath to directory containing .csv files
#' @param dir Directory to save database in, otherwise will save in the
#' 		filepath given in the `path` argument.
#' @param db_name Name given to the database.
#' @param single_table Whether to place all .csv files in a single table,
#' 		otherwise will produce a table per file.
#' @param table_name Only relevant if `single_table = TRUE`: what to call the table.
#' 
#' @import RSQLite
#'
#' @export

csv_to_sqlite_path_ <- function(path, dir = NULL, db_name = "db", single_table = FALSE, table_name = "exp"){
    
    # if not given a path for `dir` will set
    # the working directory to the path given
    save_wd <- getwd() # record current wd before function call
    if (is.null(dir)){
        setwd(path)
        warning(paste("Directory not given, saving database to:", path))
    } else setwd(dir)
    
    # check `path` is at least characters
    if (!is.character(path)){
        stop("Argument 'path' has to be a filepath", call. = FALSE)
    }
    
    # create connection to an SQLite database with the name `db_name`
    message(" - Creating database:", db_name)
    con <- dbConnect(SQLite(), paste0(db_name, ".sqlite3"))
    if(!dbIsValid(con)) stop("Failed to create database")
    
    # warn that table_name has no effect when creating multiple tables
    if (!single_table & table_name != "exp"){
        warning("Single table is set to FALSE,\ntables will be named after the original filenames",
                call. = FALSE)
    }
    
    for (file in list.files(path, pattern = ".csv")){
        message(paste(" - Reading file:", file))
        tmp <- read.csv(file)
        
        if (single_table == FALSE){
            message(paste(" - Writing", file, "to database"))
            dbWriteTable(
                con,
                value = tmp,
                name = strsplit(file, "\\.")[[1]][1])
            
        } else if (single_table == TRUE){
            message(paste(" - Writing", file, "to database"))
            dbWriteTable(
                con,
                value = tmp,
                name = table_name,
                append = TRUE)
            
        } else stop("single_table requires either TRUE or FALSE")
    }
    
    message(paste(" - Disconnecting from", db_name))
    dbDisconnect(con) # disconnect from database
    if (!dbIsValid(con)) message(" - Disconnected!")
    setwd(save_wd) # restore previous wd
}