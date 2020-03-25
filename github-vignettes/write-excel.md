
<!-- write-excel.md is generated from write-excel.Rmd. Please edit that file -->

## Overview

The workflow package includes convenience functions for writing to
Excel. This can be helpful for packaging multiple results (e.g.,
spending profiles) into a single file for easily sharing with
colleagues. It uses [package
openxlsx](https://ycphs.github.io/openxlsx/index.html).

### Initializing a Workbook

The first step is to create an Excel workbook using
`xlsx_initialize_workbook()`. This makes an Excel file with a single
“README” tab. I recommend always including a README for documentation
(to be edited manually in Excel).

``` r
library(workflow)

xlsx_initialize_workbook("tmp.xlsx")
openxlsx::getSheetNames("tmp.xlsx")
#> [1] "README"
```

### Adding Results

R data frames can be written directly to an Excel file with
`xlsx_write_table()`:

``` r
# create some data
poem <- data.frame(verse = "All that is gold does not glitter", stringsAsFactors = FALSE)

xlsx_write_table(poem, "tmp.xlsx")
openxlsx::getSheetNames("tmp.xlsx")
#> [1] "README" "poem"
```

### Updating Results

Additional calls to `xlsx_write_table()` will simply overwrite tabs with
the same name, so you can easily update results. This does imply that
you shouldn’t manually edit the Excel file (other than the README tab).

``` r
# modify data of interest
poem[2, ] <- "Not all those who wander are lost"

xlsx_write_table(poem, "tmp.xlsx")
openxlsx::readWorkbook("tmp.xlsx", "poem")
#>                               verse
#> 1 All that is gold does not glitter
#> 2 Not all those who wander are lost
```
