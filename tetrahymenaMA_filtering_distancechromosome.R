setwd("C:/Users/Owner/OneDrive - Arizona State University/Documents/")
library(VariantAnnotation)
library(biomaRt)
library(dplyr)
library(tidyr)
library(tidyverse)
library(UpSetR)
library(ComplexHeatmap)

#combine these two
vcf <- readVcf("chr_151_n1000.vcf", "hg19")
library(lattice)
#need to read df3 back in to make snp name the rowname again
df2=as.data.frame(rowRanges(vcf))
df3=as.data.frame((geno(vcf)$GT))
total1 <- merge(df2,df3, by="row.names")

library(plyr)
raceyearfunction<-function(x)
{
  v <- as.numeric(total1$start[x != "./." & x != "0/0" ])
  d1=as.data.frame(matrix(v))
 # d1$V2=colnames(total1)
  return(d1)
}
#rownamesto coulmn - remove .# after
#data<-lapply(total1[c("AncGE01A", "AncGE04A")], raceyearfunction)
data<-lapply(total1[,12:83], raceyearfunction)
df <- do.call("rbind", data)
df <- tibble::rownames_to_column(df, "VALUE")
df$VALUE=gsub("\\..*","",df$VALUE)
dotplot(V1~VALUE, data=df, scales=list(y=list(rot=45), x=list(rot=45)))


