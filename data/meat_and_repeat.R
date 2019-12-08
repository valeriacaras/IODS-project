# Exercise 6 by Valeria Caras 04.12.19

# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
# Look at the (column) names of BPRS
names(BPRS)
# Look at the structure of BPRS
str(BPRS)
# Print out summaries of the variables
summary(BPRS)

## BPRS data icludes information about 40 male subjects who were randomly assigned to one of two treatment groups and each subject was rated on the brief psychiatric rating scale (BPRS)
## subjects are measured during 8 weeks. data has 40 obs. of  11 variables (8 weeks, subject and treatment)

## Convert the categorical variables of  data sets to factors

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)
# explore long data
summary (BPRSL)
str(BPRSL)
dim(BPRSL)

## Now data has 360 obs. of  5 variables. This is because all weeks were combined in one variable and each subject's observation is repeated 10 times in week and bprs colimn. This was done to overcome the correlated nature of the initial data where all weeks were coorelated with each other. 
# save new data
write.csv(BPRSL, file = "data/BPRSL.csv", row.names = TRUE)
read.csv( file="data/BPRSL.csv", row.names = 1) 

## RATS data
# read the RATS data and explore
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
names(RATS)
str(RATS)
summary(RATS)

## Thus is data from a  study conducted in three groups of rats. The three groups were put on different diets, and each animal’s body weight  was recorded repeatedly over a 9-week period.
## data has 16 obs. of  13 variables (as ID, group 1/2/3 and weeks)

# Factor variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)
# Glimpse the data
glimpse(RATS)
# Convert data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 
# Glimpse the data
glimpse(RATSL)
#expolore new data
names(RATSL)
str(RATSL)
summary(RATSL)

##New RATLS data has 176 obs. of  5 variables, It became longer because we the same combined time variabl einto one (WD) to avoid correlation. 
# save new data
write.csv(RATSL, file = "data/RATSL.csv", row.names = TRUE)
read.csv( file="data/RATSL.csv", row.names = 1) 
         

