---
title: "About project"
---


## The purpose of this app
 
The customer churn or customer attrition refers to loss of customers or subscribers for any reason at all.
It occurs when customers or subscibers stop doing bussiness with company or service.
 
Customers in the telecom industry can choose from a variety of service providers and actively switch from one to the next. The telecommunications business has an annual churn rate of 15-25 percent in this highly competitive market.
 
Individualized customer retention is tough because most firms have a large number of customers and can't afford to devote much time to each of them. The costs would be too great, outweighing the additional revenue. However, if a corporation could forecast which customers are likely to leave ahead of time, it could focus customer retention efforts only on these "high risk" clients. The ultimate goal is to expand its coverage area and retrieve more customers loyalty. The core to succeed in this market lies in the customer itself.
 
Customer churn is a critical metric because it is much less expensive to retain existing customers than it is to acquire new customers.
 
To reduce customer churn, telecom companies need to predict which customers are at high risk of churn.
 
This app uses telco customer churn data and aims at:
 
1. Developing numerical and graphical summaries,
2. Applying machine learning models to predict churn on individual customer basis
3. Analising the performance of diiferent model types.
 
Through this interactive user friendly app, users can choose the variables of their interest, can check graphical and numerical summaries of given variables and run a user selected model with varoiables of interest to predict indivisual customer churn.


## Packages used


* library(shiny)
* library(tidyverse)
* library(kableExtra)
* library(DT)
* library(plotly)
* library(rpart)
* library(randomForest)
* library(caret)
* library(party)
* library(shinybusy)
* library(tree)


## Code to install Packages

```
installPackages <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg)) 
        install.packages(new.pkg, dependencies = TRUE)
    sapply(pkg, require, character.only = TRUE)
}

packages <- c("shiny", "tidyverse", "kableExtra", "DT", "plotly", "rpart","randomForest","caret","party","shinybusy","tree")
installPackages(packages)
```

## Code to run the project in GitHub


shiny::runGitHub('Finalproject', username = "Rashmi1979", ref = "main",
  subdir = NULL, port = NULL,
  launch.browser = getOption("shiny.launch.browser", interactive()))




