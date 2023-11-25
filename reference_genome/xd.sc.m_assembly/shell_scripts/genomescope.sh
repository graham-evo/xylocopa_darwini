#!/bin/bash
#SBATCH --job-name=genomescope
#SBATCH -n 4
#SBATCH -N 1
#SBATCH --output genomescope%j.out
#SBATCH --error genomescope%j.err

cd /work/grahamcm/xylocopa/male_hifi/ftp.genome.arizona.edu/Carpenter_bee_GA9-1_GA9-2_Pooled_HiFi_193pM-Cell4/5926_import-dataset/assembly

module load R/gcc/4.3.1

Rscript /home/grahamcm/genomescope/genomescope.R kmer_counts.histo 21 10639 genomescope_reads

