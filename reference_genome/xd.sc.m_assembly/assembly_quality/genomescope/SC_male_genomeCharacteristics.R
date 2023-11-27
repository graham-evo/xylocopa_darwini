# Graham C. McLaughlin
# Created: 11-6-2023
# Modified: 11-24-2-23
## ---------------------

library(ggplot2)

# Sequencing metrics:
hifi_reads <- read.csv("zmw_metrics.csv")
head(hifi_reads) 
dim(hifi_reads) # 1,802,366 total reads
hifi_reads <- subset(hifi_reads, read_qual >= 0.99 & num_passes >= 3)
dim(hifi_reads) # 1,085,872 reads that meet the quality threshold

mean(hifi_reads$read_length) # 10,640 mean read length
sd(hifi_reads$read_length) # +/- 5299.36 bps
max(hifi_reads$read_length) # max read length is 72,979 bp
min(hifi_reads$read_length) # min read length is 105 bp
dim(hifi_reads)

summary(hifi_reads$read_length) # confirming above calculations


## Estimation of Genome Characteristics Using K-mer Count Frequencies from Jellyfish-2.1.0
# Starting with a k-mer of length 19

k19mer_counts <- read.table("19mer_counts.histo")
colnames(k19mer_counts) <- c("k19","freq")

summary(k19mer_counts)
barplot(k19mer_counts$freq, xlim = c(1,100),ylim = c(0,5000000))

# Estimating genome size
error = 15
peak = 58
g_est <- round(sum(as.numeric(k19mer_counts[error:nrow(k19mer_counts),1]*k19mer_counts[error:nrow(k19mer_counts),2]))/peak, digits = 0)
g_est # 298.79 Megabases or 298 million base pairs

# Estimating Coverage
total_bp = 11500000000 # 11.5 Gigabases
cov <- round(total_bp/g_est, digits = 2)
cov

# Genome size estimation with k-mer of length 31:
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



k23mer_counts <- read.table("23mer_counts.histo")
k27mer_counts <- read.table("27mer_counts.histo")
k31mer_counts <- read.table("31mer_counts.histo")

colnames(kmer_counts) <- c("freq","k21")

summary(kmer_counts)
barplot(kmer_counts$k21, xlim = c(1,100),ylim = c(0,5000000))

# Estimating genome size
error = 16
peak = 58
g_est <- round(sum(as.numeric(kmer_counts[error:nrow(kmer_counts),1]*kmer_counts[error:nrow(kmer_counts),2]))/peak, digits = 0)
g_est # 298.79 Megabases or 298 million base pairs

# Estimating Coverage
total_bp = 11500000000 # 11.5 Gigabases
cov <- round(total_bp/g_est, digits = 2)
cov
