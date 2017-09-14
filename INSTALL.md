# datascience101

This is an installation guide for the computational software used by Stats / Data Science 101. All of the software is free but does require a bit of patience to get all the way through. Please don't hesitate to contact one of your instructors with any issues.

## Why R?

In this course we use `R` for our computations. `R` is a one stop shop for data science. 

 - Open Source == free
 - Over 11,000 libraries == customizable research
 - Top Flight Data Visualization
 - Support for many, many kinds of data (`.csv`,`.xml`,`.pdf`, `.sas`, `.dta`, `.json`, etc.)
 - Extensions to other languages (`C`, `C++`, `Python`, `Java`, etc.)
 - Parallel processing for speed (with library(parallel) or `OMP`)
 - Distributed processing for big data (`Hadoop`, `Sparklyr`, etc.)

### Getting R

Install [R 3.4.1 "Single Candle"](https://cran.cnr.berkeley.edu/) for your operating system (Mac, Windows, etc.).


## Why RStudio?

`Rstudio` is an IDE (Integrated Development Environment). It helps with any number of things from keeping track of variables you've created and even helps you put your results into PDFs documents or slides.

- Automatically flag code errors
- Manage packages, files, graphs
- Make documents like reports or slides (with RNotebook or RMarkdown)
- Make your own R packages (and sync them with GitHub)

### Getting RStudio

Install [RStudio 1.0.153](https://www.rstudio.com/products/rstudio/download/). (Scroll down and download the free version with the Open Source License.)

## Open RStudio

On the left, you will see the console. This is the best place for quick computations. Try a few commands like these.

```
3145 + 4136
123 * 123
123 == 123^2
pi > exp(1) # e = 2.718282
1:10
sum(1:10000)
sample(100, 5) # take five random draws from 1-100
```

## Make an R Script

In the upper left, click `File` > `New File` > `R Script`. Whenever you have more than a handful of lines of code, you will want one of these to store your work. 

- Type in the R code (like that below).
- Keep an eye out for squiggly lines or other symbols that warn if the syntax is bad. 
- When you are ready, highlight the code. 
- Click Run (just above the R script).
- File > Save.

```
area <- function(radius){
  pi*radius^2
}
area(5)
area(5:12)
```

## Installing Packages

Just like you have to install apps separately on your phone, to get the most out of R you need to install packages based on your research interests. This can be done one of two ways in RStudio. On the right hand side, click "Packages" (towards the middle) and then "Install". Simply type in the name of the package. Here's how to do it with an R command:

```
install.packages("fivethirtyeight")
```
(That package contains data featured in 538, the online magazine.)

You may have to choose a server the first time. It doesn't matter much but I usually find something relatively local.

## RTools for Windows

Many of the more advanced, newer packages and development features in R require Windows users to have RTools. (There's no "RTools for Mac" but talk to your instructor if your Mac doesn't seem to be configured properly to install all of the packages.)

### Getting RTools for Windows 
Windows users should install [RTools 3.3](https://cran.r-project.org/bin/windows/Rtools/). 


## Installing the Data Science 101 Packages

To be able to do all of the lab activies and work with the code found in lecture slides, you need a long list of packages. Fortunately you can just copy and paste the following command into the R Console.

```
install.package(c('boot', 'class', 'combinat', 'crayon', 
'devtools', 'dplyr', 'foreach', 'ggplot2', 'graphics', 
'Hmisc', 'IRdisplay', 'ISLR', 'iterpc', 'kernlab', 'knitr', 
'lubridate', 'magrittr', 'maps', 'MASS', 'mvtnorm', 
'nutshell', 'nycflights13', 'pbdZMQ', 'RColorBrewer', 
'readr', 'repr', 'reshape2', 'rmarkdown', 'rpart.plot', 
'rvest', 'scatterplot3d', 'selectiveInference', 'tibble', 
'tidyr', 'tm', 'UsingR', 'vcd', 'wordcloud', 'xml2'))
```

## Installing from GitHub

Packages under development are often only available on GitHub. These are installed by opening the devtools (as in development tools) library. Here's how to install the two we will use:

```
library(devtools)
install_github("hadley/neiss") # https://github.com/hadley/neiss to see the code
install_github('IRkernel/IRkernel')
```

## Making RMarkdown Documents

RMarkdown lets you knit together output from R (numbers, graphs, etc.) with text, links, and images. You can create documents and slides. Documents may be PDF, Word, or HTML. This makes RMarkdown an excellent choice for scientific replicability (it's best to create your assignments directly from RStudio to establish a clear chain of evidence). 

- To get started, click File > New File > R Markdown. (If RStudio asks to install anything else at this point, say yes.) 

This will open a template with instructions on how to switch between R code and text. To see how this works, paste the following code just after it says `summary(cars)`.

```
area <- function(radius){
  pi*radius^2
}
area(5)
area(5:12)
```

- Click "knit" just above the RMarkdown script. (Specify a file name when prompted and if RStudio asks to install anything else at this point, say yes.) 

## Using LaTeX to make Equations

$\pi$ = `r pi`

In many STEM fields, $\LaTeX$ (Latex) is the preferred method of writing equations. You can easily switch into LaTeX from an RMarkdown with dollar signs like so: 

`$\pi$` 



### Getting Latex

Installing Latex is also good for knitting PDFs. However, it is also a fairly large program to install (and the full version is necessary). If you don't have space for it and need to create a PDF, you can knit to Word .docx and create a PDF from there. 

Mac users should install "Mactex": http://www.tug.org/mactex/mactex-download.html

Windows users should install "Miktex": https://miktex.org/howto/install-miktex

## A Few Resources...

- For basic R syntax, complete these [http://tryr.codeschool.com/](short e-tutorials).

- [Cheat Sheets on RStudio and RMarkdown](https://www.rstudio.com/resources/cheatsheets/)

- [Useful Math symbols in LaTex](https://www.sharelatex.com/learn/List_of_Greek_letters_and_math_symbols)


