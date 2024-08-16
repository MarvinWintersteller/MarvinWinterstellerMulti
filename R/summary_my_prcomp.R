# Summary-Methode für my_prcomp Objekte
#' Summary Method for my_prcomp Objects
#'
#' @description
#' This function provides a summary of the results from a Principal Component Analysis (PCA) performed using the `my_prcomp` function. It calculates and displays the standard deviations, proportion of variance, and cumulative proportion of variance explained by each principal component.
#'
#' @param object A my_prcomp object. The result of a PCA analysis performed using the my_prcomp function.
#'
#' @param ... Additional arguments (currently not used).
#'
#' @return
#' This function returns a formatted summary of the PCA results, including the standard deviations of the principal components, the proportion of variance explained by each component, and the cumulative proportion of variance explained.
#'
#' @export
#'
#' @examples
#' # Perform PCA on a sample dataset
#' data(iris)
#' pca_result <- my_prcomp(iris[, -5], scale. = TRUE)
#'
#' # Get the summary of the PCA result
#' summary.my_prcomp(pca_result)


summary.my_prcomp <- function(object, ...) {
  # Berechnen der Proportion der Varianz
  variance_proportion <- object$variance

  # Berechnen der kumulativen Proportion
  cumulative_proportion <- cumsum(variance_proportion)

  # Erstellen einer Tabelle
  summary_table <- data.frame(
    `Standard deviation` = object$sdev,
    `Proportion of Variance` = variance_proportion,
    `Cumulative Proportion` = cumulative_proportion
  )

  # Hinzufügen von Spaltennamen
  colnames(summary_table) <- c("Standard deviation", "Proportion of Variance", "Cumulative Proportion")

  # Setzen der Zeilen- und Spaltennamen
  rownames(summary_table) <- paste0("PC", 1:length(object$sdev))

  # Ausgabe der Ergebnisse
  cat("Importance of components:\n\n")
  print(summary_table)
}

# Beispielanwendung der Funktion
# biopsy_pca <- my_prcomp(biopsy_sample, scale. = TRUE)
# summary.my_prcomp(biopsy_pca)
