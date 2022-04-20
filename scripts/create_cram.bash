set -e 

SAMTOOLS_BIN="samtools"
REF="$1"
CRAM="$3"
BAM="$2"

$SAMTOOLS_BIN view -C -T "$REF" -o "$CRAM" "$BAM" 
$SAMTOOLS_BIN index "$CRAM" 


