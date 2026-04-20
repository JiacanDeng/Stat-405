library(tidyverse)
library(readr)
df <- read_csv("Downloads/archive 2/amsterdam_weekdays.csv",
               show_col_types = FALSE)

install.packages("rstan", dependencies = TRUE)
library(rstan)

install.packages("rstan", dependencies = TRUE)
library(rstan)

# preprocessing
df_clean <- df %>%
  drop_na(realSum, dist, bedrooms) %>%
  filter(realSum > 0)

# figure
ggplot(df_clean, aes(x = dist, y = realSum)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm") +
  labs(
    title = "Price vs Distance (Amsterdam Weekdays)",
    x = "Distance to City Center",
    y = "Listing Price"
  )

# data for Stan
stan_data <- list(
  N = nrow(df_clean),
  y = df_clean$realSum,
  dist = df_clean$dist,
  bedrooms = df_clean$bedrooms
)
install.packages("cmdstanr")
# fit model
fit <- stan(
  file = "model1.stan",
  data = stan_data,
  iter = 1000,
  chains = 4
)

print(fit, pars = c("beta0", "beta1", "beta2", "sigma"))

# diagnostics
traceplot(fit, pars = c("beta1", "beta2"))
summary(fit)$summary
