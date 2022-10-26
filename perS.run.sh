#!/bin/bash

#SBATCH -N 1            # number of nodes
#SBATCH -n 128            # number of "tasks" (default: 1 core per task)
#SBATCH -t 7-00:00:00   # time in d-hh:mm:ss
#SBATCH -p general      # partition
#SBATCH -q public       # QOS
#SBATCH -o slurm.%j.out # file to save job's STDOUT (%j = JobId)
#SBATCH -e slurm.%j.err # file to save job's STDERR (%j = JobId)
#SBATCH --mail-type=ALL # Send an e-mail when a job starts, stops, or fails
#SBATCH --mail-user=%u@asu.edu # Mail-to address
#SBATCH --export=NONE   # Purge the job-submitting shell environment
###THESE NEED TO BE RUN FIRST
#SIMG=persvade_v1.02.6.sif interactive
apptainer exec /packages/apps/simg/persvade_v1.02.6.sif /home/aahowel3/perS.sh
