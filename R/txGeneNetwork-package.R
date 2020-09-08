#' @importFrom tibble tibble
NULL

# use this when a returned object is a tibble
# @return a [tibble][tibble::tibble-package]


#' Test example
#' @importFrom rlang .data
#' @import ggraph
#' @return a [tibble][tibble::tibble-package]
#' @export
test_dependencies <- function() {
  set.seed(42)
  `%>%` <- magrittr::`%>%`
  `.data` <- rlang::`.data`
  temp_df <- tidyr::tibble(
    from = sample(paste0("gene_", 1:9), size = 50, replace = TRUE),
    to = sample(paste0("gene_", 1:9), size = 50, replace = TRUE)
  )
  graph_obj <- temp_df %>%
    dplyr::mutate(
      Pathway = sample(paste0("Pathway_",1:9), size = 50, replace = TRUE)
    ) %>%
    tidygraph::as_tbl_graph() %>%
    tidygraph::activate("nodes") %>%
    tidygraph::mutate(centrality = tidygraph::centrality_power()) %>%
    tidygraph::mutate(Type = sample(c("Gene", "LncRNA", "NMD"), size = 9, replace = TRUE)) %>%
    tidygraph::activate("edges") %>%
    tidygraph::mutate(
      Direction = sample(c("Up", "Down", NA), size = 50, replace = TRUE)
    ) %>%
    tidygraph::activate("nodes")

  graph_plot <- graph_obj %>%
    ggraph::ggraph(layout = "kk") +
    ggforce::geom_mark_hull(
      ggplot2::aes(x = .data[["x"]], y = .data[["y"]], fill = .data[["Type"]], color = .data[["Type"]])
    ) +
    ggraph::geom_edge_link(ggplot2::aes(color = .data[["Direction"]])) +
    ggnewscale::new_scale("color") +
    ggraph::geom_node_point(
      ggplot2::aes(size = .data$centrality, shape = .data[["Type"]], color = .data[["Type"]])
    ) +
    ggraph::theme_graph()


  result_df <- tibble::as_tibble(graph_plot$data) %>%
    dplyr::select(.data$name, .data$Type)
  return(result_df)
}

#add_pathways <- function() {
#  if (
#
#  )
#
#}
#
# geom_edge_hull <- function() {
#
# }
