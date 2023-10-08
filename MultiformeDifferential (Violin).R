library(ggplot2)
require(scales)
require(gridExtra)

# Prompt user to select a data file
datafile <- file.choose()
filename <- basename(datafile)
data <- read.csv(datafile)

# Replace values less than 1 in the TPM column with 1 for better log-scale visualization
data$TPM[data$TPM < 1.00] = 1.00 

# Identify the range for the Oligo group
oligo_min <- min(data[data$Type == "Oligo", "TPM"])
oligo_max <- max(data[data$Type == "Oligo", "TPM"])

# Identify the range for the IDH-Mut group
idh_mut_min <- min(data[data$Type == "IDH-Mut", "TPM"])
idh_mut_max <- max(data[data$Type == "IDH-Mut", "TPM"])

# Rescale the IDH-Mut values to match the range of the Oligo group
data$TPM[data$Type == "IDH-Mut"] <- ((data$TPM[data$Type == "IDH-Mut"] - idh_mut_min) / 
                                       (idh_mut_max - idh_mut_min)) * (oligo_max - oligo_min) + oligo_min

# Create violin plot
violin <- ggplot(data, aes(x=Type, y=TPM, fill=Type)) + 
  geom_violin(scale = "width") + 
  scale_y_continuous(trans='log2', limits = c(1, 2^12), 
                     breaks = trans_breaks("log2", function(x) 2^x),
                     labels = trans_format("log2", math_format(2^.x))) + 
  ggtitle("Violin Plots for BAI Family and Other Genes") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Genes") + 
  ylab("TPM (Transcripts Per Million)") + 
  labs(fill = "Sample") + 
  facet_wrap(~ Gene, ncol = 4)
  facet_grid(. ~ Type, scales = "free_y") 

# Calculate the median TPM value of the Oligo group
oligo_median <- median(data[data$Type == "Oligo", "TPM"])

# Number of genes being tested
num_genes <- length(unique(data$Gene))
# Total number of tests (each gene is tested against three groups)
total_tests <- num_genes * 3
# Bonferroni-corrected significance threshold
bonferroni_threshold <- 0.05 / total_tests

# Compare each of the first three groups to 'Oligo'
groups <- c("H2K37M", "IDH-Mut", "IDH-WT")
p_values <- sapply(groups, function(group) {
  group_data <- data[data$Type == group, "TPM"]
  wilcox_test <- wilcox.test(group_data, oligo_data)
  return(wilcox_test$p.value)
})
names(p_values) <- groups

# Annotate the plot with the significance and fold change labels
for (i in 1:length(groups)) {
  group_name <- groups[i]
  p_value <- p_values[group_name]
  sig_label <- get_significance_label(p_value)
  
  # Set y position for the labels based on the maximum TPM value for the group and add a buffer
  y_position <- max(data[data$Type == group_name, "TPM"]) * 1.1
   
  violin <- violin # + 
    #annotate("text", x = group_name, y = y_position, label = sig_label, hjust = 0.5, vjust = 0, size=4)
}

# Print the violin plot
print(violin)
