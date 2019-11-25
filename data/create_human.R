

# Data wrangling week 4_Caras Valeria_25.11
d <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
str(d)
str(gii)
dim(d)
dim(gii)
summary(d)
summary(gii)


#These are datasets on the human development indices which iclude different variables on development.
#D data has 195 obs. on 8 variables while gii has 195 obs. on 10 variables.
# Change variables names

names(gii)
names(gii)[names(gii) == "Gender.Inequality.Index..GII."] <- "GII"
names(gii)[names(gii) == "Maternal.Mortality.Ratio"] <- "Mat.Mor" 
names(gii)[names(gii) == "Adolescent.Birth.Rate"] <- "Ado.Birth"
names(gii)[names(gii) == "Percent.Representation.in.Parliament"] <- "Parli.F" 
names(gii)[names(gii) == "Population.with.Secondary.Education..Female."] <- "Edu2.F"
names(gii)[names(gii) == "Population.with.Secondary.Education..Male."] <- "Edu2.M"
names(gii)[names(gii) == "Labour.Force.Participation.Rate..Female."] <- "Labo.F" 
names(gii)[names(gii) == "Labour.Force.Participation.Rate..Male." ] <- "Labo.M" 
names(gii)

names(d)
names(d)[names(d) ==  "Human.Development.Index..HDI."] <- "HDI"
names(d)[names(d) == "Life.Expectancy.at.Birth"] <- "Life.Exp"
names(d)[names(d) == "Expected.Years.of.Education"] <- "Edu.Exp"
names(d)[names(d) == "Mean.Years.of.Education"] <- "Edu.Mean"
names(d)[names(d) == "Gross.National.Income..GNI..per.Capita"] <- "GNI"
names(d)[names(d) == "GNI.per.Capita.Rank.Minus.HDI.Rank"] <- "GNI.Minus.Rank"
names(d)


# join 2 datasets
library(dplyr)
join_by <- c("Country")
human <- inner_join(d, gii, by = join_by)
str(human)
# Mutate the “Gender inequality” data and create two new variables
library(dplyr); library(ggplot2)
human <- mutate(human, Edu2.FM = (Edu2.F + Edu2.M))
human <- mutate(human, Labo.FM = (Labo.F + Labo.M))
str(human)
# now the joined data has 195 obs. of  19 variables

# save new human data and read

write.csv(human, file = "data/human.csv", row.names = FALSE)
read.csv( file="data/human.csv")

         