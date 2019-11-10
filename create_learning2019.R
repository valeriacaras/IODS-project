#Valeria Caras. 6.11.2019
#Exercise 2. Linear regression
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(lrn14)
str(lrn14)
#The data has 183 observations of 60 variables shown by functions dim () and str ().
# divide each number in a vector
c(1,2,3,4,5) / 2
# print the "Attitude" column vector of the lrn14 data
lrn14$Attitude
# divide each number in the column vector
lrn14$Attitude / 10
# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10
install.packages ("dplyr")
library(dplyr)
# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)
# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <-select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
# select the 'keep_columns' to create a new dataset
learning2014 <-select(lrn14, one_of(keep_columns))
# print out the column names of the data
colnames(learning2014)
# change the name of the second column
colnames(learning2014)[2] <- "age"
# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"
# print out the new column names of the data
colnames(learning2014)
# select male students
male_students <- filter(learning2014, gender == "M")
# select rows where points is greater than zero
learning2014 <-filter(learning2014, points >0)
?write.csv 
write.csv(learning2014, file = "learning2014")

read.csv(file = "learning2014")
str(learning2014)
dim(learning2014)
head(learning2014)

