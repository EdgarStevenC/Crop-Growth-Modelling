library("nasapower")

#setwd("C:/Users/CORREAPINZON/Downloads/Climate_Data_Store_Toolbox_for_MATLAB (1)")

#setwd('C:/Users/CORREAPINZON/Desktop/Samara/1.UNO_ENVIRONMENTDB/WEATHER')
setwd('D:/Full DISK MAY 2024/MAIN CODE/1.UNO_ENVIRONMENTDB/WEATHER -  CODES')

#setwd("C:/Users/CORREAPINZON/Desktop/Samara")  # Downloads/ShapeFILE")  #
lonlat<- read.csv("lonlat.txt", header=FALSE)
year<- read.csv("year.txt", header=FALSE)

#CLRSKY_SFC_PAR_TOT  CLRSKY_SFC_SW_DWN
daily_ag <- get_power(community = "ag",
                      lonlat = c( lonlat$V1 , lonlat$V2 ), #lonlat = c( -13.9579359374857,13.7676445493381 ),
                      pars = c("ALLSKY_SFC_SW_DWN","T2M_MAX","T2M_MIN","T2M","QV2M","RH2M","PRECTOTCORR","WS2M","WD2M","GWETTOP","GWETROOT","GWETPROF"),
                      dates = c(year$V1, year$V2),    #"20210501","20211130"),    CLRSKY_SFC_SW_DWN
                      temporal_api = "daily"
)
daily_ag


write.csv(daily_ag, "daily.csv", row.names=TRUE, quote=FALSE)


# dates = c("20210501"),

