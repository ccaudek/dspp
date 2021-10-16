
data {
 int <lower = 1> N; // Total number of trials
 vector[N] y; // Score in each trial
 real mean_y;
 real <lower = 0> sd_y;
}

parameters {
 real mu_raw; 
 real <lower = 0> sigma_raw;  
}

transformed parameters {
 }

model {
  mu ~ normal(30, 15);
  sigma ~ cauchy(10, 10);
  // Likelihood:
  target += normal_lpdf(y | mu, sigma); 
}

generated quantities { // The posterior predictive distribution
  real y_rep[N];
  for (n in 1:N) {
    y_rep[n] = normal_rng(mu, sigma);
  }
}

