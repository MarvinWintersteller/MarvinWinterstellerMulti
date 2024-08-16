#' Dataset: Processed Biopsy Data for PCA
#'
#' This dataset contains processed biopsy data, prepared for Principal Component Analysis (PCA).
#' Rows with missing values have been removed, and specific categorical or identifier columns have been excluded.
#'
#' @format A data frame with `r nrow(biopsy_sample)` rows and `r ncol(biopsy_sample)` variables:
#' \describe{
#'   \item{V2}{Numeric variable representing [Description of V2].}
#'   \item{V3}{Numeric variable representing [Description of V3].}
#'   \item{V4}{Numeric variable representing [Description of V4].}
#'   \item{V5}{Numeric variable representing [Description of V5].}
#'   \item{V6}{Numeric variable representing [Description of V6].}
#'   \item{V7}{Numeric variable representing [Description of V7].}
#'   \item{V8}{Numeric variable representing [Description of V8].}
#'   \item{V9}{Numeric variable representing [Description of V9].}
#'   \item{V10}{Numeric variable representing [Description of V10].}
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

