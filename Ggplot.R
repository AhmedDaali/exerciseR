library(ggplot2)
library(RColorBrewer)
install.packages("viridis")
library(viridis)

getwd()
setwd("C:/Users/ahmed/Desktop/exerciseR")

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

#It is possible to create a variable with your base aesthetics and 
#then simply call it to apply other layers.
#The following will create the same output as the previous graph
key <- ggplot(data = iris, aes(x = Sepal.Length, 
                               y = Petal.Length, , 
                               color = Species))
key + geom_point()

#Different geometries can also be used to complement each other. 
#Here “geom_smooth()” adds a trend line and area to the points
key + geom_point() + geom_smooth()

#You should have noticed how geometries are here added with default options.
#Each has a set of options, such as removing the trend area in the following with se=FALSE
key + geom_point() + geom_smooth(se=FALSE)

#You can easily change the points size, shape and colour from “geom_point()” options,
#but see how it affects the display: if you force one colour, you will not have any more colors by Species,
#even if they are required in the key variable
key + geom_point(size=4, shape=15, color="red3")

#Or the size, shape and color as dependent now on Sepal.Length values from aes
ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length, 
                        color = Sepal.Length, size = Sepal.Length)) + geom_point()

#Remember that we are only covering here the “ggplot()” usage, but other possibilities
#exist to generate the same output as in Step 6 of this Article, such as “qplot()” 
#which is used to generate quick plots with ggplot2
qplot(Sepal.Length, Petal.Length, data = iris, color = 
        factor(Species)) + 
  geom_point() + 
  geom_smooth(se=FALSE)

#Generating different plots will require different geometries:

#Boxplot with default options
ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length, 
                        color = Species)) + geom_boxplot()

#Bar plot with default options
ggplot(data=Iris,aes(x=Sepal.Length)) + geom_bar()

#Or more complex ones even with default options such as Density plot
ggplot(data=Iris,aes(x=Sepal.Length, y = Petal.Length)) + 
  geom_density_2d_filled()


#An important thing to remember is that each plotting functions 
#comes with its own set of option, that might not work for other functions.
#Let’s see how to generate and modify histograms

#Default options
ggplot(data=Iris,aes(x=Sepal.Length)) + geom_histogram()

#Filling histogram colurs by Species. 
#Note how calling the colour option is different here
ggplot(data=Iris, aes(x=Sepal.Length,fill=Species)) + 
  geom_histogram()

#Use binwidth option with histograms
ggplot(data=Iris,aes(x=Sepal.Length,fill=Species)) + 
  geom_histogram(binwidth = 0.05)

#Now that we learned how to choose our data, and apply layers of aesthetics
#and geometries, let’s explore other possible layers of information such as facets and scales

#This is a list of convenient packages to use with ggplot2
library(ggplot2)
library(RColorBrewer)
library(viridis)
install.packages("ggsci")
library(ggsci)

#Here is an example of how to facet the output by Species, using “facet_wrap()”, 
#that requires the facets argument to be specified, i.e. here the Specie
key <- ggplot(data = iris,aes( x= Sepal.Length,y = 
                                 Petal.Length, color = Species))
key + geom_point() + geom_smooth(se=FALSE) + 
  facet_wrap(~Species)

#Other arguments with “facet_wrap()” give the possibility of fitting the y-axis scales to
#the values in order to optimize the output
key + geom_point() + geom_smooth(se=FALSE) + 
  facet_wrap(~Species, scale='free_y')

#It is also possible to plot discrete variables using “scale_x_discrete()” or “scale_y_discrete()”

#To set x-axis limits using “scale_x_continuous()” with limits option
key + geom_point() + geom_smooth(se=FALSE) + 
  facet_wrap(~Species, scale='free_y') + 
  scale_x_continuous(limits = c(1, 10))

#To reverse the x-axis using “scale_x_reverse()”
key + geom_point() + geom_smooth(se=FALSE) + 
  facet_wrap(~Species, scale='free_y') + 
  scale_x_reverse()+ 
  scale_x_continuous(limits = c(1, 10))

#Scales for colours, sizes and shapes
#Scales can be manually set by choosing specific colours, sizes and shapes
key + geom_point() + geom_smooth(se=FALSE) + 
  facet_wrap(~Species, scale='free_y') + 
  scale_shape_manual(values=c(3, 16, 17)) +
  scale_size_manual(values=c(2,3,4)) + 
  scale_color_manual(values=c('#669999','#a3c2c2', '#b30059'))

#Scales can be set using existing colour palettes from the RColorBrewer package
key + geom_point() + geom_smooth(se=FALSE) + 
  facet_wrap(~Species, scale='free_y') + 
  scale_color_brewer(palette="RdYlBu")

#RColorBrewer palettes can be consulted with
display.brewer.all()

#Scales can use different options with other color palettes from the viridis package
new_key <- key + geom_point(aes(color = Species)) + 
  geom_smooth(aes(color = Species, fill = Species), method = "lm") + 
  facet_wrap(~Species, scale='free_y')

new_key + scale_shape_manual(values=c(3, 16, 17)) +
  scale_size_manual(values=c(2,3,4)) + 
  scale_color_viridis(discrete = TRUE, option = "D") + 
  scale_fill_viridis(discrete = TRUE)

new_key + scale_color_tron() + scale_fill_tron()

#The particular case of missing values

#Missing values (NA) can exist in any data set, and need to be taken into account when plotting data.
#Let’s use this very simple data frame containing NA values

#Plotting with default colors in ggplot2. By default, a grey colour will be used for NA
df_test <- data.frame(x = 1:10, y = 1:10, 
                      z = c(1, 2, 3, NA, 5, 6, 7, NA, 8, NA))
plot_test <- ggplot(df_test, aes(x, y)) + 
  geom_tile(aes(fill = z), size = 10)
plot_test

#We can ask to have no colour of NA values
plot_test + scale_fill_gradient(na.value = NA)

#Or color NA values in a chosen colour, such as “red3” here
plot_test + scale_fill_gradient(na.value = "red3")

#Or use another colour palette, instead of default ggplot2 colours, 
#and you will still be able to specify the NA values. Because we need 
#many colors in this palette we use “scale_fill_gradientn()” instead of “scale_fill_gradient()”
plot_test + scale_fill_gradientn(colours = viridis(7), na.value = "white")




