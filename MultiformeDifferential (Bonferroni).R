library(ggplot2)
require(scales)
require(gridExtra)

# Prompt user to select a data file
datafile <- file.choose()
filename <- basename(datafile)
data <- read.csv(datafile)

# Replace values less than 1 in the TPM column with 1 for better log-scale visualization
data$TPM[data$TPM < 1.00] = 1.00 

# Compare each of the first three groups to 'Oligo'
groups <- c("H2K37M", "IDH-Mut", "IDH-WT")

# Identify the range for the Oligo group
oligo_min <- min(data[data$Type == "Oligo", "TPM"])
oligo_max <- max(data[data$Type == "Oligo", "TPM"])

# Identify the range for the IDH-Mut group
idh_mut_min <- min(data[data$Type == "IDH-Mut", "TPM"])
idh_mut_max <- max(data[data$Type == "IDH-Mut", "TPM"])

# Rescale the IDH-Mut values to match the range of the Oligo group
data$TPM[data$Type == "IDH-Mut"] <- ((data$TPM[data$Type == "IDH-Mut"] - idh_mut_min) / 
                                       (idh_mut_max - idh_mut_min)) * (oligo_max - oligo_min) + oligo_min

# # Determine significance label based on p-value (w/ Bonferroni)
# get_significance_label <- function(p_value) {
#   if (p_value > bonferroni_threshold) {
#     return("ns")
#   } else if (p_value <= bonferroni_threshold && p_value > bonferroni_threshold/10) {
#     return("*")
#   } else if (p_value <= bonferroni_threshold/10 && p_value > bonferroni_threshold/100) {
#     return("**")
#   } else if (p_value <= bonferroni_threshold/100) {
#     return("***")
#   } else {
#     return("")
#   }
# }

# Determine significance label based on p-value
get_significance_label <- function(p_value) {
  if (p_value > 0.05) {
    return("ns")
  } else if (p_value <= 0.05 && p_value > 0.01) {
    return("*")
  } else if (p_value <= 0.01 && p_value > 0.001) {
    return("**")
  } else if (p_value <= 0.001) {
    return("***")
  } else {
    return("")
  }
}

# # Initialize matrix to store p-values for each gene and group
# p_value_matrix <- matrix(nrow=length(unique(data$Gene)), ncol=length(groups))
# rownames(p_value_matrix) <- unique(data$Gene)
# colnames(p_value_matrix) <- groups
#
# # Loop over each gene and calculate p-values
# for (gene in unique(data$Gene)) {
#   gene_data <- subset(data, Gene == gene)
#
#   for (group in groups) {
#     group_data <- gene_data[gene_data$Type == group, "TPM"]
#     wilcox_test <- wilcox.test(group_data, gene_data[gene_data$Type == "Oligo", "TPM"])
#     p_value_matrix[gene, group] <- wilcox_test$p.value
#   }
# }

# # Print the matrix of p-values
# print(p_value_matrix)



# Number of genes being tested
num_genes <- length(unique(data$Gene))
# Total number of tests (each gene is tested against three groups)
total_tests <- num_genes * 3
# Bonferroni-corrected significance threshold
bonferroni_threshold <- 0.05 / total_tests


# Create a data frame to store label positions and text for each gene and group
label_data <- data.frame(
  Gene = rep(unique(data$Gene), each=length(groups)),
  Type = rep(groups, times=length(unique(data$Gene))),
  TPM = NA,
  Label = character(length(groups) * length(unique(data$Gene)))
)

# Calculate positions and labels for the new data frame
for (gene_name in unique(data$Gene)) {
  for (group_name in groups) {
    # Get the p_value for the current gene and group from the matrix
    p_value <- p_value_matrix[gene_name, group_name]
    sig_label <- get_significance_label(p_value)
    print(cat(gene_name, group_name, p_value))

    # Calculate the y position for the label
    y_position <- max(data[data$Type == group_name & data$Gene == gene_name, "TPM"]) * 1.1

    label_data$TPM[label_data$Gene == gene_name & label_data$Type == group_name] <- y_position
    label_data$Label[label_data$Gene == gene_name & label_data$Type == group_name] <- sig_label
  }
}


# Create violin plot
violin <- ggplot(data, aes(x=Type, y=TPM, fill=Type)) + 
  geom_violin(scale = "width") + 
  scale_y_continuous(trans='log2', limits = c(1, 2^12), 
                     breaks = trans_breaks("log2", function(x) 2^x),
                     labels = trans_format("log2", math_format(2^.x))) + 
  ggtitle("Violin Plots for BAI Family and Other Genes") + 
  theme(plot.title = element_text(size = 20, hjust = 0.5)) +
  xlab("Genes") + 
  ylab("TPM (Transcripts Per Million)") + 
  labs(fill = "Glioma Subclass \n(& Oligodendrocytes)") + 
  #geom_text(data = label_data, aes(y = TPM, label = Label), hjust = 0.5, vjust = -0.5, size=8) + #adds significance labels
  facet_wrap(~ Gene, ncol = 4) + theme(
    plot.title = element_text(hjust = 0.5, size=38), 
    axis.title.x = element_text(size=28),            
    axis.title.y = element_text(size=28),            
    axis.text.x = element_text(size=18),             
    axis.text.y = element_text(size=18),             
    legend.title = element_text(size=26),
    legend.text = element_text(size=20),
    strip.text = element_text(size=28)
  )
  

# Print the violin plot
print(violin)
