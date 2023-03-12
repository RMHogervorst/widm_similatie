rem_cont <- function(round,available_picks, dropouts_per_round){
    # remove dropout at end available_picks round
    available_picks[!available_picks == dropouts_per_round[round]]
}


simulate_1000 <- function(mole,dropouts_per_round, strategy){
    scorematrix <- matrix(0,nrow= 8, ncol=1000)
    for (j in 1:1000) {
        scorematrix[,j] <-strategy(mole,dropouts_per_round)
    }
    rowSums(scorematrix)
}
