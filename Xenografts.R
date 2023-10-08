library(ggplot2)

#gria2 = read.csv(file="GRIA2.csv", header=TRUE, sep=",")

datafile = file.choose()
filename = basename(datafile)
data = read.csv(datafile)

data[data < 1.00] = 1.00 #Replace values less than 1 in data frame with 1
#print(data)

require(scales)

# Create violin plot
violin <- ggplot(data, aes(x=Type, y=TPM, fill=Type)) + 
  geom_violin(scale = "width") + 
  scale_y_continuous(trans='log2', limits = c(1, 2^10), 
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



print(violin)

