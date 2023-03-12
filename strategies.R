### Strategies

 
#' It doesn't matter man 
random <- function(mole,dropouts_per_round){
    available_picks <- start
    scores <- rep(0,8)
    pick <- sample(available_picks,1)
    for(i in 1:8){
        # if the same this becomes one
        scores[i] <- sum(pick == mole)
        available_picks <- rem_cont(i, available_picks, dropouts_per_round)
        ## Jay strategy: always switch!
        pick <- sample(available_picks,1)
    }
    scores
}

#' It's just like a monty hall problem! Switching is always better!
monty_hall <- function(mole,dropouts_per_round){
    available_picks <- start
    scores <- rep(0,8)
    pick <- sample(available_picks,1)
    for(i in 1:8){
        # if the same this becomes one
        scores[i] <- sum(pick == mole)
        available_picks <- rem_cont(i, available_picks, dropouts_per_round)
        ## Jay strategy: always switch!
        pick <- sample(available_picks[!available_picks == pick],1)
    }
    scores
}

#' Pick one and stay
no_backsies <- function(mole,dropouts_per_round){
    available_picks <- start
    scores <- rep(0,8)
    pick <- sample(available_picks,1)
    for(i in 1:8){
        # if the same this becomes one
        scores[i] <- sum(pick == mole)
        available_picks <- rem_cont(i, available_picks, dropouts_per_round)
        ## random strategy:
        ## switch when no longer available
        if(!pick %in% available_picks){
            pick <- sample(available_picks,1)
        }
    }
    scores
}
