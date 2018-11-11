#Juha Luukkonen, 06.11.2018.
#File description: The second exercise for the IODS-course organized by the University of Helsinki.
#Reference to the data source: 

# OVERALL SETUP / OVERALL SETUP / OVERALL SETUP 

#Clear all:
rm(list=ls())

#Setting the working directory:
setwd("~/GitHub/IODS-project/data")


#Libraries used:
library(dplyr)
library(ggplot2)
library(GGally)


# DATA WRANGLING PART / DATA WRANGLING PART / DATA WRANGLING PART 

# PART 2

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

str(lrn14)
dim(lrn14)
#The 'learning' data contains 183 observations (invididuals) and a grand total of 60 variables.
#59 of the variables are integers, and one is factor variable expressing gender. 


# PART 3

#Questions related to deep, surface and strategic learning (copypasted from the Data camp)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# Selecting the columns related to deep, surface and strategic learning and create respective columns by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# Choosing the columns to keep in order to  create a new dataset:
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))

# Filtering zero pointers away:
learning2014 <- filter(learning2014, Points > 0)


# Structure of the new dataset seems to be what it should be! 
str(learning2014)
dim(learning2014)


# PART 4

# Saving the data as a text-file.

write.table(learning2014, file = "learning2014.txt")

students2014 <- read.table("learning2014.txt")
str(students2014)
head(students2014)




