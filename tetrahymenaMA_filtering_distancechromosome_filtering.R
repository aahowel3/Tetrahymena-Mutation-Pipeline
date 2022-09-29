###actually filtering out the distance chromosomes part
setwd("C:/Users/Owner/OneDrive - Arizona State University/Documents/tetrahymena_mutationcalls/") 
library(VariantAnnotation)
#combine these two
vcf <- readVcf("tetrahymenaMA_all.dng.vcf", "hg19")
#need to read df3 back in to make snp name the rowname again
df = as.data.frame(info(vcf))
df2=as.data.frame(rowRanges(vcf))
total1 <- merge(df2,df, by="row.names")

ordered_df = total1[with(total1, order(seqnames, start)), ]

filtered_df = ordered_df %>% group_by(seqnames) %>%
  filter(((start - lag(start, default = 0)) > 200) & (abs((lead(start, default = 0) - start)) > 200))

#ok getting rid of the first one fir some reason
#what the hell chromosome 4?
chr4 = ordered_df %>% 
  filter(seqnames=="chr_004")


chr4 %>%
  filter(((start - lag(start, default = 0)) > 200) & (abs((lead(start, default = 0) - start)) > 200))


chr4 %>%
  filter(((chr4$start - lag(chr4$start, default = 0)) > 200) & (abs((lead(chr4$start, default = 0) - chr4$start)) > 200))

apply(
  
  
  outer(chr4$start,   chr4$start,   function(x, y) abs(x - y) < 200)) & diag(nrow(chr4)) == 0)))   



apply(outer(df$lat,   df$lat,   function(x, y) abs(x - y) <   1) &
        outer(df$lon,   df$lon,   function(x, y) abs(x - y) <   1) &
        outer(df$score, df$score, function(x, y) abs(x - y) < 0.7) &
        diag(nrow(df)) == 0, 
      MARGIN = 1,
      function(x) paste(df$ID[x], collapse = ", "))


chr4
sapply(chr4$Row.names, function(x){
  
  chr4 %>%
    filter(abs(start- start[Row.names == x]) > 1,
           Row.names != x) %>%
    pull(Row.names) %>%
    paste0(collapse = ',')
  
})


sapply(chr4$Row.names, function(x){
  
  chr4 %>%
    filter(abs(start- start[Row.names == x]) > 1,
           Row.names != x) 
  
})

#sloppy plot of filter criteria vs. variants called
# fake data
#should remove 300 and 320
#dat <- tribble(~pos, ~A, ~B, ~C,
#               1, "0", "x", "y",
#               2, "1", "r", "y",
#               3, "2", "y", "x",
#               4, "5", "y", "x",
#               5, "920", "y", "x",
#               6, "1000", "y", "x"
#)

#dat=as.data.frame(dat)
#dat$A=as.numeric(dat$A)



# fake data
#should remove 300 and 320
#dat <- tribble(~pos, ~A, ~B, ~C,
#               1, "300", "x", "y",
#               2, "320", "r", "y",
#               3, "600", "y", "x",
#               4, "900", "y", "x",
#               5, "920", "y", "x",
#               6, "1000", "y", "x"
#)
#dat=as.data.frame(dat)
#dat$A=as.numeric(dat$A)
#dat %>% 
#  filter(((A - lag(A, default = 0)) > 30) & (abs((lead(A, default = 0) - A)) > 30))


chr4$marker = apply(outer(chr4$start,   chr4$start,   function(x, y) abs(x - y) <  100) &
        diag(nrow(chr4)) == 0, 
      MARGIN = 1,
      function(x) paste(chr4$Row.names[x], collapse = ", "))
