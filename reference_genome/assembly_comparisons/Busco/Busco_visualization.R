# Author: Graham C. McLaughlin
# Created: Dec 1 2023

## Visualizing BUSCO score from HiCanu HiFiasm and Verkko de novo genome assemblies of X. darwinii

library(ggplot2)
library(ggbreak)
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
colnames(busco_df)[2] <- "Ortholog"

busco_df <- busco_df %>%
  group_by(Assembly) %>%
  mutate(busco_sum = sum(value),
         busco_percent = (value/busco_sum)*100)

busco_df$Ortholog <- factor(busco_df$Ortholog,
                           levels = c("Complete_single_copy",
                                     "Complete_duplicated",
                                     "Fragmented",
                                     "Missing"), 
                        labels = c("Complete\nSingle\nCopy",
                                       "Complete\nDuplicated",
                                       "Fragmented",
                                       "Missing"))
busco_df$Assembly <- factor(busco_df$Assembly,
                            levels = c("hicanu-assembly",
                                       "hifiasm-assembly",
                                       "verkko-assembly"),
                            labels = c("HiCanu",
                                       "HiFiasm",
                                       "Verkko"))

busco_plot <- ggplot(busco_df, aes(x=Assembly, fill= fct_rev(Ortholog), y = busco_percent)) +
  geom_bar(position = "stack", width = 0.7, stat = "identity", color = "black") +
  labs(x = "Assembly", y = "Presence of Universal\nSingle Copy Ortholog (%)", fill = "Ortholog") +
  scale_fill_manual(values = c("red3","yellow2","orange","gold3"))+
  geom_hline(aes(yintercept = 95),
             linetype = "dashed",
             linewidth = 0.4) +
  scale_y_break(c(0,70), scales = "fixed", ticklabels = c(0,70,75,80,85,90,95,100)) +
  coord_flip() +
  theme_bw() +
  theme(legend.position = "top",
        axis.text = element_text(color = "black"),
        axis.title = element_text(face = "bold"))
