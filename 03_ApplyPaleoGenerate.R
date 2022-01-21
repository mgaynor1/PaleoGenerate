# 03_ApplyPaleoGenerate
## Applying PaleoGenerate
## PaleoGenerate2.0
## ML Gaynor

# Load source
source("functions/PaleoGenerate.R")

# Load packages
library(foreach)
library(doParallel)
library(iterators)
library(doMC)

# Load time slices
Slice <- read.csv("Slice/Slice_time.csv")
time <- Slice$Time
seq(time)

## make_parallel
make_parallel <- function(schedulerCores){
  numCores = 1
  print(paste("Requested cores:", schedulerCores))
  numCores = schedulerCores
  registerDoParallel(numCores)
  registerDoMC(numCores)
  print(paste("Using ", numCores, " CPU cores for analysis"))
  return(numCores)
}

## Set nodes to 15
num <- make_parallel(15)

# Run Paleo_layergenerate
## Bio1
foreach (data=seq_along(time)) %dopar% { 
  var1 <- as.numeric(time[[data]])
  BioV <- "Bio1"
  Paleo_layergenerate(var1, BioV, folder = "output/Bio1/")
}

## Bio4
foreach (data=seq_along(time)) %dopar% { 
  var1 <- as.numeric(time[[data]])
  BioV <- "Bio4"
  Paleo_layergenerate(var1, BioV, folder = "output/Bio4/")
}

## Bio12
foreach (data=seq_along(time)) %dopar% { 
  var1 <- as.numeric(time[[data]])
  BioV <- "Bio12"
  Paleo_layergenerate(var1, BioV, folder = "output/Bio12/")
}

## Bio13
foreach (data=seq_along(time)) %dopar% { 
  var1 <- as.numeric(time[[data]])
  BioV <- "Bio13"
  Paleo_layergenerate(var1, BioV, folder = "output/Bio13/")
}

## Bio14
foreach (data=seq_along(time)) %dopar% { 
  var1 <- as.numeric(time[[data]])
  BioV <- "Bio14"
  Paleo_layergenerate(var1, BioV, folder = "output/Bio14/")
}

## Bio15
foreach (data=seq_along(time)) %dopar% { 
  var1 <- as.numeric(time[[data]])
  BioV <- "Bio15"
  Paleo_layergenerate(var1, BioV, folder = "output/Bio15/")
}

