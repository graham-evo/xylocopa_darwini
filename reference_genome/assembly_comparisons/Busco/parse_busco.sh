#!/bin/sh

#  parse_busco.sh
#  
#
#  Created by Graham McLaughlin on 12/1/23.
#  
# BUSCO will measure the quality and presence of single copy orthologs in four different categories: (1) COMPLETE AND SINGLE COPY, (2) COMPLETE AND DUPLICATED, (3) FRAGMENTED, and (4) MISSING. This script will parse the number of data points in each of the categories and output a .csv file

# Create BUSCO output file having a header line:

echo "Assembly, Complete_single_copy, Complete_duplicated, Fragmented, Missing" > busco.csv

# Extract the count for each BUSCO category for each assembly startin with first assembly

ASSEMBLY1=hicanu-assembly

# (S) represents COMPLETE AND SINGLE COPY

cat busco_report.$ASSEMBLY1.txt | \
grep "(S)" | \
awk -v assembly="$ASSEMBLY1" '{print assembly","$1}' > complete_single.txt

# (D) represents COMPLETE AND DUPLICATED

cat busco_report.$ASSEMBLY1.txt | \
grep "(D)" | \
awk '{print $1}' > complete_duplicated.txt

# (F) represents COMPLETE AND FRAGMENTED

cat busco_report.$ASSEMBLY1.txt | \
grep "(F)" | \
awk '{print $1}' > fragmented.txt

# (M) represents COMPLETE AND MISSING

cat busco_report.$ASSEMBLY1.txt | \
grep "(M)" | \
awk '{print $1}' > missing.txt

paste -d "," complete_single.txt complete_duplicated.txt fragmented.txt missing.txt >> busco.csv

# Next wit hifiasm
ASSEMBLY2=hifiasm-assembly

cat busco_report.$ASSEMBLY2.txt | \
grep "(S)" | \
awk -v strain="$PREFIX2" ’{print strain", "$1}’ > complete_single.txt

cat busco_report.$ASSEMBLY2.txt | \
grep "(D)" | \
awk ’{print $1}’ > complete_duplicated.txt

cat busco_report.$ASSEMBLY2.txt | \
grep "(F)" | \
awk ’{print $1}’ > fragmented.txt

cat busco_report.$ASSEMBLY2.txt | \
grep "(M)" | \
awk ’{print $1}’ > missing.txt

paste -d "," complete_single.txt complete_duplicated.txt fragmented.txt missing.txt >> busco.csv

# Finally wit verkko assembly

ASSEMBLY3=verkko-assembly

cat busco_report.$ASSEMBLY3.txt | \
grep "(S)" | \
awk -v strain="$PREFIX2" ’{print strain", "$1}’ > complete_single.txt

cat busco_report.$ASSEMBLY3.txt | \
grep "(D)" | \
awk ’{print $1}’ > complete_duplicated.txt

cat busco_report.$ASSEMBLY3.txt | \
grep "(F)" | \
awk ’{print $1}’ > fragmented.txt

cat busco_report.$ASSEMBLY3.txt | \
grep "(M)" | \
awk ’{print $1}’ > missing.txt

paste -d "," complete_single.txt complete_duplicated.txt fragmented.txt missing.txt >> busco.csv
