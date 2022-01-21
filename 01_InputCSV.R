# 01_InputCSV
## Reduce complexity and create input CSV
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
library(raster)
library(gtools)

############ Make input CSV files for kriging function ###########
# Crop input layers and write as df without NAs
## Set desired extent
e <- extent(-180, 180, 0, 90)

## raster_convertpt function
### Input includes the original file (from PaleoClim), the new file name, and the output path + filename
raster_convertpt <- function(file, newfile, newrast){
  rast <- raster(file)
  ## Crop raster to desired extent
  rasta <- crop(rast, e)
  ## Decrease the resolution of the raster by a factor of 2
  rastb <- raster::aggregate(rasta, fact=2)
  ## Convert to df
  raster::writeRaster(rastb, newrast, format = "ascii")
  pt <- as.data.frame(rastb, xy=TRUE, na.rm = TRUE)
  ## Write as csv
  write.csv(pt, newfile, row.names = FALSE)
}


# Create lists for each set of input files 
current <- list.files("data/fixed_layers/CHELSA_cur_V1_2B_r10m/", pattern = "*.tif")
LGM <- list.files("data/fixed_layers/chelsa_LGM_v1_2B_r10m/", pattern = "*.tif")
MIS <- list.files("data/fixed_layers/MIS19_v1_r10m/", pattern = "*.tif")
mPWP <- list.files("data/fixed_layers/mPWP_v1_r10m/", pattern = "*.tif")
M2 <- list.files("data/fixed_layers/M2_v1_r10m/", pattern = "*.tif")

## For each list, I created a 'for' loop to create the name and output directory for each layer set. 
### Current
for (i in current){
  tag <- "current"
  oldd <- "data/fixed_layers/CHELSA_cur_V1_2B_r10m/"
  newd <- "data/InputLayers/"
  file <- paste(oldd, i, sep="")
  i2 <- gsub("tif", "csv", i)
  new <- paste(tag, i2, sep="_")
  i3 <- gsub("tif", "asc", i)
  newrast <- paste(tag, i3, sep="_")
  newfile <- paste(newd, new, sep="")
  newfilerast <- paste(newd, newrast, sep="")
  raster_convertpt(file, newfile, newfilerast)
}

### LGM
for (i in LGM){
  tag <- "LGM"
  oldd <- "data/fixed_layers/chelsa_LGM_v1_2B_r10m/"
  newd <- "data/InputLayers/"
  file <- paste(oldd, i, sep="")
  i2 <- gsub("tif", "csv", i)
  new <- paste(tag, i2, sep="_")
  i3 <- gsub("tif", "asc", i)
  newrast <- paste(tag, i3, sep="_")
  newfile <- paste(newd, new, sep="")
  newfilerast <- paste(newd, newrast, sep="")
  raster_convertpt(file, newfile, newfilerast)
}

### MIS 
for (i in MIS){
  tag <- "MIS"
  oldd <- "data/fixed_layers/MIS19_v1_r10m/"
  newd <- "data/InputLayers/"
  file <- paste(oldd, i, sep="")
  i2 <- gsub("tif", "csv", i)
  new <- paste(tag, i2, sep="_")
  i3 <- gsub("tif", "asc", i)
  newrast <- paste(tag, i3, sep="_")
  newfile <- paste(newd, new, sep="")
  newfilerast <- paste(newd, newrast, sep="")
  raster_convertpt(file, newfile, newfilerast)
}

### mPWP
for (i in mPWP){
  tag <- "mPWP"
  oldd <- "data/fixed_layers/mPWP_v1_r10m/"
  newd <- "data/InputLayers/"
  file <- paste(oldd, i, sep="")
  i2 <- gsub("tif", "csv", i)
  new <- paste(tag, i2, sep="_")
  i3 <- gsub("tif", "asc", i)
  newrast <- paste(tag, i3, sep="_")
  newfile <- paste(newd, new, sep="")
  newfilerast <- paste(newd, newrast, sep="")
  raster_convertpt(file, newfile, newfilerast)
}

### M2
for (i in M2){
  tag <- "M2"
  oldd <- "data/fixed_layers/M2_v1_r10m/"
  newd <- "data/InputLayers/"
  file <- paste(oldd, i, sep="")
  i2 <- gsub("tif", "csv", i)
  new <- paste(tag, i2, sep="_")
  i3 <- gsub("tif", "asc", i)
  newrast <- paste(tag, i3, sep="_")
  newfile <- paste(newd, new, sep="")
  newfilerast <- paste(newd, newrast, sep="")
  raster_convertpt(file, newfile, newfilerast)
}

# Move files to folders
# system("mkdir data/InputLayers/csv")
# system("mkdir data/InputLayers/asc")
# system("mv data/InputLayers/*.csv data/InputLayers/csv/  ")
# system("mv data/InputLayers/*.asc data/InputLayers/asc/  ")


# Change headers in bio12 and bio17 files
# system("for i in data/InputLayers/csv/*_bio_4.csv; do perl -pi -e 's/\"bio_4\"/\"bio_1\"/g' $i; done")
# system("for i in data/InputLayers/csv/*_bio_12.csv; do perl -pi -e 's/\"bio_12\"/\"bio_1\"/g' $i; done")
# system("for i in data/InputLayers/csv/*_bio_13.csv; do perl -pi -e 's/\"bio_13\"/\"bio_1\"/g' $i; done")
# system("for i in data/InputLayers/csv/*_bio_14.csv; do perl -pi -e 's/\"bio_14\"/\"bio_1\"/g' $i; done")
# system("for i in data/InputLayers/csv/*_bio_15.csv; do perl -pi -e 's/\"bio_15\"/\"bio_1\"/g' $i; done")

