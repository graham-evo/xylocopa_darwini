#!/bin/bash
#SBATCH --job-name=kmerfreq
#SBATCH -n 4
#SBATCH -N 1
#SBATCH --output kmerfreq%j.out
#SBATCH --error kmerfreq%j.err

cd /home/grahamcm/jellyfish-2.3.0 # jellyfish is was downloaded to the home directory using gcc and ./configure and make

jellyfish count -C \ # The count command produces a .jf file of dmer counts. -C specifies that the forward and reverse compliments should be counted
-m 21 \ # k-mer size length. 21 is an optimal size
-s 1000000000 \ # max memory allocation, just make this huge. Jellyfish will automatically scale this number if need be
/work/grahamcm/xylocopa/male_hifi/ftp.genome.arizona.edu/Carpenter_bee_GA9-1_GA9-2_Pooled_HiFi_193pM-Cell4/5926_import-dataset/hifi_reads/hifi_reads.bc2025.fast \ #requires a fasta or fastq file as input. Fastq was obtained from the ubam_to_fastq shell script
-o /work/grahamcm/xylocopa/male_hifi/ftp.genome.arizona.edu/Carpenter_bee_GA9-1_GA9-2_Pooled_HiFi_193pM-Cell4/5926_import-dataset/assembly/kmer_counts.jf # output directory

# jellfish histo produces a distribution count of k-mer / coverage to be used in genomescope for genomesize estimation
jellyfish histo -t 8  /work/grahamcm/xylocopa/male_hifi/ftp.genome.arizona.edu/Carpenter_bee_GA9-1_GA9-2_Pooled_HiFi_193pM-Cell4/5926_import-dataset/assembly/kmer_counts.jf > /work/grahamcm/xylocopa/male_hifi/ftp.genome.arizona.edu/Carpenter_bee_GA9-1_GA9-2_Pooled_HiFi_193pM-Cell4/5926_import-dataset/assembly/kmer_counts.histo

done;

