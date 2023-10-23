library(ggplot2)
library(RColorBrewer)
install.packages("viridis")
library(viridis)

getwd()
setwd("/ahmed/Desktop/exerciseR/Project_test")

# Load the dplyr package
library(dplyr)

# Read the iris.txt file (if it's in the current directory)
Iris <- read.table("iris.txt")

# If the file is not in the current directory, provide the correct path

# Select the columns Sepal.Length and Petal.Length
iris_length <- Iris %>% select(Sepal.Length, Petal.Length)

# Show the first rows of iris_length
head(iris_length)


#Let’s use basic layers to plot Petal.Length vs. Sepal.Length. 
#With ggplot2, “aes()” specifies aesthetics for x and y-axis, 
#and “geom_point()” generates a scatterplo
ggplot(data = iris,aes(x = Sepal.Length, y = Petal.Length)) + 
  geom_point()

#Using the same previous plot options, let’s color the points according to the Species
ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) + 
  geom_point()

#There are other possible shorter ways for generating this same output
ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) + 
  geom_point()
