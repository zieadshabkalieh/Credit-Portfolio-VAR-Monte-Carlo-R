compute_default_correlation <- function(default_probs, joint_probs) {
  n <- length(default_probs)
  default_correlation_matrix <- matrix(0, nrow = n, ncol = n)
  for (i in 1:n) {
    for (j in 1:n) {
      if (i != j) {
        p1 <- default_probs[i]
        p2 <- default_probs[j]
        p12 <- joint_probs[i, j]
        default_correlation_matrix[i, j] <- (p12 - p1 * p2) / sqrt(p1 * (1 - p1) * p2 * (1 - p2))
      }
    }
  }
  return(default_correlation_matrix)
}
default_probabilities_list <- list(
  '2008' = c(0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.05, 0.03, 0.06, 0.04, 0.05, 0.02, 0.01, 0.08, 0.03, 0.07, 0.04, 0.06, 0.05, 0.02, 0.01, 0.09),
  '2009' = c(0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.06, 0.04, 0.07, 0.05, 0.06, 0.03, 0.02, 0.09, 0.04, 0.08, 0.05, 0.07, 0.06, 0.03, 0.02, 0.10),
  '2010' = c(0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.09, 0.07, 0.05, 0.08, 0.06, 0.07, 0.04, 0.03, 0.10, 0.05, 0.09, 0.06, 0.08, 0.07, 0.04, 0.03, 0.10),
  '2011' = c(0.05, 0.06, 0.07, 0.08, 0.09, 0.10, 0.09, 0.08, 0.08, 0.06, 0.09, 0.07, 0.08, 0.05, 0.04, 0.09, 0.06, 0.08, 0.07, 0.09, 0.08, 0.05, 0.04, 0.08),
  '2012' = c(0.06, 0.07, 0.08, 0.09, 0.10, 0.09, 0.08, 0.07, 0.09, 0.07, 0.10, 0.08, 0.09, 0.06, 0.05, 0.08, 0.07, 0.09, 0.08, 0.10, 0.09, 0.06, 0.05, 0.07),
  '2013' = c(0.07, 0.08, 0.09, 0.10, 0.09, 0.08, 0.07, 0.06, 0.10, 0.08, 0.09, 0.09, 0.10, 0.07, 0.06, 0.07, 0.08, 0.10, 0.09, 0.09, 0.10, 0.07, 0.06, 0.08),
  '2014' = c(0.08, 0.09, 0.10, 0.09, 0.08, 0.07, 0.06, 0.05, 0.09, 0.09, 0.08, 0.10, 0.09, 0.08, 0.07, 0.06, 0.09, 0.09, 0.10, 0.08, 0.09, 0.08, 0.07, 0.09),
  '2015' = c(0.09, 0.10, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.08, 0.10, 0.09, 0.09, 0.08, 0.09, 0.08, 0.07, 0.10, 0.08, 0.09, 0.09, 0.08, 0.09, 0.08, 0.10),
  '2016' = c(0.10, 0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.07, 0.09, 0.08, 0.08, 0.07, 0.10, 0.09, 0.08, 0.09, 0.07, 0.08, 0.10, 0.09, 0.07, 0.06, 0.09),
  '2017' = c(0.09, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.06, 0.08, 0.07, 0.07, 0.06, 0.09, 0.08, 0.07, 0.08, 0.06, 0.07, 0.09, 0.08, 0.06, 0.05, 0.08),
  '2018' = c(0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01, 0.05, 0.07, 0.06, 0.06, 0.05, 0.08, 0.07, 0.06, 0.07, 0.05, 0.06, 0.08, 0.07, 0.05, 0.04, 0.07),
  '2019' = c(0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.01, 0.05, 0.04, 0.06, 0.05, 0.05, 0.04, 0.07, 0.06, 0.05, 0.06, 0.04, 0.05, 0.07, 0.06, 0.04, 0.03, 0.06),
  '2020' = c(0.06, 0.05, 0.04, 0.03, 0.02, 0.01, 0.05, 0.04, 0.03, 0.05, 0.04, 0.04, 0.03, 0.06, 0.05, 0.04, 0.05, 0.03, 0.04, 0.06, 0.05, 0.03, 0.02, 0.05),
  '2021' = c(0.05, 0.04, 0.03, 0.02, 0.01, 0.05, 0.04, 0.03, 0.02, 0.04, 0.03, 0.03, 0.02, 0.05, 0.04, 0.03, 0.04, 0.02, 0.03, 0.05, 0.04, 0.02, 0.01, 0.04),
  '2022' = c(0.04, 0.03, 0.02, 0.01, 0.05, 0.04, 0.03, 0.02, 0.01, 0.03, 0.02, 0.02, 0.01, 0.04, 0.03, 0.02, 0.03, 0.01, 0.02, 0.04, 0.03, 0.01, 0.05, 0.03),
  '2023' = c(0.03, 0.02, 0.01, 0.05, 0.04, 0.03, 0.02, 0.01, 0.05, 0.02, 0.01, 0.01, 0.05, 0.03, 0.02, 0.01, 0.02, 0.05, 0.01, 0.03, 0.02, 0.01, 0.05, 0.02)
)
set.seed(42)
joint_default_probabilities_list <- list()
num_companies <- 24
for (year in names(default_probabilities_list)) {
  joint_default_probabilities_list[[year]] <- matrix(runif(num_companies * num_companies, min = 0.001, max = 0.05), nrow = num_companies, ncol = num_companies)
}
correlation_per_year_list <- list()
for (year in names(default_probabilities_list)) {
  default_probs <- default_probabilities_list[[year]]
  joint_probs <- joint_default_probabilities_list[[year]]
  correlation_per_year_list[[year]] <- compute_default_correlation(default_probs, joint_probs)
}
combined_default_probs <- rowMeans(do.call(cbind, default_probabilities_list))
combined_joint_probs <- Reduce("+", joint_default_probabilities_list) / length(joint_default_probabilities_list)
correlation_all_years <- compute_default_correlation(combined_default_probs, combined_joint_probs)
print("Correlations for each year:")
for (year in names(correlation_per_year_list)) {
  cat(paste("\nYear:", year))
  print(correlation_per_year_list[[year]])
}
