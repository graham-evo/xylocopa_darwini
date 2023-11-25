#!/bin/bash
#SBATCH --job-name=ubam_to_fastq
#SBATCH -n 4
#SBATCH -N 1
#SBATCH --output ubam_to_fastq%j.out
#SBATCH --error ubam_to_fastq%j.err

module load samtools/gcc/1.5 # samtools is available as a module cluster

samtools bam2fq  /work/grahamcm/xylocopa/male_hifi/ftp.genome.arizona.edu/Carpenter_bee_GA9-1_GA9-2_Pooled_HiFi_193pM-Cell4/5926_import-dataset/hifi_reads/m84082_231007_130535_s4.hifi_reads.bc2025.bam > /work/grahamcm/xylocopa/male_hifi/ftp.genome.arizona.edu/Carpenter_bee_GA9-1_GA9-2_Pooled_HiFi_193pM-Cell4/5926_import-dataset/hifi_reads/hifi_reads.bc2025.fastq # bam2fq returns a fastq file from the specified bam file


