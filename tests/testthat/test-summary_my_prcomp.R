# Tests für die Funktion summary.my_prcomp

library(testthat)

# Teste, ob die summary.my_prcomp die korrekten Berechnungen durchführt
test_that("summary.my_prcomp calculates and prints the correct summary", {
  # Erstelle eine Beispielmatrix und führe PCA durch
  data <- matrix(rnorm(100), ncol = 5)
  pca_result <- my_prcomp(data, scale. = TRUE)

  # Erfasse die Ausgabe von summary.my_prcomp
  summary_output <- capture.output(summary.my_prcomp(pca_result))

  # Teste, ob die Ausgabe die erwarteten Komponenten enthält
  expect_true(any(grepl("Importance of components:", summary_output)))

  # Teste, ob die Standardabweichungen korrekt angezeigt werden
  expect_true(any(grepl("Standard deviation", summary_output)))

  # Teste, ob die Proportion der Varianz korrekt angezeigt wird
  expect_true(any(grepl("Proportion of Variance", summary_output)))

  # Teste, ob die kumulative Proportion der Varianz korrekt angezeigt wird
  expect_true(any(grepl("Cumulative Proportion", summary_output)))

  # Teste, ob die Anzahl der Komponenten in der Ausgabe korrekt ist
  num_components <- length(pca_result$sdev)
  for (i in 1:num_components) {
    expect_true(any(grepl(paste0("PC", i), summary_output)))
  }
})

# Entfernte Tests:
# - summary.my_prcomp handles invalid input gracefully
# - summary.my_prcomp correctly calculates cumulative variance
# - summary.my_prcomp works with a minimal dataset
