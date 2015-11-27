#' Merge object data
#' 
#' Function to merge together multiple objects from a pipeline into a single
#' table and prefix the column names with the object label.
#' 
#' @param db database connection
#' @param sep seperator between pipeline and object
#' 
#' @import RSQLite
#' @import stringr
#' 
#' @export


sql_merge_objects <- function(db, sep = "_"){
    
    # check if `db` is a valid database connection,
    # otherwise initialise a connection to `db`
    if (is.character(db)){
        message(paste(" - Connecting to database", db))
        db <- dbConnect(SQLite(), db)
        if (dbIsValid(db)) message(" - Connected!")
    }
    
    if (!dbIsValid(db)) stop("Failed to connect to database")
    
    # all tables contained within db
    list_of_tables <- dbListTables(db)
    
    # get tables labelled as _Image
    image_tables <- str_subset(list_of_tables, "Image")
    
    # unique pipelines contained within the database
    pipelines <- unique(str_replace(list_of_tables, "Image", ""))
    
    # detect object tables, then remove Image from the objects
    unwanted <- c("Image", "Experiment") # might need to add more, check CP output for detritus
    objects_with_unwanted <- unique(str_replace_all(image_tables, pipelines, ""))
    objects <- str_replace_all(objects_with_unwanted, unwanted, "")
    
    if (length(objects) < 1) stop("No valid object tables detected")
    
#     # load tables containing objects for a given pipeline
#      for (pipeline in pipelines){
#         wanted_tables <- str_match(pipeline, list_of_tables)
#         print(wanted_tables)
# #         load wanted tables
# #         remove unwanted objects from wanted tables
# #         prefix featuredata column names with object name
# #         merge wanted tables by ImageNumber
# #         remove duplicated metadata columns
# #         name merged table after pipeline
# #         remove wanted tables
#      }
    # pre-fix columns with object name
    # merge columns for each pipeline
    # remove duplicate columns
    
    dbDisconnect(db)
}