function [MCM_Table] = ALLgridMECHANISTIC(TT1,TT2,TT3, SSD,YYEAR, LON, LAT, i, j, climV, GEN)
sowD = SSD(j);
GYdb = []; BSSdb = [];NGdb = []; NTdb = []; AYdb = []; CYdb = []; LSdb = [];  LAIdb = []; RDdb = []; RLdb = []; DTdb = []; 
ANTdb = []; MATdb = []; ETdb = []; 
            %if IDXgrid(i)==1
            %% SOIL/point  ************************************************************************************** 
            % CLAY =  TT.clay(i)*100;
            % SILT =  TT.silt(i)*100;
            % COARSE =  TT.COARSE(i);
            % BULK =  TT.BULK(i);
            % CARB =  TT.OrganicCarbon(i);
            % N =  TT.N(i)/100;
            % PH = TT.PH(i);
            % SLLL =  TT.SLLL(i);
            % SDUL =  TT.SDUL(i);
            % SSAT =  TT.SSAT(i);
            % SSKS =  TT.SSKS(i);

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
            SOILfiles(LON(i),LAT(i),i, sowD, COARSE, SILT, CLAY, BULK, CARB, N, PH, SLLL, SDUL, SSAT, SSKS)   % SOILfiles(OUTPUTs(i,:),i, sowD, SAND, SILT, CLAY, BULK, CARB) % "paramsSG.csv"

            %% METEO/point **************************************************************************************
            % Point = idx(i);
            daily = readtable(strcat('files/METEO3/',num2str(YYEAR),'/', num2str( i ),'sample','.csv') );
            daily.WS2M = daily.WS2M*100;

            % visialMETEO = 0;
            % if visialMETEO == 1 
            %     f1 = figure, plot(daily.CLRSKY_SFC_SW_DWN, 'r-*'), hold on, plot(SRAD, 'b-*'), grid on, title(strcat('SRAD -',  dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  f1.Position = [298.6000  145.0000  910.4000  449.6000]; xlabel('Samples (days)'), ylabel('MJ/m^2/day'), saveas(gcf,strcat('SRAD',int2str(i), '.png' ))
            %     f2 = figure, plot(daily.T2M_MAX, 'r-*'), hold on, plot(TMAX, 'b-*'), grid on, title(strcat('TMAX -',dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  f2.Position = [298.6000  145.0000  910.4000  449.6000]; xlabel('Samples (days)'), ylabel('°C'),  saveas(gcf,strcat('TMAX',int2str(i), '.png' ))
            %     f3 = figure, plot(daily.T2M_MIN, 'r-*'), hold on, plot(TMIN, 'b-*'), grid on, title(strcat('TMIN -',dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  f3.Position = [298.6000  145.0000  910.4000  449.6000]; xlabel('Samples (days)'), ylabel('°C'),  saveas(gcf,strcat('TMIN',int2str(i), '.png' ))
            %     f4 = figure, plot(daily.PRECTOTCORR, 'r-*'), hold on, plot(RAIN, 'b-*'), grid on, title(strcat('RAIN -',dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  f4.Position = [298.6000  145.0000  910.4000  449.6000]; xlabel('Samples (days)'), ylabel('mm/day'),  saveas(gcf,strcat('RAIN',int2str(i), '.png' ))
            %     f5 = figure, plot(daily.WS2M, 'r-*'), hold on, plot(WIND, 'b-*'), grid on, title(strcat('WIND -',dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  f5.Position = [298.6000  145.0000  910.4000  449.6000]; ylim([0 max(daily.WS2M)*1.2]),  xlabel('Samples (days)'), ylabel('cm/s'), saveas(gcf,strcat('WIND',int2str(i), '.png' ))
            %     f6 = figure, plot(EVAP, 'b-*'), grid on, title('EVAP'), legend('Gerareaux DB'),  f6.Position = [298.6000  145.0000  910.4000  449.6000];   xlabel('Samples (days)'), ylabel(''),  saveas(gcf,strcat('EVAP',int2str(i), '.png' ))
            %     f7 = figure, plot(daily.RH2M, 'r-*'), hold on, plot(RHUM, 'b-*'), grid on, title(strcat('RHUM -',dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  f7.Position = [298.6000  145.0000  910.4000  449.6000];  xlabel('Samples (days)'), ylabel('%'), saveas(gcf,strcat('RHUM',int2str(i), '.png' ))
            % end
            EVAP = zeros(size(daily.T2M_MAX)) - 99 ;
            METEOfiles2(daily, daily.ALLSKY_SFC_SW_DWN(1:365), daily.T2M_MAX(1:365), daily.T2M_MIN(1:365),daily.PRECTOTCORR(1:365), daily.WS2M(1:365), EVAP(1:365), daily.RH2M(1:365)) 
            % % METEOfiles2oldW(daily,daily.CLRSKY_SFC_SW_DWN, daily.T2M_MAX, daily.T2M_MIN, daily.PRECTOTCORR, daily.WS2M, EVAP, daily.RH2M)               % Satellite 
            % % % METEOfiles2(daily,daily.ALLSKY_SFC_SW_DWN(1:365), daily.T2M_MAX(1:365), daily.T2M_MIN(1:365), daily.PRECTOTCORR(1:365), daily.WS2M(1:365), EVAP(1:365), daily.RH2M(1:365))               % Satellite 

            %% ***********************************************************************************************
            %% NEW PARAM - N4   --> EDGAR1
                P1=GEN.P1;
                P2R=GEN.P2R;
                P5=GEN.P5;
                P2O=GEN.P2O;
                G1=GEN.G1;
                G2=GEN.G2;
                G3=GEN.G3;
                PHINT=GEN.PHINT;
                % PREFINE - Temperature limits
                THOT=GEN.THOT;
                TCLDP=GEN.TCLDP;
                TCLDF=GEN.TCLDF;
                G4=GEN.G4;
                G5=GEN.G5;      
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
                strP1   = sprintf('%4.1f', P1);     % 4 caracteres en total, 1 decimal
                strP2R  = sprintf('%5.1f', P2R);     % 5 caracteres en total, 1 decimal
                strP5   = sprintf('%5.1f', P5);
                strP2O  = sprintf('%5.1f', P2O);
                strG1   = sprintf('%6.1f', G1);
                strG2   = sprintf('%5.3f', G2);      % 5 caracteres en total, 3 decimales
                strG3   = sprintf('%5.2f', G3);      % Puedes ajustar a 4 decimales si lo requieres: '%6.4f'
                strPHINT = sprintf('%5.1f', PHINT);
                strTHOT  = sprintf('%4.1f', THOT);
                strTCLDP = sprintf('%5.1f', TCLDP);
                strTCLDF = sprintf('%5.1f', TCLDF);
                strG4   = sprintf('%5.2f', G4);      % O el formato que necesites
                strG5   = sprintf('%5.1f', G5);

            fprintf(fileID, '%1s\', ["AR0002", " NERICA 4         ", "10,20 ", "IB0001 ", strP1," ", strP2R," ", strP5," ", strP2O," ", strG1," ", strG2(2:end)," ", ...
                strG3," ", strPHINT,"  ", strTHOT," ", strTCLDP," ", strTCLDF," ", " ! ", strG4," ", strG5]);
            fclose(fileID);

      
            %% ITK    **************************************************************************************
            SW = ((2012-2000)*1000) + sowD; % 12202
            DSSATitk(SW, i);
            %% launch DSSAT
                % [status,cmdout] = system('"C:\Program Files\R\R-4.2.2\bin\R.exe" CMD BATCH "C:\Users\CORREAPINZON\Desktop\Samara\RdssatMATLAB21.R"');  
                status = 1;
                while status == 1
                    [status,cmdout] = system('"C:\Program Files\R\R-4.4.2\bin\R.exe" CMD BATCH "C:\Users\USER\Desktop\CODE PhD - TEST 2025\03. IDEOTYPE OPTIMIZATION\RdssatMATLAB21-2.R"');  
                    if status == 1; disp("Error DSSAT - Conection... relaunch the CERES-Rice"), else disp('DSSAT - OK'), end
                end

            %%  %% Read OUTPUTS and SAVE DATA TO ML -->edg
                SD = readtable('PlantGro.csv'); % figure,  figure, plot(N4D.DATE, N4D.GWAD)
                SM = readtable('Summary.csv');
                ET = readtable('ET.csv');
                WTH = readtable('Weather.csv');
                climV = [climV,  {WTH.DATE, WTH.SRAD} ];

                N4D = SD( SD.TRNO == 1, :);
                N4M = SM( SM.TRNO == 1, :);
                ET =  ET( ET.TRNO == 1, :);
                WTH = WTH(WTH.TRNO == 1, :);
                
                writetable(N4D,strcat('files\INSILICOgridMATLAB\', num2str( i ),'N4D','.csv') ,'Delimiter',',');
                writetable(N4M,strcat('files\INSILICOgridMATLAB\', num2str( i ),'N4M','.csv') ,'Delimiter',',');
                writetable(ET ,strcat('files\INSILICOgridMATLAB\', num2str( i ),'ET ','.csv') ,'Delimiter',',');
                writetable(WTH,strcat('files\INSILICOgridMATLAB\', num2str( i ),'WTH','.csv') ,'Delimiter',',');
        
%% Plant response - Yield

if isa(N4D.L_SD(end), 'double'),  LS = N4D.L_SD(end);else, LS = 0; end  % Lea f per stem(#)
if isa(N4M.LAIX, 'double'),  LAI = N4M.LAIX;  else,LAI = 0; end    % Leaf area index(m2/m2) 
if isa(N4M.HWAM, 'double'),  GY = N4M.HWAM;  else, GY = 0; end     % Grain yiled(Kg/Ha)
if isa(N4M.CWAM, 'double'),  BSS = N4M.CWAM; else, BSS=0;  end     % Biomass(Kg/Ha)
if isa((N4D.G_AD), 'double'),NG = max(N4D.G_AD); else, NG=0; end   % Grain Number(#/m2) 
if isa((N4D.T_AD), 'double'),NT = max(N4D.T_AD); else, NT=0; end   % Tiller number(#/m2)
if isa((N4D.RDPD), 'double'),RD = max(N4D.RDPD); else, RD=0; end   % Root depht(m)
if isa((N4D.RL1D), 'double'),RL = max(N4D.RL1D); else, RL=0; end   % Root density (cm/cm3)
if isa(sum(ET.ETAA), 'double'),ET = sum(ET.ETAA);  else, ET=0; end   % SUM[Evapotranspiration (mm/d)]
%% CYCLE
% figure, plot(N4D.DATE, N4D.GWAD, '-*'), grid on, title('GWAD - yield')   
ff = N4M.PDAT;    if isa(ff, 'datetime'), S  = ((ff.Month-1)*30)+ff.Day; else,  S = 0; end
ff = N4M.ADAT;    if isa(ff, 'datetime'), ANT= ((ff.Month-1)*30)+ff.Day; else, ANT= 0, end
ff = N4M.HDAT;    if isa(ff, 'datetime'), MAT= ((ff.Month-1)*30)+ff.Day; else, MAT= 0, end
CY = MAT-S;   % Cycle - days
AY = ANT-S;   % Cycle - days
%% SAVE ALL RESULTS
GYdb = [GYdb; GY];     % GY
BSSdb = [BSSdb; BSS]; 
ANTdb = [ANTdb; ANT]; 
MATdb = [MATdb; MAT];  
CYdb = [CYdb; CY]; 
AYdb = [AYdb; AY]; 

NGdb = [NGdb; NG]; 
NTdb = [NTdb; NT]; 

LSdb = [LSdb ; LS];  
LAIdb = [LAIdb; LAI];  
RDdb = [RDdb; RD];
RLdb = [RLdb; RL];
ETdb = [ETdb; ET];
%% DROUGHT STESS  - Cycle
% % % PET = N4D.ETO;   % evapotranspiration
C = N4D.GSTD; C(N4D.GSTD>6) = 7;
% % % PET = N4D.ETO;   % evapotranspiration
DROUGHT = N4D.WSPD; DT = []; 
for l = 1 : 7
    DT(l) = mean(DROUGHT(C==l-1)) ;
end 
DTdb = [DTdb; DT];

HI = GYdb/BSSdb;
WUE = GYdb/ETdb;

MCM = [GYdb BSSdb NGdb NTdb AYdb CYdb LSdb LAIdb RDdb RLdb DTdb ETdb HI WUE];
columnNames = {'Grain_Yield', 'Biomass', 'Grain_Number', 'Tiller_Number', ...
               'Anthesis', 'Cycle', 'Leaf_per_Stem', 'Leaf_Area_Index', 'Root_Depth', ...
               'Root_Density', 'DT1', 'DT2', 'DT3', 'DT4', 'DT5', 'DT6', 'DT7', 'Evapotranspiration','HI','WUE'};
MCM_Table = array2table(MCM, 'VariableNames', columnNames);
%writetable(MCM_Table,  strcat('files\INSILICOgridMATLAB\', num2str( Year ),'/ALLGRID','s',num2str( sd ),'MCM','.csv')     );


          
end