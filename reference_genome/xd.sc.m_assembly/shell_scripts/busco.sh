#!/bin/bash

conda activate bucso # busco was created as its own conda environment

busco -i xd.sc.m.contigs.fasta \ # name of input assembly fasta file
    -l hymenopetera_odb10 \ # lineage database to compare single copy orthologs
    -m genome \ # method, 'GENOME' for reference genoems
    -o busco_xd.sc.m \ # output file directory
    -c 12 # 12 cpu's
