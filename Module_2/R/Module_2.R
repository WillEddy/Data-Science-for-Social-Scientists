# Importing and Labeling
rt_df <- read.csv("../data/week2.csv", header=TRUE)
levels(rt_df$condition) <- factor(c("Control","Experimental"))
levels(rt_df$gender) <- factor(c("Male","Female","Transgender"))

# Analysis
mean(rt_df$rt)
rt_f_df <- subset(rt_df, rt_df$gender == "Female")
summary(rt_f_df)
hist(rt_f_df$rt)
