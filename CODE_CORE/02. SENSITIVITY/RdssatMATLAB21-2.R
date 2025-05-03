library(DSSAT)
library(Dasst)
library(dplyr)

#setwd("C:/Users/USER/Desktop/ARTICLE1/SENSITIVITY/")
setwd("C:/Users/USER/Desktop/CODE PhD - TEST 2025/02. SENSITIVITY/")
getwd()

trial<- read.csv("trialALL.txt", header=FALSE)

#trial.txt

#wth <- read_wth('CLT/weather/input/DARO1201.WTH')
#wth <- read_wth('/CLT/weather/DARO1201.csv')
wth <- read_wth(paste0('DARO1201.WTH')) # DSSATmeteo.WTH')) #WTH      DARO1201.WTH     SEFA1301.WTH

soil <- read_sol("CR.SOL",id_soil = trial$V2)  #"DSS/SOIL/CR.SOL"
soil$PEDON = "CR06002014"
soil$SBDM[[1]][1]
soil$SLCL[[1]][1]
soil$SLSI[[1]][1]
soil$SLOC[[1]][1]
soil$SLNI[[1]][1]
soil$SLHW[[1]][1]
x <- c(soil$SBDM[[1]][1], soil$SLCL[[1]][1], soil$SLSI[[1]][1], soil$SLOC[[1]][1], soil$SLNI[[1]][1], soil$SLHW[[1]][1])
write.csv(x,'x.csv',row.names=FALSE, quote=FALSE)

options(DSSAT.CSM = 'C:\\DSSAT48\\dscsm048.exe')
t <- tibble(FILEX=paste0(trial$V3,'.WHX'), TRTNO=1:1, RP=1, SQ=0, OP=0, CO=0) %>% write_dssbatch()  #'DSS/WHX/',   trial$V3
run_dssat()

DSSAT_plant_original <- read_output('PlantGro.OUT')
write.csv(DSSAT_plant_original, "PlantGro.csv", row.names=TRUE, quote=FALSE)

DSSAT_meteo <- read_output('Weather.OUT')
write.csv(DSSAT_meteo, "Weather.csv", row.names=TRUE, quote=FALSE)

DSSAT_ET<- read_output('ET.OUT')
write.csv(DSSAT_ET, "ET.csv", row.names=TRUE, quote=FALSE)

DSSAT_plant_original <- read_output('Summary.OUT')
write.csv(DSSAT_plant_original, "Summary.csv", row.names=TRUE, quote=FALSE)
DSSAT_plant_original$HWAH[1]

#DS <- read_output('PlantGro.OUT')

