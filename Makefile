# Configuration file which holds messy variables
include config.mk

#step 0 download and combine reference genomes
data/ref_genome/mac_mito.fasta:
	bash scripts/download_data.bash

#path to mac+mito ref
MAC_REF=data/ref_genome/mac_mito.fasta
DICT=data/ref_genome/mac_mito.dict

# Recreate the configuration file for this makefile
config.mk : metadata.tsv $(DICT)
	bash scripts/create_config.bash $^ > $@

# Create a readgroups metadata file for use in alignment
readgroups.tsv : metadata.tsv
	cat $< | bash scripts/create_readgroups.bash  | cut -f 2- | uniq > $@

#step 1
# Setup paths
BAM_ALN_FILES=$(addsuffix .bam,$(BASENAMES_WITH_LANES))
BAM_ALN_FILES_MAC=$(addprefix data/bam_mac_aligned/bam_aln/,$(BAM_ALN_FILES))

bam_mac_aligned: $(BAM_ALN_FILES_MAC)

.PHONY: bam_mac_aligned

# Align fastq files to the mac refrence using bwa mem
data/bam_mac_aligned/bam_aln/%.bam: data/fastq/%_R1_001.fastq data/fastq/%_R2_001.fastq
	bash scripts/align_fastq.bash $(MAC_REF) $^ $@

data/bam_mac_aligned/bam_aln/%.bam: readgroups.tsv

#step 2
BAM_FIXMATE_FILES=$(addprefix data/bam_mac_aligned/bam_fixmate/,$(BAM_ALN_FILES))
bam_mac_aligned_fixmate: $(BAM_FIXMATE_FILES)
.PHONY: bam_mac_aligned_fixmate

data/bam_mac_aligned/bam_fixmate/%.bam: data/bam_mac_aligned/bam_aln/%.bam
	bash scripts/fix_matepairs.bash $< $@

#step 3
BAM_MERGED=$(addsuffix .bam,$(BASENAMES))
BAM_MERGED_FILES=$(addprefix data/bam_mac_aligned/bam_merged/,$(BAM_MERGED))
bam_merged: $(BAM_MERGED_FILES)
.PHONY: bam_merged 

data/bam_mac_aligned/bam_merged/%.bam : data/bam_mac_aligned/bam_fixmate/%_L001.bam data/bam_mac_aligned/bam_fixmate/%_L002.bam data/bam_mac_aligned/bam_fixmate/%_L003.bam data/bam_mac_aligned/bam_fixmate/%_L004.bam
	bash scripts/merge_lanes.bash $@ $^


#step 4
BAM_DEDUP_FILES=$(addprefix data/bam_mac_aligned/bam_dedup/,$(BAM_MERGED))
BAM_DEDUP_MET=$(subst _.bam,_dedup_metrics.txt,$(BAM_DEDUP_FILES))

bam_mac_aligned_dedup: $(BAM_DEDUP_FILES) $(BAM_DEDUP_MET)
.PHONY: bam_mac_aligned_dedup

data/bam_mac_aligned/bam_dedup/%.bam data/bam_mac_aligned/bam_dedup/%_dedup_metrics.txt: data/bam_mac_aligned/bam_merged/%.bam 
	bash scripts/dedup.bash $^ $@


#step 4 continued
BAM_SORT_FILES=$(addprefix data/bam_mac_aligned/bam_sort/,$(BAM_MERGED))
bam_mac_aligned_dedup: $(BAM_SORT_FILES) 
.PHONY: bam_mac_aligned_sort

data/bam_mac_aligned/bam_sort/%.bam: data/bam_mac_aligned/bam_merged/%.bam        
	bash scripts/sort.bash $^ $@

#step 5 giant mic files by contig
CONTIG_CRAMS=$(addsuffix .cram,$(CONTIGS))
CONTIG_FILES=$(addprefix data/bam_mac_aligned/merged_contigs/,$(CONTIG_CRAMS))

merge_contigs_mic: $(CONFIG_FILE_FINAL)
.PHONY: merge_contigs_mic
data/bam_mac_aligned/merged_contigs/%.cram: $(BAM_SORT_FILES) 
	samtools merge -R $* --reference $(MAC_REF) --write-index -o $@ $^
    
#step 7
VCFS = $(notdir $(subst .bam,.vcf,$(CONFIG_FILE_FINAL)))
VCF_FILES=$(addprefix data/variant_calls/,$(VCFS))

vcf: $(VCF_FILES)
.PHONY: vcf
data/variant_calls/%.vcf: data/bam_mac_aligned/merged_contigs/%.bam
	bash scripts/haplotypecaller.bash $(MAC_REF) $^ $@



