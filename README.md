# pyscenic_singularity

Description: Run PySCENIC using Singularity container

Author: Alejandro Sifrim

Date: 19/02/2020

Usage: 

```
./run_pyscenic_singularity.sh <data_folder>
```

data_folder must contain an exprMat.tsv file which can be obtained like this from a Seurat object:

```r
exprMat <- t(seu_object@assays$RNA@data)
write.table(data.frame("cell_id"=rownames(exprMat),exprMat),
 file=paste0(output_path,"exprMat.tsv"),
 row.names=FALSE,col.names=TRUE,sep="\t",quote = FALSE)
```

Be sure to use the correct branch (master branch = Mus Musculus, human branch = Homo Sapiens)
