# ViolaRNA
ViolaRNA is an automated pipeline tool that processes raw RNA-seq data and generates violin plots of expression distribution profiles

<a href="https://zenodo.org/badge/latestdoi/634778015"><img src="https://zenodo.org/badge/634778015.svg" alt="DOI"></a>

### MIT License


![Official Plot](https://github.com/henrylowgh/ViolaRNA/assets/131828718/b753e3d3-3c69-404e-b89a-82a73f91348f)
![Official Plots](https://github.com/henrylowgh/ViolaRNA/assets/131828718/2d183778-1f36-425e-85fc-56fc0de30f9c)



# To use:

Obtain RNA-seq data. These can encompass your own sequenced data or open-access GEO data accession repositories. Data should be annotated according to histological characteristics. For instance, using the example of HGG cell samples obtained from rat xenograft models and patient biopsies, pre-process raw RNA-seq data files (example shown below) and annotate on the basis of histological markers associated with the models or patients from which the single cells had been acquired. 

![image](https://github.com/henrylowgh/ViolaRNA/assets/131828718/fcfa4ac7-2388-454c-a522-4babd231e839)

Ensuring values are normalized to be xpressed as transcripts per million (TPM), transform your data into vertically tabulated .csv or .tsv files, organized based on histology characteristic. For example, data can be organized acccording to IDH/H3K27M mutation status, based on clinical markers from sources (example shownbelow). Upon importing and running the program, violin plots of RNA-seq expression profiles will be generated.

![image](https://github.com/henrylowgh/ViolaRNA/assets/131828718/13f22f47-ac64-4e1b-8ee3-cbb73aa3bda2)

## Miscellaneous Notes on a Sample Workflow
(1)	NLGN3 and the GRIA genes were included for validation purposes.
(2)	TP53 was included as a reference, given its identity as a gene frequently associated with high expression in gliomas and other cancers.
(3)	DIPG-VI and DIPG-XIII refer to the two respective sources of diffuse intrinsic pontine glioma (DIPG) used in xenograft models.
(4)	This data was manually compiled from two separate biopsy tissue datasets (GSE102130 and GSE89567). The first dataset featured RNA-seq reads for H3K27M+ glioma cells as well as for H3K27M wild type, isocitrate dehydrogenase (IDH) wild type glioma cells. The second dataset featured RNA-seq reads for IDH-mutant glioma cells and for non-malignant oligodendrocyte cells.
(5)	Dataset 1 - H3K27M: This batch of data features manually annotated entries in the H3K27M+ dataset by linking individual patient cell entries with their corresponding tumor markers. In my final concatenated dataset, Includes the RNA-seq reads for  MUV1, MUV10, BCH836, BCH869, and BCH1126, which all tested positive for the H3K27M mutation, along with MUV5, which was positive for a mutation in the related H1K27M gene. Meanwhile, MGH66, MGH101, and MGH104 tested negative for both the H3K27 and IDH mutations, designated as the IDH-wild type cohort. 
(6)	IDH Dataset: Annotated and organized in a similar way to the H3K27M+ dataset. MGH42, MGH43, MGH44, MGH45, MGH56, MGH61, MGH64, MGH103, and MGH107 all tested positive for the IDH mutation, designed as the IDH-mutant cohort.

## References
(1)	Venkatesh, Humsa S et al. “Electrical and synaptic integration of glioma into neural circuits.” Nature vol. 573,7775 (2019): 539-545. 
(2)	Filbin, Mariella G et al. “Developmental and oncogenic programs in H3K27M gliomas dissected by single-cell RNA-seq.” Science (New York, N.Y.) vol. 360,6386 (2018): 331-335.
(3)	Venteicher, Andrew S et al. “Decoupling genetics, lineages, and microenvironment in IDH-mutant gliomas by single-cell RNA-seq.” Science (New York, N.Y.) vol. 355,6332 (2017).
