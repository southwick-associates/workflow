# run analysis

# example production script (saving md log file)
workflow::run("code/example.R")

# example production script (saving html log file)
workflow::run_html("code/example.R")

# example Rmd (i.e., summary script)
workflow::run_rmd("code/example.Rmd")
