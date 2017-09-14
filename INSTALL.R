## Installing Packages

# Just like you have to install apps separately on your phone, to get the most out of R you need 
# to install packages based on your research interests. This can be done one of two ways in RStudio. 
# On the right hand side, click "Packages" (towards the middle) and then "Install". 
# Simply type in the name of the package. Here's how to do it with an R command:

install.packages("fivethirtyeight")

# (That package contains data featured in 538, the online magazine.)

# You may have to choose a server the first time. It doesn't matter much but I usually find something relatively local.

## RTools for Windows

# Many of the newer packages and development features in R require Windows users to have RTools. 

### Getting RTools for Windows 
# Windows users should install RTools 3.3 from  
# https://cran.r-project.org/bin/windows/Rtools/
  
  
## Installing the Data Science 101 Packages
# To be able to do all of the lab activies and work with the code found in lecture slides, 
# you need a long list of packages. 
# Fortunately you can just copy and paste the following command into the R Console.


install.packages(c('boot', 'class', 'combinat', 'crayon', 
                  'devtools', 'dplyr', 'foreach', 'ggplot2', 'graphics', 
                  'Hmisc', 'IRdisplay', 'ISLR', 'iterpc', 'kernlab', 'knitr', 
                  'lubridate', 'magrittr', 'maps', 'MASS', 'mvtnorm', 
                  'nutshell', 'nycflights13', 'pbdZMQ', 'RColorBrewer', 
                  'readr', 'repr', 'reshape2', 'rmarkdown', 'rpart.plot', 
                  'rvest', 'scatterplot3d', 'selectiveInference', 'tibble', 
                  'tidyr', 'tm', 'UsingR', 'vcd', 'wordcloud', 'xml2'))


## Installing from GitHub

# Packages under development are often only available on GitHub. 
# These are installed by opening the devtools (as in development tools) library. 
# Here's how to install the two we will use:


library(devtools)
install_github("hadley/neiss") # https://github.com/hadley/neiss to see the code
install_github('IRkernel/IRkernel')
