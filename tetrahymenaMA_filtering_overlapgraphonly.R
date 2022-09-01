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

#reading it in as a dataframe instead of a CompressedVCF object 
df = as.data.frame(info(vcf))
df2=as.data.frame(rowRanges(vcf))
df3=as.data.frame((geno(vcf)$GT))
df4=as.data.frame((geno(vcf)$AD))
library(tibble)
df3 <- tibble::rownames_to_column(df3, "VALUE")

#currently vcf shows location and then genotype 
#input format needs to be a 0/1 binary for EACH genotype 
#I can do this by gluing the location and every possible genotype together 
#and turn it into a matrix if its 0/1 present/absent for each sample, for each possible genotype, for each location 
#MIC SAMPLES 
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

#converting to a 0/1 matrix 
set_matrix=list_to_matrix(lt)
qwerty=as.data.frame(set_matrix)
library(tibble)
qwerty <- tibble::rownames_to_column(qwerty, "VALUE")
library(dplyr)
library(tidyr)

#removing lines with a "./." genotype 
qwerty2=qwerty[!grepl("_./.", qwerty$VALUE),]

#create the upset plot for mic samples 
colnames(qwerty) = colnames(df3)[4:64]
UpSetR::upset(qwerty2,nsets=60,mb.ratio = c(0.30, 0.70), set_size.show = FALSE,    
              text.scale = c(1.3, 1.3, 1, 1, 2, 2))


#SAME THING FOR MAC SAMPLES NOW
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

#creating 0.1 matrix 
set_matrix=list_to_matrix(lt)
qwerty=as.data.frame(set_matrix)
library(tibble)
qwerty <- tibble::rownames_to_column(qwerty, "VALUE")
library(dplyr)
library(tidyr)

#remove "./." genotype lines 
#grep command had to be different for some godforsaken reason it wouldnt work the same as previously 
qwerty=qwerty[!grepl('\\.', qwerty$VALUE),]
colnames(qwerty) = c("VALUE","A12MA","C12MA","C3MA","D2MA","F6MA","F7MA","G10MA","G12MA",
                     "G7MA","G9MA","SB210E_1","SB210E_2")

#create upset plot for mac samples 
UpSetR::upset(qwerty,nsets=60,mb.ratio = c(0.30, 0.70), set_size.show = FALSE,    
              text.scale = c(1.3, 1.3, 1, 1, 2, 2))


####yes fine reeds way is a much more succient way of doing it 
library(tidyverse)

# fake data
dat <- tribble(~pos, ~A, ~B, ~C,
               1, "x", "x", "y",
               2, "x", "r", "y",
               3, "x", "y", "x"
)

# Convert dat into long format
# Add a column indicating that a pos-value-sample triplet was observed
# Convert the observed triplets to wide format and fill in missing values with 0.
tbl <- dat |> pivot_longer(-pos) |> 
        mutate(obs=1L) |>
        pivot_wider(names_from="name", values_from="obs", values_fill=0L)

