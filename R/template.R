# functions to create templates

#' Initiliaze a project workflow
#' 
#' This populates the project with template folders and files.
#' 
#' @param dir Folder to place template files. Defaults to working directory.
#' @param overwrite If TRUE, will overwrite existing files. Use with caution.
#' @export
#' @examples 
#' \dontrun{
#' init("tmp")
#' init("tmp", overwrite = TRUE)
#' }
init <- function(dir = getwd(), overwrite = FALSE) {
    template_files <- list.files(
        system.file("template-init", package = "workflow"), full.names = TRUE
    )
    files_to_create <- file.path(dir, basename(template_files))
    if (any(file.exists(files_to_create)) && !overwrite) {
        stop("The init function won't overwrite existing files unless overwrite = TRUE",
             call. = FALSE)
    }
    if (!file.exists(dir) && dir != "") {
        dir.create(dir)
    }
    for (i in template_files) {
        file.copy(i, dir, overwrite = overwrite, recursive = TRUE)
    }
    message(paste0("Template files/folders have been added to:\n- ", dir))
    writeLines(readLines(system.file("template-files.txt", package = "workflow")))
}
