set -e

PICARD=/usr/bin/picard
PICARD_ARGS=MarkDuplicates \
 MAX_RECORDS_IN_RAM=2000000 \
 VALIDATION_STRINGENCY=SILENT  

BAM_in="$1" 
BAM_out="$2"
MET="$3"

$PICARD $PICARD_ARGS M="$MET" I="$BAM_in" O="$BAM_out"
