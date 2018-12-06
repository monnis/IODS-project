#Juha Luukkonen, 4.12.2018.
#File description: Data wrangling for the sixth exercise for the IODS-course organized by the University of Helsinki.
#Source of the data:

# OVERALL SETUP / OVERALL SETUP / OVERALL SETUP 

#Clear all:
rm(list=ls())

#Setting the working directory:
setwd("~/GitHub/IODS-project/data")

#Libraries used:
library(dplyr);library(ggplot2);library(GGally);library(readr);library(stringr);library(tidyr)

# DATA WRANGLING / DATA WRANGLING / DATA WRANGLING 

# PART 1: Importing the data

#BPRS
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header=TRUE)
str(BPRS)
summary(BPRS)

#BPRS in its wide form has only factor variables.


#RATS
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt")
str(RATS)
summary(RATS)

# PART 2: Converting variables into Christianity

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# PART 3: from wide to long, sounds like going to the gym.

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5,10)))

RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD,3,4))) 


str(RATSL)


# PART 4: The long and wide forms of data

dim(BPRS)
dim(BPRSL)

summary(BPRS)
summary(BPRSL)

dim(RATS)
dim(RATSL)

summary(RATS)
summary(RATSL)


#The crucial difference: the long form lists observations by two (or more) variables: In this case by individual and
#by the observational point of time, while in the wide form observations at different time points 
#are all listed as different variables. There might be some use for data in its wide form,
#for instance, data it is useful in assessing weekly summaries, but the long form is usable by these
#regression tools introduced here. 

#So basically, it boils down to grouping observations by two variables(id, t), instead of one (id), 
#though the same information exists in both forms.


#Saving the datasets:

write.table(RATSL, file = "RATSL.txt")
write.table(BPRSL, file = "BPRSL.txt")

