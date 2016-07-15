### Clean R Script
## Minimal notation

## Emily Greathead - 15/07*16

library(dplyr)
library(tidyr)
library(igraph)

g <- read_graph(' ... .graphml', format = c("graphml")) # load graphml from Sci2/Tethne

bw <- betweenness(g)
d <- degree(g)
df <- data.frame(bw, d) # put the metrics into a data frame, ready to be combined with the node table

n <- read.csv(file = " ... .csv") # read in the node table

all <- bind_cols(n, df) # binding the node table and the metric table together

write.csv(all, file = " ... .csv")
