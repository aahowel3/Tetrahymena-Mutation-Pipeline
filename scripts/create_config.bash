metadata=metadata.tsv

echo "FASTQ_BASENAMES="
cat $metadata | tail -n +2 | cut -f 2 | awk '{ print "    ",$0,"\\" }'
