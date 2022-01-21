# 02_KriggingLayers
## Universal Kriging
## PaleoGenerate2.0
## ML Gaynor

# Load source file
source("functions/InputKrige.R")

# Kriging function 
## bio1
breakup_kriging("data/InputLayers/csv/current_bio_1.csv", "data/InputLayers/kriged/bio1_current.asc", 30)
breakup_kriging("data/InputLayers/csv/LGM_bio_1.csv", "data/InputLayers/kriged/bio1_LGM.asc", 30)
breakup_kriging("data/InputLayers/csv/MIS_bio_1.csv", "data/InputLayers/kriged/bio1_MIS19.asc", 30)
breakup_kriging("data/InputLayers/csv/mPWP_bio_1.csv", "data/InputLayers/kriged/bio1_Mid.asc", 30)
breakup_kriging("data/InputLayers/csv/M2_bio_1.csv", "data/InputLayers/kriged/bio1_M2.asc", 30)

## bio4
breakup_kriging("data/InputLayers/csv/current_bio_4.csv", "data/InputLayers/kriged/bio4_current.asc", 30)
breakup_kriging("data/InputLayers/csv/LGM_bio_4.csv", "data/InputLayers/kriged/bio4_LGM.asc", 35)
breakup_kriging("data/InputLayers/csv/MIS_bio_4.csv", "data/InputLayers/kriged/bio4_MIS19.asc", 30)
breakup_kriging("data/InputLayers/csv/mPWP_bio_4.csv", "data/InputLayers/kriged/bio4_Mid.asc", 30)
breakup_kriging("data/InputLayers/csv/M2_bio_4.csv", "data/InputLayers/kriged/bio4_M2.asc", 30)


## bio12
breakup_kriging("data/InputLayers/csv/current_bio_12.csv", "data/InputLayers/kriged/bio12_current.asc", 30)
breakup_kriging("data/InputLayers/csv/LGM_bio_12.csv", "data/InputLayers/kriged/bio12_LGM.asc", 30)
breakup_kriging("data/InputLayers/csv/MIS_bio_12.csv", "data/InputLayers/kriged/bio12_MIS19.asc", 30)
breakup_kriging("data/InputLayers/csv/mPWP_bio_12.csv", "data/InputLayers/kriged/bio12_Mid.asc", 30)
breakup_kriging("data/InputLayers/csv/M2_bio_12.csv", "data/InputLayers/kriged/bio12_M2.asc", 30)

## bio13
breakup_kriging("data/InputLayers/csv/current_bio_13.csv", "data/InputLayers/kriged/bio13_current.asc", 30)
breakup_kriging("data/InputLayers/csv/LGM_bio_13.csv", "data/InputLayers/kriged/bio13_LGM.asc", 30)
breakup_kriging("data/InputLayers/csv/MIS_bio_13.csv", "data/InputLayers/kriged/bio13_MIS19.asc", 30)
breakup_kriging("data/InputLayers/csv/mPWP_bio_13.csv", "data/InputLayers/kriged/bio13_Mid.asc", 30)
breakup_kriging("data/InputLayers/csv/M2_bio_13.csv", "data/InputLayers/kriged/bio13_M2.asc", 30)

## bio14
breakup_kriging("data/InputLayers/csv/current_bio_14.csv", "data/InputLayers/kriged/bio14_current.asc", 30)
breakup_kriging("data/InputLayers/csv/LGM_bio_14.csv", "data/InputLayers/kriged/bio14_LGM.asc", 30)
breakup_kriging("data/InputLayers/csv/MIS_bio_14.csv", "data/InputLayers/kriged/bio14_MIS19.asc", 30)
breakup_kriging("data/InputLayers/csv/mPWP_bio_14.csv", "data/InputLayers/kriged/bio14_Mid.asc", 30)
breakup_kriging("data/InputLayers/csv/M2_bio_14.csv", "data/InputLayers/kriged/bio14_M2.asc", 30)

## bio15
breakup_kriging("data/InputLayers/csv/current_bio_15.csv", "data/InputLayers/kriged/bio15_current.asc", 30)
breakup_kriging("data/InputLayers/csv/LGM_bio_15.csv", "data/InputLayers/kriged/bio15_LGM.asc", 30)
breakup_kriging("data/InputLayers/csv/MIS_bio_15.csv", "data/InputLayers/kriged/bio15_MIS19.asc", 30)
breakup_kriging("data/InputLayers/csv/mPWP_bio_15.csv", "data/InputLayers/kriged/bio15_Mid.asc", 30)
breakup_kriging("data/InputLayers/csv/M2_bio_15.csv", "data/InputLayers/kriged/bio15_M2.asc", 30)


# Correct extent
## Load pre-kriged file
bio1_og <- raster("data/InputLayers/asc/current_bio_1.asc")

## List files and sort 
krigged_files <- list.files("data/InputLayers/kriged/", full.names = TRUE, recursive = FALSE, pattern = "*.asc$")
krigged_files <- mixedsort(sort(krigged_files))

## Loop through all files to fix the CRS
for (i in krigged_files){
  raster <- raster(i)
  raster_fixed <- resample(raster, bio1_og)
  raster::writeRaster(raster_fixed, i, format = "ascii", overwrite = TRUE)
}

# Move files into folders
system("mkdir data/InputLayers/kriged/bio1")
system("mkdir data/InputLayers/kriged/bio4")
system("mkdir data/InputLayers/kriged/bio12")
system("mkdir data/InputLayers/kriged/bio13")
system("mkdir data/InputLayers/kriged/bio14")
system("mkdir data/InputLayers/kriged/bio15")

system("mv data/InputLayers/kriged/bio1_*.asc data/InputLayers/kriged/bio1/")
system("mv data/InputLayers/kriged/bio4*.asc data/InputLayers/kriged/bio4/")
system("mv data/InputLayers/kriged/bio12*.asc data/InputLayers/kriged/bio12/")
system("mv data/InputLayers/kriged/bio13*.asc data/InputLayers/kriged/bio13/")
system("mv data/InputLayers/kriged/bio14*.asc data/InputLayers/kriged/bio14/")
system("mv data/InputLayers/kriged/bio15*.asc data/InputLayers/kriged/bio15/")


