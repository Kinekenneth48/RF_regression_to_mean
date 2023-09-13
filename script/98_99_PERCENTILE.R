mean <- 1.5  # Mean of the corresponding normal distribution
std_dev <- 0.8  # Standard deviation of the corresponding normal distribution

# Calculate the parameters of the lognormal distribution
log_mean <- 0.2
log_std_dev <- 0.5
t = 0.6

# Calculate the 98th percentile
percentile_98 <- exp(qnorm(0.98, mean = log_mean, sd = 0.5))
percentile_98

# Calculate the 98th percentile
percentile_98_10 <- exp(qnorm(0.98, mean = log_mean, sd = 0.5*1.1))
percentile_98_10

# Calculate the 98th percentile
percentile_98_20 <- exp(qnorm(0.98, mean = log_mean, sd = 0.5*1.2))
percentile_98_20


# Calculate the 99th percentile
percentile_99 <- exp(qnorm(0.99, mean = log_mean, sd = 0.5))
percentile_99

# Calculate the 99th percentile
percentile_99_10 <- exp(qnorm(0.99, mean = log_mean, sd = 0.5*1.1))
percentile_99_10

# Calculate the 99th percentile
percentile_99_20 <- exp(qnorm(0.99, mean = log_mean, sd = 0.5*1.2))
percentile_99_20