# library(pacman)                            
# p_load(knitr, foreign, scales, questionr, tidyverse)

# survey <- read.spss("Jan16/Jan16 public.sav", to.data.frame = TRUE)


sumOne <- function(x, ...) x/sum(x, ...)

tabs <- function(dataframe, x, y = NULL, style = "percent",
                 weight = NULL, normwt = FALSE, na.rm = TRUE, 
                 na.show = FALSE){
  
  if(!(style %in% c("percent", "proportion", "counts"))){
    stop("style must either be \"percent\", \"proportion\", or \"counts\". For example:\n\ntabs(survey, \"q1\", \"q2\", style = \"percent\")))")
  }
  
  not_found <- function(var, df){ 
    if(!is.null(var)){
      !(var %in% names(df))
    }
  }  
  
  missing <- (not_found(x, dataframe) || not_found(y, dataframe)) | not_found(weight, dataframe)
  
  if(missing){
    stop(paste("\nx, y, or weight not found in the data.frame you provided.\nPlease call tabs again with syntax like:\n\n",
               "tabs(survey, x = \"q1\")\n",
               "tabs(survey, x = \"q1\", y = c(\"age\", \"sex\"), \"cellweights\")\n"))
  }
  
  xtabs <- wtd.table(dataframe[[x]], y = NULL, weights = dataframe[[weight]], 
                     normwt = normwt, na.rm = na.rm, na.show = na.show)
  
  
  
  if(style %in% c("percent", "proportion")){
    xtabs <- sumOne(xtabs)
  }

  if(!is.null(y)){
    
    out <- lapply(y, 
                  function(x, y, w, normwt = FALSE, na.rm = TRUE, 
                           na.show = FALSE) 
                    wtd.table(dataframe[[y]], dataframe[[x]], dataframe[[w]], 
                              normwt = normwt, na.rm = na.rm, na.show = na.show), 
                  x, weight, normwt, na.rm, na.show)
    
    for(i in 1:length(out)){
      xtabs <- cbind(xtabs, 
                     if(style %in% c("percent", "proportion")) sumOne(out[[i]]) else out[[i]])
    } 
    colnames(xtabs) <- "Overall"
  }
  
  return(if(style == "percent") apply(xtabs, c(1, 2), percent) else xtabs)
}


# wtd.table(survey$ideo, survey$sex, survey$weight)
# tabs(survey, "q1", c("sex", "race3m1"), weight = "cellweight")
