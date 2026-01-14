# Number of obligors in the portfolio
n <- 100

# Given variables
alpha <- c(125.618999, 125.618999, 1291.099749)
beta <- c(112.2507208, 112.2507208, 973.9875296)
PD_values <- c(0.004512183, 0.056146093, 0.01)
LGD_values <- c(0.4719, 0.4719, 0.43)
EAD_values <- c(57820000.00, 19489500.00, 21590.00)

# Parameters of the beta distribution
b1 <- alpha[1]
b2 <- beta[1]

# Replace the existing values with the given variables
PD <- rep(PD_values, n)
LGD <- rep(LGD_values, n)
EAD <- rep(EAD_values, n)

lossrealization <- function(n, PD, EAD, LGD, b1, b2) {
  # Keep track of the loss in this portfolio
  totalloss <- 0
  
  # Draw Q
  Q <- rbeta(1, b1, b2)
  
  # Loop through all obligors to see if they
  # go into default
  for (obligor in 1:n) {
    # Does this obligor go into default or not?
    default <- rbinom(1, 1, PD[obligor])
    
    # Check for default
    if (default == 1) {
      totalloss <- totalloss + EAD[obligor] * LGD[obligor]
    }
  }
  
  return(totalloss)
}

runs <- 10000

# Run a number of realizations
losses <- numeric(runs)
for (run in 1:runs) {
  # Add a new realization of the loss variable
  losses[run] <- lossrealization(n, PD, EAD, LGD, b1, b2)
}

# Output: normalized histogram
hist(losses, freq = FALSE, main = "Histogram of Loss",
     xlab = "Loss", ylab = "Density")

alpha_level <- 0.99  # Alpha level

# Sort losses and select the right value for VaR
losses <- sort(losses)
j <- floor(alpha_level * runs)
var <- losses[j]

# Output the VaR
cat("VaR at", alpha_level, "confidence level:", var, "\n")
