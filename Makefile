# Configuration file which holds messy variables
include config.mk

# Path to the macronuclear reference
MAC_REF=data/ref_genome/1-upd-Genome-assembly.fasta

# Setup paths
BAM_ALN_FILES=$(addsuffix .bam,$(BASENAMES_WITH_LANES))
BAM_ALN_FILES_MAC=$(addprefix data/bam_mac_aligned/bam_aln/,$(BAM_ALN_FILES))

bam_mac_aligned: $(BAM_ALN_FILES_MAC)

.PHONY: bam_mac_aligned

# Recreate the configuration file for this makefile
config.mk : metadata.tsv
	bash scripts/create_config.bash > $@

# Create a readgroups metadata file for use in alignment
readgroups.tsv : metadata.tsv
	cat $< | bash scripts/create_readgroups.bash  | cut -f 2- | uniq > $@

# Align fastq files to the mac refrence using bwa mem
data/bam_mac_aligned/bam_aln/%.bam: data/fastq/%_R1_001.fastq data/fastq/%_R2_001.fastq
	bash scripts/align_fastq.bash $(MAC_REF) $^ $@

data/bam_mac_aligned/bam_aln/%.bam: readgroups.tsv
