## ----setup, include = TRUE-----------------------------------------------
library(gammabuster)

## ----minmax.input, include = TRUE----------------------------------------
judgement1 <- GbusterMinMax(5, 10, .90)

## ----minmax.output, include = TRUE---------------------------------------
print(judgement1)

## ----plot, include = TRUE------------------------------------------------
x <- seq(2, 14, length=100)
hx <- dgamma(x, shape=14, rate=1.9)

plot(x, hx, type="l", lty=1, xlab="Value of X",
     ylab="Density", main="Gamma distribution with shape=14, rate=1.9", col="blue", lwd=3)

## ----mean.input, include = TRUE------------------------------------------
judgement2 <- GbusterMean(7.5, 4, pct=.90)

## ----mean.output, include = TRUE-----------------------------------------
print(judgement2)

## ----start, include = TRUE-----------------------------------------------
judgement2 <- GbusterMean(7.5, 4, pct=.99, start=c(20,3))

