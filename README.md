# ViolaRNA
ViolaRNA is an automated pipeline tool that processes raw RNA-seq data and generates violin plots of expression distribution profiles

### MIT License

![image](https://github.com/henrylowgh/ViolaRNA/assets/131828718/4f177166-8570-4585-89d4-f2fde73d5837)

# To use:

Obtain RNA-seq data. These can encompass your own sequenced data or open-access GEO data accession repositories. Data should be annotated according to histological characteristics. For instance, using the example of HGG cell samples obtained from rat xenograft models and patient biopsies, pre-process raw RNA-seq data files (example shown below) and annotate on the basis of histological markers associated with the models or patients from which the single cells had been acquired. 

![image](https://github.com/henrylowgh/ViolaRNA/assets/131828718/fcfa4ac7-2388-454c-a522-4babd231e839)

Ensuring values are normalized to be xpressed as transcripts per million (TPM), transform your data into vertically tabulated .csv or .tsv files, organized based on histology characteristic. For example, data can be organized acccording to IDH/H3K27M mutation status, based on clinical markers from sources (example shownbelow). Upon importing and running the program, violin plots of RNA-seq expression profiles will be generated.

![image](https://github.com/henrylowgh/ViolaRNA/assets/131828718/13f22f47-ac64-4e1b-8ee3-cbb73aa3bda2)

## Miscellaneous Notes on a Sample Workflow
(1)	NLGN3 and the GRIA genes were included to verify the accuracy of the R script used to generate these plots and for comparison to those used in the paper by Venkatesh et al. The plots that I produced in R for these genes were nearly identical in appearance to those found in the paper, which seemed to validate my code.  
(2)	TP53 was included as a reference, given its identity as a gene frequently associated with high expression in gliomas and other cancers.
(3)	DIPG-VI and DIPG-XIII refer to the two respective pediatric patients with diffuse intrinsic pontine glioma (DIPG) whose cells were used to produce the xenograft models.
(4)	This data was manually compiled from two separate biopsy tissue datasets (GSE102130 and GSE89567). The first dataset featured RNA-seq reads for H3K27M+ glioma cells as well as for H3K27M wild type, isocitrate dehydrogenase (IDH) wild type glioma cells. The second dataset featured RNA-seq reads for IDH-mutant glioma cells and for non-malignant oligodendrocyte cells.
(5)	Dataset 1 - H3K27M: This batch of data features manually annotated entries in the H3K27M+ dataset by linking individual patient cell entries with their corresponding tumor markers. In my final concatenated dataset, I included the RNA-seq reads for patients MUV1, MUV10, BCH836, BCH869, and BCH1126, who all tested positive for the H3K27M mutation. I also included patient MUV5, who was positive for a mutation in the related H1K27M gene. Meanwhile, patients MGH66, MGH101, and MGH104 tested negative for both the H3K27 and IDH mutations, so I designated them as the IDH-wild type cohort. 
(6)	IDH Dataset: Annotated and organized in a similar way to the H3K27M+ dataset. Patients MGH42, MGH43, MGH44, MGH45, MGH56, MGH61, MGH64, MGH103, and MGH107 all tested positive for the IDH mutation, so they are designed as the IDH-mutant cohort.
