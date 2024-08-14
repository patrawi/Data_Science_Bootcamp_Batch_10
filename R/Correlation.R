## Correlation
cor(mtcars$mpg, mtcars$hp)
cor(mtcars$hp, mtcars$mpg)
cor(mtcars$wt, mtcars$mpg)

plot(mtcars$hp, mtcars$mpg, pch = 16)

cor(mtcars[, c("mpg", "wt", "hp")])


## dplyr (tidyverse)
library(dplyr)
corMat <- mtcars %>%
  select(mpg,wt,hp) %>%
  cor()

cor(mtcars$hp, mtcars$mpg)

## how to test correlation
cor.test(mtcars$hp, mtcars$mpg)
## Linear Regression
## mpg = f(hp)
lmFit <- lm(mpg ~ hp,data = mtcars)

summary(lmFit)

lmFit$coefficients[[1]] + lmFit$coefficients[[2]] * 200

new_cars <- data.frame(
  hp = c(250,320, 400, 410, 450)
)

## predict()
new_cars$hp_pred <- NULL
new_cars$mpg_pred <-predict(lmFit, newdata = new_cars)

summary(mtcars$hp)


## mpg = f(hp,wt,am)

## mpg = intercept + b0*hp + b1*wt + b2*am

lmFit_v2 <- lm(mpg ~ hp + wt + am, data = mtcars)

coefs <- coef(lmFit_v2)

coefs[[1]] + coefs[[2]] * 200 + coefs[[3]] * 3.5 + coefs[[4]] * 1

## Build Full Model
lmFit_Full <- lm(mpg ~. , data =mtcars)

lmFit_Full <- lm(mpg ~. -gear, data =mtcars)
## Root Mean Squared Error (rmse)
## Multiple linear regression

mtcars$predicted <- predict(lmFit_Full)

squared_error <- (mtcars$mpg -mtcars$predicted) ** 2

rmse <- sqrt(mean(squared_error))

## Split
set.seed(42)
n <- nrow(mtcars)

id <- sample(1:n, size = n*0.8)

train_data <- mtcars[id, ]
test_data <- mtcars[-id, ] ## reason we use -id becase we filter out data used in train

## Train Model
model1 <- lm(mpg ~ hp + wt, data = train_data)
p_train <- predict(model1)
rnse <- sqrt(mean((train_data$mpg - p_train)**2))
## Test Model

p_test <- predict(model1, newdata = test_data)
error_test <- test_data$mpg - p_test
(rmse_test <- sqrt(mean(error_test**2)))

## Print Result
cat("RMSE TRAIN:", rnse)
cat("\nRMSE TEST:", rmse_test)



## Logistic Regression
library(dplyr)
mtcars %>% head

str(mtcars)

mtcars$am <- factor(mtcars$am, levels = c(0,1), labels = c("Auto", "Manual"))
class(mtcars$am)
table(mtcars$am)


## split data
set.seed(42)
n <- nrow(mtcars)
id <- sample(1:n, size = n *0.7)
train_data <- mtcars[id,]
test_data <- mtcars[-id, ]

## train model
logit_model <- glm(am ~ mpg, data = train_data, family = "binomial") ## family = binomial to set it to predict 2 value data
p_train <- predict(logit_model, type = "response") ## response

train_data$pred <- if_else(p_train >= 0.5, "Manual", "Auto")

train_data$am == train_data$pred
mean(train_data$am == train_data$pred)

p_test <- predict(logit_model,newdata = test_data, type = "response") ## response

test_data$pred <- if_else(p_test >= 0.5, "Manual", "Auto")

(mean(test_data$am == test_data$pred))
## Due to knowing only the 335 as max,if we pass higher hp it will change in linear, and fail to predict