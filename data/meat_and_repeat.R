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
# explore ling data
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
         








#Access the package ggplot2
library(ggplot2)

# Draw the plot
ggplot(BPRSL, aes(x = week, y = bprs, linetype = subject)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:10, times=4)) +
  facet_grid(. ~ treatment, labeller = label_both) +
  theme(legend.position = "none") + 
  scale_y_continuous(limits = c(min(BPRSL$bprs), max(BPRSL$bprs)))
# Standardise the variable bprs
BPRSL <- BPRSL %>%
  group_by(week) %>%
  mutate(stdbprs = bprs) %>%
  ungroup()

# Glimpse the data
glimpse(BPRSL)

# Plot again with the standardised bprs
ggplot(BPRSL, aes(x = week, y = stdbprs, linetype = subject)) +
  geom_line() +
  scale_linetype_manual(values = rep(1:10, times=4)) +
  facet_grid(. ~ treatment, labeller = label_both) +
  scale_y_continuous(name = "standardized bprs")
# Number of weeks, baseline (week 0) included
n <- BPRSL$week %>% unique() %>% length()

# Summary data with mean and standard error of bprs by treatment and week 
BPRSS <- BPRSL %>%
  group_by(treatment, week) %>%
  summarise( mean = mean(bprs), se = sd(bprs)/sqrt(n) ) %>%
  ungroup()

# Glimpse the data
glimpse(BPRSS)

# Plot the mean profiles
ggplot(BPRSS, aes(x = week, y = mean, linetype = treatment, shape = treatment)) +
  geom_line() +
  scale_linetype_manual(values = c(1,2)) +
  geom_point(size=3) +
  scale_shape_manual(values = c(1,2)) +
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se, linetype="1"), width=0.3) +
  theme(legend.position = c(0.8,0.8)) +
  scale_y_continuous(name = "mean(bprs) +/- se(bprs)")
# Create a summary data by treatment and subject with mean as the summary variable (ignoring baseline week 0).
BPRSL8S <- BPRSL %>%
  filter(week > 0) %>%
  group_by(treatment, subject) %>%
  summarise( mean=mean(bprs) ) %>%
  ungroup()

# Glimpse the data
glimpse(BPRSL8S)

# Draw a boxplot of the mean versus treatment
ggplot(BPRSL8S, aes(x = treatment, y = mean)) +
  geom_boxplot() +
  stat_summary(fun.y = "mean", geom = "point", shape=23, size=4, fill = "white") +
  scale_y_continuous(name = "mean(bprs), weeks 1-8")

# Create a new data by filtering the outlier and adjust the ggplot code the draw the plot again with the new data
BPRSL8S1 <- BPRSL8S %>%
  filter(mean < 60)

glimpse(BPRSL8S1)
## RATS data
# read the RATS data and explore
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
names(RATS)
str(RATS)
summary(RATS)
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

dim(RATSL)
# Plot the RATSL data
ggplot(RATSL, aes(x = Time, y = Weight, group = ID)) +
  geom_line(aes(linetype = Group)) +
  scale_x_continuous(name = "Time (days)", breaks = seq(0, 60, 10)) +
  scale_y_continuous(name = "Weight (grams)") +
  theme(legend.position = "top")