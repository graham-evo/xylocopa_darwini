#!/bin/sh

#  get_hifi_read_lengths.sh
#  
#
#  Created by Graham McLaughlin on 11/30/23.
#  
conda activate conda_grahamcm

bioawk -c fastx '{print "Arizona_HiFi," length($seq)}' ../hifi_reads/hifi_reads.bc2025.fastq >> length.csv
