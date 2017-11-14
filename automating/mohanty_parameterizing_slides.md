From Data to Document: A Practical Guide to Parameterizing Reports
================
Bay Area R Users Group, November 2017

Tonight's Code via RViews: [http://bit.ly/2AE6En3](https://rviews.rstudio.com/2017/11/07/automating-summary-of-surveys-with-rmarkdown/?utm_content=buffer00098&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer)
============================================================================================================================================================================================================================

<img src="images/mohanty_rviews.png" width="800" />

Motivation
==========

> -   *Efficiency*: maximize the reusabililty of code, minimize copying and pasting errors
> -   *Reproducibility*: maximize the number of people + computers that can reproduce findings

> -   <img src="https://imgs.xkcd.com/comics/automation.png" alt="XKCD" height="400" />
>     XKCD 1319

the Recipe
==========

> -   <img src="https://ih0.redbubble.net/image.329882875.2295/st%2Csmall%2C420x460-pad%2C420x460%2Cf8f8f8.lite-1u1.jpg" height="400" />
>     Create a template
> -   <img src="http://hexb.in/hexagons/knitr.png" height="400" />
>     Write a loop

Software--seriously, keep up-to-date
====================================

``` r
install.packages("pacman")
p_load(rmarkdown, knitr, questionr, tidyverse, sessioninfo, update = TRUE)
```

Make sure **RStudio** is new enough to get previews

<img src="images/preview.png" height="300" />

the Data
========

My guide works with four Pew Research Political Surveys: January, March, August, and October 2016. Data are free and easy to download (but account is required).

<img src="images/pewlogo.png" width="1000" />

Configuring the RMarkdown Template
==================================

<img src="images/config.png" height="500" />

Building the Template
=====================

### The Template

I find it easiest to write a fully working example and then make little changes as needed so that `knitr::render()` can loop over the data sets. First things first.

``` r
survey <- read.spss("Jan16/Jan16 public.sav", to.data.frame = TRUE)
```

Summary stats can easily be inserted into the text like so.

![](images/intext.png)

Making Tables with Kable
========================

``` r
kable(wtd.table(survey$ideo, survey$sex, survey$weight)/nrow(survey), digits = 2)
```

|                   |  Male|  Female|
|-------------------|-----:|-------:|
| Very conservative |  0.04|    0.03|
| Conservative      |  0.14|    0.13|
| Moderate          |  0.20|    0.20|
| Liberal           |  0.08|    0.09|
| Very liberal      |  0.03|    0.03|
| DK\*              |  0.02|    0.03|

Using Kable in a Loop
=====================

``` r
x <- names(survey)[grep("q2[[:digit:]]", names(survey))]
x
```

     [1] "q20"  "q21"  "q22a" "q22b" "q22c" "q22d" "q22e" "q22f" "q22g" "q22h"
    [11] "q22i" "q25"  "q26"  "q27"  "q28" 

``` r
y <- c("ideo", "party")
```

``` r
for (i in x) {
    for (j in y) {
        cat("\nWeighted counts for", i, "broken down by", j, "\n")
        print(kable(wtd.table(survey[[i]], survey[[j]], survey$weight)))  # requires asis=TRUE
        cat("\n")  # break out of table formatting
    }
    cat("\\newpage")
}
```

Adding a plot
=============

``` r
PA <- ggplot(survey) + geom_bar(aes(q1, y = (..count..)/sum(..count..), weight = weight, 
    fill = q1)) + facet_grid(party.clean ~ .)
PA <- PA + theme_minimal() + theme(strip.text.y = element_text(angle = 45)) + 
    xlab("") + ylab("Percent of Country") + scale_y_continuous(labels = scales::percent) + 
    ggtitle("Presidential Approval: January 2016")
PA
```

![](images/ggPresApproval-1.png)

Adapting the Template with Parameters
=====================================

