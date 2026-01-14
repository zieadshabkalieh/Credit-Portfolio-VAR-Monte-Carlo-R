library(readxl)
library(copula)
library(openxlsx)
library(Matrix)

data <- read_excel("الخسارة المتوقعة .xlsx")
data_numeric <- data.frame(lapply(data, function(x) suppressWarnings(as.numeric(x))))
data_numeric <- data_numeric[, !sapply(data_numeric, function(x) all(is.na(x)))]

if(ncol(data_numeric) == 0) {
  stop("No valid numeric columns found in the Excel file.")
}

all_default_samples <- NULL
set.seed(123)

for (year in names(data_numeric)) {
  cat("Processing year:", year, "\n")
  default_probabilities <- data_numeric[[year]]
  if (any(is.na(default_probabilities))) {
    warning("Column ", year, " contains some NA values. Skipping this column.")
    next
  }
  default_probabilities <- ifelse(default_probabilities <= 0, 0.001,
                           ifelse(default_probabilities >= 1, 0.999, default_probabilities))
  n_companies <- length(default_probabilities)
  raw_matrix <- matrix(runif(n_companies * n_companies, min = 0.1, max = 0.9),
                       nrow = n_companies, ncol = n_companies)
  symmetric_matrix <- (raw_matrix + t(raw_matrix)) / 2
  diag(symmetric_matrix) <- 1
  valid_corr_matrix <- as.matrix(nearPD(symmetric_matrix, corr = TRUE)$mat)
  gaussian_copula <- normalCopula(param = valid_corr_matrix[lower.tri(valid_corr_matrix)],
                                  dim = n_companies, dispstr = "un")
  uniform_samples <- rCopula(10000, gaussian_copula)
  default_samples <- qnorm(uniform_samples, mean = default_probabilities,
                           sd = sqrt(default_probabilities * (1 - default_probabilities)))
  all_default_samples <- rbind(all_default_samples, default_samples)
}

combined_correlation_matrix <- cor(all_default_samples)
wb <- createWorkbook()
addWorksheet(wb, "Combined_Matrix")
writeData(wb, sheet = "Combined_Matrix", x = combined_correlation_matrix)
saveWorkbook(wb, file = "CombinedDefaultCorrelationMatrix.xlsx", overwrite = TRUE)
cat("Output written to CombinedDefaultCorrelationMatrix.xlsx\n")
