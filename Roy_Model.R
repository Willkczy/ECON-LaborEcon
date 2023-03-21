library(MASS)
library(data.table)
library(magrittr)
library(dplyr)

set.seed(0)

#1
# set μ0, μ1, σ0, σ1, σ01, C
mu_0 = 2
mu_1 = 5
sigma_0 = sqrt(7)
sigma_1 = sqrt(5)
sigma_01 = 3.5
cost = 5

sizes = 10000000

#2
multi_normal_data = as.data.table(mvrnorm(n = sizes,
                                         mu = c(0, 0), 
                                         Sigma = matrix(c(sigma_1, sigma_0, sigma_01, sigma_01), ncol = 2)))
multi_normal_data = multi_normal_data[, .(epsilon_0 = V1, epsilon_1 = V2)]

#3
multi_normal_data = multi_normal_data[, .(w_0 = mu_0 + epsilon_0, w_1 = mu_1 + epsilon_1), by=.(epsilon_0, epsilon_1)]

#4
multi_normal_data = multi_normal_data[, `:=` (I = sample(c(0,1), replace = TRUE,size = sizes))]

#5
#Q1
multi_normal_data %>%
  group_by(I) %>%
  summarise(Q_0 = mean(w_0))

#Q2
multi_normal_data %>%
  group_by(I) %>%
  summarise(Q_1 = mean(w_1))
