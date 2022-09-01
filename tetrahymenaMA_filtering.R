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

df = as.data.frame(info(vcf))
df2=as.data.frame(rowRanges(vcf))
df3=as.data.frame((geno(vcf)$GT))

df4=as.data.frame((geno(vcf)$AD))


library(data.table)
out <- setcolorder(cbind(df3, df4), order(c(names(df3), names(df3))))[]

out=as.data.frame(out)
df <- apply(out,2,as.character)
df=as.data.frame(df)

write.table(df, "tetrahymena_example_set.csv", sep = "\t")

library(tibble)
df3 <- tibble::rownames_to_column(df3, "VALUE")
#df3$VALUE = NULL

set1 <- str_c(df3$VALUE,"_", df3$AncGE01A)
set2 <- str_c(df3$VALUE,"_", df3$AncGE01B)
set3 <- str_c(df3$VALUE,"_", df3$AncGE02A)
set4 <- str_c(df3$VALUE,"_", df3$AncGE02B)
set5 <- str_c(df3$VALUE,"_", df3$AncGE03A)
set6 <- str_c(df3$VALUE,"_", df3$AncGE03B)
set7 <- str_c(df3$VALUE,"_", df3$AncGE04A)
set8 <- str_c(df3$VALUE,"_", df3$AncGE04B)
set9 <- str_c(df3$VALUE,"_", df3$AncGE05A)
set10 <- str_c(df3$VALUE,"_", df3$AncGE05B)
set11 <- str_c(df3$VALUE,"_", df3$AncGE06A)
set12 <- str_c(df3$VALUE,"_", df3$AncGE06B)
set13 <- str_c(df3$VALUE,"_", df3$AncGE07A)
set14 <- str_c(df3$VALUE,"_", df3$AncGE07B)
set15 <- str_c(df3$VALUE,"_", df3$AncGE08A)
set16 <- str_c(df3$VALUE,"_", df3$AncGE08B)
set17 <- str_c(df3$VALUE,"_", df3$AncGE09A)
set18 <- str_c(df3$VALUE,"_", df3$AncGE09B)
set19 <- str_c(df3$VALUE,"_", df3$AncGE10A)
set20 <- str_c(df3$VALUE,"_", df3$AncGE10B)
set21 <- str_c(df3$VALUE,"_", df3$AncGE11A)
set22 <- str_c(df3$VALUE,"_", df3$AncGE11B)
set23 <- str_c(df3$VALUE,"_", df3$AncGE12A)
set24 <- str_c(df3$VALUE,"_", df3$AncGE12B)
set25 <- str_c(df3$VALUE,"_", df3$AncGE13A)
set26 <- str_c(df3$VALUE,"_", df3$AncGE13B)
set27 <- str_c(df3$VALUE,"_", df3$AncGE14A)
set28 <- str_c(df3$VALUE,"_", df3$AncGE14B)
set29 <- str_c(df3$VALUE,"_", df3$AncGE15A)
set30 <- str_c(df3$VALUE,"_", df3$AncGE15B)
set31 <- str_c(df3$VALUE,"_", df3$AncGE16A)
set32 <- str_c(df3$VALUE,"_", df3$AncGE16B)
set33 <- str_c(df3$VALUE,"_", df3$AncGE17A)
set34 <- str_c(df3$VALUE,"_", df3$AncGE17B)
set35 <- str_c(df3$VALUE,"_", df3$AncGE18A)
set36 <- str_c(df3$VALUE,"_", df3$AncGE18B)
set37 <- str_c(df3$VALUE,"_", df3$AncGE19A)
set38 <- str_c(df3$VALUE,"_", df3$AncGE19B)
set39 <- str_c(df3$VALUE,"_", df3$AncGE20A)
set40 <- str_c(df3$VALUE,"_", df3$AncGE20B)

set41 <- str_c(df3$VALUE,"_", df3$A12GE1)
set42 <- str_c(df3$VALUE,"_", df3$A12GE2)
set43 <- str_c(df3$VALUE,"_", df3$C12GE1)
set44 <- str_c(df3$VALUE,"_", df3$C12GE2)
set45 <- str_c(df3$VALUE,"_", df3$C3GE1)
set46 <- str_c(df3$VALUE,"_", df3$C3GE2)
set47 <- str_c(df3$VALUE,"_", df3$D2GE1)
set48 <- str_c(df3$VALUE,"_", df3$D2GE2)
set49 <- str_c(df3$VALUE,"_", df3$F6GE1)
set50 <- str_c(df3$VALUE,"_", df3$F6GE2)
set51 <- str_c(df3$VALUE,"_", df3$F7GE1)
set52 <- str_c(df3$VALUE,"_", df3$F7GE2)
set53 <- str_c(df3$VALUE,"_", df3$G10GE1)
set54 <- str_c(df3$VALUE,"_", df3$G10GE2)
set55 <- str_c(df3$VALUE,"_", df3$G12GE1)
set56 <- str_c(df3$VALUE,"_", df3$G12GE2)
set57 <- str_c(df3$VALUE,"_", df3$G7GE1)
set58 <- str_c(df3$VALUE,"_", df3$G7GE2)
set59 <- str_c(df3$VALUE,"_", df3$G9GE1)
set60 <- str_c(df3$VALUE,"_", df3$G9GE2)

