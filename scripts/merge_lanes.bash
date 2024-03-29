set -e
PICARD="java -jar /home/aahowel3/picard/build/libs/picard.jar"
PICARD_ARGS=MergeSamFiles \
 USE_THREADING=true \
 MAX_RECORDS_IN_RAM=2000000 \
 VALIDATION_STRINGENCY=SILENT \
 SORT_ORDER=queryname 

#input files
OUTBAM="$1"
B1="$2"
B2="$3"
B3="$4"
B4="$5"

$PICARD $PICARD_ARGS INPUT="$B1" INPUT="$B2" INPUT="$B3" INPUT="$B4" OUTPUT="$OUTBAM" 
