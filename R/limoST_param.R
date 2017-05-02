
#' limonadeST_param
#'
#' limonadeST_param
#' @keywords limonadeST
#' @export
#' @examples
#' \dontrun{
#' limonadeST_param()
#' }
limonadeST_param <- function(){
  limonadeST_param_object()
}

limonadeST_param_object <- function(){

   limoST_param <-NULL

   object <- local({

     new <- function(varid=NULL,proj4S=NULL,xi=NULL,yi=NULL,ti=NULL,CELLCENTER=NULL){
        limoST_param <<- list(varid=varid,proj4S=proj4S,xi=xi,yi=yi,ti=ti,CELLCENTER=CELLCENTER)
        invisible()
     }
     reset <- function(){
        limoST_param <<- NULL
        invisible()
     }

     settle <- function(varid=NULL,proj4S=NULL,xi=NULL,yi=NULL,ti=NULL,CELLCENTER=NULL){
        if (!is.null(limoST_param)){
          if (!is.null(varid)) limoST_param$varid <<- varid
          if (!is.null(proj4S)) limoST_param$proj4S <<- proj4S
          if (!is.null(xi)) limoST_param$xi <<- xi
          if (!is.null(yi)) limoST_param$yi <<- yi
          if (!is.null(ti)) limoST_param$ti <<- ti
          if (!is.null(CELLCENTER)) limoST_param$CELLCENTER <<- CELLCENTER
        }
        invisible()
     }

     summary <- function(){
       return(limoST_param)
     }

     environment()
     })
     lockEnvironment(object, TRUE)
     structure(object, class=c("limonadeST_param", class(object)))
}
