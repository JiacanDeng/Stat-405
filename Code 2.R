# fit model 2
fit2 <- stan(
  file = "model2(New).stan",
  data = stan_data,
  iter = 1000,
  chains = 4
)

print(fit2, pars = c("beta0", "beta1", "beta2", "beta4", "sigma"))