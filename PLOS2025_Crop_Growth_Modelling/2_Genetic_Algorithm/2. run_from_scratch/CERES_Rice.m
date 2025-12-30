function [MCM_Table] = CERES_Rice(GEN, GP)
%% INIT VARIBLES
climV = []; GT = []; GYdbDSSAT = [];  ANTdb = [];  MATdb = [];  BSSdb = [];  CYdb = [];  AYdb = [];  DROUGHTdb = []; DTdb = [];  GYdb2 = []; 
dss = readtable('files/namesGX2.csv');
MCM_Table = [];
%% SOIL
TT = readtable("files/TaiALL.csv");   % SOIL VARIABLES --<  {'LON'}    {'LAT'}    {'sand'}    {'silt'}    {'clay'}    {'BULK'}    {'COARSE'}    {'OrganicCarbon'}    {'N'}    {'PH'}    {'SLLL'}    {'SDUL'}    {'SSAT'}    {'SSKS'}
load('files/IDXgrid.mat'), sum(IDXgrid)
TT1 = readtable("files/TG10191.csv");   
TT2 = readtable("files/TG10192.csv");
TT3 = readtable("files/TG10193.csv");
LON = TT.LON;  LAT = TT.LAT;  %Y = T.Year; % N4
%% TIME
YEARS = [2012:2014];
startt = 165; % datetime('2012-06-23')-->175
SSD = [startt, startt+15, startt+30 , startt+45    , startt+60, startt+75]; %, startt+30, startt+40          % SSD = [startt , startt+7, startt+14, startt+21, startt+28 , startt+35 , startt+42 , startt+49 , startt+56  ];
trialALL = [dss.WTH(1), dss.SOIL(1), dss.ID(1), dss.Cultivar(1)];       % DARO1201,CR06002014,CRDA1201,Nerica 4
writecell(trialALL);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for yy = 1 :  numel(YEARS)
    YYEAR =  YEARS(yy);
    %GP = 73;   % Grid Point  
    j = 3;      % Sowing date      
    [MCM_Table] = [MCM_Table;  ALLgridMECHANISTIC(TT1,TT2,TT3, SSD, YYEAR, LON, LAT, GP, j, climV, GEN) ];    
end

end