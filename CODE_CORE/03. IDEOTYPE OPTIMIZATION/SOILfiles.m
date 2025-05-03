function [] = SOILfiles(X, Y, i, sowD, COARSE, SILT, CLAY, BULK, CARB, N, PH, SLLL, SDUL, SSAT, SSKS)
% n = 1;
%% PARAMS SOIL *************************************************************************************
% % soil_df = readtable('CLT\soil\SNGL\ouput\soil_df.csv');
% % SOL = soil_df(1,:);  %  BULK    CLAY    SILT      C       N      PH ???
% % mm2 = soil_df{1,11};
% % M2 = mm2{1};         % 10 = Soil_Name
% % SOL.soil_ID = M2;
% 
% FSOL.soil_ID = num2str(i);
% FSOL.wsalt = 23; 
% FSOL.wslat = X;
% FSOL.wslong = Y;
% 
% FSOL.stockinisurf = 10;      %SOL.stockinisurf;
% FSOL.stockiniprof = 10;      %SOL.stockiniprof;
% FSOL.epaisseursurf = 100;    %SOL.epaisseursurf;
% FSOL.epaisseurprof = 1000;   %SOL.epaisseurprof;
% 
% FSOL.tankminirrig = 0;
% FSOL.tankmaxirrig = 0;
% FSOL.tankcapacity = 0;
% FSOL.volrelmacropores = 10;
% 
% FSOL.ca =  400;              %SOL.ca;
% FSOL.seuilruiss = 15;        %SOL.seuilruiss;
% FSOL.pourcruiss = 30;        %SOL.pourcruiss;
% 
% FSOL.humcr = 0.19;
% 
% FSOL.humpf = 0.0267;         %SOL.humpf;
% FSOL.humfc = 0.2822;         %SOL.humfc;
% FSOL.humsat = 0.3727;        %SOL.humsat;
% FSOL.pevap = 0.2000;         %SOL.pevap;
% FSOL.percolationmax = 5;     %SOL.percolationmax;
% 
% SOL = struct2table(FSOL);
% %% ITK *************************************************************************************
% 
% M3 = strcat('CLT\itk\output\','CRDA1201.csv');
% Gx = readtable(strcat('CLT\itk\output\','CRDA1201.csv') );
% ITK = Gx;
% ITK.sowing = juliandate(sowD);
% ITK.startingdate = ITK.sowing-30 ;
% ITK.endingdate = ITK.sowing+120 ;
% % Parameters Managment
% % wslat = 13.83; % New file
% %ca = 400;
% %percolationmax = 5;
% %pevap = 0.2;
% %pourcruiss = -999; %30
% %seuilruiss = -999; %15
% ITK.densitynursery = 1000000;
% ITK.kpar = 0.5;
% ITK.bundheight = 0;
% % ITK.plotdrainagedaf=99;
% ITK.lifesavingdrainage=1;
% 
% FITK.ITK_id = num2str(i);
% FITK.startingdate = ITK.startingdate;
% FITK.endingdate = ITK.endingdate;
% FITK.kpar = ITK.kpar;
% FITK.sowing = ITK.sowing;
% FITK.profracini = ITK.profracini;    % 20 --> % 50
% FITK.densite = 53333; 
% FITK.laiini = 0;
% FITK.mulch = ITK.mulch; 
% FITK.degreesjourini = 0;
% FITK.biomasseini = 0;
% FITK.seuileausemis = 20;
% FITK.nbjtestsemis = 20;
% FITK.seuilstresssemis = 0;
% FITK.plantsperhill = 1;                            % ITK.plantsperhill;       %-999  --> % 1
% FITK.bundheight = ITK.bundheight;
% FITK.lifesavingdrainage = ITK.lifesavingdrainage;
% FITK.plotdrainagedaf = 0;                          % ITK.plotdrainagedaf;     %-999  --> % 99
% FITK.irrigauto = 0;                                % ITK.irrigauto;           %-999  --> % 0
% FITK.irrigautotarget = 0;                          % ITK.irrigautotarget;     %-999  --> % 0.5
% FITK.transplanting = ITK.transplanting;
% FITK.durationnursery = 0;                          % 20
% FITK.densitynursery = ITK.densitynursery;          % 1 000 000 --> % 40 000 000
% FITK.densityfield = ITK.densityfield;              % 600 000 -->   % 62 500
% FITK.coefftransplantingshock = ITK.coefftransplantingshock; 
% FITK.irrigautostop = 0;                            % ITK.irrigautostop;       % -999
% FITK.irrigautoresume = 0;                          % ITK.irrigautoresume;
% FITK.ftswirrig = 0;                                % ITK.ftswirrig; 
% FITK.transplantingdepth = ITK.transplantingdepth;
% ITK = struct2table(FITK);
% %% Cultivar *************************************************************************************
% % M4 = strcat("CLT\cultivar\",T.CULTn(n,:),".csv");
% %% NERICA 4
% M4 = strcat("CLT\cultivar\",'Nerica 4',".csv");
% CUL01 = readtable(M4);
%  CUL01.sdjbvp = 711;   % Phenology
%  CUL01.sdjmatu1 = 223; % Phenology
%  CUL01.tilability = 1.5000;            % Morphology
%  CUL01.coefffixedtillerdeath = 0.07; % Morphology
%  CUL01.internodelengthmax = 253;    % Morphology
%  CUL01.leaflengthmax = 581.75;         % Morphology
%  CUL01.coeffleafwlratio = 0.1420;      % Biomass
%  CUL01.slamin = 0.2767;                % Biomass
%  CUL01.slamax = 0.0069;                % Biomass
%  CUL01.coeffleafdeath = 0.4864;       % Biomass
%  CUL01.poidssecgrain = 0.0230;        % Phenology
%  CUL01.coeffpaniclemass = 0.1687;     % Phenology
% 
% %% SAVE ****************************************************************************************
% params = [SOL, ITK, CUL01]; 
% writetable(params,strcat('params','SG','.csv') );  



%% 
% clay = CLAY;   % OUTPUTs.Clay;
% sand = SAND;   % OUTPUTs.Sand;
% silt = SILT;   % OUTPUTs.Silt;
% bulk = 1.49;   % defauld Myriam
% carbon = CARB; % OUTPUTs.TC


  fileID = fopen( 'CR.SOL' , 'w');
  fprintf(fileID,'%1s\n','*CR06002014');
  fprintf(fileID,'%1s %14s %12s %8s %1s %3s\n','@SITE','COUNTRY', 'LAT', 'LONG', 'SCS', 'FAMILY'); 
  fprintf(fileID,' %1s %8s %13.2f  %5.2f %1.0f\n','DAROUPAKAT', 'SENEGAL',Y , X, -99);    % 13.96, -15.85

  fprintf(fileID,'%1s  %1s  %1s  %1s  %1s  %1s  %1s  %1s  %1s  %1s\n','@ SCOM','SALB','SLU1','SLDR','SLRO','SLNF','SLPF','SMHB','SMPX','SMKE'); 
  fprintf(fileID,'     %1s  %1.2f     %1.0f   %1.1f    %1.0f     %1.0f   %1.1f %1s %1s %1s\n','G',   .13,     6,    .6,    76,     1,    .6, 'IB001', 'IB001', 'IB001'); 
 
  fprintf(fileID,'%1s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s\n', '@  SLB','SLMH','SLLL','SDUL','SSAT','SRGF','SSKS','SBDM','SLOC','SLCL','SLSI','SLCF','SLNI','SLHW','SLHB','SCEC','SADC'); 
  fprintf(fileID,'    %1.0f   %1.0f  %1.2f  %1.2f  %1.2f  %1.2f  %1.2f  %1.2f   %1.1f  %1.2f  %1.1f  %1.1f  %1.2f   %1.1f   %1.0f   %1.0f   %1.0f\n', 15, -99, SLLL(1), SDUL(1), SSAT(1), 1,     SSKS(1), BULK(1),  CARB(1),   CLAY(1)*1,   SILT(1)*1,   COARSE(1),  N(1),   PH(1),   -99,  -99, -99); 
  fprintf(fileID,'    %1.0f   %1.0f  %1.2f  %1.2f  %1.2f  %1.2f  %1.2f  %1.2f   %1.1f  %1.1f  %1.1f  %1.1f  %1.2f   %1.1f   %1.0f   %1.0f   %1.0f\n', 60, -99, SLLL(2), SDUL(2), SSAT(2), 1,     SSKS(2), BULK(2),  CARB(2),   CLAY(2)*1,   SILT(2)*1,   COARSE(2),  N(2),   PH(2),   -99,  -99, -99); 
  fprintf(fileID,'   %1.0f   %1.0f  %1.2f  %1.2f  %1.2f  %1.2f  %1.2f  %1.2f   %1.1f  %1.1f  %1.1f  %1.1f  %1.2f   %1.1f   %1.0f   %1.0f   %1.0f\n', 100, -99, SLLL(3), SDUL(3), SSAT(3), 0.301, SSKS(3), BULK(3),  CARB(3),   CLAY(3)*1,   SILT(3)*1,   COARSE(3),  N(3),   PH(3),   -99,  -99, -99); 
  fclose(fileID);


end