# functions to run scripts

#' Source an R script, storing rendered output as md or html in a log subfolder
#' 
#' Uses \code{\link[rmarkdown]{render}} to create a log of the sourced script:
#' \itemize{
#'   \item Use run() with .R files to format the log output in a way that works 
#'   well for github (markdown)
#'   \item Use run_html() with .R files for a log output formatted as html, which
#'   works better for viewing within Rstudio
#'   \item Use run_rmd() for .Rmd files to markdown
#'   \item Use run_rmd_html() for .Rmd files to html
#' }
#' 
#' @param script_path file path of R script to be executed
#' @inheritParams rmarkdown::render
#' @family functions to run scripts
#' @export
#' @examples 
#' # workflow::run("path/to/script.R")
#' # workflow::run_html("path/to/script.R")
#' # workflow::run_rmd("path/to/script.Rmd")
#' # workflow::run_rmd_html("path/to/script.Rmd")
run <- function(script_path, knit_root_dir = getwd()) {
    # source script & render to markdown
    rmarkdown::render(
        output_format = "github_document",
        input = script_path,
        knit_root_dir = knit_root_dir
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
run_html <- function(script_path, knit_root_dir = getwd()) {
    rmarkdown::render(
        input = script_path,
        output_dir = file.path(dirname(script_path), "log"),
        knit_root_dir = knit_root_dir
    )
}

#' @rdname run
#' @export
run_rmd <- function(script_path, knit_root_dir = NULL) {
    run(script_path, knit_root_dir = knit_root_dir)
}

#' @rdname run
#' @export
run_rmd_html <- function(script_path, knit_root_dir = NULL) {
    run_html(script_path, knit_root_dir = knit_root_dir)
}
