
# workflow

A Southwick-only R package to streamline workflow development.

## Installation

From the R console:

```r
install.packages("remotes")
remotes::install_github("southwick-associates/workflow")
```

## Usage

See the vignettes:

- [Setting up a workflow](github-vignettes/setup-project.md)
- [Writing multiple results to one Excel workbook](github-vignettes/write-excel.md)

## Development

See the [R packages book](http://r-pkgs.had.co.nz/) for a guide to package development. The software environment was specified using [package renv](https://rstudio.github.io/renv/index.html). Use `renv::restore()` to build the project library.
