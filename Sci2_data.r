## Sci2 ----

## Emily Greathead - 14/07/16

#startup routine
library(dplyr)
library(tidyr)
library(igraph)

# .csv data ----

n <- read.csv(file = "Node Table from Graph.csv")
e <- read.csv(file = "Edge Table from Graph.csv") # node and edge files from Sci2, very basic info for constructing a network


## .graphml data ----

## Tried reading data in .xlm file format from the Sci2 .graphML file
## Now trying with the .graphML file format
## Working with data set DeleteIsolates from the BioChem search, nodes= , edges=

g <- read_graph('DeleteIsolates.graphml', format = c("graphml")) # works, we can put .graphML files into R!

# Calculating metrics ----

bw <- betweenness(g) # calculates the betweenness centrality of each node. 12290 entries - same as number of nodes in n
c <- closeness(g) # closeness centrality of the nodes
d <- degree(g) 

df <- data.frame(bw, c, d) # helpful to add label in, then merge the data sets - tidyr
labels(df, 'Betweenness', 'Closeness', 'Degree') # did somehting, but not what I was expecting...

## Now put in node table, will now merge the data sets so we have the metrics, IDs and Names in one data.frame
# n <- read.csv(file = "Node Table from Graph.csv")

all <- bind_cols(n, df) # putting the data next to each other, now check if it's in the right order...

write.csv(all, file = "foo.csv") # make sure to put the file name

## these seem to be the same, or at least relatively the same

## The betweenness centrality and closeness centrailty metrics from Cytoscape and R were different
## Degree was the same
## Decided to use the R metrics, ultimately easier to cut out the cytoscape step, particularly once we're using larger amounts of data

## Degree and betweenness centrality are crucial for us - will not necessarily return the same individuals
## Will possibly give a good contrast


## other betweenness calculation method  ----
other <- betweenness(g, v=V(g), directed = TRUE, weights = NULL, normalized = FALSE)
newdf <- data.frame(bw, other)

# Can use the above, or use betweenness()
# Gives the same result


## Eperiment plotting g ----
plot.igraph(g) ## probably not a good idea atm, did plot, but then crashed, can do this later if it's useful
