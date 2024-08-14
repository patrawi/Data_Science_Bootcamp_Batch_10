## data visualization + markdown
library(tidyverse)

## ggplot2
## grammar of graphics - 2D
## hadley wickham
data(mtcars)
ggplot(data = mtcars,
       mapping = aes(x= mpg, y=hp)) +
  geom_point()





## ggplot2 cheat sheet - https://rstudio.github.io/cheatsheets/html/data-visualization.html
## discrete vs. continuous

### discrete
## 1,2,3,4,5 or "M", "F" or "high", "med", "low"

## continuous (measurement)

## quiz
## heart rate  - discrete -> 1,2,3,4,5, 120, 150
## internet data - continuous -> (10mb , 10.234554645 GB)

## character
gender <- c(rep("M", 10), 
            rep ("F", 8))
## factor
## categorical data
gender_factor <- factor(gender, labels = c("M", "F"),
                        levels = c("M", "F"))

## table() will count frequency in factor 


animals <- c("cat", "dog", "hippo", "cat")
animals <- factor(animals)


## ordinal data : 
## temperature : low < medium < high
## spending: low < medium < high

spending <- c("low", "high", "med", "med", "high")

spending <- factor(spending, 
                   level= c("low", "med", "high"), 
                   labels = c("low", "med", "high"), 
                   ordered =  TRUE)


## factor => 1. categorical data 2. ordinal data

## one variable - continuous

ggplot(mtcars, aes(mpg)) +
  geom_histogram(bins = 5, fill = "red", binwidth = 5, color = "black" )


base <- ggplot(mtcars, aes(mpg))
base <- geom_area(stat = "bin")
base + geom_density()


  ggplot(data =  mtcars %>%
           select(hp, wt, am) %>%
           mutate(am = ifelse(am==0, "Auto", "Manual")),aes(am)) +
  geom_bar()
  
  
  mtcars %>%
    select(hp, wt, am) %>%
    mutate(am = ifelse(am==0, "Auto", "Manual")) %>%
    count(am)
  
  
## two variables, both continuous
  base <- ggplot(data = mtcars,
                 mapping = aes(hp, mpg))
  
  
base + 
  geom_point() + 
  geom_smooth(method = "lm") +
  geom_rug()


## setting vs. Mapping

## Setting
base + 
  geom_point(col = "red", 
             size=5, 
             alpha = 0.5,
             shape = 8)

## Mapping
base + 
  geom_point(
    mapping = aes(col = factor(am))
  )


base +
  geom_point(mapping = aes(col = wt))

## explore data with chart
set.seed(9)

small_df <- diamonds %>% 
  sample_frac(0.1) %>% filter(cut %in% c("Fair", "Good", "Very Good"))
ggplot(small_df, aes(carat, price)) + 
  geom_point(alpha = 0.1, color = "blue") + 
  theme_minimal()


base2 <- ggplot(small_df %>% filter(carat <= 2.5), aes(carat, price)) + geom_point(size = 3, alpha = 0.5) +
  geom_smooth(se = FALSE)
  theme_minimal()
base3 <- ggplot(data =small_df %>%
                   filter(carat <= 2.5),
                 mapping =aes(carat, price)) +
  geom_point(size = 3, alpha = 0.2) + 
  geom_smooth(se = FALSE, col = "red") +
  theme_minimal()
## facet, sub-plot 

### facet-wrap - create multiple sub-plot
base2 + 
  facet_wrap(~clarity, ncol = 2)

base2 + 
  facet_wrap(~color)

base2 + 
  facet_grid(color ~ cut)


ggplot(data = small_df %>% filter(carat <= 2.8))

base3 +
  labs(title = "Correlation is very Strong",
       subtitle = "Correlatin is 0.85",
       caption = "Source: ggplot package",
       x = "Diamond Carat",
       y = "Price $ USD")


## change color manual
df <- data.frame(
  id = 1:5,
  fruit = c(rep("orange", 3), rep("bananan", 2)),
  price = c(20, 25,21,24,30),
  weight = c(5,4,4,7,10)
)

### if variable is discrete use manual
ggplot(df, aes(weight, price, color = fruit)) +
  geom_point() +
  scale_color_manual(values = c("gold", "blue"))

## if variable is continuous use gradient
ggplot(df, aes(weight, price, color = price)) +
  geom_point(size = 3) +
  theme_minimal() +
  scale_color_gradient(low = "gold", high = "red")


## final tips - multiples data frame in one chart
df1 <- df %>%
  filter(weight < 7) 

df2 <- df %>%
  filter(weight >= 7)

ggplot() +
  theme_minimal() +
  geom_point(data = df1, mapping = aes(weight, price), color = "salmon", size =3)  +
  geom_point(data = df2, mapping = aes(weight, price), color = "gold", size =3) 
  