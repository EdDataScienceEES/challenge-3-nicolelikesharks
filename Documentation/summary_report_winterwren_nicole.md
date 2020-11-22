<h2 align="center"> Population trends of winter wren in Canada from 1970-2010 </h2>
<h3 align="center"> Nicole Yap s1761850@ed.ac.uk  </h3>
 <p align="center"> 17/11/2020 </p>

## Summary

Winter wrens (Troglodytes troglodytes) are an important part of the ecosystem, as they support higher trophic levels.  The winter wren is an elusive, secretive species, behaving much like a mouse by creeping through the tangle of branches covering the forest floor.(The Cornell Lab, 2019). Masters of hide and seek, the winter wren also hides its nest well, in the cavities of dead trees or under creek banks making them rather hard to find (The Cornell Lab, 2019). Being a weak flier, this bird prefers to hop and explore coniferous forest understories, examining upturned roots for invertebrates, their main food source (The Cornell Lab, 2019). The song of the winter wren is particularly breathtaking; when played at quarterspeed, an amazing blend of halftones and overtones is revealed, all sung simultaneously (Boreal Songbird Initiative, 2020).

This report assesses the population trends of winter wren populations in Canada over 1970-2010 through the use and analysis of a Frequentist framework. The results from my study reflect the growth of winter wren populations 


<p align="center">
  <img width="460" height="300" src="https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Documentation/Images/winterwren_image.jpg?raw=true">
</p>

<p align="center">
  Figure 1: Winter wrens provide regulating and supporting services through their insectivorous foraging ecology (Whelan et al., 2015). They are also a food source for larger predators, and help maintain the integrity of trophic networks and ecosystem functions (Whelan et al., 2016).  Photo by Suzanne Britton 
</p>

## Research design

The main research question driving this report is:  
"What trend do populations of winter wrens exhibit in Canada over the years 1970-2010?"

As winter wrens are small, insectivorous birds, extended periods of low temperature have especially adverse effects on their survival compared to other bird species (Robinson et al., 2007). Thus, due to the the particular vulnerability of winter wrens to winter weather effects, they have been considered indicators of climate change (Robinson et al., 2007). 

Therefore, given that the most warming has occurred in the past 4 decades years (NASA, 2020), I predict that winter wren population abundance will increase over time. 

## Methods:

