# Introduction----

# Challenge 3 Statistical Modelling
# Data Science in EES 2020
# Nicole Yap
# 4th November 2020


# Libraries----
library(tidyverse)
library(ggplot2)

# Loading data---- 

# Load Living Planet Data
load("Data/LPI_species.Rdata")


# Data preparation---- 

# Filtering dataset for my species i.e Winter Wren
LPI_wren <- LPI_species %>%
  filter(Common.Name == "Winter wren") %>%
  mutate(year = as.numeric(str_remove_all(year, "X"))) %>%
  select(id,
         Location.of.population,
         Country.list,
         Region,
         realm,
         year,
         pop,
         scalepop,
         Units,
         Sampling.method
         ) %>%
  droplevels()


# Inspecting data and checking what class of data I'm dealing with using str()

str(LPI_wren)
head(LPI_wren)


# Renaming unit names for consistency 

# Combining n counts for "Annual Index" and "Annual index" as they are the same sampling method 

LPI_wren <- LPI_wren %>% mutate(Units = replace(Units, Units == "Annual index", "Annual Index")) 


# Counting the number of observations for each country and breaking them down by sampling method and units
LPI_wren_count <- LPI_wren %>%
  group_by(Country.list, Sampling.method, Units) %>% 
  tally() 


# Filtering dataset for only one Unit( i.e Sampling method) and one country (i.e Canada). 
# Discard samples that do not specify a useful detailed location (just "canada")
LPI_wren_cad <- LPI_wren %>%
  filter(Country.list == "Canada", Location.of.population!="Canada",Units == "Annual Index")%>%
  droplevels()

LPI_wren_cad2 = select(LPI_wren_cad, pop, year)


(basic_hist <- ggplot(LPI_wren_cad2, aes(x = year))  +
    geom_histogram())


(basic_hist <- ggplot(LPI_wren_cad, aes(x = year)) +                
    geom_histogram(binwidth = 1, colour = "#8B5A00", fill = "#CD8500") +    # Changing the binwidth and colours
    theme_bw() +                                                      # Changing the theme to get rid of the grey background
    ylab("Annual index of wren population\n") +                        # Changing the text of the y axis label
    xlab("\nYear")  +                                                  # \n adds a blank line between axis and text
    scale_x_continuous(breaks = 1975:2010) + 
    scale_y_continuous(limits = c(0, 20)) +                 
    theme(axis.text.x = element_text(size = 12, angle = 45, vjust = 1, hjust = 1),     # making the years at a bit of an angle
          axis.text.y = element_text(size = 12),
          axis.title = element_text(size = 14, face = "plain"),                        
          panel.grid = element_blank(),                                   # Removing the background grid lines               
          plot.margin = unit(c(1,1,1,1), units = , "cm"),                 # Adding a 1cm margin around the plot
          legend.text = element_text(size = 12, face = "italic"),         # Setting the font for the legend text
          legend.title = element_blank(),                                 # Removing the legend title
          legend.position = "right"))   
