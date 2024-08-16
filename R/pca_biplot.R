
# Funktion zum Erstellen eines PCA Biplots mit Gruppierung
#' Create a Biplot for Visualizing Principal Component Analysis (PCA) with Grouping
#'
#' @param pca_result A `my_prcomp` object. The result of a PCA analysis performed using the `my_prcomp` function. This object contains the principal components, loadings, and other relevant data for plotting.
#'
#' @param obs_labels A vector of labels for the observations. These labels will be displayed on the plot near the corresponding points. If `NULL`, no labels are shown for the observations.
#'
#' @param var_labels A logical value indicating whether the names of the variables (loadings) should be displayed as labels on the plot. Default is `TRUE`.
#'
#' @param scale_obs A numeric value to scale the observations' points on the plot. Adjusts the size of the points representing the observations. Default is `1`.
#'
#' @param scale_vars A numeric value to scale the variables' arrows on the plot. Adjusts the length of the arrows representing the original variables. Default is `1`.
#'
#' @param arrow_multiplier A numeric value that controls the length of the arrows representing the variables (loadings). Increasing this value makes the arrows longer. Default is `1.5`.
#'
#' @param habillage A factor or vector used for grouping the observations. The observations will be color-coded and represented with different shapes based on the levels of this factor. If `NULL`, no grouping is applied.
#'
#' @param ... Additional arguments passed to the underlying plotting functions. This can be used to customize various aspects of the plot, such as colors, themes, and sizes.
#'
#' @return
#' A `ggplot` object representing the biplot of the first two principal components. This plot displays observations and variable loadings, with options to color-code observations by groups and label them accordingly.
#' The plot can be further customized using `ggplot2` functions.
#'
#' @export
#'
#' @examples
#' # Perform PCA on a sample dataset
#' data(iris)
#' pca_result <- my_prcomp(iris[, -5], scale. = TRUE)
#'
#' # Basic biplot
#' pca_biplot(pca_result)
#'
#' # Biplot with observation labels and custom arrow length
#' pca_biplot(pca_result, obs_labels = rownames(iris), arrow_multiplier = 2)
#'
#' # Biplot with grouping by species
#' pca_biplot(pca_result, obs_labels = rownames(iris), arrow_multiplier = 2, habillage = iris$Species)


pca_biplot <- function(pca_result, obs_labels = NULL, var_labels = TRUE, scale_obs = 1, scale_vars = 1, arrow_multiplier = 1.5, habillage = NULL, ...) {

  # Überprüfen, ob das Objekt ein my_prcomp-Objekt ist
  if (!inherits(pca_result, "my_prcomp")) {
    stop("Input must be a my_prcomp object")
  }

  # Extrahieren der projizierten Daten (Scores) und Rotation (Ladungen)
  scores <- as.data.frame(pca_result$x[, 1:2])  # Nur die ersten beiden Hauptkomponenten
  loadings <- as.data.frame(pca_result$rotation[, 1:2])  # Nur die ersten beiden Hauptkomponenten

  # Skalieren der Beobachtungen und Variablen
  scores <- scores * scale_obs
  loadings <- loadings * scale_vars * arrow_multiplier  # Pfeile verlängern

  # Namen der Variablen und Beobachtungen hinzufügen
  colnames(scores) <- c("PC1", "PC2")
  colnames(loadings) <- c("PC1", "PC2")
  loadings$var <- rownames(loadings)

  # Gruppierung hinzufügen, falls vorhanden
  if (!is.null(habillage)) {
    scores$group <- factor(habillage)
  }

  # Erstellen des Biplots mit ggplot2
  p <- ggplot() +
    geom_segment(data = loadings, aes(x = 0, y = 0, xend = PC1, yend = PC2),
                 arrow = arrow(length = unit(0.3, "cm")), color = "red", size = 1) +  # Pfeile verlängert
    labs(title = "PCA Biplot", x = paste0("Dim1 (", round(100 * var(pca_result$x[, 1])/sum(pca_result$sdev^2), 1), "%)"),
         y = paste0("Dim2 (", round(100 * var(pca_result$x[, 2])/sum(pca_result$sdev^2), 1), "%)")) +
    theme_minimal()

  # Punkte für Beobachtungen mit Gruppierung
  if (!is.null(habillage)) {
    p <- p + geom_point(data = scores, aes(x = PC1, y = PC2, color = group, shape = group), size = 3)
  } else {
    p <- p + geom_point(data = scores, aes(x = PC1, y = PC2), color = "blue", size = 2)
  }

  # Optionale Labels für Beobachtungen hinzufügen
  if (!is.null(obs_labels)) {
    p <- p + geom_text(data = scores, aes(x = PC1, y = PC2, label = obs_labels),
                       vjust = -1, color = "blue", size = 3.5)
  }

  # Optionale Labels für Variablen hinzufügen
  if (var_labels) {
    p <- p + geom_text(data = loadings, aes(x = PC1, y = PC2, label = var),
                       hjust = 1.2, vjust = 1.2, color = "red", size = 3.5)
  }

  # Legende hinzufügen, wenn Gruppierung vorhanden ist
  if (!is.null(habillage)) {
    p <- p + labs(color = "Groups", shape = "Groups")
  }

  # Plot anzeigen
  print(p)
}

# Beispielanwendung der Funktion
# pca_biplot(biopsy_pca, arrow_multiplier = 2)  # Verwende einen höheren Multiplikator für längere Pfeile
# pca_biplot(biopsy_pca, arrow_multiplier = 6, obs_labels = rownames(biopsy_sample))
# pca_biplot(biopsy_pca, arrow_multiplier = 6, obs_labels = rownames(biopsy_sample), habillage = biopsy_nomiss$class)
