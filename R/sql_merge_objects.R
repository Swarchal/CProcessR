#' Get metadata columns
#'
#' Returns metadata columns from dataframe, by grep'ing columns beginning
#' with 'Metadata_'
#'
#' @param table dataframe or table within database
#' @param value If \code{TRUE} will return the column names, if \code{FALSE}
#'    will return the indicies
#'
#' @export

metadata_cols <- function(table, value = TRUE){
    grep("Metadata_", colnames(table), value)
}




#' Get featuredata columns
#'
#' Returns the feature data columns from a dataframe, feature data is classed
#'  as anything that is not metadata
#'
#' @param table dataframe of table within database
#' @param value If \code{TRUE} will return the column names, if \code{FALSE}
#'   will return the indicies
#'
#' @export

featuredata_cols <- function(table, value = TRUE){
    setdiff(colnames(table), grep("Metadata_", colnames(x)))
}





#' Merge object data
#'
#' Function to merge together multiple objects from a pipeline into a single
#' table and prefix the column names with the object label.
#'
#' @param db database connection
#' @param metrics helper filepath to file detailing pipelines and objects
#' @param sep separator to separate pipeline and object in the filename
#'      only used if a metric file is not supplied
#'
#' @import DBI
#' @import RSQLite
#' @import stringr
#'
#' @export


sql_merge_objects <- function(db, metrics = NULL, sep = "_"){

    # check if `db` is a valid database connection,
    # otherwise initialise a connection to `db`
    if (is.character(db)){
        message(paste(" - Connecting to database", db))
        con <- dbConnect(SQLite(), db)
        if (dbIsValid(con)) message(" - Connected!")
    }

    if (!dbIsValid(con)) stop("Failed to connect to database")

    # all tables contained within db
    list_of_tables <- dbListTables(con)

    # get tables labelled as _Image
    image_tables <- str_subset(list_of_tables, "Image")

    if (is.null(metrics)){
        message(" - No metric file supplied: Attempting to separate pipeline and objects")
        split_list <- str_split(list_of_tables, sep)
        pipelines <- unique(sapply(split_list, function(x) x[1])) # first subelement
        objects <- unique(sapply(split_list, function(x) x[2])) # second subelement

    } else if (!isnull(metrics)){
        message(" - Reading pipeline and object info from ", metrics)
        metrics <- read.csv(metrics)
        pipelines <- unique(metrics$pipelines)
        objects <- unique(metrics$objects)
    }

    #TODO identify featuredata and metadata
    #TODO prefix featuredata with object name
    #TODO merge together tables from the same pipeline by ImageNumber
    #TODO remove duplicate metadata columns
    #TODO give new name to merged tables

    # disconnect from the database
    message(" - Disconnecting from ", db)
    dbDisconnect(con)
    if (!dbIsValid(con)) message (" - Disconnected!")
}
