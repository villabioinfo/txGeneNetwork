#' Annotate area around group of nodes
#' @param expand A numeric or unit vector of length one, specifying the expansion amount.
#'   Negative values will result in contraction instead.
#'   If the value is given as a numeric it will be understood as a proportion of the plot area width.
#' @param radius As expand but specifying the corner radius.
#' @param concavity A measure of the concavity of the hull.
#'   1 is very concave while it approaches convex as it grows.
#'   Defaults to 2
#' @importFrom rlang .data
#' @import ggraph
#' @export
geom_node_area <- function(expand = NULL, radius = NULL, concavity = NULL) {

  column_to_use <- "Type"

  geom_to_add <- list()
  for (i in column_to_use) {
    geom_to_add <- list(
      ggforce::geom_mark_hull(
        ggplot2::aes(
          x = .data$x, y = .data$y,
          fill = .data[[column_to_use]], color = .data[[column_to_use]]
        ),
        expand = expand, radius = radius, concavity = concavity
      )
    )
  }

  if (isTRUE(length(geom_to_add) == 0)) {
    geom_to_add <- NULL
  }
  return(geom_to_add)
}

GeomSimplePoint <- ggplot2::ggproto(
  "GeomSimplePoint",
  ggplot2::Geom,
  required_aes = c("x", "y"),
  default_aes = ggplot2::aes(shape = 19, colour = "black"),
  draw_key = ggplot2::draw_key_point,

  draw_panel = function(data, panel_params, coord) {
    coords <- coord$transform(data, panel_params)
    grid::pointsGrob(
      coords$x, coords$y,
      pch = coords$shape,
      gp = grid::gpar(col = coords$colour)
    )
  }
)

#' x
#' @export
geom_simple_point <- function(mapping = NULL, data = NULL, stat = "identity",
                              position = "identity", na.rm = FALSE, show.legend = NA,
                              inherit.aes = TRUE, ...) {
  ggplot2::layer(
    geom = GeomSimplePoint, mapping = mapping, data = data, stat = stat,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

ggplot2::ggplot(ggplot2::mpg, ggplot2::aes(.data$displ, .data$hwy)) +
  geom_simple_point()
