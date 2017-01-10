#Hello World in R
#STOR666: Intoduction to Data Science, spring 2017
#Tutorial by Iain Carmichael

#This script is based on R Programming for Data Science by Roger Peng

#Using a programming language allows you to save numbers as a variable
a <- 1 #assign the number 2 to the variable a
b <- 2 
c = 3 #you can use <- or = 
d <- 4.5


a + d
b*c
c/b
c^b
c^2


#We can also assign text to variables. 
#Note that text data is called a "string" or "characters"
msg <- "hello world"

#You can print a variable by using the print() funciton
print(msg)

#Or just running the variable
msg


#What other types of variables can we store? (There are many)

#Logical. Note these are called "boolean" variables. 
t <- TRUE
f <- FALSE

#True or false. Note "|" means "or" in R
t | f

#True and False. Note "&" means "and"
t & f


#Vectors
#Let's store the populations of the 5 largest cities in NC (from Google)
pop <- c(792862, 431746,279639, 245475,236441) 
mean(pop)
median(pop)
min(pop)
max(pop)
sd(pop) #standard deviation
pop[2] #Get the second element of the vector

#If you just want a vectors of 1:n 
1:5

#You can also store vectors of strings
cities <- c("Charlotte", "Raleigh", "Greensboro", "Durham", "Winston-Salem")

#Or a vector of booleans
#Cities Iain has visited. Note the order matters.
has_visited <- c(TRUE, TRUE, FALSE, T, F) #can use True or T (False or F)

#Now let's make a data frame (picture an Excel table)
df <- data.frame(cities, pop, has_visited)

print(df)
df #these are equivalent

#Much more on data frames later. For now notices the attributes
names(df)

#we can access the colums of a data frame various different ways
df['pop']
df$pop
df[,2]

#Or the rows
df[1,]

#Or an individual entry
df[1,2]

#Now let's make a plot (highlight both lines and run)
barplot(df$pop, names = df$cities, 
        main = "Five largest cities in NC", ylab = "population", xlab = 'city', col = 'blue')


###################Let's read in the UNC salary data set#############################
#Read data from the web (will cover this in much more detail later)
data <- read.csv(url("http://ryanthornburg.com/wp-content/uploads/2015/05/UNC_Salares_NandO_2015-05-06.csv"))

#Print out the first 6 rows
head(data)

#Column names
names(data)

#Dimensions of the data
dim(data) 

#Let's install and load an r package
#install.packages('dplyr')
library(dplyr)

#Don't worry about the details right now
by_dept <- group_by(data, dept)
dept_sum <- summarise(by_dept, 
                     avgsal = mean(totalsal),
                     num_emp = n(),
                     maxsal = max(totalsal))

#Look at 20 deptarments with highest average salary
head(dept_sum[order(dept_sum$maxsal, decreasing = T),], n= 20)

#Box plot of a few departments
new_df<- filter(data,dept %in% 
                     c("Medicine","Provost", "Kenan-Flagler Business School"))
new_df$dept = as.character(new_df$dept)
boxplot(totalsal ~ dept, new_df, xlab = "Department", ylab = "Salary")

#Plot number of years emplyed against salary
plot(data$stservyr,data$totalsal, xlab = "Years employed", ylab = "Salary", col = "blue")

