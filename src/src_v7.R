default_probabilities <- c(0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.05, 0.03,
                           0.06, 0.04, 0.05, 0.02, 0.01, 0.08, 0.03, 0.07, 0.04, 0.06,
                           0.05, 0.02, 0.01, 0.09)
# Define the correlation matrix for the Gaussian copula
correlation_matrix <- matrix(runif(24*24, min = 0.1, max = 0.9), nrow = 24, ncol = 24)
diag(correlation_matrix) <- 1  # Set diagonal to 1 for valid correlation matrix
# Create the Gaussian copula
gaussian_copula <- normalCopula(param = correlation_matrix[lower.tri(correlation_matrix)], dim = 24, dispstr = "un")
# Generate correlated uniform random variables
set.seed(123)
uniform_samples <- rCopula(10000, gaussian_copula)
# Transform uniform samples to default probabilities using inverse CDF
default_samples <- qnorm(uniform_samples, mean = default_probabilities, sd = sqrt(default_probabilities * (1 - default_probabilities)))
# Calculate the default correlation matrix
default_correlation_matrix <- cor(default_samples)
print(default_correlation_matrix)
