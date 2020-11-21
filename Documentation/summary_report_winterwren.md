<p align="center"> ## Population trends of winter wren in Canada from 1970-2010 
<p align="center"> Nicole Yap s1761850@ed.ac.uk  
 <p align="center"> 17/11/2020
</p>

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

## Methods

The open-source data used in this report is available from the [Living Planet Index (LPI) Database](https://livingplanetindex.org/home/index) as of November, 2020. LPI indicates "the state of the world's biological diversity based on population trends of vertebrate species from different habitats and currently reflects a worrying overall trend (Living Planet Index, 2020) with the population sizes of mammals, birds, fish, amphibians and reptiles decreasing by 68% on average since 1970 (Living Planet Index 2020).  The survey methods varied among populations sampled, which influenced the survey units. To ensure consistency in units, I chose to work with the populations under a single survey method- Volunteer Survey of set routes during peak breeding season. As population data were not integer counts of individuals, a Poisson regression model could not be used. Despite considering manipulating  the data (to give integers), I decided to general a mixed effect linear model.  

I used a Frequentist  modelling framework in order to test my hypothesis- if winter wren population abundance increased over time. 

The hypotheses are as follows:   

​ Hypothesis: Winter wren population abundance increase over time

​ Null hypothesis: Winter wren populations do not increase over time i.e they decrease, or stay constant, or do not exhibit any clear trends.  

I included year as a fixed effect. I included the location of populations (different locations within Canada) as my random intercept as different locations within canada might either encourage or discourage  growth in  winter wren populations. 

I attempted to include locations of populations as my random slope as well, because specific locations may relatively important environmental, ecological differences that might affect the relationship between winter wren population abundance and time. However it returned the error below: 

'boundary (singular) fit: see ?isSingular'

which suggests that the model didn't converge and that we should be wary of these results. Due to the population already being scaled, I couldn't scale the population further to solve this error. 





## 7. Conclusions

In conlusion, populations of winter wrens do exhibit a clear upward trend from 1970-2010, thus confirming the hypothesis. 





## Appendix

Initial data exploration to decide which model to use: 
![basic hist](https://github.com/EdDataScienceEES/challenge-3-nicolelikesharks/blob/master/Output/basic_hist.png?raw=true)


# Acknowledgements
LPI 2016. Living Planet Index database. 2016. < www.livingplanetindex.org/>. Downloaded on 12th November 2020”
Boreal Songbird Initiative (2020) Guide to Boreal Birds- Winter Wren (Troglodytes troglodytes)
Accessed: https://www.borealbirds.org/bird/winter-wren on 12th November 2020  
Audubon (2020) Guide to North American Birds 
Accessed: https://www.audubon.org/field-guide/bird/winter-wren on 12th November 2020
https://climate.nasa.gov/evidence/
Britton, S (http://homeforaday.org/gallery/birds/songbirds/wrens/winter/winter_wren_1.html
https://onlinelibrary.wiley.com/doi/full/10.1111/j.1474-919X.2006.00648.x?saml_referrer
https://link.springer.com/article/10.1007/s10336-015-1229-y
https://www.researchgate.net/publication/276282045_Trophic_interaction_networks_and_ecosystem_services
