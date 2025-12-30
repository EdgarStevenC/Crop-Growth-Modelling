function [GYdbDSSAT, GT] = MECHANISTIC(P1,P2R,P5,P2O,G1,G2,G3,PHINT,THOT,TCLDP,TCLDF,G4,G5, VISUAL, SATELLITE, SATELLITEsol)

DBg = readtable("ID.csv");
T1 = readtable("T441.csv");  %("Tai.csv"); % SOIL VARIABLES --<  {'LON'}    {'LAT'}    {'sand'}    {'silt'}    {'clay'}    {'BULK'}    {'COARSE'}    {'OrganicCarbon'}    {'N'}    {'PH'}    {'SLLL'}    {'SDUL'}    {'SSAT'}    {'SSKS'}
T2 = readtable("T442.csv");
T3 = readtable("T443.csv");

[TT1, idx] = Preparing(T1);
[TT2, idx] = Preparing(T2);
[TT3, idx] = Preparing(T3);


LON = TT1.LON;  LAT = TT1.LAT;  Y = TT1.Year; % N4
GT = []; GYdbDSSAT = [];  ANTdb = [];  MATdb = [];  BSSdb = [];  CYdb = [];  AYdb = [];  DROUGHTdb = []; DTdb = [];
NGdb = [];  NTdb = []; 

DSS11=[]; DSS21=[]; DSS31=[];   DSS12=[]; DSS22=[]; DSS32=[];   DSS13=[]; DSS23=[]; DSS33=[];  tagDSS = [];
SATELLITE = 1;     % METEO Station
SATELLITEsol = 1;  % SOIL Sample
%% PARTE 0 _ SENSITIVITY - (CKECK SOIL FILE - original from Edgard)
SSDg = DBg.SW;   % [202 198 203 192 214 205 196 203 205];
climV = [];
GYdb = []; 
DAY = readtable("DOY.csv");  
 % %       m = [1 0, 0 0 0 0 1 1 1 0, 0, 0 0, 0, 0 1 0, 1]; % SAMARA REFERENCE

           % ii = logical([1 0 1  0, 0 0 1 0 1 1, 0, 0 0, 1 0]);  %   ii = logical([0 0 0  1,  1 1 1 0 0  1, 0, 0 0, 0 1]);  % ii = logical([1 0 1 1 1 1 1 0 0 1 1 0 0 1 1]); % ii = logical([1 1 1 1 1 1 1 0 0 1 1 1 1 1 1]);
         ii = logical([1 1 1 1, 1, 1, 1, 1 1 1, 1 1 1 1 1,]);  %%  ALL-15 (23/04/2024)

 % ii = logical([0 0 0 1, 0, 0, 0, 0 0 0, 0 0 0 0 0,]);  %%  KOLDA1301 (23/04/2024)
