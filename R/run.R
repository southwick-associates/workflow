# functions to run scripts

#' Source an R script, storing rendered output as .md in a log subfolder
#' 
#' Uses \code{\link[rmarkdown]{render}} to create a log of the sourced script.
#' The markdown output is formatted in a way that works well for github. If not
#' using github, you may want to use \code{\link{run_html}} instead.
#' 
#' @param script_path file path of R script to be executed
#' @family functions to run scripts
#' @export
#' @examples 
#' # workflow::run("path/to/script.R")
run <- function(script_path) {
    # source script & render to markdown
    rmarkdown::render(
        output_format = "github_document",
        input = script_path,
        knit_root_dir = getwd()
    )
    # clean-up
    # - define file paths
    script_name <- tools::file_path_sans_ext(basename(script_path))
    indir <- dirname(script_path)
    outdir <- file.path(indir, "log")
    dir.create(outdir, showWarnings = FALSE)
    
    # - remove any html preview files
    file.remove(file.path(indir, paste0(script_name, ".html")))
    
    # - move .md files to log folder 
    file.rename(
        file.path(indir, paste0(script_name, ".md")),
        file.path(outdir, paste0(script_name, ".md"))
    )
    # - a files folder will be produced if figures are included in the md file
    # - and it needs to be moved along with the md file
    old <- file.path(indir, paste0(script_name, "_files"))
    if (file.exists(old)){
        file.copy(old, outdir, recursive = TRUE)
        unlink(old, recursive = TRUE)
    }
}

#' @rdname run
#' @export
run_html <- function(script_path) {
    rmarkdown::render(
        input = script_path,
        output_dir = file.path(dirname(script_path), "log"),
        knit_root_dir = getwd()
    )
}
