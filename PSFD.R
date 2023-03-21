#Download the RR2011 data
library(dplyr,warn.conflicts = FALSE)
library(magrittr)
library(ggplot2)

data = read.csv('rr2012_data.csv')

data_2 = data %>%
  select(a05, a02a01)

data_2$a05 = ifelse(data_2$a05 == 1 | data_2$a05 == 2, 1, data_2$a05)
data_2$a05 = ifelse(data_2$a05 == 3, 0, data_2$a05)

data_2 = data_2 %>% 
  group_by(a02a01) %>%
  summarise(work_mean = mean(a05))

data_2 = data_2 %>% rename(work_dummy_mean = work_mean, age = a02a01)

scatter_plot = ggplot(data_2) + 
  geom_point(mapping = aes(x = age, y = work_dummy_mean))

scatter_plot
