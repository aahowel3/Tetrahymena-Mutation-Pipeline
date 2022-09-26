#!/bin/bash

#SBATCH -N 1            # number of nodes
#SBATCH -n 1            # number of "tasks" (default: 1 core per task)
#SBATCH -t 7-00:00:00   # time in d-hh:mm:ss
#SBATCH -p general      # partition
#SBATCH -q public       # QOS
#SBATCH -o slurm.%j.out # file to save job's STDOUT (%j = JobId)
#SBATCH -e slurm.%j.err # file to save job's STDERR (%j = JobId)
#SBATCH --mail-type=ALL # Send an e-mail when a job starts, stops, or fails
#SBATCH --mail-user=%u@asu.edu # Mail-to address
#SBATCH --export=NONE   # Purge the job-submitting shell environment
module load bcftools-1.14-gcc-11.2.0

for file in /scratch/aahowel3/variant_calls/*.vcf
do
base=$(basename "$file" .vcf)
/home/aahowel3/denovogear-develop/build/src/dng-call --all --input="$file" --output="${base}".dng.vcf \
--ped=tetrahymenaMA_pedexample.ped \
--min-qual=13 \
--mu=0.00000001 \
--theta=0.0001 \
--lib-error=0.01 \
--lib-overdisp-hom=0.001 \
--lib-overdisp-het=0.001
bcftools index "${base}".dng.vcf
done
