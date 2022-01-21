# PaleoGenerate

## Introduction  

High-resolution paleoclimatic datasets are broadly applicable to investigating drivers of contemporary biodiversity patterns. Generation of paleoclimatic layers is often done with proprietary software, which greatly limits new applications, particularly for those without advanced GIS skills. Here, we provide a completely open source-based approach to infer robust paleoclimatic layers, specifically annual mean temperature (bio1), for 50 distinct time segments between 0 and 3.3 MYA. In addition, we generate layers for five additional bioclimatic variables: temperature seasonality (bio4), annual precipitation (bio12), precipitation of wettest month (bio13), precipitation of driest month (bio14), and precipitation seasonality (bio15). 

PaleoGenerate is an R project used to generate Bioclim variables at time between 0 and 3.3 million years ago (MYA). This method is based on [Gamisch, 2019](https://onlinelibrary.wiley.com/doi/full/10.1111/geb.12979) and utilizes [PaleoClim layers](http://paleoclim.org/). 

| Variable |  |
| ------------ | ------------- |
| BIO1 | Annual Mean Temperature |
| BIO4 | Temperature Seasonality |
| BIO12 | Annual Precipitation |
| BIO13 | Precipitation of Wettest Month |
| BIO14 | Precipitation of Driest Month |
| BIO15 | Precipitation Seasonality |

Despite the ability of these scripts to generate predictions for additional variables, we caution this use. Historical trends in temperature and precipitation are temporally and spatially distinct; given the use of temperature data for extrapolation, we conservatively excluded layers that are based on a relationship between precipitation and temperature (Bio8–Bio11 and Bio16–Bio19). Our methods substantially improve upon Oscillayers [(Gamisch, 2019](https://onlinelibrary.wiley.com/doi/full/10.1111/geb.12979), a recent similar attempt to generate gridded paleoclimate data with high temporal resolution, which has been the subject of criticism [Brown et al. 2020](https://onlinelibrary.wiley.com/doi/full/10.1111/geb.13103). Our work addresses a number of these criticisms. Among the limitations pointed out by Brown et al. (2020)  is that the Oscillayers approach assumes no spatio-temporal variation in climates; this is potentially problematic because historical climate change had high spatial heterogeneity. We address this limitation by utilizing a stronger set of historical time periods through Paleoclim layers and avoid extrapolation in the predictions. However, as an important potential shortcoming, we point out that we are assuming a linear relationship between global temperature and precipitation for the precipitation datasets; therefore we caution care in the use of the the use of our precipitation layers (Bio12, Bio13, Bio14, and Bio15) but provide them for the benefit of interested users. 

## Workflow
![Figure 1: Flowchart of workflow for generating layers with PaleoGenerate. Red points in Hansen plot indicate the corresponding surface temperature for each time point included.](Workflow.jpg)


## Set-up
Locally, I set up an [R project](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects). This is where I generated the input files for PaleoGenerate and tested the functions.

Input data files obtained PaleoClim included the following:

| Name | Age |
| ------------ | ------------- |
| Current | 1979 – 2013, marked as 0 Mya |
| Pleistocene: Last Glacial Maximum (LGM) | ca. 21 ka |
| Pleistocene: MIS19 | ca. 787 ka |
| Pliocene: mid-Pliocene warm period (Mid) | 3.264-3.025 Mya, set as equal to 3.264 Mya|
| Pliocene: M2 | ca. 3.3 Mya |



## Generating Input files for PaleoGenerate
The **.R** R file generates raster stacks for each desired bioclim variable using layer files for 0 to 3.3 million years ago (MYA) obtained from [PaleoClim layers](http://paleoclim.org/). All layers were cropped to the extent of 180 E, 180 W, 0 N, and 90 N - this decreased run time. 
 
 
## Running PaleoGenerate

