
library(MASS)

# Generate sample data from a log-normal distribution
set.seed(123)
x <- rlnorm(100, meanlog = 2, sdlog = 0.5)


# Increase the lower values by adding a constant to the data
x_transformed <- x + 10

# Fit a log-normal distribution to the sample data
fit <- fitdistr(x_transformed, "lognormal")

# Extract the estimated location and scale parameters
meanlog_est <- fit$estimate[1]
sdlog_est <- fit$estimate[2]

# Print the estimated parameters
cat("Estimated location parameter (meanlog):", meanlog_est, "\n")
cat("Estimated scale parameter (sdlog):", sdlog_est, "\n")

qlnorm(0.98,2,0.5)+10
qlnorm(0.98, meanlog_est, sdlog_est )

# Correct for the increase in lower values by subtracting the constant
x_corrected <- x_transformed - 10

# Refit the log-normal distribution to the corrected data
fit_corrected <- fitdistr(x_corrected, "lognormal")

# Extract the corrected location and scale parameters
meanlog_corrected_est <- fit_corrected$estimate[1]
sdlog_corrected_est <- fit_corrected$estimate[2]

# Print the corrected parameters
cat("Estimated location parameter (meanlog) after correction:", meanlog_corrected_est, "\n")
cat("Estimated scale parameter (sdlog) after correction:", sdlog_corrected_est, "\n")
