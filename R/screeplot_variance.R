# Funktion zum Erstellen eines Scree-Plots
#' Create a Scree Plot of Explained Variance
#'
#' @description
#' This function creates a scree plot to visualize the proportion of variance explained by each principal component in a PCA. It can also add labels to each bar and optionally include a line to show the cumulative proportion of variance.
#'
#' @param pca_result A my_prcomp object. The result of a PCA analysis performed using the `my_prcomp` function. This object contains the principal components and their associated variance.
#'
#' @param add_labels A logical value indicating whether to display the proportion of variance explained by each principal component as labels on the bars. Defaults to `TRUE`.
#'
#' @param line A logical value indicating whether to include a line representing the cumulative proportion of variance explained. Defaults to `TRUE`.
#'
#' @param ... Additional arguments passed to the ggplot2 plotting functions for further customization.
#'
#' @return
#' A ggplot object representing the scree plot of explained variance for the principal components. The plot can be further customized using `ggplot2` functions.
#'
#' @export
#'
#' @examples
#' # Perform PCA on a sample dataset
#' data(iris)
#' pca_result <- my_prcomp(iris[, -5], scale. = TRUE)
#'
#' # Basic scree plot
#' screeplot_variance(pca_result)
#'
#' # Scree plot with labels and without cumulative line
#' screeplot_variance(pca_result, add_labels = TRUE, line = FALSE)
#'
#' # Customize the scree plot using additional ggplot2 arguments
#' screeplot_variance(pca_result) + ggplot2::theme_minimal()


screeplot_variance <- function(pca_result, add_labels = TRUE, line = TRUE, ...) {

  # Überprüfen, ob das Objekt ein my_prcomp-Objekt ist
  if (!inherits(pca_result, "my_prcomp")) {
    stop("Input must be a my_prcomp object")
  }

  # Berechnung der Proportion der Varianz
  variance_proportion <- pca_result$variance

  # Erstellen eines Dataframes für das Plotten
  scree_data <- data.frame(
    PC = paste0("PC", 1:length(variance_proportion)),
    Variance = variance_proportion
  )

  # Erstellen des Scree-Plots mit ggplot2
  p <- ggplot(scree_data, aes(x = PC, y = Variance)) +
    geom_bar(stat = "identity", fill = "steelblue", ...) +
    labs(title = "Scree Plot", x = "Principal Components", y = "Proportion of Variance Explained") +
    theme_minimal()

  # Optionale Linie hinzufügen, die die Varianz kumulativ anzeigt
  if (line) {
    p <- p + geom_line(aes(group = 1), color = "red", size = 1) +
      geom_point(aes(group = 1), color = "red", size = 2)
  }

  # Optionale Labels an die Balken hinzufügen
  if (add_labels) {
    p <- p + geom_text(aes(label = round(Variance, 3)), vjust = -0.5, size = 3.5)
  }

  # Plot anzeigen
  print(p)
}

# Beispielanwendung der Funktion
# screeplot_variance(biopsy_pca)
