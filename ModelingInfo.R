library(shiny)

fluidPage(
  
  withMathJax(),
  h4("Generalised linear models:"),
  tags$div("Generalised linear models are used when assumptions for standard linear models such as normality and constant variance are violated
or when the reponses come from non normal distributions. Logistic Reression, Poisson Regression, Negative Binomial Regression, Multiple Linear 
         Regression all come in the GLM framework."),
  helpText('The logit function (log ({P}{1-P})) is called the link function.It links the mean (recall p = average number of 
successes at a given x) to the linear form of the mode.l Generally, we can look at a link function g where'),
  helpText('g(mu)=beta0+beta1x1+beta2x2+...+betapxp where mu is the mean for the set of x values used'),
  tags$b('Advantages'),
  tags$div("1.Allows for responses from non-normal distributions, 2.Can have both types of predictors"),
  tags$b('Disadvantage'),
  tags$div("The logistic regression model doesn't have a closed form solution (maximum likelihood often used to fit parameters"),
  h4("Classification trees:"),
  tags$div("It is a tree based method:Split up predictor space into regions, different predictions for each region"),
  tags$div("Classification tree is used if the goal is to classify (predict) group membership
  For a given region, usually most prevalent class is used as prediction"),
  tags$div("Usually Gini index or entropy/deviance used"),
  tags$div("For a binary response, within a given node (p = P(correct classification))"),
  helpText('Gini:2p(1-p)
  Deviance: -2plog(p-2(1-p)log(1-p)'),
  tags$div("Both will be small if p is near 0 or 1 (i.e. node classifies well)"),
  tags$b("Advantages:"),
  tags$div("1. Simple to understand and easy to interpret output, 2. Predictors don't need to be scaled, 
  3. No statistical assumptions necessary 4. Built in variable selection"),
  tags$b("Disadvantages:"),
  tags$div("1. Small changes in data can vastly change tree 2. Greedy algorithm necessary (no optimal algorithm), 
  3. Need to prune (usually)"),
  h4("Random Forest:"),
  tags$div("It uses same idea as bagging(bootstrap aggregation). Creates multiple trees from bootstrap samples and averages the results thus decreasing the variance over individual tree fit."),
  tags$b("Different from bagging:"),
  tags$div("Doesn't use all predictors!Instead  RF method uses a random subset of predictors for each bootstrap sample/tree fit"),
  tags$b("Advantages:"),
  tags$div("Better than bagging.If a strong predictor is present every bootstrap tree will probably use it for the first split.This makes bagged trees highly correlated 
  By randomly selecting a subset of predictors, a good predictor or two won't dominate the tree fits"),
  tags$div("Different from bagging:"),
  tags$b("Disadvantages:"),
  tags$div("1. Random forest models are not all that interpretable. 2. For very large data sets, the size of the trees can take up a lot of memory."),
  
  
  


  
  
  
  
)
