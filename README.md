# limonadeST

[![Travis-CI Build Status](https://travis-ci.org/jeanmarielepioufle/timeManip.svg?branch=master)](https://travis-ci.org/jeanmarielepioufle/limonadeST)

limonadeST makes easy the extraction of space-time datasets.

The package focuses on providing simple and efficient ways to manipulate space-time grid datasets.

Without any effort:

1. get automatically spatial and temporal objects, and an easy access to values.

2. Spatial and temporal information and values are inter-connected for an easier exploitation.

## Installation

```R
# install.packages("devtools")
devtools::install_github("jeanmarielepioufle/limonadeST")
```

## Usage

```R
library(limonadeST)

# filename
filename <-  "/path/to/your/file/filename"

# parameters of your file
format <- "netcdf"
varid <- "mean_temperature"
proj4S <- spatialManip::crs("+proj=utm +zone=33 +ellps=GRS80 +units=m +no_defs")
param <- limonadeST_param()
# xi,yi,ti represents the space-time structure of you file
xi <- 1L
yi <- 2L
ti <- 3L
# CELLCENTER tells whether or not the coordinate respresents the cell center
CELLCENTER <- TRUE
param$new(varid=varid,proj4S=proj4S,xi=xi,yi=yi,ti=ti,CELLCENTER=CELLCENTER)

# make the connection to your file
limSTObj <- limonadeST(filename=filename,format=format,param)

# subset
limSTObj$subset(offset = list(i=1,j=1,k=1), count = list(i=1000,j=1000,k=1),v=450)

limSTObj

sp::plot(limSTObj$spatial())
limSTObj$date()$fromPeriod()
limSTObj$date()$toPeriod()
limSTObj$date()$timeResolution()
v <- limSTObj$values()

limSTObj

param$reset()
```

The public package only accept necdf4 file sofar.
I am working on making a vignette.

## Questions and remarks
Don't hesitate to contact me for more details and suggestions.
