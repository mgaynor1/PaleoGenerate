# Input Krige functions
## PaleoGenerate2.0
## ML Gaynor

# Load packages
library(sp)
library(gstat)
library(automap)
library(raster)
library(sf)
library(dplyr)
library(tidyr)
library(rgdal)
library(gtools)

# Parallelization
library(foreach)
library(doParallel)
library(iterators)
library(doMC)


# split_k function
split_k <- function(x, k, remainder_as_additional = FALSE) {
  if (k < 2) {
    stop("k needs to be 2 or more")
  }
  if (nrow(x) %% k == 0) {
    split(x, rep(1:k, nrow(x)/k))
  } else {
    # Find the remainder
    rem <- nrow(x) %% k
    div <- floor(nrow(x)/k)
    if (remainder_as_additional) {
      split(x, c(rep(1:k, each=div), rep(k+1, rem)))
    } else {
      split(x, c(rep(1:(k-1), each=div), rep(k, div + rem)))
    }
  }
}

# create_kriglist function
krig_ending <- ".asc"
create_kriglist <- function(dfall, number){
  df <- dfall
  ## Make into raster
  sp::coordinates(df) <- ~x+y
  proj4string(df)<- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
  ## Fit the Variogram
  vgOK <- autofitVariogram(bio_1 ~ x+y, df)
  vgOK <- vgOK$var_model
  ## Predict krige
  print("Predict krige")
  directory <- "data/temp/krigged"
  output <- paste(directory, number, sep="_")
  output <- paste(output, krig_ending, sep="")
  raster::writeRaster((raster(gstat::krige(bio_1 ~ x+y, df, as(df,"SpatialPixelsDataFrame"), model=vgOK))), 
                      output,  format = "ascii")
}

# make_parallel function
make_parallel <- function(schedulerCores){
  numCores = 1
  print(paste("Requested cores:", schedulerCores))
  numCores = schedulerCores
  registerDoParallel(numCores)
  registerDoMC(numCores)
  print(paste("Using ", numCores, " CPU cores for analysis"))
  return(numCores)
}

# breakup_kriging function
breakup_kriging <- function(input_path, output_path, schedulerCores){
  ## Read csv
  print(paste("Reading data from", input_path))
  df <- read.csv(input_path)
  ## Split into equal parts and save the leftovers
  sections = as.integer(schedulerCores) - 1
  dfall <- split_k(df, sections, remainder_as_additional=TRUE)
  ## Kriging loop
  print("Starting Kriging")
  num <- make_parallel(schedulerCores)
  system("mkdir data/temp")
  foreach (data=seq_along(dfall), n = icount(num)) %dopar% { 
    create_kriglist(dfall[[data]], number = n )
  }
  print("Finished Kriging") 
  ## Merge krig output
  kriglist <- list.files("data/temp/", full.names = TRUE)
  kriglist <-  mixedsort(sort(kriglist))
  raster_kriglist = raster(kriglist[1])
  for (i in 2:length(kriglist)){
    element = raster(kriglist[[i]])
    print(paste("Merging element", i))
    raster_kriglist = merge(raster_kriglist, element)	
  }
  system("rm -r data/temp")
  print(paste("Writing results to", output_path))
  writeRaster(raster_kriglist, output_path, format = "ascii", overwrite=TRUE)
}


