# data import and cleaning
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))       #Set working director to where this document is

raw_df <- read.csv("../data/week3.csv")
raw_df$timeStart <- as.POSIXct(raw_df$timeStart)
raw_df$timeEnd <- as.POSIXct(raw_df$timeEnd)
clean_df <- raw_df[raw_df$timeStart >= as.POSIXct("2017-07-01"),]        #TRIED clean_df <- raw_df$timeStart[grep("2017-06-", raw_df$timeStart)]
clean_df <- clean_df[clean_df$q6 == "1",]

# Analysis
clean_df$timeSpent <-  difftime(clean_df$timeEnd,clean_df$timeStart, units="secs")        # ALTERNATIVELY: clean_df$timeSpent <- (unclass(clean_df$timeEnd)) - (unclass(clean_df$timeStart))
hist(as.numeric(clean_df$timeSpent))
frequency_tables_list <- lapply (clean_df[,5:14], table)
lapply (frequency_tables_list, barplot)
sum ((clean_df$q1 >= clean_df$q2) & (clean_df$q2 != clean_df$q3))
