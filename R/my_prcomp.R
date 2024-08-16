# Eigenes R Package - Funktion zur Durchführung einer PCA
#' Perform Principal Component Analysis (PCA)
#'
#' @description
#' This function performs a Principal Component Analysis (PCA) on a given dataset.
#' It centers and optionally scales the data before applying Singular Value Decomposition (SVD) to compute the principal components.
#' The function returns an object similar to that returned by the `prcomp` function in base R.
#'
#' @param x A numeric matrix or data frame. The data to be analyzed, where rows represent observations and columns represent variables.
#'
#' @param scale. A logical value indicating whether the variables should be scaled to have unit variance before the analysis. Defaults to `FALSE`.
#'
#' @param center A logical value indicating whether the variables should be centered to have mean zero before the analysis. Defaults to `TRUE`.
#'
#' @return
#' A list with class "my_prcomp" containing the following components:
#' \item{sdev}{The standard deviations of the principal components (square roots of the eigenvalues).}
#' \item{rotation}{The matrix of variable loadings (eigenvectors). Each column contains the loading vector for one principal component.}
#' \item{x}{The coordinates of the original data in the principal component space (the principal component scores).}
#' \item{center}{The centering values used, if any.}
#' \item{scale}{The scaling values used, if any.}
#' \item{variance}{The proportion of variance explained by each principal component.}
#'
#' @export
#'
#' @examples
#' # Example usage with a random dataset
#' set.seed(123)
#' data <- matrix(rnorm(100), ncol=5)
#'
#' # Perform PCA without scaling
#' pca_result <- my_prcomp(data, scale. = FALSE)
#'
#' # View the result
#' print(pca_result)
#'
#' # Perform PCA with scaling
#' pca_result_scaled <- my_prcomp(data, scale. = TRUE)
#'
#' # View the result
#' print(pca_result_scaled)


my_prcomp <- function(x, scale. = FALSE, center = TRUE) {

  # Überprüfen, ob die Eingabe eine Matrix oder ein data.frame ist
  if (!is.matrix(x) && !is.data.frame(x)) {
    stop("Input must be a matrix or data.frame")
  }

  # Zentrieren der Daten
  if (center) {
    x <- scale(x, center = TRUE, scale = FALSE)
  }

  # Skalieren der Daten
  if (scale.) {
    x <- scale(x, center = FALSE, scale = TRUE)
  }


  # SVD Funktion bauen

  # Funktion zur Durchführung der SVD ohne Verwendung der svd()-Funktion
  svd <- function(X) {
    # 1. Berechnung von X^T * X
    XtX <- t(X) %*% X

    # 2. Eigenwertzerlegung von X^T * X
    eigen_XtX <- eigen(XtX)

    # 3. Berechnung der Singulärwerte als Quadratwurzel der Eigenwerte
    sing_values <- sqrt(eigen_XtX$values)

    # 4. Berechnung der rechten Singulärvektoren (V) als normierte Eigenvektoren von X^T * X
    V <- eigen_XtX$vectors

    # 5. Berechnung der linken Singulärvektoren (U)
    # U = X * V * D^-1, wobei D die Diagonalmatrix der Singulärwerte ist
    U <- X %*% V %*% diag(1/sing_values)

    # 6. Rückgabe der Ergebnisse als Liste
    list(u = U, d = sing_values, v = V)
  }






  # Durchführung der Singular Value Decomposition (SVD)
  svd_result <- svd(x)

  # Berechnung der Eigenwerte
  eigenvalues <- (svd_result$d)^2 / (nrow(x) - 1)

  # Berechnung der Varianzproportionen
  variance_proportion <- eigenvalues / sum(eigenvalues)

  # Erstellen eines Objekts, das der Struktur von prcomp ähnelt
  result <- list(
    sdev = sqrt(eigenvalues),
    rotation = svd_result$v,
    x = svd_result$u %*% diag(svd_result$d),
    center = attr(x, "scaled:center"),
    scale = attr(x, "scaled:scale"),
    variance = variance_proportion
  )

  # Setzen der Klassenattribute für das result-Objekt
  class(result) <- "my_prcomp"

  return(result)
}

# Print-Methode für my_prcomp Objekte
print.my_prcomp <- function(x, ...) {
  cat("Standard deviations (1, .., p=components):\n")
  print(x$sdev)
  cat("\nRotation (Eigenvectors):\n")
  print(x$rotation)
  cat("\nCenter:\n")
  print(x$center)
  cat("\nScale:\n")
  print(x$scale)
}

# Beispielanwendung der Funktion
# set.seed(123)
# data <- matrix(rnorm(100), ncol=5)
# biopsy_pca <- my_prcomp(data, scale. = TRUE)
# print(pca_result)
