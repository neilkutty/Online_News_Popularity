# Online News Popularity
rm(list=ls())

onpdata <- read.csv('Final/OnlineNewsPopularity/OnlineNewsPopularity.csv')

library(dplyr)
library(stringr)
library(caret)

dataLite <- onpdata[,-1]

inTr <- createDataPartition(dataLite$shares, p=0.70, list=F)
train <- dataLite[inTr,]
test <- dataLite[-inTr,]
# 
# NAs <- array()
# for(i in 1:ncol(train)){
#     NAs[i] = sum(is.na(train[,i]))
# }

#There are no NA values

#Predict with Random Forest Classifier
set.seed(0123)

simple = lm(shares ~ ., data=train)


#Gradient Boosting
glm = train(shares ~ ., data = train, method = 'glm')

#Random Forest
control = trainControl(method = "repeatedcv", number=10, repeats=1)
forest = train(shares ~ ., data = train, method = 'rf', trControl = control)

