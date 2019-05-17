# data import and cleaning
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))       #Set working director to where this document is
raw_df <- read.csv("../data/week3.csv")

# New line