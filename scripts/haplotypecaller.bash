set -e 

GATK=/usr/bin/gatk
GATK_ARGS="HaplotypeCaller \
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
 -A VariantType" 

REF="$1"
BAM="$2"
VCF="$3"

"$GATK" "$GATK_ARGS" -R "$REF" -I "$BAM" -stand-call-conf 0 -ploidy 2 -O "$VCF"

