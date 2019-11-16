#  Exercise 3_13.11_Caras Valeria
#Data wrangling
#I have dowlanded data and now read it
url_math <- read.csv("data/student-mat.csv", sep=";")
url_math
dim(url_math)
str(url_math)
url_por <- read.csv("data/student-por.csv", sep=";")
url_por
dim(url_por)
str(url_por)
#url_math has 395 observations and 33 variables. url_por has 649 obs. of the same 33 variables

library(dplyr)
# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(url_math, url_por, by = join_by, suffix = c(".math", ".por"))
math_por
# see the new column names
names(math_por)

# glimpse at the data
glimpse(math_por)
#The data has 382 observations and 53 variables.
names(math_por)
# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(url_math)[!colnames(url_math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)


# access the 'tidyverse' packages dplyr and ggplot2
library(dplyr); library(ggplot2)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# initialize a plot of 'high_use'
g2 <- ggplot(data = alc, aes(x = high_use))
g2 + geom_bar()
# draw a bar plot of high_use by sex
g3 <- ggplot(data = alc, aes(x = high_use))+facet_wrap("sex")
g3 + geom_bar()

glimpse(alc)
#The data has 382 observations of 35 variables.
#save the dataset and read it to check
write.csv(alc, file = "data/alc.csv", row.names = FALSE)

read.csv( file="data/alc.csv")
