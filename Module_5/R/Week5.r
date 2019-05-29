# R Studio API Code
library(rstudioapi); library(data.table); library(stringr); library(lubridate)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))       #Set working director to where this document is

# Data import
library(tidyverse)
Adata_tbl <- read_delim("../data/Aparticipants.dat",delim="-",col_names = c("casenum","parnum","stimver","datadate","qs"))
Anotes_tbl <- fread("../data/Anotes.csv")
Bdata_tbl <- read_delim("../data/Bparticipants.dat",delim="\t",col_names = c("casenum","parnum","stimver","datadate",paste0("q",1:10)))
Bnotes_tbl <- fread("../data/Bnotes.txt")

# Data cleaning
Adata_tbl <- Adata_tbl %>%
  separate(qs,paste0("q",1:5)," - ") %>% # Could use argument "convert = T"
  mutate_at(vars(starts_with("q")),funs(as.numeric)) %>%
  mutate(datadate = mdy_hms(Adata_tbl$datadate))
#
Aaggr_tbl <- Adata_tbl %>%
  group_by(parnum) %>%
  summarize_at(vars(q1:q5),mean)
Baggr_tbl <- Bdata_tbl %>%
  group_by(parnum) %>%
  summarize_at(vars(q1:q5),mean)
Aaggr_tbl <- Aaggr_tbl %>% left_join(Anotes_tbl)
Baggr_tbl <- Baggr_tbl %>% left_join(Bnotes_tbl)
bind_rows(A=Aaggr_tbl, B= Baggr_tbl,.id="dataset") %>%
  group_by(dataset) %>%
  filter(notes == "") %>%
  summarize(n())
