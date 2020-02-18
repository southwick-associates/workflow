# functions for writing to excel

#' Initialize an Excel Workbook with a README tab
#'
#' The README sheet is intended to serve as documentation for the results
#' stored in the Excel file.
#'
#' @param filename path where the Excel workbook will be written
#' @family functions for writing to excel
#' @export
#' @examples
#' xlsx_initialize_workbook("tmp.xlsx")
xlsx_initialize_workbook <- function(filename) {
    if (file.exists(filename)) {
        return(invisible()) # an existing file won't be overwritten
    }
    wb <- openxlsx::createWorkbook()
    openxlsx::addWorksheet(wb, "README")
    openxlsx::saveWorkbook(wb, filename)
}

#' Write a data frame to an Excel tab
#'
#' Requires an existing Excel file, preferably created using
#' \code{\link{xlsx_initialize_workbook}}. The selected tab will be removed
#' (if it already exists) and a new tab will be written.
#'
#' @param df data frame to write to the Excel worksheet
#' @param sheet name to use for Excel worksheet. If NULL (default) the name of
#' the df will be used.
#' @inheritParams xlsx_initialize_workbook
#' @family functions for writing to excel
#' @export
#' @examples
#' xlsx_initialize_workbook("tmp.xlsx")
#' moria <- data.frame(a = 1:4, b = c("speak", "friend", "and", "enter"))
#' xlsx_write_table(moria, "tmp.xlsx")
xlsx_write_table <- function(df, filename, sheet = NULL) {
    if (is.null(sheet)) {
        sheet <- deparse(substitute(df))
    }
    wb <- openxlsx::loadWorkbook(filename)
    if (sheet %in% openxlsx::getSheetNames(filename)) {
        openxlsx::removeWorksheet(wb, sheet)
    }
    openxlsx::addWorksheet(wb, sheet)
    openxlsx::writeData(wb, sheet = sheet, df)
    openxlsx::saveWorkbook(wb, filename, overwrite = TRUE)
}
