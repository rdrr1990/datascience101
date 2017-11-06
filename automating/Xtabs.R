# library(pacman)                            
# Xtabs written by Pete Mohanty
# submitted as PR to questionr November 5, 2017
# https://github.com/juba/questionr/pull/96

# p_load(knitr, foreign, scales, questionr, tidyverse)
# survey <- read.spss("Jan16/Jan16 public.sav", to.data.frame = TRUE)


sumOne <- function(x, ...) x/sum(x, ...)

Xtabs <- function(df, x, y = NULL, type = "percent",
                    weight = NULL, normwt = FALSE, na.rm = TRUE, 
                    na.show = FALSE, digits = 3, exclude = NULL){
  
  sumOne <- function(x, ...) x/sum(x, ...)
  if(!(type %in% c("percent", "proportion", "counts"))){
    stop("type must either be \"percent\", \"proportion\", or \"counts\". For example:\n\nXtabs(survey, x = \"q1\", y = \"q2\", type = \"percent\")))")
  }
  
  stopifnot(is.data.frame(df))
  
  missing <- match(x, names(df), nomatch = 0L) == 0L
  if(!is.null(y)){
    missing <- missing | (min(match(y, names(df), nomatch = 0L)) == 0)
  }
  if(!is.null(weight)){
    missing <- missing | (min(match(weight, names(df), nomatch = 0L)) == 0)
  }
  
  if(missing){
    stop(paste("x, y, or weight not found in the data.frame you provided.\nPlease call tabs again with syntax like:\n\n",
               "Xtabs(survey, x = \"q1\")\n",
               "Xtabs(survey, x = \"q1\", y = c(\"age\", \"sex\"), weight = \"cellweights\")\n"))
  }
  
  w <- if(is.null(weight)) NULL else df[[weight]]
  
  tabs <- wtd.table(df[[x]], y = NULL, weights = w, digits = digits,
                    normwt = normwt, na.rm = na.rm, na.show = na.show, exclude = exclude)
  
  if(type %in% c("percent", "proportion")){
    tabs <- sumOne(tabs)
  }
  
  if(!is.null(y)){
    
    out <- lapply(y, 
                  function(x, y, w, normwt = FALSE, na.rm = TRUE, 
                           na.show = FALSE, digits = 3, exclude = NULL){
                    
                    wtd.table(df[[y]], df[[x]], 
                              weights = w, normwt = normwt, na.rm = na.rm, 
                              na.show = na.show, digits = digits, exclude = exclude)
                  } 
                  , 
                  x, w, normwt, na.rm, na.show, digits, exclude)
    
    for(i in 1:length(out)){
      tabs <- cbind(tabs, 
                    if(type %in% c("percent", "proportion")) sumOne(out[[i]]) else out[[i]])
    } 
    colnames(tabs)[1] <- "Overall"
    
    if(type == "percent" | type == "proportion") 
      for(i in 1:nrow(tabs))
        for(j in 1:ncol(tabs))
          tabs[i, j] <- paste0(format(100^(type == "percent")*as.numeric(tabs[i ,j]), digits = 3), 
                               if(type == "percent") "%" else NULL)
    
  }else{
    for(i in 1:length(tabs))
      tabs[i] <- paste0(format(100^(type == "percent")*as.numeric(tabs[i]), digits = 3), 
                        if(type == "percent") "%" else NULL)
  }
  
  return(tabs)   
  
}


# wtd.table(survey$ideo, survey$sex, survey$weight)
# Xtabs(survey, "q1", c("sex", "race3m1"), weight = "cellweight")
