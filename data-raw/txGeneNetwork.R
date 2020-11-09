## ----style, echo=FALSE, results='hide', message=FALSE-------------------------
library(BiocStyle)
library(knitr)
knitr::opts_chunk$set(error = FALSE, message = FALSE, warning = FALSE, cache = FALSE)
# knitr::opts_chunk$set(fig.asp = 1)

## ----load_deps, echo=FALSE, message=FALSE, warning=FALSE----------------------
#txGeneNetwork:::load_dependencies()
# suppressPackageStartupMessages({
#   library(ggraph)
#   library(tidygraph)
#   library(ggforce)
#   library(readr)
#   library(tidyr)
#   library(ggnewscale)
#   library(concaveman)
# })


requireNamespace("ggplot2")
requireNamespace("ggforce")
requireNamespace("dplyr")
requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("ggnewscale")
requireNamespace("tidygraph")
requireNamespace("ggraph")
requireNamespace("concaveman")

## ----load_dependencies2-------------------------------------------------------
library(ggplot2)
library(dplyr)
library(ggforce)
library(readr)
library(tidyr)
library(ggnewscale)
library(tidygraph)
library(ggraph)
library(concaveman)

library(txGeneNetwork)

## ----message=FALSE, warning=FALSE---------------------------------------------
example_dataset_path <- system.file("extdata", "example_dataset.csv", package = "txGeneNetwork")
example_dataset <- read_csv(example_dataset_path)

## -----------------------------------------------------------------------------
example_tbl_graph <- as_tbl_graph(example_dataset)
example_tbl_graph

## ----fig1, fig.height=3, fig.width=5------------------------------------------
example_tbl_graph %>%
  ggraph() +
  geom_node_point() +
  geom_edge_link()

## ----fig2, fig.height=3, fig.width=3------------------------------------------
example_tbl_graph %>%
  ggraph(layout = "kk") +
  geom_node_point() +
  geom_edge_link()

## ----fig3, fig.height=3, fig.width=4------------------------------------------
example_tbl_graph %>%
  mutate(centrality = centrality_power()) %>%
  ggraph(layout = "kk") +
  geom_node_point(aes(size = centrality)) +
  geom_edge_link()

## ----fig4, fig.height=3, fig.width=4------------------------------------------
example_tbl_graph %>%
  mutate(centrality = centrality_power()) %>%
  ggraph(layout = "kk") +
  geom_edge_link(aes(col = Direction)) +
  geom_node_point(aes(size = centrality))

## ----fig5, fig.height=3, fig.width=6------------------------------------------
example_tbl_graph %>%
  mutate(centrality = centrality_power()) %>%
  ggraph(layout = "kk") +
  geom_edge_link(aes(color = Group)) +
  geom_node_point(aes(size = centrality))

## ----message=FALSE------------------------------------------------------------
example_tbl_graph %>% 
  activate(nodes) %>%
  as_tibble()

## ----message=FALSE, warning=FALSE---------------------------------------------
modified_nodes_path <- system.file("extdata", "modified_nodes.csv", package = "txGeneNetwork")

modified_nodes <- read_csv(modified_nodes_path)

## ----fig6, fig.height=4.5, fig.width=6.5--------------------------------------
example_tbl_graph %>%
  activate(nodes) %>%
  mutate(Type = modified_nodes$Type) %>%
  mutate(centrality = centrality_power()) %>%
  ggraph(layout = "kk") +
  geom_edge_link(aes(col = Direction)) +
  geom_node_point(aes(size = centrality, color = Type))

## ----fig7, fig.height=7, fig.width=10-----------------------------------------
example_tbl_graph %>%
  activate(nodes) %>%
  mutate(
    Type = modified_nodes$Type,
    Process = modified_nodes$Process_1,
    Process_2 = modified_nodes$Process_2,
    Process_3 = modified_nodes$Process_3
  ) %>%
  mutate(centrality = centrality_power()) %>%
  ggraph(layout = "kk") +
  geom_mark_hull(aes(x = x, y = y, fill = Process, color = Process)) +
  geom_mark_hull(aes(x = x, y = y, fill = Process_2, color = Process_2)) +
  geom_mark_hull(aes(x = x, y = y, fill = Process_3, color = Process_3)) +
  geom_edge_link(aes(col = Direction)) +
  new_scale("color") +
  geom_node_point(aes(size = centrality, color = Type)) +
  theme_graph()

## ----fig8, fig.height=7, fig.width=10-----------------------------------------
example_tbl_graph %>%
  activate(nodes) %>%
  mutate(
    Type = modified_nodes$Type,
    Process = modified_nodes$Process_1,
    Process_2 = modified_nodes$Process_2,
    Process_3 = modified_nodes$Process_3
  ) %>%
  mutate(centrality = centrality_power()) %>%
  ggraph(layout = "kk") +
  geom_mark_hull(aes(x = x, y = y, fill = Process, color = Process)) +
  geom_mark_hull(aes(x = x, y = y, fill = Process_2, color = Process_2)) +
  geom_mark_hull(aes(x = x, y = y, fill = Process_3, color = Process_3)) +
  geom_edge_link(aes(col = Direction)) +
  new_scale("color") +
  geom_node_point(aes(size = centrality, color = Type))

## -----------------------------------------------------------------------------
sessionInfo()
# sessioninfo::session_info()
# xfun::session_info()

