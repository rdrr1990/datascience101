library(pacman)
p_load(knitr, rmarkdown) 

setwd("/users/mohanty/Desktop/pewpolitical/")

waves <- c("August 2016", "January 2016", "March 2016", "October 2016")

for(i in 1:length(waves)){
  render("pewpoliticaltemplate.Rmd", 
         params = list(spssfile = i,
                       surveywave = waves[i]),
         output_file = paste0("Survey Analysis ", waves[i], ".pdf"))
}

session <- session_info()
save(session, file = "session.Rdata")

