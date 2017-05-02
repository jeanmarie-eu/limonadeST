rangeInfo <- function(lim_obj,varid,idim,offset=NULL,count=NULL){
  Vcellsize <- VcellsizeMIN <- Inf
  VMIN <- VMAX <- NA
  Vunit <- lim_obj$extract(varid,idim)$unit
  Vrange <- range(lim_obj$extract(varid,idim,offset,count)$vals)
  Vcellsize <- mean(diff(lim_obj$extract(varid,idim,offset,count)$vals))
  VMIN <- min(Vrange,VMIN,na.rm=TRUE)
  VMAX <- max(Vrange,VMAX,na.rm=TRUE)
  VcellsizeMIN <- abs(min(Vcellsize,VcellsizeMIN,na.rm=TRUE))

  return(list(Vunit = Vunit,
              VMIN  = VMIN,
              VMAX  = VMAX,
              VcellsizeMIN = VcellsizeMIN))
}
