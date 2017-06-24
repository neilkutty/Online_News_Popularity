# Online News Popularity
rm(list=ls())

onpdata <- read.csv('OnlineNewsPopularity/OnlineNewsPopularity.csv')
library(stringr)
library(caret)
library(randomForest)
library(ggplot2)
library(dplyr)

dataLite <- onpdata[,-1]
#  dataLite <- as.data.frame(scale(dataLite))

inTr <- createDataPartition(dataLite$shares, p=0.70, list=F)
train <- dataLite[inTr,]
test <- dataLite[-inTr,]
# 
# NAs <- array()
# for(i in 1:ncol(train)){
#     NAs[i] = sum(is.na(train[,i]))
# }

#There are no NA values

set.seed(0123)

simple = lm(shares ~ ., data=train)

#Random Forest
forest = randomForest(shares ~ ., data=train, ntree=50, importance = T)
forest

forestResult = predict(forest, test)
varImp(forest)
