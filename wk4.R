library(sf)
library(tmap)
library(tmaptools)
library(RSQLite)
library(tidyverse)
library(countrycode)

mycsv <- read_csv(file=r"(D:\UCL\CASA0005GIS\HOMEWORK\WEEK4\global gender inequality data\Global Gender Inequality Index_2010&2019.csv)")
shape <- st_read(r"(D:\UCL\CASA0005GIS\HOMEWORK\WEEK4\spatial data of the World\World_Countries_(Generalized)\World_Countries__Generalized_.shp)")

mycsv$dif_2019_2010 <-(mycsv$gii_2019-mycsv$gii_2010)

?codelist
mycsv$ISO <- countrycode(mycsv$iso3, origin = "iso3c", destination = "iso2c")

shape2 <- merge(shape,mycsv, by = "ISO")

tmap_mode("plot")

install.packages("RColorBrewer")

pal <- brewer.pal(6,"BuGn")
pal

display.brewer.pal(6,"BuGn")

map01 <- tm_shape(shape2)+
  tm_fill("dif_2019_2010",palette="BuGn" ,n = 4,title="Changes in GII 2010-2019",textNA="No data")+
  tm_borders(col = "grey40", lwd = .3, lty = "solid")+
  tm_layout(inner.margins = c(0.02, 0, 0.02, 0),
           legend.position = c("left","bottom"),
           legend.text.size = 0.5,
           legend.title.size = 0.7,
           main.title = "Change in the value of the Gender Inequality Index between 2010 and 2019",
           main.title.position ="center",
           main.title.size=1,
           bg.color = "lightblue",
           frame = FALSE)

map01

tmap_save(map01,"map01.jpeg",dpi=1000)

install.packages("shiny")
install.packages("shinyjs")
library(shiny)
library(shinyjs)
palette_explorer()
