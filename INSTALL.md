# datascience101

This is an installation guide for the computational software used by Stats / Data Science 101. All of the software is free but does require a bit of patience to get all the way through. Please don't hesitate to contact one of your instructors with any issues.

## Why R?

In this course we use `R` for our computations. `R` is a one stop shop for data science. 

 - Open Source == free
 - Over 11,000 libraries == customizable research
 - Best in Class Data Visualization (`ggplot2`, `animation`)
 - Analyze many, many kinds of of numeric, textual, and visual data (`.csv`,`.xml`,`.pdf`, `.png`, `.gif`, `.sas`, `.dta`, `.json`, etc.)
 - Extensions to other languages (`C`, `C++`, `Python`, `Java`, etc.)
 - Parallel processing for speed (with library(`parallel`) or `OMP`)
 - Distributed processing for big data (`Hadoop`, `Sparklyr`, etc.)

### Getting R

Install [R 3.4.1 "Single Candle"](https://cran.cnr.berkeley.edu/) for your operating system (Mac, Windows, Linux...).

If you're operating system isn't new enough for the newest version of `R`, you should (at some point) consider upgrading your OS. However, the majority of the course material should work on a slightly older version like `3.3`, so you can use the link above to find the newest possible version for now. Talk an instructor about any problems you encounter.

## RTools for Windows

Many of the more advanced, newer packages and development features in R require Windows users to have RTools. Windows users should install [RTools 3.3](https://cran.r-project.org/bin/windows/Rtools/). 

There's no "RTools for Mac" but talk to your instructor if your Mac doesn't seem to be configured properly to install all of the packages. To learn more about best configuration practices for both Mac and Windows, we recommend http://thecoatlessprofessor.com/.


## Why RStudio?

`Rstudio` is an IDE (Integrated Development Environment). It helps with any number of things from keeping track of variables you've created and even helps you put your results into PDFs documents or slides.

- Automatically flag code errors
- Manage packages, files, graphs
- Make documents like reports or slides (with `RMarkdown` or the more interactice `RNotebook`)
- Make your own `R` packages (and sync them with `GitHub`)

### Getting RStudio

Install [RStudio 1.0.153](https://www.rstudio.com/products/rstudio/download/). (Scroll down and download the free version with the Open Source License for your operating system.)

## Getting the rest of Data Science 101 pre-reqs

Just like you have to install apps separately on your phone, to get the most out of R you need to install packages based on your research interests. Open `RStudio`. On the left, you will see the `R` console. Copy and paste the line below into the console and hit enter.

```
source('rdrr1990/datascience101/INSTALL.R')
```

Click [here] to see the source code and a brief explanation of how that works.


## Using LaTeX for Equations

In many STEM fields, [LaTeX](https://www.latex-project.org/) is the preferred method of writing equations. You can easily embed LaTeX in your RNotebooks. Installing LaTeX is also good for knitting PDFs. However, it is also a fairly large program to install (and the full version is necessary). If you don't have space for it and need to create a `PDF`, you can always knit your `RNotbeook` into a `Word .docx` and create a `PDF` from there. 

### Getting Latex

Mac users should install [Mactex](http://www.tug.org/mactex/mactex-download.html)

Windows users should install [Miktex](https://miktex.org/howto/install-miktex)

## A Few Resources...

- For basic R syntax, complete these [short e-tutorials](http://tryr.codeschool.com/).

- [Cheat Sheets on RStudio and RMarkdown](https://www.rstudio.com/resources/cheatsheets/)

- [Useful Math symbols in LaTex](https://www.sharelatex.com/learn/List_of_Greek_letters_and_math_symbols)

## All Done!

