
fit_lnorm <- function(df, column) {
  require(fitdistrplus)
  
  fit <- fitdistrplus::fitdist(
    data = df[[column]], distr = "lnorm",
    start = list(
      meanlog = mean(log(df[[column]])), sdlog = stats::sd(log(df[[column]]))
    ),
    method = "mle"
  )
    
  
  # data frame of station parameters(GEV)
  df_para <- data.frame(
    ID = unique(df$ID),
    meanlog = fit[["estimate"]][["meanlog"]],
    sdlog = fit[["estimate"]][["sdlog"]]
  )
  
  return(df_para)
}

