//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;
  vector[N] y;
  vector[N] dist;
  vector[N] bedrooms;
  vector[N] satisfaction;
}

parameters {
  real beta0;
  real beta1;
  real beta2;
  real beta4;
  real<lower=0> sigma;
}

model {
  beta0 ~ normal(0, 10);
  beta1 ~ normal(0, 10);
  beta2 ~ normal(0, 10);
  beta4 ~ normal(0, 10);
  sigma ~ cauchy(0, 5);

  y ~ normal(beta0 + beta1 * dist + beta2 * bedrooms + beta4 * satisfaction, sigma);
}
