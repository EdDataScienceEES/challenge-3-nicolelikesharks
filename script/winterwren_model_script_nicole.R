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

# Save our modified dataset as a .csv file
write.csv(LPI_wren_cad, file = "data/LPI_wren_cad.csv")

str(LPI_wren_cad)


# Preliminary data visualiazation---- 

# Creating basic histogram to take a look at the distribution 

Population <- LPI_wren_cad$scalepop

hist(Population,
     main="Histogram of wren population data",
     xlab="Annual index of wren population",
     xlim=c(-1,1)) # Our distribution is right-skewed


# Looking at facet plots quickly to eyeball population trends in each location

(basic_facetplot <- ggplot(aes(year, scalepop, colour=Location.of.population), data = LPI_wren_cad) + 
    geom_point() + 
    theme_classic() +
    theme(legend.position = "none", panel.spacing = unit(2, "lines")) +  # adding space between panels
    facet_wrap(~ Location.of.population) + # create a facet for each location
    xlab("Year") + 
    ylab("scalepop")+
  labs(
    x = "Year",
    y = "Population"))

# Saving the facet plots

ggsave("Output/Basic_facet_plot.pdf", basic_facetplot)
ggsave("Output/Basic_facet_plot.png", basic_facetplot)


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


# Generating mixed effect models----

# Generating model with random intercept (location of population as random effect)
# Testing if association between year and wren population exists after controlling for the variation in location.

mixed.lmer <- lmer(scalepop ~ year + (1|Location.of.population), data = LPI_wren_cad) 
summary(mixed.lmer) # 0.04302/(0.04302 + 0.19176) =  ~18% 
                    # Differences between location explain ~18% of the variance that’s “left over” 
                    ## after the variance is explained by fixed effects (year)
                    # The model estimate is bigger than associated error, meaning that 
                    ## effect/slope can be distinguished from 0. 


# Generating model with random slope and random intercept


mixed.re.rs <- lmer(scalepop ~ year + (1 + year|Location.of.population), data = LPI_wren_cad) # doesn't converge? error
summary(mixed.re.rs)


# Visualizing models----

# Visualization for random intercept model 
 
(model_vis_plot <- ggplot(LPI_wren_cad, aes(x = year, y = scalepop, colour = Location.of.population)) +
   facet_wrap(~Location.of.population) +   # a panel for each mountain range
   geom_point(alpha = 0.5) +
   theme_classic() +
   geom_line(data = cbind(LPI_wren_cad, pred = predict(mixed.lmer)), aes(y = pred), size = 1) +  # adding predicted line from mixed model 
   theme(legend.position = "none",
         panel.spacing = unit(2, "lines"))  # adding space between panels
)

ggsave("Output/Pred_facet_plot_ri.pdf", model_vis_plot)
ggsave("Output/Pred_facet_plot_ri.png", model_vis_plot)

# Visualization for random intercept and random slope model

(model_vis_plot_rs <- ggplot(LPI_wren_cad, aes(x = year, y = scalepop, colour = Location.of.population)) +
    facet_wrap(~Location.of.population) +   # a panel for each mountain range
    geom_point(alpha = 0.5) +
    theme_classic() +
    geom_line(data = cbind(LPI_wren_cad, pred = predict(mixed.re.rs)), aes(y = pred), size = 1) +  # adding predicted line from mixed model 
    theme(legend.position = "none",
          panel.spacing = unit(2, "lines"))  # adding space between panels
)
ggsave("Output/Pred_facet_plot_rs.pdf", model_vis_plot_rs)
ggsave("Output/Pred_facet_plot_rs.png", model_vis_plot_rs)

# Plotting model predictions---- 

# Extract the prediction data frame
pred.mm <- ggpredict(mixed.lmer, terms = c("year"))  # Outputs overall predictions for the model

# Plot the predictions (random intercept model)

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

# Saving prediction plot (random intercept model)
ggsave("Output/prediction_plot.pdf", prediction_plot)
ggsave("Output/prediction_plot.png", prediction_plot)

# Extract the prediction data frame

pred.mm.rs <- ggpredict(mixed.re.rs, terms = c("year"))  # this gives overall predictions for the model


# Plot predictions (random slope and random interecpt model)

(prediction_plot_rs <- ggplot(pred.mm.rs) + 
    geom_line(aes(x = x, y = predicted)) +          # slope
    geom_ribbon(aes(x = x, ymin = predicted - std.error, ymax = predicted + std.error), 
                fill = "lightgrey", alpha = 0.5) +  # error band
    geom_point(data = LPI_wren_cad,                      # adding the raw data (scaled values)
               aes(x = year, y = scalepop, colour = Location.of.population)) + 
    labs(x = "Year", y = "Population Abundance (Annual Index)", 
         title = "Year does affect population abundance of winter wrens") + 
    theme_minimal()
)


# Saving prediction plot (random slope model)
ggsave("Output/prediction_plot_rs.pdf", prediction_plot_rs)
ggsave("Output/prediction_plot_rs.png", prediction_plot_rs)


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






