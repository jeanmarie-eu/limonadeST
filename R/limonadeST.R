#' limonadeST
#'
#' limonadeST
#' @param filename filename or vector of filenames
#' @param format format of the file
#' @param limonadeST_param limonadeST_param object
#' @keywords limonadeST
#' @export
#' @examples
#' \dontrun{
#' limonadeST()
#' }
limonadeST <- function(filename=NULL,format=NULL,limonadeST_param=NULL){
  stopifnot(!is.null(filename))
  stopifnot(!is.null(format))
  stopifnot(!is.null(limonadeST_param))
  limonadeST_object(filename=filename,format=format,limonadeST_param=limonadeST_param)
}

limonadeST_object <- function(filename,format,limonadeST_param){

   lim_obj <- limonade::limonade(filename=filename,format=format)

   spatial_obj <- NULL
   date_obj <- NULL

   offset <- NULL
   count <- NULL

   object <- local({

     subset <- function(offset_p,count_p,v=NULL,cellsize=NULL){
       offset <<- offset_p
       count <<- count_p
       spatial_obj <<- buildSpatial_(lim_obj,limonadeST_param,offset=offset,count=count,cellsize=cellsize)
       date_obj <<- buildDate_(lim_obj,limonadeST_param,offset=offset,count=count,v=v)
       invisible()
     }

     spatial <- function(HIDDEN=FALSE,v=NULL,cellsize=NULL){
       if (is.null(spatial_obj)){
         spatial_obj <<- buildSpatial_(lim_obj,limonadeST_param,offset=offset,count=count,cellsize=cellsize)
       }
       if (HIDDEN) {
         invisible()
       } else return(spatial_obj)
     }

     date <- function(HIDDEN=FALSE,v=NULL){
         if (is.null(date_obj)){
           date_obj <<- buildDate_(lim_obj,limonadeST_param,offset=offset,count=count,v=v)
         }
         if (HIDDEN) {
           invisible()
         } else return(date_obj)
     }

     values <- function(of=NULL,co=NULL){
         if (!is.null(of) && !is.null(co)) {
           return(values_(lim_obj=lim_obj,limonadeST_param=limonadeST_param,offset=of,count=co))
         } else if (is.null(of) && is.null(co)) {
           return(values_(lim_obj=lim_obj,limonadeST_param=limonadeST_param,offset=offset,count=count))
         }
     }

     summary <- function(...){
       return(summary_(lim_obj,date_obj,spatial_obj))
     }

     environment()
     })
     lockEnvironment(object, TRUE)
     structure(object, class=c("limonadeST", class(object)))
}
