#Juha Luukkonen, 23.11.2018.
#File description: Data wrangling for the fifth exercise for the IODS-course organized by the University of Helsinki.
#Sources of the data:
  #HDI: http://hdr.undp.org/en/content/human-development-index-hdi
  #GII: http://hdr.undp.org/en/content/gender-inequality-index-gii


#IMPORTANT NOTICE, this contains data wrangling from exercise sets 4 and 5.

# OVERALL SETUP / OVERALL SETUP / OVERALL SETUP 

#Clear all:
rm(list=ls())

#Setting the working directory:
setwd("~/GitHub/IODS-project/data")

#Libraries used:
library(dplyr);library(ggplot2);library(GGally);library(readr);library(stringr)


# DATA WRANGLING FOR EXERCISE SET 4

# PART 2, reading the datasets

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


# PART 3, exploring the datasets

#Human Development Index
dim(hd)
str(hd)
summary(hd)

#Gender Inequality Index
dim(gii)
str(gii)
summary(gii)



# PART 4: renaming the variables 

colnames(hd)
names(hd) <- c("HDI_rank","Country","HDI","Life_exp", "Educ_exp", "Educ_mean", "GNI","GNI_cap")

colnames(gii)
names(gii) <- c("GII_rank","Country","GII","Mat_mortr", "Adol_birthr", "Percent_MP_F", "ed2_F", "ed2_M", "lf_partr_F", "lf_partr_M")


# PART 5: Mutating the gender equality data

#Ratio of females with secondary education to males with secondary education.
gii <- mutate(gii, ed2r_FM = ed2_F/ed2_M)      

#Ratio of labour force participation of females and males in each country.
gii <- mutate(gii, lfr_FM = lf_partr_F/lf_partr_M)      

summary(gii)


# PART 6: Joining these datasets together

human <- inner_join(hd, gii, by=c("Country" ="Country"), suffix = c(".hd",".gii"))

colnames(human)

#Looks alright!


# DATA WRANGLING FOR EXERCISE SET 5 BEGINS HERE

#The data contains combined variables concerning Human Development Index and Gender Inequality Index data by the UN.
#HDI is based on the idea, that economic growth alone should not assess the development of a country. 
#195 observations (countries) and 8 variables including components of the index, such as life expectancy, education and gross national income.
#Variables include rank of human development, the actual index and the components of this index.

#GII measures gender inequalities from perspectives such as education, economic perspective, politics and female reproductive health.


# PART 1: mutating the nonnumeric comma away

str(human$GNI)
human <- mutate(human, GNI = str_replace(GNI, ",","") %>% as.numeric ) 
human$GNI 


# PART 2: excluding unwanted variables
colnames(human)

keep <- c("Country", "ed2r_FM", "lfr_FM", "Life_exp", "Educ_exp", "GNI", "Mat_mortr", "Adol_birthr", "Percent_MP_F")
human <- select(human, one_of(keep))


# PART 3: filtering rows that contain missing values away

comp <- complete.cases(human)
human <- filter(human, comp == TRUE)

dim(human)
#Now there are 162 observations left.


# PARTS 4 & 5: removing the regional observations and defining row names by country names.

tail(human, 10)

last <- nrow(human) - 7
human_ <- human[1:last,]

rownames(human_) <- human_$Country

human_ <- select(human_, -Country)
dim(human_)

# The data is set!
write.table(human_, file = "human.txt")
