# Title: Population trends of winter wren in Canada from 1970-2010 
Author: Nicole Yap s1761850@ed.ac.uk  
Date: 17/11/2020

## 1. Introduction:  
This report assesses the population trends of winter wren populations in Canada over 1970-2010 through the design and analysis of a linear mixed model in Rstudio. 
The data used in this report can be accessed from [Living Planet Index (LPI)](https://livingplanetindex.org/home/index). LPI indicates "the state of the world's biological diversity based on population trends of vertebrate species from terrestrial,
freshwater and marine habitats" and currently reflects a worrying overall trend (Living Planet Index, 2020). The population sizes of mammals, birds, fish, amphibians and reptiles decreased by 68% on average since 1970 (Living Planet Index 2020).

## 2. Species focus: Winter Wren 
The winter wren is an elusive, secretive species, behaving much like a mouse by creeping through the tangle of branches covering the forest floor.(The Cornell Lab, 2019). Masters of hide and seek, the winter wren also hides its nest well, making
them difficult to find. The winter wren is a weak flier and prefers to hop and explore forest understories, examining upturned roots and vegetation for it's main food source- invertebrates (The Cornell Lab, 2019). 
Of particular beauty is the song of the winter wren, when played at quarterspeed, it reveals an amazing blend of halftones and overtones all sung simultaneously (Boreal Songbird Initiative, 2020). 

## 3. Research design
The main research question driving this report is: "What trend do populations of winter wrens exhibit in Canada over the years 1970-2010?".  
The hypotheses are as follows:   

​ Hypothesis 1: Winter wren populations show an increasing or decreasing trend and change over time.   

​ Null hypothesis: Winter wren populations do not exhibit any clear trends or stay the same over time.   

I hypothesized that due to global climate change, winter wrens might experience a shift in their range. [Here](https://www.audubon.org/field-guide/bird/winter-wren), 
under a +2 ℃ warming scenario, the populations of winter wrens are moderately vulnerable and experience a 56% decrease in range in summer (Audubon, 2020).   


## 4. Data preperation  

To examine my key species, I filtered out all species except "winter wren" using the dplyr package. When viewing the dataset, I realized that the units changed according to the
sampling method. Using 
I first looked at the population column as this was most important to the study. I noticed that the units for these population
varied depending on the sampling method.



## 5. Statistical Model

 I chose to generate a liner mixed effects model (lmer) with variables as follows:  
 Dependent variable: Population of winter wren (scalepop)  
 Independent variable: Year 1970-2010 (year)   
 Random effect: Location of winter wren populations within Canada (Location.of.population)  
 
 
 I initially wanted to use a poisson regression model, a generalized linear mixed model (glm) approach. However, as I noticed
 in the data preperation stage, my populations were not measured in whole integers. Rather they were in the form of a "Annual Index" which held numbers in up to 3 decimal points. 
 I could have transfromed my population data (by multiplying by a 1000 etc.), but I couldn't justify this transformation well enough. I didn't want to transfrom the dataset for
 the sake of using a poisson model (which only accepts integers) and risk manipulating the output without knowing how I was changing it. Therefore despite



## 6. Model Summary


## 7. Visualisations


## 7. Conclusions

In conlusion, populations of winter wrens do exhibit a clear upward trend from 1970-2010, thus confirming the hypothesis. 


## 8. Acknowledgments
LPI 2016. Living Planet Index database. 2016. < www.livingplanetindex.org/>. Downloaded on 12th November 2020”
Boreal Songbird Initiative (2020) Guide to Boreal Birds- Winter Wren (Troglodytes troglodytes)
Accessed: https://www.borealbirds.org/bird/winter-wren on 12th November 2020  
Audubon (2020) Guide to North American Birds 
Accessed: https://www.audubon.org/field-guide/bird/winter-wren on 12th November 2020



## 9. Appendix   

Initial data exploration to decide which model to use: 
![basic hist](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/basic_hist.png?raw=true)
![prelimplot](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/prelim_plot.png?raw=true)
![facet plot](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/Facet_plot.png?raw=true)


Visualization of model: 
![colourplot](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/colour_plot.png?raw=true)
![assumption1](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/Assumption_plot_1.png?raw=true)
![assumption2](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/Assumption_plot_2.png?raw=true)
![assumption3](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/assumption_plot_3.png?raw=true)
![assumption4](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/assumption_plot_4.png?raw=true)




Statistical analysis:
![modelfe](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/model_re.png?raw=true)
![modelre](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/model_fe.png?raw=true)
