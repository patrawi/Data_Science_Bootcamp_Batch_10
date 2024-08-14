install.packages("dplyr")

install.packages('titanic')
library(dplyr)
library(titanic)
## Predicted Survive rate

titanic_train <- na.omit(titanic_train) ## We still don't know how to clean bro so let's delete it first

nrow(titanic_train)

## SPLIT DATA
set.seed(99)

sample(1:6, 1)

n <- nrow(titanic_train)
id <- sample(1:n , size = n*0.7)
train_data <- titanic_train[id, ]
test_data <- titanic_train[-id,]

model <- glm(Survived ~ Pclass + Age, data=  train_data, family ="binomial")
summary(model)
## Test Model

train_data$prob_survive <- predict(model, type = "response")
train_data$pred_survived <- ifelse(train_data$prob_survive >= 0.5, 1, 0)

## Accuracy

conM <- table(train_data$pred_survived, train_data$Survived, dnn = c("Predicted", "Actual"))

cat("Accuracy:", accuracy <- (conM[1,1] + conM[2,2]) / sum(conM))
cat("Precision", conM[2,2] / (conM[2,1] + conM[2,2]))

cat("Recall" , conM[2,2] / (conM[1,2] + conM[2,2]))

cat("F1:", 2 * (0.9*0.9) / (0.9+0.9))