summary_ <- function(lim_obj,date_obj,spatial_obj){
  res <- list()
  if (!is.null(date_obj)) res$date <- date_obj$summary() 
  if (!is.null(spatial_obj)) {
    cellsize <- spatial_obj@grid@cellsize
    res$spatial <- list(grid = list(cellcentre.offset = spatialManip::cellcentre_offset(spatial_obj,cellsize),
                                  cellsize = spatial_obj@grid@cellsize,
                                  cells.dim = spatialManip::cellDim(spatial_obj,cellsize)),
                        bbox = spatialManip::minmax(spatial_obj),
                        proj4string = spatialManip::proj4string(spatial_obj))
  }
  if (!is.null(lim_obj)) res$limonade <- lim_obj$summary()
  return(res)
}
