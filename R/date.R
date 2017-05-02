buildDate_ <- function(lim_obj,limonadeST_param,offset=NULL,count=NULL,v=NULL){

  par <- limonadeST_param$summary()

  if (is.null(par$varid) || is.null(par$ti)) {
     res <- NULL
  } else {
    if(!is.null(offset) && !is.null(count)){
      if (count$k==1) {
         tmp <- rangeInfo(lim_obj,par$varid,par$ti,offset$k,count$k)
         T <- list(Vunit = tmp$Vunit,
                   VMIN  = tmp$VMIN,
                   VMAX  = tmp$VMAX,
                   VcellsizeMIN = ifelse(is.null(v),1,v))
      } else {
        T <- rangeInfo(lim_obj,par$varid,par$ti,offset$k,count$k)
      }

    } else {
      T <- rangeInfo(lim_obj,par$varid,par$ti)
    }
    infoDate <- timeUnit(T$Vunit)
    fromPeriod <- timeManip::YYYYmmddHHMMSS(timeManip::addition_nonsec(date=infoDate$dateBeginning,timeResolution=infoDate$timeResolution,v=T$VMIN))
    toPeriod   <- timeManip::YYYYmmddHHMMSS(timeManip::addition_nonsec(date=infoDate$dateBeginning,timeResolution=infoDate$timeResolution,v=T$VMAX))
    res <- timeManip::timeManip(fromPeriod=fromPeriod,toPeriod=toPeriod,timeResolution=infoDate$timeResolution,v=T$VcellsizeMIN)

  }
  return(res)
}


timeUnit <- function(x){
  tmp <- unlist(strsplit(x, "\\s+"))
  timeResolution <- TR(tmp[1])
  dateBeginning  <- DB(gsub("-","",gsub(":","",paste(tmp[3:length(tmp)],collapse=""))))

  return(list(
         timeResolution = timeResolution,
         dateBeginning  = dateBeginning)
       )
}

# timeResolution
TR <- function(x){
  res <- switch(x,
    "seconds"     = "second",
    "minutes"     = "minute",
    "hours"       = "hourly",
    "three-hours" = "three-hourly",
    "days"        = "daily",
    "months"      = "monthly",
    "years"       = "yearly",
    stop("time unit not recognized: ", x)
    )
  return(res)
}

# beginning date
DB <- function(x){
  res <- timeManip::YYYYmmddHHMMSS_chr(x)
  return(res)
}
