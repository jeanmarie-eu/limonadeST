values_ <- function(lim_obj,limonadeST_param,offset=NULL,count=NULL){
  par <- limonadeST_param$summary()
  stopifnot(!is.null(par$varid))
  res <- lim_obj$extract(varid=par$varid,offset=offset,count=count)$vals
  return(res)
}