The open-source data used in this report is available from the [Living Planet Index (LPI) Database](https://livingplanetindex.org/home/index) as of November, 2020. LPI indicates "the state of the world's biological diversity based on population trends of vertebrate species from different habitats and currently reflects a worrying overall trend (Living Planet Index, 2020) with the population sizes of mammals, birds, fish, amphibians and reptiles decreasing by 68% on average since 1970 (Living Planet Index 2020).  The survey methods varied among populations sampled, which influenced the survey units. To ensure consistency in units, I chose to work with the populations under a single survey method- Volunteer Survey of set routes during peak breeding season. 

I used a Frequentist  modelling framework in order to test my hypothesis- if winter wren population abundance increased over time. A hierarchical linear mixed effects model was used.

The hypotheses are as follows:   

​ Hypothesis: Winter wren population abundance increases over time

​ Null hypothesis: Winter wren populations do not increase over time i.e they decrease, or stay constant, or do not exhibit any clear trends.  

I included `year` as a fixed effect. I included the `location.of.population` (different locations within Canada) as my random intercept because different locations within canada might either encourage or discourage  growth in  winter wren populations due to their unique set of features (e.g one location could have higher abundance of insect prey, thus being beneficial for winter wrens and increasing their population).  

The code for the model including `location.of.population` as the random intercept is as follows: 

`mixed.lmer <- lmer(scalepop ~ year + (1|Location.of.population), data = LPI_wren_cad) `

The full code can be accessed [here](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/script/winterwren_model_script_nicole.R). 


## Limitations:  

As population data were not integer counts of individuals, a Poisson regression model could not be used. Despite considering manipulating the data (multiplying by a 1000 to give integers), I decided to use a mixed effect linear model.  

I attempted to include locations of populations as my random slope as well, because specific locations may relatively important environmental, ecological differences that might affect the relationship between winter wren population abundance and time.

The code for the model including both random intercept and random slope is as follows: 

`mixed.re.rs <- lmer(scalepop ~ year + (1 + year|Location.of.population), data = LPI_wren_cad)`

However it returned the error below: 

`boundary (singular) fit: see ?isSingular`

which suggests that the model didn't converge and that we should be wary of results generated (that took in account both the random intercept and random slope). Due to the population already being scaled, I couldn't scale the population further to solve this error and make model converge.

In addition, since I filtered my data down to a single unit and sampling method, my results may not accurately reflect the overall trend of winter wren populations over time. 

## Results and conclusions

![prediction plot](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/prediction_plot.png)  
Figure 2: Winter wren populations have increased over time from 1970-2010 in Canada. (Slope= 0.017, see Figure 3 for full model outputs). The points are raw data colour coded based on the location of populations. The narrow grey shaded band around the line represents the area in which the predicted trend could fall given the standard error, and suggests a good fit.   

![table](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/table.png)  
Figure 3:Analysing summary from the model of population trends of winter wrens. The estimate for `year` shows us that winter wren population abundance is increasing at a rate of 0.018 each year.  


In conlusion, populations of winter wrens do exhibit a clear upward trend from 1970-2010, thus confirming the hypothesis. The null hypothesis is hence rejected. On the surface, the fact that winter wrens populations are not declining like many other species as indicated in the [LPI report](https://livingplanetindex.org/home/index) could be deemed as a good thing. However, the increasing trend of winter wren populations may indicate and reflect a larger, more pressing issue- that of global climate change.  In addition, the extreme, unprecedented increase (or decrease) in the population of any species would disrupt the delicate balance in the ecosystem and the relationships within them. Insect pest populations may also rise as a result of the increased number of birds feeding on predaceous insects and parasitoids (Whelan et al., 2015). It is thus important to note that our individual reports on individual species should not be looked at in isolation. Given the complex interactions between trophic levels and species within an ecosystem, more research must be done to examine these links to come to a more holistic understanding for future conservation planning. Perhaps a follow up report could model the effect of winter wren populations on keystone insects. 


## Appendix

![basic hist](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/basic_hist.png?raw=true)  
Figure 3: Winter wren distribution is right-skewed, and should follow a Poisson distribution.

![boxplot 2](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/boxplot.png)    
Figure 4: Assesssing/ comparing the medians and spread of groups (locations).  The median weights of winter wren populations look different for each location and the weights of some groups are more variable than others. Looks like there is something going on!

![facet prediction plot ri](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/Pred_facet_plot_ri.png)  
Figure 5: Visualizing fitted prediction lines (in each location) for model allowing for random intercept. 

![facet prediction plot rs](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/Pred_facet_plot_rs.png)
Figure 6: Visualizing fitted prediction lines (in each location) for model allowing for random slope as well as intercept

![model random effect](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/model_re.png)  Figure 7: Showing how the relationship between population and year vary according to different levels of our random effect (location of populations).

![model fix effect](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/model_fe.png)  
Figure 8: Showing the relationship between year (fixed effect) and population. Slope is 0.02. 



# Acknowledgements  
Audubon (2020) Guide to North American Birds   
Accessed: https://www.audubon.org/field-guide/bird/winter-wren on 12 Nov 2020
  

Boreal Songbird Initiative (2020) Guide to Boreal Birds- Winter Wren (Troglodytes troglodytes)  
Accessed: https://www.borealbirds.org/bird/winter-wren on 12 Nov 2020  

Britton, S (n.d) 
Accessed: http://homeforaday.org/gallery/birds/songbirds/wrens/winter/winter_wren_1.html  on 12 Nov 2020

LPI (2016) Living Planet Index database 2016. 
Accessed: < www.livingplanetindex.org/>   on 10 Nov 2020 

NASA (2020) Climate Change: How do we know?
Accessed: https://climate.nasa.gov/evidence/ on 10 Nov 2020  

Robinson, R.A et al., (2007) Weather‐dependent survival: implications of climate change for passerine population processes, IBIS, Vol 149, Issue 2, pp357-364  
Accessed: https://onlinelibrary.wiley.com/doi/full/10.1111/j.1474-919X.2006.00648.x?saml_referrer on 12 Nov 2020  

Whelan, C.J et al., (2015) Why birds matter: from economic ornithology to ecosystem services, Journal of Ornithology, Vol 156 pp227-238  
Accessed: https://link.springer.com/article/10.1007/s10336-015-1229-y on 12 Nov 2020  

Whelan, C.J et al., (2016) Trophic interaction networks and ecosystem services
https://www.researchgate.net/publication/276282045_Trophic_interaction_networks_and_ecosystem_services


