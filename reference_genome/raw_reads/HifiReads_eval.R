# Author: Graham C. McLaughlin
# Date Created: November 30th 2023
# Date Modified: November 30th 2023

library(ggplot2)
library(dplyr)
library(cowplot) 

## Estimating read length estimates from Arizona Genomics Insitute Hifi Reads after processing
##with ccs software and parsing to a .csv file with bioawk

read_length_df <- read.csv("KimKim_length.csv") # Read in bioawk parsed read lengths
colnames(read_length_df) <- c("PacBio_HiFi","length") # Change column names
head(read_length_df) # check for correction

# Calculate the average read-length:

# Using Dplyr
summary_df <- read_length_df %>%
  summarise(grp.mean=mean(length),
            grp.median=median(length),
            grp.max=max(length))

# or base R
mean(read_length_df$length)

# Draw a read-length distribution plot for all reads:
total.length.plot <- ggplot(read_length_df,
                            aes(x=length)) +
  geom_histogram(binwidth=100,
                 alpha=0.5,
                 position="dodge",
                 color="gold3") +
  geom_vline(data=summary_df,
             aes(xintercept=grp.mean),
             linetype="dashed",
             size =0.4) +
  geom_vline(data=summary_df,
             aes(xintercept=grp.median),
             linetype="dashed",
             size =0.4) +
  geom_vline(data=summary_df,
             aes(xintercept=grp.max),
             linetype="dashed",
             size =0.4) +
  scale_x_continuous(limits = c(0, max(read_length_df$length)),
                     breaks = seq(0, max(read_length_df$length),10000)) +
  scale_y_continuous(limits = c(0, 13000),
                     breaks = seq(0, 13000, 2000)) +
  labs(x="Read Length (bp)",
       y= "Frequency of Reads") +
  theme_bw() 
  
kb.length.plot <- ggplot(read_length_df,
                              aes(x=length)) +
    geom_histogram(binwidth=50,
                   alpha=0.5,
                   position="dodge",
                   color = "gold3") +
    geom_vline(data=summary_df,
               aes(xintercept=grp.mean),
               linetype="dashed",
               size =0.4) +
    geom_vline(data=summary_df,
               aes(xintercept=grp.median),
               linetype="dashed",
               size =0.4) +
    geom_vline(data=summary_df,
               aes(xintercept=grp.max),
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
plot <- plot_grid(total.length.plot, kb.length.plot, ncol = 1) # Save the figure using the file name, ‘‘read.length.pdf’’ pdf("read.length.pdf",width=6,height=8,paper=’special’) print(plot)
