set -e
SAMTOOLS_BIN="samtools"

#input files
OUTBAM="$1"
B1="$2"
B2="$3"
B3="$4"
B4="$5"

"$SAMTOOLS_BIN" merge "$OUTBAM" "$B1" "$B2" "$B3" "$B4" 
