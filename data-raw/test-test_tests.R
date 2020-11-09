# tests give a shot
test_that("`geom_node_area` works", {
  output_obj <- test_dependencies()
  expect_s3_class(output_obj$plot, "ggraph")
  expect_s3_class(output_obj$data, "tbl_df")
  vdiffr::expect_doppelganger("test plot", output_obj$plot)
})
