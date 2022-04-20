set -e

GATK=/usr/bin/gatk
GATK_ARGS=GenotypeGVCFs \
 -nt 5 \
 --disable_auto_index_creation_and_locking_when_reading_rods 
REF=../data/ref_genome/mac_mito.fasta

$GATK $GATK_ARGS -R $REF -V `find ../data/variant_calls/ -name *.vcf | xargs | sed 's/ / -V /g'` -o tetrahymena.gvcf.merged.vcf
