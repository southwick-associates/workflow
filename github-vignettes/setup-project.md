
<!-- setup-project.md is generated from setup-project.Rmd. Please edit that file -->

## Overview

The workflow package is intended to add some consistency/efficiency for
R-based analysis projects. I’ve provided guidelines below for
structuring Southwick projects, but these aren’t hard-and-fast rules. My
thinking on this workflow was heavily influenced by a Python-based
approach: [Cookiecutter Data
Science](https://drivendata.github.io/cookiecutter-data-science/).

I follow 3 steps for new projects:

1.  [Create a project with Rstudio](#create-project)
2.  [Initialize with package workflow](#initialize-workflow)
3.  [Isolate from other projects with package
    renv](#define-your-software-environment)

## 1\. Create Project

I recommend creating an [RStudio
Project](https://r4ds.had.co.nz/workflow-projects.html) as a first step
(in RStudio: File \> New Project):

![](img/my-project.png)

I also suggest checking “Create a git repository” in case you want to
use version control (and it will also set you up for placing the project
on Github). If you’re new to Git, there is a [nice intro
chapter](http://r-pkgs.had.co.nz/git.html) in Hadley Wickham’s R
packages book.

## 2\. Initialize Workflow

Next, you’ll use `workflow::init()` to populate the project with
template files/folders:

![](img/init.png)

### README.md

This file is the documentation for your project, and it will
conveniently display on the Github landing page (if you make a Github
repo):

![](img/readme.png)

### data/README.md

It’s also helpful to include documentation about the input data you use.
I like organizing data into 4 subfolders:

![](img/cookie.png)

### code/run.R

A master script is a nice way to organize your code. I recommend using
regular `.R` files for production code and ordering them sequentially
(e.g., `01-load-raw.R`, `02-clean.R`, etc.).

![](img/run.png)

### code/log/example.md

Using `workflow::run("code/example.R")` sources the R script and
produces a log summary that displays nicely on Github:

![](img/example.png)

### Rmd Templates

I consider `.Rmd` files better-suited to summary reports. Note that this
package includes a couple of templates which you can access in Rstudio
using File \> New File \> R Markdown:

![](img/rmd-template.png)

## 3\. Define your Software Environment

I recommend using [package
renv](https://rstudio.github.io/renv/index.html) to isolate your project
package libraries and help ensure the code can be run on another
machine. The basic workflow:

1.  `renv::init()` to initialize the project library
2.  `renv::snapshot()` after you install new packages

This adds a few more files which renv will use (and you shouldn’t edit
by hand). Your project will now look something like this:

![](img/renv.png)

My experience is that renv takes a few minutes to setup the first time
you use it, but then goes quickly in the future (since it caches
packages on your machine). The `renv.lock` file defines the project’s
package versions, which can be installed on another machine with
`renv::restore()`.
