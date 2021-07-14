#e chris.conley@hci.utah.edu -b
#c kingspeak_24
#t 24
set -e

# Limit the memory to 120G
SLURM_MEM_PER_NODE=120000

##  Transcriptome reference
ORG=/tomato/dev/data/Human/GRCh38
DB=$ORG/10x_star
INDEX=$DB/refdata-cellranger-GRCh38-3.0.0

## Cell Ranger 
module load cellranger/3.0.2

## Input
FASTQS=`ls -d  MKFASTQ_*`
SAMPLE=$(echo $FASTQS | cut -d'_' -f 2)

cellranger count --id=$SAMPLE \
--fastqs=$FASTQS \
--transcriptome=$INDEX \
--expect-cells=2000 \
--jobmode=local \
--localmem=95

# REMOVE temporary pipeline data
rm -rf $SAMPLE/SC_RNA_COUNTER_CS/
