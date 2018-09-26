#setwd("C:/Users/Install/Desktop/CASE_R_september")
load("BloodBrain.RData")
library(caret)
library(RANN)
####################################################################
#Remove near zero variance predictors
####################################################################
#One interesting aspect of this dataset is that it contains many variables 
#and many of these variables have extemely low variances

# Identify near zero variance predictors: remove_cols
remove_cols <- nearZeroVar(bloodbrain_x, names = TRUE, 
                           freqCut = 2, uniqueCut = 20)
# Get all column names from bloodbrain_x: all_cols
all_cols <- names(bloodbrain_x)
# Remove from data: bloodbrain_x_small
bloodbrain_x_small <- bloodbrain_x[ , setdiff(all_cols, remove_cols)]

####################################################################
#Fit model on reduced blood-brain data
####################################################################
# Fit model on reduced data: model
model <- train(x = bloodbrain_x_small, y = bloodbrain_y, method = "glm")

# Print model to console
model
#Result
model$results$RMSE
#RMSE 1.80

####################################################################
#Using PCA as an alternative to nearZeroVar()
####################################################################
#alternative to removing low-variance predictors is to run PCA on your dataset.
#preferable because it does not throw out all of your data
#This creates an ideal dataset for linear regression modeling,

# Fit glm model using PCA: model
model <- train(
  x = bloodbrain_x, y = bloodbrain_y,
  method = "glm", preProcess = "pca"
)

# Print model to console
model
