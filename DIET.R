##Loading the data
library(readr)
multiTimeline <- read_csv("multiTimeline.csv")

#Convert the data to a dataframe
data <- as.data.frame(multiTimeline)

#Checking the structure , the dimension of the data and missing values
str(data)
dim(data)
sum(is.na(data))

#Checking the first 6 rows
head(data)

# Convert the "Week" column to a date format
data$Week <- as.Date(data$Week, format = "%m/%d/%Y")
class(data$Week)

#Descriptive statistics
library(psych)
desc_stats <- describe(data[, c(2, 3, 4)])
print(desc_stats)

# Explore relationships and trends with visualizations
# Line plot for Weight Loss over Weeks
ggplot(data, aes(x = Week, y = `weight loss: (United States)`, color = "Weight Loss")) +
  geom_line() +
  labs(title = "Weight Loss Over Weeks", x = "Week", y = "Weight Loss") +
  scale_color_manual(values = c("Weight Loss" = "blue")) 

#Line plot for the trend on diet
ggplot(data, aes(x = Week, y = `diet: (United States)`, color = "Diet")) +
  geom_line() +
  labs(title = "Diet Over the  Weeks", x = "Week", y = "Diet") +
  scale_color_manual(values = c("Diet" = "red")) 

#Line plot for the trend on  training
ggplot(data, aes(x = Week, y = `training: (United States)`, color = "Training")) +
  geom_line() +
  labs(title = "Training Over Weeks", x = "Week", y = "Training") +
  scale_color_manual(values = c("Training" = "green")) 

#Checking on the relationships
# Scatter plot for Diet vs. Training
ggplot(data, aes(x = `diet: (United States)`, y = `training: (United States)`)) +
  geom_point(color = "#0099f9") +
  labs(title = "Diet vs. Training", x = "Diet", y = "Training")

ggplot(data, aes(x = `diet: (United States)`, y = `weight loss: (United States)`)) +
  geom_point() +
  labs(title = "Diet vs. Weight loss", x = "Diet", y = "Weight Loss")

##Correlation analysis.
library(corrplot)
correlation_matrix <- cor(data[, c(2, 3, 4)])
print(correlation_matrix)

#Correlation plot
corrplot(correlation_matrix, method = "circle", type = "upper", order = "hclust", addCoef.col = "black", number.cex = 0.7)

#linear regression analysis.
# Perform linear regression for Weight Loss vs. Diet and Training
model1 <- lm(`weight loss: (United States)` ~ `diet: (United States)` + `training: (United States)`, data = data)
summary(model1)

