# Author: Graham C. McLaughlin
# Date Created: November 30th 2023
# Date Modified: January 5th 2023

library(ggplot2)
library(dplyr)
library(cowplot) 
library(egg) 

## Estimating read length estimates from Arizona Genomics Insitute Hifi Reads after preprocessing
#with ccs software and parsing to a .csv file with bioawk

read_length_df <- read.csv(here::here("reference_genome/raw_reads/KimKim_length.csv")) # Read in bioawk parsed read lengths
colnames(read_length_df) <- c("PacBio_HiFi","length") # Change column names
head(read_length_df) # check for correction
dim(read_length_df)

## ---- read-stats ----
summary_df <- read_length_df %>%
  summarise(Mean.Length= mean(length),
            Median.Length= median(length),
            Max.Length= max(length),
            Num.Reads = length(read_length_df$length),
            Num.Bases = sum(length))
summary_df

## ---- Plotting ----
# Draw a read-length distribution plot for all reads:
total.length.plot <- ggplot(read_length_df,
                            aes(x=length)) +
  geom_histogram(binwidth=100,
                 position="dodge",
                 fill="gold3") +
  geom_vline(data=summary_df,
             aes(xintercept=Mean.Length),
             linetype="solid",
             size =0.4) +
  geom_vline(data=summary_df,
             aes(xintercept=Median.Length),
             linetype="dashed",
             size =0.4) +
  geom_vline(data=summary_df,
             aes(xintercept=Max.Length),
             linetype="dashed",
             size =0.4) +
  scale_x_continuous(limits = c(0, max(read_length_df$length)),
                     breaks = seq(0, max(read_length_df$length),10000)) +
  scale_y_continuous(limits = c(0, 13000),
                     breaks = seq(0, 13000, 2000)) +
  labs(x="Read Length (bp)",
       y= "Frequency of Reads") +
  theme_bw() 

zoomed.length.plot <- ggplot(read_length_df,
                            aes(x=length)) +
  geom_histogram(binwidth=100,
                 position="dodge",
                 fill="gold3") +
  geom_vline(data=summary_df,
             aes(xintercept=Mean.Length),
             linetype="solid",
             size =0.4) +
  geom_vline(data=summary_df,
             aes(xintercept=Median.Length),
             linetype="dashed",
             size =0.4) +
  geom_vline(data=summary_df,
             aes(xintercept=Max.Length),
             linetype="dashed",
             size =0.4) +
  scale_x_continuous(limits = c(0, 20000),
                     breaks = seq(0, max(read_length_df$length),2500)) +
  scale_y_continuous(limits = c(0, 13000),
                     breaks = seq(0, 13000, 2000)) +
  labs(x="Read Length (bp)",
       y= "Frequency of Reads") +
  theme_bw()
  
# Merge both the read-length distribution plots 
## ---- read_length_plot ----
plot <- plot_grid(total.length.plot, zoomed.length.plot, ncol = 1) # Save the figure using the file name, ‘‘read.length.pdf’’ pdf("read.length.pdf",width=6,height=8,paper=’special’) print(plot)
ggarrange(total.length.plot,
          zoomed.length.plot
            )

## ---- read-quality-metrics ----
# Sequencing metrics:
hifi_reads <- read.csv(here::here("reference_genome/raw_reads/zmw_metrics.csv"))
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

summary(hifi_reads$read_qual)

ggplot(hifi_reads, aes(x=read_qual)) +
  geom_histogram(position="dodge",
                 fill="gold3") +
  labs(x = "Quality Score (%)", y = "Number of Reads") +
  theme_bw()

ggplot(hifi_reads, aes(x=num_passes)) +
  geom_histogram(position="dodge",
                 fill="gold3") +
  labs(x = "Number of Passes", y = "Number of Reads") +
  theme_bw()