lt=list(set1,set2,set3,set4,set5,set6,set7,set8,set9,set10,
        set11,set12,set13,set14,set15,set16,set17,set18,set19,set20,
set21,set22,set23,set24,set25,set26,set27,set28,set29,set30,
set31,set32,set33,set34,set35,set36,set37,set38,set39,set40,
set41,set42,set43,set44,set45,set46,set47,set48,set49,set50,
set51,set52,set53,set54,set55,set56,set57,set58,set59,set60)


set_matrix=list_to_matrix(lt)
qwerty=as.data.frame(set_matrix)
library(tibble)
qwerty <- tibble::rownames_to_column(qwerty, "VALUE")
library(dplyr)
library(tidyr)

qwerty2=qwerty[!grepl("_./.", qwerty$VALUE),]

colnames(qwerty) = colnames(df3)[4:64]
UpSetR::upset(qwerty2,nsets=60,mb.ratio = c(0.30, 0.70), set_size.show = FALSE,    
              text.scale = c(1.3, 1.3, 1, 1, 2, 2))




#HUH there may not be any GE variants that aren't a "./." call - hmmm lets look at mac maybe just combine them
set1 <- str_c(df3$VALUE,"_", df3$A12MA)
set2 <- str_c(df3$VALUE,"_", df3$C12MA)
set3 <- str_c(df3$VALUE,"_", df3$C3MA)
set4 <- str_c(df3$VALUE,"_", df3$D2MA)
set5 <- str_c(df3$VALUE,"_", df3$F6MA)
set6 <- str_c(df3$VALUE,"_", df3$F7MA)
set7 <- str_c(df3$VALUE,"_", df3$G10MA)
set8 <- str_c(df3$VALUE,"_", df3$G12MA)
set9 <- str_c(df3$VALUE,"_", df3$G7MA)
set10 <- str_c(df3$VALUE,"_", df3$G9MA)
set11 <- str_c(df3$VALUE,"_", df3$SB210E_1)
set12 <- str_c(df3$VALUE,"_", df3$SB210E_2)

lt=list(set1,set2,set3,set4,set5,set6,set7,set8,set9,set10,
        set11,set12)


set_matrix=list_to_matrix(lt)
qwerty=as.data.frame(set_matrix)
library(tibble)
qwerty <- tibble::rownames_to_column(qwerty, "VALUE")
library(dplyr)
library(tidyr)

qwerty=qwerty[!grepl('\\.', qwerty$VALUE),]

colnames(qwerty) = c("VALUE","A12MA","C12MA","C3MA","D2MA","F6MA","F7MA","G10MA","G12MA",
                     "G7MA","G9MA","SB210E_1","SB210E_2")


UpSetR::upset(qwerty,nsets=60,mb.ratio = c(0.30, 0.70), set_size.show = FALSE,    
              text.scale = c(1.3, 1.3, 1, 1, 2, 2))




######lets not use this package - cant specify mb.ratio impossible to visualize 
colnames(qwerty) = colnames(df3)[4:44]
interactions = colnames(qwerty)[2:41]
library(ComplexUpset)
library(ggplot2)
ComplexUpset::upset(
  qwerty,
  interactions,
  name='Variant Overlap',
  mb.ratio = c(0.20, 0.80),
  set_sizes=FALSE,
  base_annotations=list(
    'Intersection size'=intersection_size(
      counts=FALSE,
    )
  ),
  width_ratio=0.9 
)
##########################

#some other stuff to show - mutations by distance chromosome 
library(lattice)
#need to read df3 back in to make snp name the rowname again
df3=as.data.frame((geno(vcf)$GT))
total1 <- merge(df2,df3, by="row.names")

v <- as.numeric(total1$start[total1$AncGE01A != "./." & total1$AncGE01A != "0/0" ])
d1=as.data.frame(matrix(v))
d1$V2="AncGE01A"

v <- as.numeric(total1$start[total1$AncGE04A != "./." & total1$AncGE04A != "0/0" ])
d2=as.data.frame(matrix(v))
d2$V2="AncGE04A"

v <- as.numeric(total1$start[total1$SB210E_2 != "./." & total1$SB210E_2 != "0/0" ])
d3=as.data.frame(matrix(v))
d3$V2="SB210E_2"

v <- as.numeric(total1$start[total1$F6MA != "./." & total1$F6MA != "0/0" ])
d4=as.data.frame(matrix(v))
d4$V2="FGMA"

V6=rbind(d1,d2,d3,d4)
dotplot(V1~V2, data=V6)





#additional RD, MQ plots
library(vcfR)
vcf <- read.vcfR("chr_151_n1000.vcf", verbose = FALSE)

chrom <- create.chromR(name="Supercontig", vcf=vcf, verbose=TRUE)

plot(chrom)

chromoqc(chrom, dp.alpha = 66)


