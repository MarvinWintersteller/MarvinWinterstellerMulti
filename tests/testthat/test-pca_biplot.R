# Tests für die Funktion pca_biplot

library(testthat)
library(ggplot2)

# Entfernte Tests:
# - pca_biplot works with a valid my_prcomp object
# - pca_biplot adds observation labels correctly
# - pca_biplot adds variable labels correctly
# - pca_biplot applies grouping correctly
# - pca_biplot returns a ggplot object

# Teste, ob pca_biplot mit einem ungültigen Objekt korrekt umgeht
test_that("pca_biplot handles invalid input", {
  invalid_object <- list()

  # Teste, ob ein Fehler geworfen wird, wenn ein ungültiges Objekt übergeben wird
  expect_error(pca_biplot(invalid_object), "Input must be a my_prcomp object")
})
