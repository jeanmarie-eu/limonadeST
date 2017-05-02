buildSpatial_ <- function(lim_obj,limonadeST_param,offset=NULL,count=NULL,cellsize=NULL){
  par <- limonadeST_param$summary()

  if ( is.null(par$varid) || is.null(par$xi) || is.null(par$yi) || is.null(par$proj4S) || is.null(par$CELLCENTER)) {
     res <- NULL
  } else {
    if(!is.null(offset) && !is.null(count)){
      if ((count$i==1) && (count$j==1)) {
        tmp <- rangeInfo(lim_obj,par$varid,par$xi,offset$i,count$i)
        X <- list(Vunit = tmp$Vunit,
                  VMIN  = tmp$VMIN,
                  VMAX  = tmp$VMAX,
                  VcellsizeMIN = ifelse(is.null(cellsize),1,cellsize))

        tmp <- rangeInfo(lim_obj,par$varid,par$yi,offset$j,count$j)
        Y <- list(Vunit = tmp$Vunit,
                  VMIN  = tmp$VMIN,
                  VMAX  = tmp$VMAX,
                  VcellsizeMIN = ifelse(is.null(cellsize),1,cellsize))

      } else if ((count$i==1) || (count$j==1)) {
        tmp1 <- rangeInfo(lim_obj,par$varid,par$xi,offset$i,count$i)
        tmp2 <- rangeInfo(lim_obj,par$varid,par$yi,offset$j,count$j)

        X <- list(Vunit = tmp1$Vunit,
                  VMIN  = tmp$VMIN,
                  VMAX  = tmp$VMAX,
                  VcellsizeMIN = max(tmp1$VcellsizeMIN,tmp2$VcellsizeMIN,na.rm=TRUE))

        Y <- list(Vunit = tmp2$Vunit,
                  VMIN  = tmp2$VMIN,
                  VMAX  = tmp2$VMAX,
                  VcellsizeMIN = max(tmp1$VcellsizeMIN,tmp2$VcellsizeMIN,na.rm=TRUE))
      } else {
        X <- rangeInfo(lim_obj,par$varid,par$xi,offset$i,count$i)
        Y <- rangeInfo(lim_obj,par$varid,par$yi,offset$j,count$j)
      }


    } else {
      X <- rangeInfo(lim_obj,par$varid,par$xi)
      Y <- rangeInfo(lim_obj,par$varid,par$yi)
    }

    x <- spatialManip::xGridBuild(xmin=X$VMIN,xmax=X$VMAX,ymin=Y$VMIN,ymax=Y$VMAX,cellsize=min(X$VcellsizeMIN,Y$VcellsizeMIN),CELLCENTER=par$CELLCENTER)
    res <- spatialManip::construct(type="grid",x=x,proj4S=par$proj4S)
  }
  return(res)
}
