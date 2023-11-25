#!/bin/bash
#SBATCH --job-name=quast
#SBATCH -n 4
#SBATCH -N 1
#SBATCH --output quast%j.out
#SBATCH --error quast%j.err

python3/anaconda/2023.9

/home/grahamcm/quast/quast.py xd.sc.m.contigs.fasta -o /work/grahamcm/xylocopa/male_hifi/ftp.genome.arizona.edu/Carpenter_bee_GA9-1_GA9-2_Pooled_HiFi_193pM-Cell4/5926_import-dataset/assembly/canu-assembly
