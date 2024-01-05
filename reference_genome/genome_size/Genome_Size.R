# Author: Graham McLaughlin
# Date Created: 12-02-2023
# Date Modified: 01-05-2023

# Estimating Genome Size Using A variety of Approaches
# References:
#- <https://doi.org/10.1111/1755-0998.13570>
#- <https://doi.org/10.1093/gbe/evx032>
#- <https://github.com/schellt/backmap/blob/master/README.md>

## ---- Coverage ----
library(tidyverse)

cov.freq <- read.table(here::here("reference_genome/assembly_comparisons/coverage/cov.txt"), header = TRUE)
colnames(cov.freq) <- c("contig", "freq", "coverage")

head(cov.freq)
tail(cov.freq)
summary(cov.freq$coverage)

ggplot(cov.freq, aes(x=coverage)) +
  geom_histogram(binwidth = 0.5, alpha=0.5,
                 position="dodge",
                 color="gold3") +
  labs(x = "Coverage", y = "Number of Bases") +
  theme_bw()

## ---- basic-method ----
avg_cov = 53.47
avg_length = 10640.6
num_reads = 1071017
gen_size = (avg_length*num_reads)/avg_cov
gen_size

## ---- 19mer-counting-method ----
## Estimation of Genome Characteristics Using K-mer Count Frequencies from Jellyfish-2.1.0
# Starting with a k-mer of length 19

k19mer_counts <- read.table(here::here("reference_genome/genome_size/k-mer_counts/19mer_counts.histo"))
colnames(k19mer_counts) <- c("k19","freq")

summary(k19mer_counts)
#barplot(k19mer_counts$freq, xlim = c(1,100),ylim = c(0,5000000))
plot(k19mer_counts[5:200,], type="l",
     xlab = "K-mers of length 19",
     ylab = "Frequency")
# Estimating genome size
error = 14
peak = 57
g_est <- round(sum(as.numeric(k19mer_counts[error:nrow(k19mer_counts),1]*k19mer_counts[error:nrow(k19mer_counts),2]))/peak, digits = 0)
g_est

# Estimating Coverage
total_bp = 11500000000 # 11.5 Gigabases
cov <- round(total_bp/g_est, digits = 2)
cov

## ---- 31mer-counting-method ----
k31mer_counts <- read.table("31mer_counts.histo")
colnames(k31mer_counts) <- c("k31","freq")

summary(k31mer_counts)
barplot(k31mer_counts$freq, xlim = c(1,100),ylim = c(0,5000000))

# Estimating genome size
error = 14
peak = 57
g_est <- round(sum(as.numeric(k31mer_counts[error:nrow(k31mer_counts),1]*k31mer_counts[error:nrow(k31mer_counts),2]))/peak, digits = 0)
g_est # 298.79 Megabases or 298 million base pairs

# Estimating Coverage
total_bp = 11500000000 # 11.5 Gigabases
cov <- round(total_bp/g_est, digits = 2)
cov

## ---- backmapping-method ----
error = 16
peak = 58
g_est <- round(sum(as.numeric(kmer_counts[error:nrow(kmer_counts),1]*kmer_counts[error:nrow(kmer_counts),2]))/peak, digits = 0)
g_est # 298.79 Megabases or 298 million base pairs

# Estimating Coverage
total_bp = 11500000000 # 11.5 Gigabases
cov <- round(total_bp/g_est, digits = 2)
cov

library(fitdistrplus)
library(truncdist)
library(splitstackshape)

cov.freq <- expandRows(cov.freq$freq)
obj <- as.vector(cov.freq$freq)
#transform Qualimap output to R-object
#define function for mode
mode <- function(obj) {uniqv <- unique(obj)
  uniqv[which.max(tabulate(match(obj, uniqv)))]}
uniqv <- unique(obj)
mode <- uniqv[which.max(tabulate(match(obj, uniqv)))]
min <- 2 - 5
max <- 2 + 5
dtruncated_poisson <- function(x, lambda) {dtrunc(x, "pois", a=min, b=max, lambda=lambda)}
ptruncated_poisson <- function(q, lambda) {ptrunc(q, "pois", a=min, b=max, lambda=lambda)}
fitdist(obj, "pois", start = c(lambda = mode))
fitdist(obj, "truncated_poisson", start = c(-3,7))