DSC5T1  =[]; DSC10T1 =[]; DSC20T1 =[]; DSC1T1 =[];  DS1T1  =[]; DSxlT1 =[];
DSC5T2  =[]; DSC10T2 =[]; DSC20T2 =[]; DSC1T2 =[];  DS1T2  =[]; DSxlT2 =[];
DSC5T3  =[]; DSC10T3 =[]; DSC20T3 =[]; DSC1T3 =[];  DS1T3  =[]; DSxlT3 =[];
tag1 = []; tag2 = []; tag3 = [];
Indecator1 = []; Indecator2 = []; Indecator3 = [];
        for i =  1 : size(DBg,1)   % 8   % 38 for N4
          if ii(i) == 1
            sowD = SSDg(i);
            dss = readtable('namesGX.csv');
            if SATELLITEsol == 0
                trialALL = [dss.WTH(1), dss.SOIL(i), dss.ID(1), dss.Cultivar(1)];       % DARO1201,CR06002014,CRDA1201,Nerica 4
            else
                trialALL = [dss.WTH(1), dss.SOIL(1), dss.ID(1), dss.Cultivar(1)];       % DARO1201,CR06002014,CRDA1201,Nerica 4
            end

            writecell(trialALL);


            year = 2012;  % Y(i);
            %% SOIL/point  ************************************************************************************** 
            CLAY =  [ TT1.clay(i) TT2.clay(i)  TT3.clay(i) ];
            SILT =  [ TT1.silt(i) TT2.silt(i) TT3.silt(i) ];
            COARSE =  [ TT1.COARSE(i) TT2.COARSE(i)  TT3.COARSE(i) ];
            BULK =  [ TT1.BULK(i) TT2.BULK(i) TT3.BULK(i) ];

            CARB =  [ TT1.OrganicCarbon(i) TT2.OrganicCarbon(i) TT3.OrganicCarbon(i) ];
            N =  [ TT1.N(i)/100  TT2.N(i)/100  TT3.N(i)/100 ];
            PH = [ TT1.PH(i)  TT2.PH(i)  TT3.PH(i) ];

            SLLL =  [ TT1.SLLL(i) TT2.SLLL(i) TT3.SLLL(i) ];
            SDUL =  [ TT1.SDUL(i) TT2.SDUL(i) TT3.SDUL(i) ];
            SSAT =  [ TT1.SSAT(i) TT2.SSAT(i) TT3.SSAT(i) ];
            SSKS =  [ TT1.SSKS(i) TT2.SSKS(i) TT3.SSKS(i) ];
            if SATELLITEsol == 1
                SOILfiles(LON(i),LAT(i),i, sowD, COARSE, SILT, CLAY, BULK, CARB, N, PH, SLLL, SDUL, SSAT, SSKS);   % SOILfiles(OUTPUTs(i,:),i, sowD, SAND, SILT, CLAY, BULK, CARB) % "paramsSG.csv"
            end
            %% METEO/point **************************************************************************************
            Point = idx(i);
            daily = readtable(strcat('METEOai2/',num2str( Point ),'sample','.csv'));
            daily.WS2M = daily.WS2M*100;
            METEOg = readtable(strcat('DBGT/',DBg.ID{i},'.csv') ); strcat(DBg.ID{i}); % GERARDEAUX DATA
            SRAD = METEOg.Var2;
            TMAX = METEOg.Var3;
            TMIN = METEOg.Var4;  
            RAIN = [METEOg.Var5];  
            WIND = METEOg.Var6;   
            EVAP = METEOg.Var7; 
            RHUM = METEOg.Var8;
            visialMETEO = 0;
            if visialMETEO == 1 
                % CLRSKY_SFC_SW_DWN
                f1 = figure, plot(daily.ALLSKY_SFC_SW_DWN, 'r-*'), hold on, plot(SRAD, 'b-*'), grid on, title(strcat('SRAD -',  dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  f1.Position = [298.6000  145.0000  910.4000  449.6000]; xlabel('Samples (days)'), ylabel('MJ/m^2/day'), saveas(gcf,strcat('SRAD',int2str(i), '.png' ))
                f2 = figure, plot(daily.T2M_MAX, 'r-*'), hold on, plot(TMAX, 'b-*'), grid on, title(strcat('TMAX -',dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  f2.Position = [298.6000  145.0000  910.4000  449.6000]; xlabel('Samples (days)'), ylabel('°C'),  saveas(gcf,strcat('TMAX',int2str(i), '.png' ))
                f3 = figure, plot(daily.T2M_MIN, 'r-*'), hold on, plot(TMIN, 'b-*'), grid on, title(strcat('TMIN -',dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  f3.Position = [298.6000  145.0000  910.4000  449.6000]; xlabel('Samples (days)'), ylabel('°C'),  saveas(gcf,strcat('TMIN',int2str(i), '.png' ))
                f4 = figure, plot(daily.PRECTOTCORR, 'r-*'), hold on, plot(RAIN, 'b-*'), grid on, title(strcat('RAIN -',dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  f4.Position = [298.6000  145.0000  910.4000  449.6000]; xlabel('Samples (days)'), ylabel('mm/day'),  saveas(gcf,strcat('RAIN',int2str(i), '.png' ))
                f5 = figure, plot(daily.WS2M, 'r-*'), hold on, plot(WIND, 'b-*'), grid on, title(strcat('WIND -',dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  f5.Position = [298.6000  145.0000  910.4000  449.6000]; ylim([0 max(daily.WS2M)*1.2]),  xlabel('Samples (days)'), ylabel('cm/s'), saveas(gcf,strcat('WIND',int2str(i), '.png' ))
                f6 = figure, plot(EVAP, 'b-*'), grid on, title('EVAP'), legend('Gerareaux DB'),  f6.Position = [298.6000  145.0000  910.4000  449.6000];   xlabel('Samples (days)'), ylabel(''),  saveas(gcf,strcat('EVAP',int2str(i), '.png' ))
                f7 = figure, plot(daily.RH2M, 'r-*'), hold on, plot(RHUM, 'b-*'), grid on, title(strcat('RHUM -',dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  f7.Position = [298.6000  145.0000  910.4000  449.6000];  xlabel('Samples (days)'), ylabel('%'), saveas(gcf,strcat('RHUM',int2str(i), '.png' ))
            end
            % RAIN = daily.PRECTOTCORR;   %SRAD = daily.CLRSKY_SFC_SW_DWN;

            if SATELLITE == 0
                PLUISAT1 = RAIN(1:365);            % MULLER DATA - STATAION
                PLUISAT2 = daily.PRECTOTCORR(1:365);      % SAT Power NASA
                TAMSAT = readtable("RAINTAMSAT.csv"); % SAT TAMSAT(AFRICA)
                PLUISAT3 = table2array(TAMSAT(1:365,i));
            % METEOfiles(daily);                                                       % SATELLITE DBs
            %% NOISE stage
            % %figure, subplot(1,2,1), plot((daily.ALLSKY_SFC_SW_DWN)), subplot(1,2,2),plot((daily.ALLSKY_SFC_SW_DWN)+(randn(numel(daily.ALLSKY_SFC_SW_DWN),1)*3.59))
            % signal = SRAD; 
            % signalCLEAN = (medfilt1(signal,21));
            % noise = signal-signalCLEAN;
            % signalN2 = signalCLEAN +(randn(numel(signal),1)*std(noise));
            % 
            % figure, plot(signal, 'b'),
            % hold on, plot(signalN2, 'c'), 
            % hold on, plot(signalCLEAN, 'k'), 
            % legend('Signal from a meteorological station', 'Signal without noise', 'Signal with simulated noise')




METEOfiles2(daily, SRAD(1:365), TMAX(1:365), TMIN(1:365), RAIN(1:365), WIND(1:365), EVAP(1:365), RHUM(1:365))             % Gerardeux DATA  daily.CLRSKY_SFC_SW_DWN(1:365)
            % % METEOfiles2(daily, SRAD, TMAX, TMIN, RAIN, WIND, EVAP, RHUM)           % Gerardeux DATA
            % METEOfiles2(daily, daily.CLRSKY_SFC_SW_DWN, daily.T2M_MAX, daily.T2M_MIN, daily.PRECTOTCORR, daily.WS2M, EVAP, daily.RH2M)         % Satellite
            end

            if SATELLITE ==1
                PLUISAT1 = RAIN(1:365);            % MULLER DATA - STATAION
                PLUISAT2 = daily.PRECTOTCORR(1:365);      % SAT Power NASA
                TAMSAT = readtable("RAINTAMSAT.csv"); % SAT TAMSAT(AFRICA)
                PLUISAT3 = table2array(TAMSAT(1:365,i));
METEOfiles2(daily, daily.ALLSKY_SFC_SW_DWN(1:365), daily.T2M_MAX(1:365), daily.T2M_MIN(1:365),PLUISAT3, daily.WS2M(1:365), EVAP(1:365), daily.RH2M(1:365))         % Satellite + RAINger
           % METEOfiles2(daily, SRAD(1:365), daily.T2M_MAX(1:365), daily.T2M_MIN(1:365), daily.PRECTOTCORR(1:365), daily.WS2M(1:365), EVAP(1:365), daily.RH2M(1:365))               % Satellite + SRADger
            % METEOfiles2(daily, SRAD(1:365), daily.T2M_MAX(1:365), daily.T2M_MIN(1:365), RAIN(1:365), daily.WS2M(1:365), EVAP(1:365), daily.RH2M(1:365))               % Satellite + SRADger
            end
            %% Genotype    **************************************************************************************
              fileID = fopen( 'C:/DSSAT48/Genotype/RICER048.CUL' , 'w');  
              fprintf(fileID,'%1s\n',"*RICE CULTIVAR COEFFICIENTS: RICER048 MODEL");
              fprintf(fileID,'%1s\n',"@VAR#  VAR-NAME........ EXPNO   ECO#    P1   P2R    P5   P2O    G1    G2    G3 PHINT  THOT TCLDP TCLDF  !    previous");
              fprintf(fileID,'%1s\n',"");
              fprintf(fileID,'%1s\n',"");
              fprintf(fileID,'%1s\n',"!VAR#  VAR-NAME........ EXPNO   ECO#    P1   P2R    P5   P2O    G1    G2    G3 PHINT  THOT TCLDP TCLDF  !    previous");
              fprintf(fileID,'%1s\n',"!                                        1     2     3     4     5     6     7     8     9    10    11  !    G4    G5 ");
              fprintf(fileID,'%1s\n',"!MODEL RD 23                . IB0001 310.3 140.0 370.0  11.2  53.0 .0230  0.30  83.0  28.0  15.0  15.0  !  1.00   1.0");
              fprintf(fileID,'%1s\n',"AR0001 NERICA 1         10,20 IB0001 393.1  18.9 350.8   8.9  59.4 .0425  1.00  83.0  26.7  15.0  15.0  !  1.05   1.0");
              % P1 = 329.7;
              % P2R = 133.5;    
              % P5 = 364.6;  
              % P2O = 12.1;   
              % G1 = 247.1;  
              % G2 = .063;  
              % G3 = 1.20;
              % PHINT = 83.0;
              % THOT = 25.3;
              % TCLDP = 15.0;
              % TCLDF = 15.0; 
              % G4 = 1.15;   
              % G5 = 1.0;
              fprintf(fileID,'%1s %1.2f %1.1f %1.1f  %1.1f %1.1f %1.3f  %1.2f  %1.1f  %1.1f  %1.1f  %1.1f  %1s  %1.2f   %1.1f \n', ...
                              "AR0002 NERICA 4         10,20 IB0001", P1, P2R, P5,  P2O, G1, G2,   G3,  PHINT,  THOT,  TCLDP,  TCLDF,  "!",  G4,   G5);
              fclose(fileID);
            %% ITK    **************************************************************************************
            SW = ((year-2000)*1000) + SSDg(i); % 12202
            DSSATitk(SW, i);
            %% launch
                % [status,cmdout] = system('"C:\Program Files\R\R-4.2.2\bin\R.exe" CMD BATCH "C:\Users\CORREAPINZON\Desktop\Samara\RdssatMATLAB21.R"');  
                status = 1;
                while status == 1 % [pwd, '\RdssatMATLAB21-2.R']
                    [status,cmdout] = system('"C:\Program Files\R\R-4.4.2\bin\R.exe" CMD BATCH "D:\Steven02-12-2025\Desktop\CORE PHD - DEC2025\1. CODE CORE - DEC2025\CODE PhD - TEST 2025\02. SENSITIVITY\1_Sensitivity_Analysis\2. run_from_scratch\RdssatMATLAB21-2.R"'); 
                    
                    if status == 1; disp("Error DSSAT - Conection... relaunch the CERES-Rice"); end  
                end
                %if status == 1, disp("Error DSSAT - Conection..."), RETURN, end
           %%  %% Read OUTPUTS and SAVE DATA TO ML -->edg
                SD = readtable('PlantGro.csv'); % figure,  figure, plot(N4D.DATE, N4D.GWAD)
                SM = readtable('Summary.csv');
                ET = readtable('ET.csv');
                WTH = readtable('Weather.csv');
                climV = [climV,  {WTH.DATE, WTH.SRAD} ];
                % f3 = figure, plot(WTH.DATE, WTH.SRAD, 'r-*'),   grid on, f3.Position = [313.8000  453.0000  910.4000  272.8000];   % hold on, plot(SRAD, 'b-*'),

                N4D = SD( SD.TRNO == 1, :);
                N4M = SM( SM.TRNO == 1, :);
                ET =  ET( ET.TRNO == 1, :);
                WTH = WTH(WTH.TRNO == 1, :);
                % % writetable(N4D,strcat('MYRIAMdssat/',num2str( year ),'/', num2str( Point ),'s',num2str(j),'N4D','.csv') ,'Delimiter',','); 
                % % writetable(N4M,strcat('MYRIAMdssat/',num2str( year ),'/', num2str( Point ),'s',num2str(j),'N4M','.csv') ,'Delimiter',',');
                % writetable(N4D,strcat('INSILICOgridMATLAB_satellite/', num2str( i ),'N4D','.csv') ,'Delimiter',',');
                % writetable(N4M,strcat('INSILICOgridMATLAB_satellite/', num2str( i ),'N4M','.csv') ,'Delimiter',',');
                % writetable(ET ,strcat('INSILICOgridMATLAB_satellite/', num2str( i ),'ET ','.csv') ,'Delimiter',',');
                % writetable(WTH,strcat('INSILICOgridMATLAB_satellite/', num2str( i ),'WTH','.csv') ,'Delimiter',',');

                %% YIELD
                if isa(N4M.HWAM, 'double'), GY = N4M.HWAM; else, GY = 0; end       % N4M.HWAM;  CWAM    % Grain Yield
                if isa(N4M.CWAM, 'double'),BSS = N4M.CWAM;else, BSS=0; end         % Biomass
                if isa((N4D.G_AD), 'double'),NG = max(N4D.G_AD);else, NG=0; end % N4M.H_AM;      % Number of grain /m2
                if isa((N4D.T_AD), 'double'),NT = max(N4D.T_AD);else, NT=0; end % Number stem /m2
                %% CYCLE
                % figure, plot(N4D.DATE, N4D.GWAD, '-*'), grid on, title('GWAD - yield')   
                ff = N4M.PDAT;    if isa(ff, 'datetime'), S  = ((ff.Month-1)*30)+ff.Day; else,  S = 0; end
                ff = N4M.ADAT;    if isa(ff, 'datetime'), ANT= ((ff.Month-1)*30)+ff.Day; else, ANT= 0, end
                ff = N4M.HDAT;    if isa(ff, 'datetime'), MAT= ((ff.Month-1)*30)+ff.Day; else, MAT= 0, end
                CY = MAT-S;   % Cycle - days
                AY = ANT-S;   % Cycle - days
        
                % Cycle = (N4M.HDAT - N4M.PDAT);  x = time2num(Cycle/24,"hours")

                % if  sum((N4M.MDAT{1})=='NA')==2, MAT=0; else,   ff = N4M.MDAT;  MAT= ((ff.Month-1)*30)+ff.Day;

                GYdb = [GYdb; GY]; GY
                BSSdb = [BSSdb; BSS]; 
                ANTdb = [ANTdb; ANT]; 
                MATdb = [MATdb; MAT];  
                CYdb = [CYdb; CY]; 
                AYdb = [AYdb; AY]; 

                NGdb = [NGdb; NG]; 
                NTdb = [NTdb; NT]; 
                
          % % % PET = N4D.ETO;   % evapotranspiration
                DROUGHT = N4D.WSPD; DT = 0; 
                for l = 1 : numel(DROUGHT)-1
                    DT(l+1) =  DROUGHT(l+1) + DT(l);
                end 
                % DROUGHTdb = [DROUGHTdb; DROUGHT]; 
                % DTdb = [DTdb; DT]; 
                DT = DT';
                STRESS = table(DROUGHT, DT);

                % % writetable(STRESS,strcat('DROUGTHg/', num2str( i ),'drougth','.csv') );    % ,'Delimiter',',');  % DSSAT

            end
        end 

%% OUTPUT of the model
GYdbDSSAT = [GYdbDSSAT, [GYdb, BSSdb, ANTdb, MATdb, NGdb, NTdb ]];   % SIMULATION     , ANTdb
GT = [GT, [DBg.GY(ii), DBg.BSS(ii), DBg.ANT(ii), DBg.MAT(ii), DBg.NG_HNAM(ii), DBg.NT_TNAM(ii)]];             % GRound Truth   , DBg.ANT
GTGY =  DBg.GY(ii); 
GTBSS = DBg.BSS(ii);
GTANT = DBg.ANT(ii); 
GTMAT = DBg.MAT(ii);
GTNG =  DBg.NG_HNAM(ii);
GTNT =  DBg.NT_TNAM(ii);

SIM = table(GYdb, BSSdb, ANTdb, MATdb, GTGY, GTBSS, GTANT, GTMAT, GTNG, GTNT )
writetable(SIM,strcat('RESULTS/', num2str( i ),'Simulation','.csv') );    % ,'Delimiter',',');  % DSSAT
%% ##########################################################################################################################
%% **************************************************************************************************************************
%% GRAPHIC
% ii = logical([1 0 1  0, 0 0 1 0 1 1, 0, 0 0, 1 0]); 
VISUAL = 0; 
if VISUAL == 1 
    MT =ERRmetrics(DBg, GYdb, BSSdb, ANTdb, MATdb, NGdb, NTdb, ii )

    ii = logical([1 0 1  0, 0 0 1 0 1 1, 0, 0 0, 1 0]);
    MTC = ERRmetrics(DBg(ii,:), GYdb(ii), BSSdb(ii), ANTdb(ii), MATdb(ii), NGdb(ii), NTdb(ii), ii )

    ii = logical([1, 1 1,  1 1 1 1, 0, 0 0 1 1 1 0 1]);
    MTV =ERRmetrics(DBg(ii,:), GYdb(ii), BSSdb(ii), ANTdb(ii), MATdb(ii), NGdb(ii), NTdb(ii), ii )
    if SATELLITE == 1
        ii = logical([1 0 1  0 1 1 1 0, 1 1 1 0 0 1 0]);
        MTV =ERRmetrics(DBg(ii,:), GYdb(ii), BSSdb(ii), ANTdb(ii), MATdb(ii), NGdb(ii), NTdb(ii), ii )
    end

end

end