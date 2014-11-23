#install and load the ggplot2 package

install.packages ("ggplot2")
library (ggplot2)
library (grid)  

#  Read the data
## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the total emissions by year

OnlyBaltimore <- subset (NEI,fips == "24510")
OnlyBaltimore <- aggregate (Emissions ~ type + year, data =OnlyBaltimore, sum)

#open the graphics device

png (file = "plot3.png", height = 480, width = 640, bg=NA)

#create a line plot to show trend

g<- ggplot (OnlyBaltimore, aes(x=year, y=Emissions))
g + geom_point(size = 3,shape= 8, color="red") + geom_line () + facet_grid (. ~ type) +
  scale_x_continuous(breaks = seq(1999, 2008, 3))  +
  geom_smooth(method = "lm", se=FALSE) + theme(panel.margin = unit(1, "lines"))

#Turn off the graphics device

dev.off ()