The next step is to add a [parameter](http://rmarkdown.rstudio.com/developer_parameterized_reports.html) with any variables you need. The parameters will be controlled by the `R` script discussed in a moment.

    params:
      spssfile: !r  1
      surveywave: !r 2016

<img src="images/newheader.png" height="300" />

Parameterizing (cont'd)
=======================

``` r
PA <- PA + ggtitle(paste("Presidential Approval:", params$surveywave))
```

``` r
dir(pattern = ".sav", recursive = TRUE)
```

    [1] "http___www.people-press.org_files_datasets_Aug16/Aug16 public.sav"
    [2] "Jan16/Jan16 public.sav"                                           
    [3] "March16/March16 public.sav"                                       
    [4] "Oct16/Oct16 public.sav"                                           

<img src="images/newreadingdata.png" height="200" />

Automating with knitr
=====================

``` r
library(pacman)
p_load(knitr, rmarkdown, sessioninfo)

setwd("/users/mohanty/Desktop/pewpolitical/")

waves <- c("August 2016", "January 2016", "March 2016", "October 2016")  # for ggtitle, etc.

for (i in 1:length(waves)) {
    render("pewpoliticaltemplate.Rmd", params = list(spssfile = i, surveywave = waves[i]), 
        output_file = paste0("Survey Analysis ", waves[i], ".pdf"))
}

session <- session_info()
save(session, file = paste0("session", format(Sys.time(), "%m%d%Y"), ".Rdata"))
```

A Little Version Control
========================

If a package stops working `install_version` (from `library(devtools)`) installs older versions.

``` r
s <- session_info()
cat("This doc was knit with", s$platform$version, "on", s$platform$os, "using the following packages:")
```

    This doc was knit with R version 3.4.2 (2017-09-28) on macOS Sierra 10.12.6 using the following packages:

``` r
s$packages
```

     package     * version date       source                          
     assertthat    0.2.0   2017-04-11 CRAN (R 3.4.0)                  
     backports     1.1.1   2017-09-25 CRAN (R 3.4.2)                  
     bindr         0.1     2016-11-13 CRAN (R 3.4.0)                  
     bindrcpp      0.2     2017-06-17 CRAN (R 3.4.0)                  
     broom         0.4.2   2017-02-13 CRAN (R 3.4.0)                  
     cellranger    1.1.0   2016-07-27 CRAN (R 3.4.0)                  
     clisymbols    1.2.0   2017-05-21 cran (@1.2.0)                   
     colorspace    1.3-2   2016-12-14 CRAN (R 3.4.0)                  
     digest        0.6.12  2017-01-27 CRAN (R 3.4.0)                  
     dplyr       * 0.7.4   2017-09-28 cran (@0.7.4)                   
     evaluate      0.10.1  2017-06-24 CRAN (R 3.4.1)                  
     forcats       0.2.0   2017-01-23 CRAN (R 3.4.0)                  
     foreign     * 0.8-69  2017-06-22 CRAN (R 3.4.2)                  
     formatR       1.5     2017-04-25 CRAN (R 3.4.0)                  
     ggplot2     * 2.2.1   2016-12-30 CRAN (R 3.4.0)                  
     glue          1.2.0   2017-10-29 CRAN (R 3.4.2)                  
     gtable        0.2.0   2016-02-26 CRAN (R 3.4.0)                  
     haven         1.1.0   2017-07-09 CRAN (R 3.4.1)                  
     highr         0.6     2016-05-09 CRAN (R 3.4.0)                  
     hms           0.3     2016-11-22 CRAN (R 3.4.0)                  
     htmltools     0.3.6   2017-04-28 CRAN (R 3.4.0)                  
     httpuv        1.3.5   2017-07-04 CRAN (R 3.4.1)                  
     httr          1.3.1   2017-08-20 cran (@1.3.1)                   
     jsonlite      1.5     2017-06-01 CRAN (R 3.4.0)                  
     knitr       * 1.17    2017-08-10 CRAN (R 3.4.1)                  
     labeling      0.3     2014-08-23 CRAN (R 3.4.0)                  
     lattice       0.20-35 2017-03-25 CRAN (R 3.4.2)                  
     lazyeval      0.2.1   2017-10-29 CRAN (R 3.4.2)                  
     lubridate     1.7.0   2017-10-29 CRAN (R 3.4.2)                  
     magrittr      1.5     2014-11-22 CRAN (R 3.4.0)                  
     mime          0.5     2016-07-07 CRAN (R 3.4.0)                  
     miniUI        0.1.1   2016-01-15 CRAN (R 3.4.0)                  
     mnormt        1.5-5   2016-10-15 CRAN (R 3.4.0)                  
     modelr        0.1.1   2017-07-24 CRAN (R 3.4.1)                  
     munsell       0.4.3   2016-02-13 CRAN (R 3.4.0)                  
     nlme          3.1-131 2017-02-06 CRAN (R 3.4.2)                  
     pacman      * 0.4.6   2017-05-14 CRAN (R 3.4.0)                  
     pkgconfig     2.0.1   2017-03-21 CRAN (R 3.4.0)                  
     plyr          1.8.4   2016-06-08 CRAN (R 3.4.0)                  
     psych         1.7.8   2017-09-09 CRAN (R 3.4.1)                  
     purrr       * 0.2.4   2017-10-18 CRAN (R 3.4.2)                  
     questionr   * 0.6.3   2017-11-06 local                           
     R6            2.2.2   2017-06-17 CRAN (R 3.4.0)                  
     Rcpp          0.12.13 2017-09-28 cran (@0.12.13)                 
     readr       * 1.1.1   2017-05-16 CRAN (R 3.4.0)                  
     readxl        1.0.0   2017-04-18 CRAN (R 3.4.0)                  
     reshape2      1.4.2   2016-10-22 CRAN (R 3.4.0)                  
     rlang         0.1.2   2017-08-09 CRAN (R 3.4.1)                  
     rmarkdown     1.6     2017-06-15 CRAN (R 3.4.0)                  
     rprojroot     1.2     2017-01-16 CRAN (R 3.4.0)                  
     rstudioapi    0.7     2017-09-07 cran (@0.7)                     
     rvest         0.3.2   2016-06-17 CRAN (R 3.4.0)                  
     scales        0.5.0   2017-08-24 cran (@0.5.0)                   
     sessioninfo * 1.0.0   2017-06-21 CRAN (R 3.4.1)                  
     shiny         1.0.5   2017-08-23 cran (@1.0.5)                   
     stringi       1.1.5   2017-04-07 CRAN (R 3.4.0)                  
     stringr       1.2.0   2017-02-18 CRAN (R 3.4.0)                  
     tibble      * 1.3.4   2017-08-22 cran (@1.3.4)                   
     tidyr       * 0.7.2   2017-10-16 CRAN (R 3.4.2)                  
     tidyverse   * 1.1.1   2017-01-27 CRAN (R 3.4.0)                  
     withr         2.0.0   2017-10-25 Github (jimhester/withr@a43df66)
     xml2          1.1.1   2017-01-24 CRAN (R 3.4.0)                  
     xtable        1.8-2   2016-02-05 CRAN (R 3.4.0)                  
     yaml          2.1.14  2016-11-12 CRAN (R 3.4.0)                  

Thanks!
=======

<img src="images/kickin.png" height="450" />
