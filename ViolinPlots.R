library(ggplot2)

#gria2 = read.csv(file="GRIA2.csv", header=TRUE, sep=",")

datafile = file.choose()
filename = basename(datafile)
data = read.csv(datafile)

data[data < 1.00] = 1.00 #Replace values less than 1 in data frame with 1
#print(data)

require(scales)

violin = ggplot(data, aes(x=Type, y=TPM, fill=Type)) + geom_violin(scale = "width") + #scale_x_discrete() +
  scale_y_continuous(trans='log2', limits = c(1,2^16), breaks = trans_breaks("log2", function(x) 2^x),
    labels = trans_format("log2", math_format(2^.x))) + ggtitle(paste(filename, "Violin Plots", sep=" ")) + 
        xlab("Genes") + ylab("TPM (Transcripts Per Million)") + labs(fill = "Sample") + geom_boxplot(width=0.5)
            #+ facet_wrap(~ Gene) 

print(violin)
