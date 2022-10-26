#!/bin/bash

source /opt/conda/etc/profile.d/conda.sh && conda activate perSVade_env
#need to run this as well to make output folders make_foldernames.sh
REF=/home/aahowel3/ref_genome/mac_mito.fasta

#infer repeats which feeds into 'call_SVs', 'find_knownSVs_regions', 'integrate_SV_CNV_calls', 'optimize_parameters' and 'call_small_variants'
python /perSVade/scripts/perSVade infer_repeats --fraction_available_mem 1.0 --ref "$REF" -o output/repeat_inference

#find homologous to pipe into opt_params (one of two options - other is find_knownSVs)
python /perSVade/scripts/perSVade find_homologous_regions --fraction_available_mem 1.0 --ref "$REF" -o output/find_hom_regions

#for file in /scratch/aahowel3/bam_merged/*.bam
#tester single file
for file in /scratch/aahowel3/bam_merged/A12GE1_S13.bam
do
#run param optimization
base=$(basename "$file" .bam)
python /perSVade/scripts/perSVade optimize_parameters --fraction_available_mem 1.0 --ref "$REF" -o output/parameter_optimization/params_"${base}" \ 
-sbam /scratch/aahowel3/bam_merged/"$file" --mitochondrial_chromosome NC_003029.1 \
--repeats_file output/repeat_inference/combined_repeats.tab --regions_SVsimulations random \
--simulation_ploidies haploid

#call SVS
python /perSVade/scripts/perSVade call_SVs --fraction_available_mem 1.0 --ref "$REF" -o output/call_SVs/SVs_"${base}" -sbam /scratch/aahowel3/bam_merged/"$file" \
--mitochondrial_chromosome NC_003029.1 --SVcalling_parameters output/parameter_optimization/params_"${base}"/optimized_parameters.json \ 
--repeats_file output/repeat_inference/combined_repeats.tab

#call CNVS
python /perSVade/scripts/perSVade call_CNVs --fraction_available_mem 1.0 --ref "$REF" -o output/call_CNVs/CNVs_"${base}" -sbam /scratch/aahowel3/bam_merged/"$file" \
--mitochondrial_chromosome NC_003029.1 -p 1 --cnv_calling_algs HMMcopy,AneuFinder --window_size_CNVcalling 500

#integrate CNV and SV calls
python /perSVade/scripts/perSVade integrate_SV_CNV_calls --fraction_available_mem 1.0 -o output/integrated_SV_CNV_calls/integrate_"${base}" --ref "$REF" --mitochondrial_chromosome NC_003029.1 \
-p 1 -sbam /scratch/aahowel3/bam_merged/"$file" --outdir_callSVs output/call_SVs/SVs_"${base}" --outdir_callCNVs output/call_CNVs/CNVs_"${base}" --repeats_file skip

#annotate 
#used protozoan mito code and ciliate nuclear code https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi#SG4
python /perSVade/scripts/perSVade annotate_SVs --fraction_available_mem 1.0 -o output/annotate_SVs/annotated_"${base}" --ref "$REF" --mitochondrial_chromosome NC_003029.1 -gff 2-upd-Genome-GFF3-latest-2.gff3 -mcode 4 -gcode 6 \
--SV_CNV_vcf output/integrated_SV_CNV_calls/SV_and_CNV_variant_calling_"${base}".vcf
done 


