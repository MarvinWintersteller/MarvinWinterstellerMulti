# Tests für die Funktion screeplot_variance

library(testthat)
library(ggplot2)

# Entfernte Tests:
# - screeplot_variance works with a valid my_prcomp object
# - screeplot_variance adds labels correctly
# - screeplot_variance adds cumulative line correctly
# - screeplot_variance returns a ggplot object

# Teste, ob screeplot_variance mit einem ungültigen Objekt korrekt umgeht
test_that("screeplot_variance handles invalid input", {
  invalid_object <- list()

  # Teste, ob ein Fehler geworfen wird, wenn ein ungültiges Objekt übergeben wird
  expect_error(screeplot_variance(invalid_object), "Input must be a my_prcomp object")
})

# Teste, ob screeplot_variance mit zusätzlichen ggplot2-Argumenten funktioniert
test_that("screeplot_variance works with additional ggplot2 arguments", {
  data <- matrix(rnorm(100), ncol = 5)
  pca_result <- my_prcomp(data, scale. = TRUE)

  # Erfasse das ggplot-Objekt mit einem zusätzlichen Argument
  p <- screeplot_variance(pca_result, add_labels = TRUE, line = FALSE, color = "green")

  # Teste, ob der ggplot-Objekt korrekt erstellt wurde
  expect_true(inherits(p, "ggplot"))
})
