library(ggplot2)
library(tidyr)
library(dplyr)

source("utils.R")
source("strategies.R")
# game
start <- 1:10


sim_results <- function(){
    steps=50
    scorematrix_no_backsies <- matrix(0,nrow= 8, ncol=steps)
    scorematrix_monty_hall <- matrix(0,nrow= 8, ncol=steps)
    scorematrix_random <- matrix(0,nrow= 8, ncol=steps)
    for (i in 1:steps){
        print(paste0("round ",i))
        picks <- sample(start, size =10)
        mole <- picks[1]
        dropouts_per_round <- picks[2:8]
        scorematrix_no_backsies[,i] <- simulate_1000(mole, dropouts_per_round, no_backsies)
        scorematrix_monty_hall[,i] <- simulate_1000(mole, dropouts_per_round, monty_hall)
        scorematrix_random[,i] <- simulate_1000(mole, dropouts_per_round, random)
    }
    data.frame(
            row_labels = factor(paste0("ronde ", 1:8), ordered = TRUE),
            contestants_left=9:2,
            monty_hall = rowSums(scorematrix_monty_hall),
            no_backsies=rowSums(scorematrix_no_backsies),
            random_pick=rowSums(scorematrix_random)
        )
}

## get point for every time you pick the right one
# graph of average score voer 1000 games for strategy


dataset <- sim_results() 

dataset |>
    pivot_longer(monty_hall:random_pick,names_to="strategy",values_to="count") |>
    ggplot(aes(row_labels, count, color=strategy, group=strategy))+
    geom_line()+
    labs(
        title="Strategieen voor WIDM",
        x="ronde",
        y="score"
    )

dataset |>
    mutate(at_random=5e4/(contestants_left+1)) |>
    pivot_longer(monty_hall:at_random,names_to="strategy",values_to="count") |>
    ggplot(aes(row_labels, count, color=strategy, group=strategy))+
    geom_line()+
    labs(
        title="Strategieen voor WIDM",
        caption='50.000 potjes',
        x="ronde",
        y="score"
    )

dataset |>
    mutate(at_random=5e4/(contestants_left+1)) %>% 
    filter(row_labels=="ronde 8")

