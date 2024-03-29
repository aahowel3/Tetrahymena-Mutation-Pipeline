set -e

PICARD="java -jar /home/aahowel3/picard/build/libs/picard.jar"
PICARD_ARGS=FixMateInformation \
 MAX_RECORDS_IN_RAM=2000000 \
 VALIDATION_STRINGENCY=SILENT \
 ADD_MATE_CIGAR=True \
 ASSUME_SORTED=true 

# Input files
BAM_in="$1"
BAM_out="$2"

$PICARD $PICARD_ARGS I="$BAM_in" O="$BAM_out" 
