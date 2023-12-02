# Author: Graham C. McLaughlin
# Created: Dec 1 2023

## Visualizing BUSCO score from HiCanu HiFiasm and Verkko de novo genome assemblies of X. darwinii

library(ggplot2)
library(reshape2)
library(tidyverse)

busco_df <- read.csv("busco.csv",
                     header = TRUE)
head(busco_df)

# Organizing inported table
busco_df$Assembly <- as.factor(busco_df$Assembly)

busco_df <- melt(busco_df,
                 id.vars = "Assembly")
head(busco_df)
colnames(busco_df)[2] <- "Type"
busco_df$Type <- factor(busco_df$Type,
                           levels = c("Complete_single_copy",
                                     "Complete_duplicated",
                                     "Fragmented",
                                     "Missing"))
busco_df$Assembly <- factor(busco_df$Assembly,
                            levels = c("hicanu-assembly",
                                       "hifiasm-assembly",
                                       "verkko-assembly"),
                            labels = c("HiCanu",
                                       "HiFiasm",
                                       "Verkko"))

busco_plot <- ggplot(busco_df, aes(x=Assembly, fill= fct_rev(Type), y = value)) +
  geom_bar(position = "stack", width = 0.7, stat = "identity") +
  labs(x = "Assembly", y = "BUSCO", fill = "Type") +
  scale_y_continuous() +
  geom_hline(aes(yintercept = 5991*0.95),
             linetype = "dashed",
             linewidth = 0.4) +
  theme_bw()
