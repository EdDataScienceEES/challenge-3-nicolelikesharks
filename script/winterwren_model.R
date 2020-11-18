# Introduction----

# Challenge 3 Statistical Modelling
# Data Science in EES 2020
# Nicole Yap
# 4th November 2020


# Libraries----
library(tidyverse)
library(ggplot2)    # to make graphs 
library(dplyr)
library(lme4)       # for models
library(sjPlot)     # to visualise model outputs
library(ggeffects)  # to visualise model predictions
library(stargazer)
library(agridat)
library(glmmTMB)


# Load Living Planet Data
load("Data/LPI_species.Rdata")


# Data tidying and preparation---- 

# Filtering dataset for Winter Wren species

LPI_wren <- LPI_species %>%
  filter(Common.Name == "Winter wren") %>%
  mutate(year = as.numeric(str_remove_all(year, "X"))) %>%
  select(id,
         Location.of.population,
         Country.list,
         Region,
         biome,
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
# Discarding samples that do not specify a useful detailed location (just "canada")
# Fix error in location name due to special character
LPI_wren_cad <- LPI_wren %>%
  filter(Country.list == "Canada", Location.of.population!="Canada",Units == "Annual Index")%>%
  mutate(Location.of.population=recode(Location.of.population,"Qu<ed><a9>bec" = "Quebec"))%>% 
  mutate(population_int = pop*1000) %>% 
  droplevels()


# Preliminary data visualiazation---- 

# Creating basic histogram to take a look at the distribution 

Population <- LPI_wren_cad$scalepop

hist(Population,
     main="Histogram of wren population data",
     xlab="Annual index of wren population",
     xlim=c(-1,1)) # Our distribution is left-skewed

(split_plot <- ggplot(aes(year, scalepop, colour=Location.of.population), data = LPI_wren_cad) + 
    geom_point() + 
    theme(legend.position = "none")+
    facet_wrap(~ Location.of.population) + # create a facet for each location
    xlab("Year") + 
    ylab("Pop")+
  labs(
    x = "Year",
    y = "Population"))

# Saving the basic histogram 

ggsave("Output/Facet_plot.pdf", split_plot)
ggsave("Output/Facet_plot.png", split_plot)


# Fit all data to linear model ignoring random effects for now
# Fitting our model with scalepop as the response and year as the predictor

basic.lm <- lm(year~scalepop, data = LPI_wren_cad)
summary(basic.lm)

# Plotting basic model 

(prelim_plot <- ggplot(LPI_wren_cad, aes(x = year, y = scalepop)) +
    geom_point() +
    geom_smooth(method = "lm"))


# Saving basic plot
ggsave("Output/prelim_plot.pdf", prelim_plot)
ggsave("Output/prelim_plot.png", prelim_plot)


# Checking assumptions to decide on what statistical model to use----

plot(basic.lm) # Residial vs fitted: Residuals almost fall along a horizontal straight line.
              ## Good indication that model doesn't have non-linear relationships.
               # Q-Q: Residuals are lined well on the straight dashed line. Good!
               # Scale-location: Red line almost horizontal, randomly spread points. Good
               # So our residuals are normally distributed, and the data is homoscedastic. 


# Saving residual vs fitted, qq, scale-location and residuals vs leverage plots

pdf("Output/assumption_plots.pdf") 
plot(basic.lm)
dev.off()


# Generating mixed effect model using lme4 package----


# Testing if association between year and wren population exists after controlling for the variation in location.
# Fix location of population as random effect

mixed.lmer <- lmer(scalepop ~ year + (1|Location.of.population), data = LPI_wren_cad) 
summary(mixed.lmer) # 0.04302/(0.04302 + 0.19176) =  ~18% 
                    # Differences between location explain ~18% of the variance that’s “left over” 
                    ## after the variance is explained by fixed effects (year)
                    # The model estimate is bigger than associated error, meaning that 
                    ## effect/slope can be distinguished from 0. 

# Checking assumptions again

plot(mixed.lmer)
qqnorm(resid(mixed.lmer))
qqline(resid(mixed.lmer))  # points roughly follow line, deviate slightly at the end


# Visualizing random effects----

# Set a clean theme for the graphs
set_theme(base = theme_bw() + 
            theme(panel.grid.major.x = element_blank(),
                  panel.grid.minor.x = element_blank(),
                  panel.grid.minor.y = element_blank(),
                  panel.grid.major.y = element_blank(),
                  plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), units = , "cm")))

# Visualises random effect (location)
(re.effects <- plot_model(mixed.lmer, type = "re", show.values = TRUE))
save_plot(filename = "Output/model_re.png",
          height = 11, width = 9) 

# To see the estimate for fixed effect (year)
(fe.effects <- plot_model(mixed.lmer, show.values = TRUE))
save_plot(filename = "Output/model_fe.png",
          height = 11, width = 9)  


# Creating independence boxplots

#boxplot(scalepop ~ Location.of.population, data = LPI_wren_cad) 

(boxplot2 <- ggplot(LPI_wren_cad, aes(Location.of.population, scalepop, colour = Location.of.population)) +
    geom_boxplot(fill = "grey", alpha = 0.8, show.legend=FALSE) +
   theme_classic() +  
    theme(axis.text.x = element_text(size = 12, angle = 15,margin=margin(20))) +
    labs(x = "Location of population", y = "Scaled population"))
    
ggsave("Output/boxplot2.pdf", boxplot2)
ggsave("Output/boxplot2.png", boxplot2)


# Plot coloured points by location
(colour_plot <- ggplot(LPI_wren_cad, aes(x = year, y = scalepop, colour = Location.of.population)) +
    geom_point(size = 2) +
    theme_classic() +
    theme(legend.position = "none"))
  
ggsave("Output/colour_plot.pdf", colour_plot)
ggsave("Output/colour_plot.png", colour_plot)





