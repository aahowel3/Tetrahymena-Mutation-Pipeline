metadata=metadata.tsv

echo "BASENAMES_WITH_LANES=\\"
cat $metadata | tail -n +2 | cut -f 2 |
  uniq | awk '{ print "    ", $0, "\\" }'
echo ""

echo "BASENAMES=\\"
cat $metadata | tail -n +2 | cut -f 2 |
  sed -re 's|_L00[1234]$||' | sort | uniq | awk '{ print "    ", $0, "\\" }'
echo ""

echo "BASENAME_MIC_FILES=\\"
cat $metadata | tail -n +2 | cut -f 2 |  uniq | grep -e "Anc" -e "GE" | awk '{ print "    ", $0, "\\" }'
echo ""

echo "BASENAME_MAC_FILES=\\"
cat $metadata | tail -n +2 | cut -f 2 |  uniq | grep -e "MA" -e "SB210" | awk '{ print "    ", $0, "\\" }'
echo ""
