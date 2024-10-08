% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/my_prcomp.R
\name{my_prcomp}
\alias{my_prcomp}
\title{Perform Principal Component Analysis (PCA)}
\usage{
my_prcomp(x, scale. = FALSE, center = TRUE)
}
\arguments{
\item{x}{A numeric matrix or data frame. The data to be analyzed, where rows represent observations and columns represent variables.}

\item{scale.}{A logical value indicating whether the variables should be scaled to have unit variance before the analysis. Defaults to \code{FALSE}.}

\item{center}{A logical value indicating whether the variables should be centered to have mean zero before the analysis. Defaults to \code{TRUE}.}
}
\value{
A list with class "my_prcomp" containing the following components:
\item{sdev}{The standard deviations of the principal components (square roots of the eigenvalues).}
\item{rotation}{The matrix of variable loadings (eigenvectors). Each column contains the loading vector for one principal component.}
\item{x}{The coordinates of the original data in the principal component space (the principal component scores).}
\item{center}{The centering values used, if any.}
\item{scale}{The scaling values used, if any.}
\item{variance}{The proportion of variance explained by each principal component.}
}
\description{
This function performs a Principal Component Analysis (PCA) on a given dataset.
It centers and optionally scales the data before applying Singular Value Decomposition (SVD) to compute the principal components.
The function returns an object similar to that returned by the \code{prcomp} function in base R.
}
\examples{
# Example usage with a random dataset
set.seed(123)
data <- matrix(rnorm(100), ncol=5)

# Perform PCA without scaling
pca_result <- my_prcomp(data, scale. = FALSE)

# View the result
print(pca_result)

# Perform PCA with scaling
pca_result_scaled <- my_prcomp(data, scale. = TRUE)

# View the result
print(pca_result_scaled)
}
