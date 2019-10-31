### Instructions for Challenge 3 - Statistical Modelling

Time to delve into statistical modelling to answer a research question in our data science course. 

In the statistical modelling challenge you are individual consultants hired by the WWF to put together a report on the population trends of a species from the Living Planet Database (http://www.livingplanetindex.org/home/index).  

The models assignment involves five components:

1. Choosing a species and indicating which species you choose in the issue thread. Each student must choose a DIFFERENT species.

2. Design the research question(s), hypotheses and predictions to test the change in abundance over time for your species. Fill out a study pre-registration before you begin working with the data.

2. Build and interpret a simple linear model (a pre-requisite for the components that follow).

3. Build and interpret a mixed effects model (all the work associated with it - code, graphs, interpretation, see below for the specific marking criteria).

4. Build and interpret a Bayesian linear model (all the work associated with it - code, graphs, interpretation, see below for the specific marking criteria).

5. Provide a summary report for all of your work including questions, hypotheses, predictions, statistical models, statistical summaries, figures of the data and the statistical models fit including predictions of the model and error and summarise all content in one markdown file in your challenge repository.

__We will provide formative feedback on your work when agreed in class (likely the Monday before the due date). If you have not started your work by then, we will not be able to give you formative feedback.__

__Marking criteria:__

- __Challenge: Clear evidence of work on three types of models a linear model, linear mixed model and a Bayesian linear model. Well-formatted and easy to interpret tables of model outputs for each model. Appropriate model visualisations for each model. (25%).__ Your repository should include report that contains all your work on the challenge. It should be a `Markdown` file that includes all your code for the three types of models, text to explain your modelling decisions, the graphs and tables. The table(s) should be generated with code. Think about what's an appropriate number of digits to show, specifying what type of variables are included in the models, etc. There are a few different `R` packages out there that help you visualise model summaries, so you should look into those and not make the tables or figures "by hand". The tables should not be "static", e.g., the numbers should not be hard coded. Every time you rerun a Bayesian model, the results will be slightly different and you should use the model `R` object to generate the table automatically, not e.g., making an object called `table` and assigning `table <- as.data.frame(c(0.005, 0.023, 0.567, etc.))`. Your `Markdown` document should include as least one graph for each model - the graphs should include the raw data points and the model predictions. Make sure you know what the model predictions are and how to plot them - there is a lot of information on plotting model predictions online and in the Coding Club tutorials, so check that out. For the mixed effects models, you can also look into visualising the fixed and random effects, again explore online the different packages for visualising mixed effects models (as discussed in class).

- __Creativity: Creative content and formatting of your challenge elements (25%).__ Demonstrate creative data visualisation and use of the data to communicate the trends in your species. Include additional content such as photographs and nice formatting of figures, tables and text and creative formatting to communicate to your audience the WWF. Creativity and efficiency in the code is also encouraged.

- __Reproducibility: Clear, logical and critical explanation of your workflows, statistical reporting and results (25%).__ Your repository and final summary report (markdown file) should include the research question, the hypotheses, predictions and explanations of the types of variables you'll test. You are encouraged to include a summary of existing information about the species and a few references in your report. Use your ecological expertise and outline why you are making your specific predictions. You should demonstrate critical thinking at all stages of your work - for example include why the linear model is or is not sufficient, why a Bayesian approach might be better, why the results might differ between the various modelling approaches you'll use. No model is perfect, there are always compromises, and we want to see evidence of that critical thinking. You should include a pre-registration document that you fill out before working with the data (see markdown template file in the preregistration folder).

- __Participation: Evidence of consistent work on the challenge, issue participation, discussion of problems, providing solutions, sharing useful information (25%).__ - The idea behind this challenge is to work on the assignment consistently throughout building on what you are learning in the different coding club tutorials. Like with previous challenges, communicate with your peers from the beginning and throughout the challenge, don't wait till a few days before the deadline to make the issue and participate in it - we want to see you discussing your work consistently through out the challenge with your peers, which will help to make everyone's work better.

#### Bonuses

__If you are keen, we have a couple of non-compulsory elements to this challenge that can be a way for you to elevate your marks on the above assessment criteria.__

- Describe in your `Markdown` document why (or why not if you decide to argue a different path) a Bayesian hierarchical model would be the best approach to use.

- Include any or all of the code, results, summary model outputs, model visualisations and interpretation for a Bayesian hierarchical model.

__As an extra bonus, anyone who provides a functioning model (hierarchical or not) written in the modelling language Stan gets their very own Stan sticker!!!__

As with all challenges, we expect nicely organised repositories with appropriate folders, files and structure.

__Useful links:__
- https://ourcodingclub.github.io/2017/02/28/modelling.html - Intro to linear models
- https://ourcodingclub.github.io/2018/04/06/model-design.html - Intro to model design
- https://ourcodingclub.github.io/2017/03/15/mixed-models.html - Intro to mixed effects models
https://ourcodingclub.github.io/2017/03/29/data-vis-2.html - Data visualisation (including plotting mixed effects)
- https://ourcodingclub.github.io/2018/01/22/mcmcglmm.html - Intro to Bayesian statistics
- https://ourcodingclub.github.io/2018/04/30/stan-2.html - Generalised linear models in Stan
- https://ourcodingclub.github.io/2018/04/17/stan-intro.html - Intro to Stan
- https://cran.r-project.org/web/packages/lme4/vignettes/lmer.pdf  - lme4 vignette
- https://cran.r-project.org/web/packages/MCMCglmm/vignettes/CourseNotes.pdf - MCMCglmm course notes
- https://github.com/paul-buerkner/brms - brms package resources (scroll down to the README.md file)
- http://mc-stan.org/ - the Stan website
