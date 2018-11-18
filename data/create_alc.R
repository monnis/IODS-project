#Juha Luukkonen, 18.11.2018.
#File description: The third exercise for the IODS-course organized by the University of Helsinki.
#Source of data: https://archive.ics.uci.edu/ml/datasets/Student+Performance


# OVERALL SETUP / OVERALL SETUP / OVERALL SETUP 

#Clear all:
rm(list=ls())

#Setting the working directory:
setwd("~/GitHub/IODS-project/data")

#Libraries used:
library(dplyr);library(ggplot2);library(GGally);library(readr)



# DATA WRANGLING / DATA WRANGLING / DATA WRANGLING 

# PART 3

math <- read_csv2("student-mat.csv", col_names=TRUE)
por <- read_csv2("student-por.csv", col_names=TRUE)

dim(por)
str(por)
dim(math)
str(math)

# PART 4
#Merging the dataset:
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

#Joining the two datasets by the selected identifiers:
math_por <- inner_join(math, por, by=join_by,suffix = c(".math", ".por"))

#Exploring the data:
glimpse(math_por)
dim(math_por)
str(math_por)

# PART 5
#Copypastelol:

alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 
    alc[column_name] <- first_column
  }
}

# PART 6
#Defining high levels of alcohol use. 
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)


# PART 7 
#The data seems to be alright with the amount of observations and variables matching
#the guidelines.

glimpse(alc)

write.table(alc, file = "alc.txt")
