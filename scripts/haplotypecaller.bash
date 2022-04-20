set -e 

GATK=/usr/bin/gatk
GATK_ARGS=HaplotypeCaller \
 --genotyping_mode DISCOVERY \
 -A AlleleBalanceBySample \
 -A DepthPerAlleleBySample \
 -A DepthPerSampleHC \
 -A InbreedingCoeff \
 -A MappingQualityZeroBySample \
 -A StrandBiasBySample \
 -A Coverage \
 -A FisherStrand \
 -A HaplotypeScore \
 -A MappingQualityRankSumTest \
 -A MappingQualityZero \
 -A QualByDepth \
 -A RMSMappingQuality \
 -A ReadPosRankSumTest \
 -A VariantType \
 -l INFO \
 --emitRefConfidence GVCF \
 -rf BadCigar \
 --variant_index_parameter 128000 \
 --variant_index_type LINEAR \
 -R $reference_fasta \
 -nct 1 \
 -I $recalibrated_bam \
 -o $gvcf

REF="$1"
BAM="$2"
VCF="$3"

$GATK $GATK_ARGS -R "$REF" -I "$BAM" -o "$VCF"

