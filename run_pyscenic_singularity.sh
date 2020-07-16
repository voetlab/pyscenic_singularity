# Run pySCENIC using singularity
# Requires a DATA FOLDER as an input that contains an exprMat.tsv file
# This script currently processes mouse data
# TODO: Make branch for human data

SCENIC_IMAGE=/staging/leuven/stg_00002/voetlab/resources/singularity_images/aertslab-pyscenic-0.9.19.sif
SCENIC_RESOURCES=/staging/leuven/stg_00002/voetlab/resources/SCENIC
DATA_FOLDER=$1
NR_WORKERS=20

singularity exec -B $DATA_FOLDER:/scenicdata,$SCENIC_RESOURCES:/resources \
$SCENIC_IMAGE \
pyscenic grn \
--num_workers $NR_WORKERS \
-o /scenicdata/expr_mat.adjacencies.tsv \
/scenicdata/exprMat.tsv \
/resources/human_tfs.txt


singularity exec -B $DATA_FOLDER:/scenicdata,$SCENIC_RESOURCES:/resources \
$SCENIC_IMAGE \
pyscenic ctx \
/scenicdata/expr_mat.adjacencies.tsv \
/resources/hg19-500bp-upstream-10species.mc9nr.feather \
/resources/hg19-tss-centered-10kb-10species.mc9nr.feather \
--annotations_fname /resources/motifs-v9-nr.hgnc-m0.001-o0.0.tbl \
--expression_mtx_fname /scenicdata/exprMat.tsv \
--mode "dask_multiprocessing" \
--output /scenicdata/regulons.csv \
--num_workers $NR_WORKERS

singularity exec -B $DATA_FOLDER:/scenicdata,$SCENIC_RESOURCES:/resources \
$SCENIC_IMAGE \
pyscenic aucell \
/scenicdata/exprMat.tsv \
/scenicdata/regulons.csv \
-o /scenicdata/auc_mtx.csv \
--num_workers $NR_WORKERS
