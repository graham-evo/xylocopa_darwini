# Author: Graham McLaughlin
# Date Created: 12-02-2023
# Date Modified: 12-02-2023

# Estimating Genome Size Using Raw Read-to-Assembly Mapping Approach
# References:
#- <https://doi.org/10.1111/1755-0998.13570>
#- <https://doi.org/10.1093/gbe/evx032>
#- <https://github.com/schellt/backmap/blob/master/README.md>

library(fitdistrplus)
library(truncdist)
library(splitstackshape)
library(tidyverse)

cov.freq <- read.table("cov.txt")
colnames(cov.freq) <- c("contig", "freq", "coverage")

head(cov.freq)
tail(cov.freq)
summary(cov.freq$coverage)

plot(cov.freq$coverage, cov.freq$freq, type = "l")

ggplot(cov.freq, aes(x=coverage)) +
  geom_histogram(binwidth = 0.5, alpha=0.5,
                 position="dodge",
                 color="gold3") +
  theme_bw()

#transform Qualimap output to R-object
#define function for mode
mode <- function(cov.freq) {uniqv <- unique(cov.freq) uniqv[which.max(tabulate(match(cov.freq, uniqv)))]}
min <- mode – 5
max <- mode + 5
dtruncated_poisson <- function(x, lambda) {dtrunc(x, "pois", a=min, b=max, lambda=lambda)}
ptruncated_poisson <- function(q, lambda) {ptrunc(q, "pois", a=min, b=max, lambda=lambda)}
fitdist(obj, "pois", start = list(lambda = mode))


  
plot(x[,1],x[,2],
log=\"x\",type=\"l\",xlab=\"Coverage\",
ylab=\"Count\",main=\"$assembly\\n$tech\")\n