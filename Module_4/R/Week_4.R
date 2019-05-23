# R Studio API Code
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))       #Set working director to where this document is

# Data import
library(tidyverse)
raw_df <- read_delim("../data/week4.dat" , delim="-", col_names = c("casenum","parnum","stimver","datadate","qs"))
glimpse(raw_df)
raw_df <- separate(raw_df,qs,paste0("q",1:5),sep=" - ")   #   paste0 as Automatic alternative to   c("q1","q2","q3","q4","q5")
raw_df[5:9] <- sapply(raw_df[5:9], as.numeric)
raw_df[, 5:9][raw_df[, 5:9] == 0] <- NA




library(lubridate)
raw_df$datadate <- mdy_hms(raw_df$datadate)

# Data Analysis
q2_over_time_df <- spread(raw_df[,c("parnum","stimver","q2")],stimver,q2)
sum(complete.cases(q2_over_time_df)) / nrow(q2_over_time_df)
