#!/bin/bash
#SBATCH --job-name=hicanu_assembly
#SBATCH -n 16
#SBATCH -N 1
#SBATCH -p defq-64core
#SBATCH --output hicanu%j.out
#SBATCH --error hicanu%j.err

module load java/17.0.3.1

cd /work/grahamcm/applications/canu-2.2/build/bin

./canu -p xd.sc.m -d /work/grahamcm/xylocopa/male_hifi/ftp.genome/arizona/edu/Carpenter_bee_GA9-1_GA9-2_Pooled_HiFi_193pM-Cell4/5926_import-dataset/assembly -genomeSize=184.3m -pacbio-hifi /work/grahamcm/xylocopa/male_hifi/ftp.genome.arizona.edu/Carpenter_bee_GA9-1_GA9-2_Pooled_HiFi_193pM-Cell4/5926_import-dataset/hifi_reads/hifi_reads.bc2025.fastq


