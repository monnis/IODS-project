#Juha Luukkonen, 23.11.2018.
#File description: Data wrangling for the fifth exercise for the IODS-course organized by the University of Helsinki.
#Sources of the data:
  #HDI: http://hdr.undp.org/en/content/human-development-index-hdi
  #GII: http://hdr.undp.org/en/content/gender-inequality-index-gii


# OVERALL SETUP / OVERALL SETUP / OVERALL SETUP 

#Clear all:
rm(list=ls())

#Setting the working directory:
setwd("~/GitHub/IODS-project/data")

#Libraries used:
library(dplyr);library(ggplot2);library(GGally);library(readr)


# DATA WRANGLING / DATA WRANGLING / DATA WRANGLING

# PART 2, reading the datasets

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


# PART 3, exploring the datasets

dim(hd)
str(hd)
summary(hd)

#Human development index is based on the idea, that economic growth alone should not assess the development of a country. 
#195 observations (countries) and 8 variables including components of the index such as, life expectancy, education and gross national income.
#Variables include rank of human development, the actual index and the components of this index.

dim(gii)
str(gii)
summary(gii)

#Gender inequality index measures gender inequalities from perspectives such as education, economic perspective, politics and female reproductive health.


# PART 4: renaming the variables 

colnames(hd)
names(hd) <- c("HDI_rank","Country","HDI","Life_exp", "Educ_exp", "Educ_mean", "GNI","GNI_cap")

colnames(gii)
names(gii) <- c("GII_rank","Country","GII","Mat_mortr", "Adol_birthr", "Percent_MP", "ed2_F", "ed2_M", "lf_partr_F", "lf_partr_M")


# PART 5: Mutating the gender equality data

#Ratio of females with secondary education to males with secondary education.
gii <- mutate(gii, ed2r_FM = ed2_F/ed2_M)      

#Ratio of labour force participation of females and males in each country.
gii <- mutate(gii, lfr_FM = lf_partr_F/lf_partr_M)      

summary(gii)


# PART 6: Joining these datasets together

human <- inner_join(hd, gii, by=c("Country" ="Country"), suffix = c(".hd",".gii"))

colnames(human)
#Looks alright, let's save that!

write.table(human, file = "human.txt")