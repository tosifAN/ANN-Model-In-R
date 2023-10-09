#Building an ANN deep learning Model to predict the strength of the concrete.


#-------------------------------------------------------------------------------
#IMPORTING THE DATASET AND CHECKING IT
#-------------------------------------------------------------------------------

conc.df <- read.csv("concrete_data.csv")
head(conc.df)
tail(conc.df)
dim(conc.df)
summary(conc.df)
sum(is.na(conc.df))


#-------------------------------------------------------------------------------
#DATA VISUALIZATION
#-------------------------------------------------------------------------------

library(ggplot2)

plt.1 <- ggplot(data = conc.df) + geom_point(aes(x=strength, y=cement), color='red')
plt.1 + ggtitle("How cement contributes to the concrete strength?") + 
  xlab("Strength of the concrete") + ylab("Cement amount")

plt.2 <- ggplot(data = conc.df) + geom_point(aes(x=strength, y=slag), color='red')
plt.2 + ggtitle("How Slag contributes to the concrete strength?") + 
  xlab("Strength of the concrete") + ylab("Slag amount")

plt.3 <- ggplot(data = conc.df) + geom_point(aes(x=ash, y=slag), color='red')
plt.3 + ggtitle("How Ash contributes to the concrete strength?") + 
  xlab("Strength of the concrete") + ylab("Ash amount")

plt.4 <- ggplot(data = conc.df) + geom_point(aes(x=strength, y=water), color='red')
plt.4 + ggtitle("How water contributes to the concrete strength?") + 
  xlab("Strength of the concrete") + ylab("Water amount")

plt.5 <- ggplot(data = conc.df) + geom_point(aes(x=strength, y=superplastic), color='red')
plt.5 + ggtitle("How superplastic contributes to the concrete strength?") + 
  xlab("Strength of the concrete") + ylab("Superplastic amount")

plt.6 <- ggplot(data = conc.df) + geom_point(aes(x=strength, y=coarseagg), color='red')
plt.6 + ggtitle("How coarseagg contributes to the concrete strength?") + 
  xlab("Strength of the concrete") + ylab("coarseagg amount")

plt.7 <- ggplot(data = conc.df) + geom_point(aes(x=strength, y=fineagg), color='red')
plt.7 + ggtitle("How fineagg contributes to the concrete strength?") + 
  xlab("Strength of the concrete") + ylab("fineagg amount")

plt.8 <- ggplot(data = conc.df) + geom_point(aes(x=strength, y=age), color='red')
plt.8 + ggtitle("How Age contributes to the concrete strength?") + 
  xlab("Strength of the concrete") + ylab("Age")

#-------------------------------------------------------------------------------
#DATA PRE-PROCESSING & SPLITTING
#-------------------------------------------------------------------------------

#Pre-processing
#scaled.features <- function(x) { return((x - min(x)) / (max(x) - min(x))) }
scaled.features <- function(x) { return(x  / max(x)) }
conc.df.scaled <- as.data.frame(lapply(conc.df, scaled.features))
summary(conc.df.scaled$strength)

#Splitting the data set
conc.train.rows <- sample(rownames(conc.df.scaled), dim(conc.df.scaled)[1]*0.7)
conc.train.df <- conc.df.scaled[conc.train.rows, ]

conc.validate.rows <- sample(setdiff(rownames(conc.df.scaled), conc.train.rows))
conc.validate.df <- conc.df.scaled[conc.validate.rows, ]

dim(conc.train.df)
dim(conc.validate.df)

#-------------------------------------------------------------------------------
#CREATING A NEURAL NETWORK MODEL
#-------------------------------------------------------------------------------

#installing the packages and calling them
#install.packages("neuralnet")
library(neuralnet)

#--------
#MODEL 1
#--------

#creating the first neural network model with 3 hidden layers
deep.learning.model.1 <- neuralnet(strength ~ cement + 
                                     slag + ash + water + superplastic + coarseagg + fineagg + age, 
                                   data = conc.train.df, hidden = c(5,3,5))

#plotting the first model
plot(deep.learning.model.1)

#predicting the strength of the concrete
conc.strength.1 <- predict(deep.learning.model.1, conc.validate.df)

#evaluating the performance of the first model
model.1.results <- cor(conc.strength.1, conc.validate.df$strength)
print(model.1.results)

#--------
#MODEL 2
#--------

#creating the second neural network model with 5 hidden layers
deep.learning.model.2 <- neuralnet(strength ~ cement + 
                                     slag + ash + water + superplastic + coarseagg + fineagg + age, 
                                   data = conc.train.df, hidden = 5)

#plotting the second model
plot(deep.learning.model.2)

#predicting the strength of the concrete
conc.strength.2 <- predict(deep.learning.model.2, conc.validate.df)

#evaluating the performance of the second model
model.2.results <- cor(conc.strength.2, conc.validate.df$strength)
print(model.2.results)

