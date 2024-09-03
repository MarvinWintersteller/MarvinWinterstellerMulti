#' Dataset: Processed Biopsy Data for PCA
#'
#' This dataset contains processed biopsy data, prepared for Principal Component Analysis (PCA).
#' Rows with missing values have been removed, and specific categorical or identifier columns have been excluded.
#'
#' @format A data frame with `r nrow(biopsy_sample)` rows and `r ncol(biopsy_sample)` variables:
#' \describe{
#'   \item{V2}{(clump thickness): Thickness of the cell clumps. Scored on a scale from 1 to 10, with higher values indicating thicker cell clumps.}
#'   \item{V3}{(uniformity of cell size): Uniformity of cell size. Scored on a scale from 1 to 10, with higher values indicating greater differences in cell size.}
#'   \item{V4}{(uniformity of cell shape): Uniformity of cell shape. Scored on a scale from 1 to 10, with higher values indicating greater differences in cell shape.
#'   \item{V5}{(marginal adhesion): Marginal adhesion, or the ability of cells to stick together at the edges. Scored on a scale from 1 to 10, with higher values indicating stronger adhesion.}
#'   \item{V6}{(single epithelial cell size): Size of the individual epithelial cells. Scored on a scale from 1 to 10, with higher values indicating larger epithelial cells.}
#'   \item{V7}{(bare nuclei): Number of bare nuclei, which are nuclei not surrounded by cytoplasm. Scored on a scale from 1 to 10, with 16 values missing in the dataset.}
#'   \item{V8}{bland chromatin): Appearance of the chromatin found within the cell nuclei. Scored on a scale from 1 to 10, with higher values indicating less densely packed chromatin.}
#'   \item{V9}{(normal nucleoli): Number of normal nucleoli in the cell nuclei. Scored on a scale from 1 to 10, with higher values indicating a greater number of nucleoli.}
#'   \item{V10}{(mitoses): Number of cell divisions (mitoses). Scored on a scale from 1 to 10, with higher values indicating a higher rate of cell division.}
#' }
#'
#' @source
#' This dataset was derived from the original `biopsy` dataset by removing rows with missing values
#' and excluding the first column (assumed to be an identifier) and the eleventh column (assumed to be a categorical variable).
#'
#' @examples
#' data(biopsy_sample)     #Lazy Loading
#' head(biopsy_sample)
#'
#' # Perform PCA on the processed biopsy data
#' biopsy_pca <- my_prcomp(biopsy_sample, scale. = TRUE)
#' summary(biopsy_pca)
"biopsy_sample"

