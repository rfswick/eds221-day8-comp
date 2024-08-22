library(tidyverse)
library(patchwork)
library(here)


lizards <- read_csv(here::here("data_tidy", "lizards.csv"))


two_lizards <- lizards |>
  dplyr::filter(common_name %in% c("eastern fence", "western whiptail"))

p1 <- ggplot(data = two_lizards, aes(x = total_length, y = weight)) +
  geom_point(aes(color = common_name)) +
  scale_color_manual(values = c("orange", "navy"), 
                     name = "Lizard species:",
                     labels = c("Eastern fence lizard",
                                "Western whiptail lizard")) +
  theme_minimal() +
  theme(legend.position = c(0.2, 0.8),
        legend.background = element_blank()) +
  labs(x = "Total length (mm)",
       y = "Weight (grams)") 

p2 <- ggplot(data=lizards, aes(x=weight, y=site)) +
  geom_boxplot() +
  labs(x="Weight (g)",
       y="Site")

p3 <- ggplot(data=lizards, aes(x=weight)) +
  geom_histogram()+
  labs(x="Weight (g)",
       y="Counts (n)")

p4 <- (p3 + p2 / p1) & theme_minimal()
ggsave("patchwork.png", p4)
