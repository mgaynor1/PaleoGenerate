# PaleoGenerate functions
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
library(gtools)

# STEP 1 
## Universal kriging with spatial linear dependence 
### Files generated through 01_InputCSV.R and 02_KriggingLayers.R
### After InputLayers.R I sorted the kriged folder into "bio1/", "bio12/" and "bio19/"
### I also corrected extent (SEE 02_Krigginglayers.R)

## Read in list of files and sort to put in order 
### bio1
bio1_files <- list.files("data/InputLayers/kriged/bio1/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio1_files <- mixedsort(sort(bio1_files))
bio1_stack <- stack(bio1_files)

### bio4
bio4_files <- list.files("data/InputLayers/kriged/bio4/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio4_files <- mixedsort(sort(bio4_files))
bio4_stack <- stack(bio4_files)

### bio8
bio8_files <- list.files("data/InputLayers/kriged/bio8/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio8_files <- mixedsort(sort(bio8_files))
bio8_stack <- stack(bio8_files)

### bio9
bio9_files <- list.files("data/InputLayers/kriged/bio9/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio9_files <- mixedsort(sort(bio9_files))
bio9_stack <- stack(bio9_files)

### bio10
bio10_files <- list.files("data/InputLayers/kriged/bio10/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio10_files <- mixedsort(sort(bio10_files))
bio10_stack <- stack(bio10_files)

### bio11
bio11_files <- list.files("data/InputLayers/kriged/bio11/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio11_files <- mixedsort(sort(bio11_files))
bio11_stack <- stack(bio11_files)

### bio12
bio12_files <- list.files("data/InputLayers/kriged/bio12/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio12_files <- mixedsort(sort(bio12_files))
bio12_stack <- stack(bio12_files)

### bio13
bio13_files <- list.files("data/InputLayers/kriged/bio13/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio13_files <- mixedsort(sort(bio13_files))
bio13_stack <- stack(bio13_files)

### bio14
bio14_files <- list.files("data/InputLayers/kriged/bio14/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio14_files <- mixedsort(sort(bio14_files))
bio14_stack <- stack(bio14_files)

### bio15
bio15_files <- list.files("data/InputLayers/kriged/bio15/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio15_files <- mixedsort(sort(bio15_files))
bio15_stack <- stack(bio15_files)

### bio16
bio16_files <- list.files("data/InputLayers/kriged/bio16/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio16_files <- mixedsort(sort(bio16_files))
bio16_stack <- stack(bio16_files)

### bio17
bio17_files <- list.files("data/InputLayers/kriged/bio17/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio17_files <- mixedsort(sort(bio17_files))
bio17_stack <- stack(bio17_files)

### bio18
bio18_files <- list.files("data/InputLayers/kriged/bio18/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio18_files <- mixedsort(sort(bio18_files))
bio18_stack <- stack(bio18_files)

### bio19
bio19_files <- list.files("data/InputLayers/kriged/bio19/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
bio19_files <- mixedsort(sort(bio19_files))
bio19_stack <- stack(bio19_files)


# STEP 2
## Calculate delta layers

### whichbio function
whichbio <- function(BioV){
  BioV <- BioV
  if (BioV == "Bio1" || BioV == "bio1"){
    Bio1 <- stack(bio1_files) 
  }else if (BioV == "Bio4" || BioV == "bio4" ){
    Bio1 <- stack(bio4_files)
  }else if (BioV == "Bio8" || BioV == "bio8" ){
    Bio1 <- stack(bio8_files)
  }else if (BioV == "Bio9" || BioV == "bio9" ){
    Bio1 <- stack(bio9_files)
  }else if (BioV == "Bio10" || BioV == "bio10" ){
    Bio1 <- stack(bio10_files)
  }else if (BioV == "Bio11" || BioV == "bio11" ){
    Bio1 <- stack(bio11_files)
  }else if (BioV == "Bio12" || BioV == "bio12" ){
    Bio1 <- stack(bio12_files)
  }else if (BioV == "Bio13" || BioV == "bio13" ){
    Bio1 <- stack(bio13_files)
  }else if (BioV == "Bio14" || BioV == "bio14" ){
    Bio1 <- stack(bio14_files)
  }else if (BioV == "Bio15" || BioV == "bio15" ){
    Bio1 <- stack(bio15_files)
  }else if (BioV == "Bio16" || BioV == "bio16" ){
    Bio1 <- stack(bio16_files)
  }else if (BioV == "Bio17" || BioV == "bio17"){
    Bio1 <-stack(bio17_files)
  }else if (BioV == "Bio18" || BioV == "bio18" ){
    Bio1 <- stack(bio18_files)
  }else if (BioV == "Bio19" || BioV == "bio19" ){
    Bio1 <- stack(bio19_files)
  }else print("not a Bio included in our function")
  return(Bio1)
}

### Hansen correction function
hansen <- read.csv("data/Scaling_factor_TabS1.csv")
hansen_correct <- function(var1) {
  var1_c <- approx(hansen$Myr_before_present, hansen$Ts_C, xout = var1, rule = 2) 
  return(var1_c$y)
}

## deltacalcA function
## climatic stacking
deltacalcA <- function(var1, BioV){
  Bio1 <- whichbio(BioV)
  h_var <- hansen_correct(var1)
  if (h_var >= 9.46 & h_var < 9.571 ){
    Bio1A <- raster(Bio1, layer = 1)
    Bio1B <- raster(Bio1, layer = 2)
    Bio1D <- overlay(Bio1A, Bio1B, fun=function(r1, r2){return(r1-r2)})
    return(Bio1D)
  }else if (h_var >= 9.571 & h_var < 12.113){
    Bio1A <- raster(Bio1, layer = 2)
    Bio1B <- raster(Bio1, layer = 5)
    Bio1D <- overlay(Bio1A, Bio1B, fun=function(r1, r2){return(r1-r2)})
    return(Bio1D)
  }else if (h_var >= 12.113 & h_var < 14.06){
    Bio1A <- raster(Bio1, layer = 5)
    Bio1B <- raster(Bio1, layer = 3)
    Bio1D <- overlay(Bio1A, Bio1B, fun=function(r1, r2){return(r1-r2)})
    return(Bio1D)
  }else if (h_var >= 14.06){ #& h_var < 15.75947
    Bio1A <- raster(Bio1, layer = 3)
    Bio1B <- raster(Bio1, layer = 4)
    Bio1D <- overlay(Bio1A, Bio1B, fun=function(r1, r2){return(r1-r2)})
    return(Bio1D)
  }else print("Year selected out of range, must be between 0.0 and 3.3 (million years ago).")
}


# STEP 3
## Calculate difference in surface temperature (Ts)

## Hansen correction function
hansen <- read.csv("data/Scaling_factor_TabS1.csv")
hansen_correct <- function(var1) {
  var1_c <- approx(hansen$Myr_before_present, hansen$Ts_C, xout = var1, rule = 2) 
  return(var1_c$y)
}

## TSCorrection function
TSCorrection <- function(var1){
  TSI <- hansen_correct(var1 = var1)
  h_var <- hansen_correct(var1)
  if (h_var >= 9.46 & h_var < 9.571 ){
    TSA <- hansen_correct(var1 = 0)
    TSB <- hansen_correct(var1 = 0.021)
    correction <- (TSI - TSB)/(TSA - TSB)
    return(correction)
  }else if (h_var >= 9.571 & h_var < 12.113){
    TSA <- hansen_correct(var1 = 0.021)
    TSB <- hansen_correct(var1 = 0.787)
    correction <- (TSI - TSB)/(TSA - TSB)
    return(correction)
  }else if (h_var >= 12.113 & h_var < 14.06){
    TSA <- hansen_correct(var1 = 0.787)
    TSB <- hansen_correct(var1 = 3.3)
    correction <- (TSI - TSB)/(TSA - TSB)
    return(correction)
  }else if (h_var >= 14.06){ #& h_var < 15.75947
    TSA <- hansen_correct(var1 = 3.3)
    TSB <- hansen_correct(var1 = 3.264)
    correction <- (TSI - TSB)/(TSA - TSB)
    return(correction)
  } else print("Year selected out of range, must be between 0.0 and 3.3 (million years ago).")
}


# STEP 4
## Calculate Delta T layer
## BioDeltaT <- (BioDelta * ((TSI-TSB)/(TSA - TSB)))


# STEP 5 
## Delta method of downscaling

## deltadownscale function
deltadownscale <- function(var1, BioV){
  Bio1 <- whichbio(BioV)
  h_var <- hansen_correct(var1)
  if (h_var >= 9.46 & h_var < 9.571 ){
    Bio1B <- raster(Bio1, layer = 2)
    return(Bio1B)
  }else if (h_var >= 9.571 & h_var < 12.113){
    Bio1B <- raster(Bio1, layer = 5)
    return(Bio1B)
  }else if (h_var >= 12.113 & h_var < 14.06){
    Bio1B <- raster(Bio1, layer = 3)
    return(Bio1B)
  }else if (h_var >= 14.06){ #& h_var < 15.75947
    Bio1B <- raster(Bio1, layer = 4)
    return(Bio1B)
  }else print("Year selected out of range, must be between 0.0 and 3.3 (million years ago).")
}


# STEP 6
## Fix coastlines

## make_raster function 
make_raster <- function(biolayer){
  coordinates(biolayer) <- ~ x + y
  gridded(biolayer) <- TRUE
  biolayer_raster <- raster(biolayer)
  crs(biolayer_raster) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
  return(biolayer_raster)
}

## hansen_land_correct function 
hansen <- read.csv("data/Scaling_factor_TabS1.csv")
hansen_land_correct <- function(var1) {
  var1_c <- approx(hansen$Myr_before_present, hansen$SL_m, xout=var1, rule = 2) 
  return(var1_c$y)
}   

## Read in the raster, cropping, and correcting resolution 
Elayer <- raster("data/ETOPO1_res.asc")
e <- extent(-180, 180, 0, 90)
Elayer <- crop(Elayer, e)

ETPO1_fix <- function(var1, BioV){
  # Read in the raster 
  # Add crs 
  crs(Elayer) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
  # Fix resolution to equal biolayers using nearest neighbor
  Bio1 <- whichbio(BioV)
  Bio1 <- raster(Bio1, layer = 1)
  crs(Bio1) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
  Elayerag <- projectRaster(Elayer, Bio1, method = 'ngb')
  # Adding changes in sea-level for each time period
  slcorrect <- hansen_land_correct(var1 = var1)
  values(Elayerag) <- (values(Elayerag) + slcorrect)
  Elayerag2 <- Elayerag
  # For this raster, areas between 0 and -15,000 m below sea 
  # level were reclassified as water (no data) and land areas > 0 m 
  # were reclassified to 1 using the mutate function.
  Elayerag2df <- as.data.frame(Elayerag2, xy=TRUE, na.rm = FALSE)
  Elayerdone <- Elayerag2df %>%
    mutate(E = ifelse(ETOPO1_res <= 0 & ETOPO1_res >= -15000, 0, 1))
  ElayerdoneB <- Elayerdone %>%
    select(x, y, E)
  Elayerdone_raster <- make_raster(ElayerdoneB)
  return(Elayerdone_raster)
}


# Extra step  
## correcting precipitation 

## correct_prec function
correct_prec <- function(BioV, Bio1DeltaT){
  if (BioV == "Bio12" || BioV == "Bio13" || BioV == "Bio14" || BioV == "Bio15" || BioV == "Bio16" || BioV == "Bio17" || BioV == "Bio18" || BioV == "Bio19" || 
      BioV == "bio12" || BioV == "bio13" || BioV == "bio14" || BioV == "bio15" || BioV == "bio16" || BioV == "bio17" || BioV == "bio18" || BioV == "bio19"){
    Bio1DeltaT[Bio1DeltaT < 0] <- NA
    Bio1DeltaT[Bio1DeltaT == 0] <- NA
    return(Bio1DeltaT)
  }else if (BioV == "bio1" || BioV == "bio4" || BioV == "bio8" || BioV == "bio9" || BioV == "bio10" || BioV == "bio11" ||
            BioV == "Bio1" || BioV == "Bio4" || BioV == "Bio8" || BioV == "Bio9" || BioV == "Bio10" || BioV == "Bio11" ){
    Bio1DeltaT <- Bio1DeltaT
    return(Bio1DeltaT)
  }else print("not a Bio included in our function")
}


################################################################################
# Combined function
ending <- ".asc"
folder <- "output/"
Paleo_layergenerate <- function(var1, BioV, folder){
  # STEP 2 - Calculate delta layers
  Bio1Delta <- deltacalcA(var1 = var1, BioV = BioV)
  # STEP 3 - Calculate difference in surface temperature (Ts)
  correction <- TSCorrection(var1 = var1)
  # STEP 4 - Calculate Delta T layer
  Bio1DeltaT <- (Bio1Delta * correction)
  ## Replace negatives with NA in the precipitation layers
  Bio1DeltaT <- correct_prec(BioV = BioV, Bio1DeltaT = Bio1DeltaT)
  # STEP 5 - Delta method of downscaling 
  Bio1B <- deltadownscale(var1 = var1, BioV = BioV)
  Bio1T <- overlay(Bio1Delta, Bio1B, fun=function(r1, r2){return(r1+r2)})
  # STEP 6 - fix coastlines
  Elayer_raster <- ETPO1_fix(var1 = var1, BioV = BioV)
  Bio1T_crop <- (Bio1T* Elayer_raster)
  # Save as asc
  oa <- paste(folder, BioV, sep="")
  out <- paste(oa, var1, sep="_")
  output <- paste(out, ending, sep="")
  writeRaster(Bio1T_crop, output, format = "ascii")
}
