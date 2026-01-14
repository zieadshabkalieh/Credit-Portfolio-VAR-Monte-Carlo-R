library(readxl)
library(copula)
library(openxlsx)

data <- read_excel("Book1.xlsx")

wb <- createWorkbook()

for (year in names(data)) {
  cat("Processing year:", year, "\n")
  default_probabilities <- as.numeric(data[[year]])
  n_companies <- length(default_probabilities)
  correlation_matrix <- matrix(runif(n_companies * n_companies, min = 0.1, max = 0.9), nrow = n_companies, ncol = n_companies)
  diag(correlation_matrix) <- 1
  gaussian_copula <- normalCopula(param = correlation_matrix[lower.tri(correlation_matrix)], dim = n_companies, dispstr = "un")
  set.seed(123)
  uniform_samples <- rCopula(10000, gaussian_copula)
  default_samples <- qnorm(uniform_samples, mean = default_probabilities, sd = sqrt(default_probabilities * (1 - default_probabilities)))
  default_correlation_matrix <- cor(default_samples)
  cat("Default correlation matrix for year", year, ":\n")
  print(default_correlation_matrix)
  cat("\n-----------------------------------\n")
  sheet_name <- paste0("Year_", year)
  addWorksheet(wb, sheetName = sheet_name)
  writeData(wb, sheet = sheet_name, x = default_correlation_matrix)
}

saveWorkbook(wb, file = "DefaultCorrelationMatrices.xlsx", overwrite = TRUE)
cat("Output written to DefaultCorrelationMatrices.xlsx\n")
