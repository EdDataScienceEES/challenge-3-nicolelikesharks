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
library(directlabels)



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
     xlim=c(-1,1)) # Our distribution is right-skewed

(split_plot <- ggplot(aes(year, scalepop, colour=Location.of.population), data = LPI_wren_cad) + 
    geom_point() + 
    theme(legend.position = "none")+
    facet_wrap(~ Location.of.population) + # create a facet for each location
    xlab("Year") + 
    ylab("scalepop")+
  labs(
    x = "Year",
    y = "Population"))

# Saving the facet plots

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


# Random slope and random intercept


mixed.re.rs <- lmer(scalepop ~ year + (1 + year|Location.of.population), data = LPI_wren_cad) 
summary(mixed.re.rs)



# Plotting model predictions---- 

# Extract the prediction data frame
pred.mm <- ggpredict(mixed.lmer, terms = c("year"))  # Outputs overall predictions for the model

# Plot the predictions 

(prediction_plot <- ggplot(pred.mm) + 
    geom_line(aes(x = x, y = predicted)) +          # slope
    geom_ribbon(aes(x = x, ymin = predicted - std.error, ymax = predicted + std.error), 
                fill = "lightgrey", alpha = 0.5) +  # error band
    geom_point(data = LPI_wren_cad,                      # adding the raw data (scaled values)
               aes(x = year, y = scalepop, colour = Location.of.population)) + 
    labs(x = "Year", y = "Population Abundance (Annual Index)", 
         title = "Year does affect population abundance of winter wrens ") + 
    theme_minimal()
)




# Saving prediction plot 
ggsave("Output/prediction_plot.pdf", prediction_plot)
ggsave("Output/prediction_plot.png", prediction_plot)


# Make summary table----

stargazer(mixed.lmer, type = "html",
          out="Output/table.html",
          digits = 3,
          star.cutoffs = c(0.05, 0.01, 0.001),
          digit.separator = "")

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






