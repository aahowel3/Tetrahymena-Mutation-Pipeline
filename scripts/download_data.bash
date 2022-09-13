PICARD="java -jar /home/aahowel3/picard/build/libs/picard.jar"
#2020 MAC reference (includes rDNA chromosome chr_181)
curl -o data/ref_genome/1-upd-Genome-assembly.fasta http://www.ciliate.org/system/downloads/1-upd-Genome-assembly.fasta
#mitchondrial reference
esearch -db nucleotide -query "NC_003029.1" | efetch -format fasta > data/ref_genome/NC_003029.1.fasta
#combine and index
cat data/ref_genome/1-upd-Genome-assembly.fasta data/ref_genome/NC_003029.1.fasta > data/ref_genome/mac_mito.fasta
bwa index data/ref_genome/mac_mito.fasta
$PICARD CreateSequenceDictionary R=data/ref_genome/mac_mito.fasta O=data/ref_genome/mac_mito.dict
