# Tests für die Funktion my_prcomp

library(testthat)

# Teste, ob die Funktion eine Matrix korrekt verarbeitet
test_that("my_prcomp processes a numeric matrix correctly", {
  data <- matrix(rnorm(100), ncol=5)
  pca_result <- my_prcomp(data)

  # Teste, ob das Ergebnis die richtige Klasse hat
  expect_s3_class(pca_result, "my_prcomp")

  # Teste, ob die Anzahl der Hauptkomponenten mit der Anzahl der Variablen übereinstimmt
  expect_equal(length(pca_result$sdev), ncol(data))

  # Teste, ob die Rotation (Eigenvektoren) die richtige Dimension hat
  expect_equal(dim(pca_result$rotation), c(ncol(data), ncol(data)))

  # Teste, ob die Scores (x) die richtige Dimension haben
  expect_equal(dim(pca_result$x), dim(data))
})


# Teste, ob die Funktion zentriert, wenn center = TRUE
test_that("my_prcomp centers the data when center = TRUE", {
  data <- matrix(rnorm(100), ncol=5)
  pca_result <- my_prcomp(data, center = TRUE)

  # Teste, ob die Mittelwerte der zentrierten Daten null sind
  centered_means <- colMeans(pca_result$x)
  expect_true(all(abs(centered_means) < 1e-10))
})



# Teste, ob die SVD korrekt ist (indirekter Test durch die Resultate)
test_that("my_prcomp SVD produces valid PCA results", {
  data <- matrix(rnorm(100), ncol=5)
  pca_result <- my_prcomp(data, scale. = TRUE)

  # Teste, ob die Varianzproportionen summiert zu 1 sind
  expect_equal(sum(pca_result$variance), 1)

})

# Teste, ob die Funktion mit einem DataFrame funktioniert
test_that("my_prcomp works with data frames", {
  data <- as.data.frame(matrix(rnorm(100), ncol=5))
  pca_result <- my_prcomp(data, scale. = TRUE)

  # Teste, ob das Ergebnis die richtige Klasse hat
  expect_s3_class(pca_result, "my_prcomp")

  # Teste, ob die Anzahl der Hauptkomponenten mit der Anzahl der Variablen übereinstimmt
  expect_equal(length(pca_result$sdev), ncol(data))
})


# Teste die Fehlerbehandlung bei ungültigen Eingaben
test_that("my_prcomp handles invalid input", {
  # Teste, ob ein Fehler geworfen wird, wenn keine Matrix oder DataFrame übergeben wird
  expect_error(my_prcomp(123), "Input must be a matrix or data.frame")
})
