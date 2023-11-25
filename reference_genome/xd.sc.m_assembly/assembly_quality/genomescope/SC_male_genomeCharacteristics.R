# Graham C. McLaughlin
# Created: 11-6-2023
# Modified: 11-24-2-23
## ---------------------

library(ggplot2)

# Sequencing metrics:
hifi_reads <- read.csv("zmw_metrics.csv")
head(hifi_reads)
dim(hifi_reads)
hifi_reads <- subset(hifi_reads, hifi == 1 & num_passes > 1)
dim(hifi_reads)

mean(hifi_reads$read_length)
sd(hifi_reads$read_length)
max(hifi_reads$read_length)
min(hifi_reads$read_length)
dim(hifi_reads)


# Estimation of Genome Characteristics Using K-mer Count Frequencies from Jellyfish-2.1.0

kmer_counts <- read.table("kmer_counts.histo")
colnames(kmer_counts) <- c("freq","k21")

summary(kmer_counts)
barplot(kmer_counts$k21, xlim = c(1,100),ylim = c(0,5000000))

# Estimating genome size
error = 7
peak = 36
g_est <- round(sum(as.numeric(kmer_counts[error:nrow(kmer_counts),1]*kmer_counts[error:nrow(kmer_counts),2]))/peak, digits = 0)
g_est # 298.79 Megabases or 298 million base pairs

# Estimating Coverage
total_bp = 11500000000 # 11.5 Gigabases
cov <- round(total_bp/g_est, digits = 2)
cov
