## Experimenting with Cytoscape data

## Emily Greathead
## 14/07/16

getwd()

## using data from Cytoscape ----
gc <- read.csv(file = "node.csv") # data from Cytoscape, Exported the default node file

## first attempt at creating an index value to rank the importance of the individual
bc <- mutate(gc, bw_ct = BetweennessCentrality * Degree) 

newvariable <- bc %>% select(label, bw_ct) # creating the new table with the name and importance index of the person
newish <- data.frame(newvariable) # putting that into a dataframe

rank1 <- rank(newvariable, na.last = TRUE, ties.method = "min")

deg <- bc %>% select(label, Degree)
deg <- data.frame(deg)
                     
## remove the unnecessary or temporary objects from the environment
rm(degree, e, filter1)
rm(rank1)

## How to creat a filter based on Degree >=5, selecting certain values
filter1 <- bc %>% 
  filter(Degree >= 5) %>%
  select(label, bw_ct, ClosenessCentrality, ClusteringCoefficient)



