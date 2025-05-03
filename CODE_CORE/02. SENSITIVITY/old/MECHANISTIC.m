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
                trialALL = [dss.WTH(1), dss.SOIL(1), dss.ID(1), dss.Cultivar(1)]       % DARO1201,CR06002014,CRDA1201,Nerica 4
            end

            writecell(trialALL)


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
                SOILfiles(LON(i),LAT(i),i, sowD, COARSE, SILT, CLAY, BULK, CARB, N, PH, SLLL, SDUL, SSAT, SSKS)   % SOILfiles(OUTPUTs(i,:),i, sowD, SAND, SILT, CLAY, BULK, CARB) % "paramsSG.csv"
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
              fprintf(fileID,'%1s %1.1f %1.1f %1.1f  %1.1f %1.1f %1.3f  %1.2f  %1.1f  %1.1f  %1.1f  %1.1f  %1s  %1.2f   %1.1f \n', ...
                              "AR0002 NERICA 4         10,20 IB0001", P1, P2R, P5,  P2O, G1, G2,   G3,  PHINT,  THOT,  TCLDP,  TCLDF,  "!",  G4,   G5);
              fclose(fileID);
            %% ITK    **************************************************************************************
            SW = ((year-2000)*1000) + SSDg(i); % 12202
            DSSATitk(SW, i);
            %% launch
                % [status,cmdout] = system('"C:\Program Files\R\R-4.2.2\bin\R.exe" CMD BATCH "C:\Users\CORREAPINZON\Desktop\Samara\RdssatMATLAB21.R"');  
                [status,cmdout] = system('"C:\Program Files\R\R-4.2.2\bin\R.exe" CMD BATCH "C:\Users\CORREAPINZON\Desktop\Samara\3.TRES_SIMULATIONCM\CM SIMULATE\RdssatMATLAB21-2.R"');  
                if status == 1, disp("Error DSSAT - Conection..."), RETURN, end
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
                % writetable(N4D,strcat('MYRIAMdssat/',num2str( year ),'/', num2str( Point ),'s',num2str(j),'N4D','.csv') ,'Delimiter',','); 
                % writetable(N4M,strcat('MYRIAMdssat/',num2str( year ),'/', num2str( Point ),'s',num2str(j),'N4M','.csv') ,'Delimiter',',');
                writetable(N4D,strcat('INSILICOgridMATLAB_satellite/', num2str( i ),'N4D','.csv') ,'Delimiter',',');
                writetable(N4M,strcat('INSILICOgridMATLAB_satellite/', num2str( i ),'N4M','.csv') ,'Delimiter',',');
                writetable(ET ,strcat('INSILICOgridMATLAB_satellite/', num2str( i ),'ET ','.csv') ,'Delimiter',',');
                writetable(WTH,strcat('INSILICOgridMATLAB_satellite/', num2str( i ),'WTH','.csv') ,'Delimiter',',');

                %% YIELD
                GY = N4M.HWAM;      % N4M.HWAM;  CWAM    % Grain Yield
                BSS = N4M.CWAM;     % Biomass
                NG = max(N4D.G_AD); % N4M.H_AM;      % Number of grain /m2
                NT = max(N4D.T_AD); % Number stem /m2
                %% CYCLE
                % figure, plot(N4D.DATE, N4D.GWAD, '-*'), grid on, title('GWAD - yield')   
                ff = N4M.PDAT;    S  = ((ff.Month-1)*30)+ff.Day;
                ff = N4M.ADAT;    ANT= ((ff.Month-1)*30)+ff.Day; 
                ff = N4M.HDAT;    MAT= ((ff.Month-1)*30)+ff.Day; 
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

                writetable(STRESS,strcat('DROUGTHg/', num2str( i ),'drougth','.csv') );    % ,'Delimiter',',');  % DSSAT


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INICES PP
                %% STRESS
                VISUAL = 0;
                if VISUAL == 1
                    % RAIN = [METEOg.Var5]+0;    
                    % f4 = figure; plot(daily.PRECTOTCORR, 'r-*'), hold on, plot(RAIN, 'b-*'), grid on, title(strcat( 'RAIN -',dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  
                    % f4.Position = [298.6000  145.0000  910.4000  449.6000]; xlabel('Samples (days)'), ylabel('mm/day'),  % saveas(gcf,strcat('RAIN',int2str(i), '.png' ))
                    % RAINsum = [sum(RAIN), sum(daily.PRECTOTCORR)]

                    % SRAD = METEOg.Var2;
                    % f1 = figure; plot(daily.CLRSKY_SFC_SW_DWN, 'r-*'), hold on, plot(SRAD, 'b-*'), grid on, title(strcat('SRAD -',  dss.WTH(i))), legend('SatelliteDB','Gerareaux DB'),  
                    % f1.Position = [298.6000  145.0000  910.4000  449.6000]; xlabel('Samples (days)'), ylabel('MJ/m^2/day'), % saveas(gcf,strcat('SRAD',int2str(i), '.png' ))
                    % RADsum = [sum(SRAD), sum(daily.CLRSKY_SFC_SW_DWN)]
                    
                    NAM = DBg.ID2{i}; % dss.WTH(i);  % NAM{1}    int2str(i)
                    % f1 = figure, plot(N4D.WSPD, 'k-*'), grid on,  ylabel('Drougth Stress'), title(strcat(NAM, ' - Drougth stress Pattern')), f1.Position = [298.6000  258.6000  671.2000  336.0000];  % Drougth stress
                      GY 
                    % hold on, yyaxis right, plot(N4D.CWAD, 'g*'), plot(N4D.CWAD, 'b.'), 
                    % plot(N4D.GWAD, 'c-*'), plot(N4D.GWAD, 'b.'), ylabel('Biomass (Kg/H)'), xlabel('days'),  %G_AD  (old EWAD)  GWAD 
                  
                    % f1 = figure, plot(DROUGHT, 'b'); ylabel('Drougth Stress - WSPD'), hold on, plot(N4D.GSTD./6, 'k-'), ylim([0, 1])
                    % hold on, yyaxis right,  plot(DT, 'r-*'),  plot(DT, 'k.'),  ylabel('Drougth Acumulated')
                    % f1.Position = [298.6000  258.6000  671.2000  336.0000]; grid on, title(strcat(NAM, ' - Drougth stress Pattern'))
                    % saveas(gcf,strcat('DROUGTHg/', num2str( i ),'drougth','.png') )
                   
                    %% LAST --> Include Error metrics
                    STT = readtable(strcat("METEOstations/", num2str(i),"drougth.csv"))
                    DSSstress = STT.STRESS_1(:,1)

                    STT = readtable(strcat("11. RAIN SAT POWER NASA/", num2str(i),"drougth.csv"))
                    DSSstressN = STT.DROUGHT(:,1)
                    
                    DSSstress2 = DROUGHT;

                    D1=DSSstress;  DT1=0; for l=1:numel(D1)-1,  DT1(l+1)=D1(l+1)+DT1(l);  end  % Local station
                    D2=DSSstressN; DT2=0; for l=1:numel(D2)-1,  DT2(l+1)=D2(l+1)+DT2(l);  end  % POWER NASA
                    D3=DSSstress2; DT3=0; for l=1:numel(D3)-1,  DT3(l+1)=D3(l+1)+DT3(l);  end  % TAMSAT

                    DSS = DSSstress(1:100);
                    idx11 = ((N4D.GSTD == 0) + (N4D.GSTD == 1) + (N4D.GSTD == 2)) == 1;
                    DSS11 = [DSS11; sum(DSS(idx11(1:100)))]; % phase 0 & 1 & 2
                    idx21 = ((N4D.GSTD == 3) + (N4D.GSTD == 4)) == 1;
                    DSS21 = [DSS21; sum(DSS(idx21(1:100)))]; % phase 3 & 4
                    idx31 = ((N4D.GSTD == 5) + (N4D.GSTD == 6)) == 1;
                    DSS31 = [DSS31; sum(DSS(idx31(1:100)))]; % phase 5 & 6

                    DSS = DSSstressN(1:100);
                    idx12 = ((N4D.GSTD == 0) + (N4D.GSTD == 1) + (N4D.GSTD == 2)) == 1;
                    DSS12 = [DSS12; sum(DSS(idx12(1:100)))]; % phase 0 & 1 & 2
                    idx22 = ((N4D.GSTD == 3) + (N4D.GSTD == 4)) == 1;
                    DSS22 = [DSS22; sum(DSS(idx22(1:100)))]; % phase 3 & 4
                    idx32 = ((N4D.GSTD == 5) + (N4D.GSTD == 6)) == 1;
                    DSS32 = [DSS32; sum(DSS(idx32(1:100)))]; % phase 5 & 6

                    DSS = DSSstress2(1:100);
                    idx13 = ((N4D.GSTD == 0) + (N4D.GSTD == 1) + (N4D.GSTD == 2)) == 1;
                    DSS13 = [DSS13; sum(DSS(idx13(1:100)))]; % phase 0 & 1 & 2
                    idx23 = ((N4D.GSTD == 3) + (N4D.GSTD == 4)) == 1;
                    DSS23 = [DSS23; sum(DSS(idx23(1:100)))]; % phase 3 & 4
                    idx33 = ((N4D.GSTD == 5) + (N4D.GSTD == 6)) == 1;
                    DSS33 = [DSS33; sum(DSS(idx33(1:100)))]; % phase 5 & 6


                    %% RMSE
                    Tag = min(numel(DSSstress), numel(DSSstress2));
                    % E = rmse( DSSstress(1:Tag), DSSstress2(1:Tag)) ;  En = num2str(E);
                    %% R2 - Coefficient of Determination (R-Squared)      https://fr.mathworks.com/help/stats/coefficient-of-determination-r-squared.html
                    mdl = fitlm( DSSstress(1:Tag), DSSstress2(1:Tag))
                    ERMSE = mdl.RMSE;  ERMSEn = num2str(ERMSE);
                    ER2 = mdl.Rsquared.Ordinary; ER2n = num2str(ER2);
                    EPV = mdl.Coefficients.pValue(2); EPVn = num2str(EPV);
                    x = (WTH.DATE);  x = x(1:numel(DSSstress));
                    f1 = figure, plot(x, DSSstress, "m-","LineWidth",1), grid on, title(strcat(NAM, ' / RMSE: ', ERMSEn ,  ' / R2: ', ER2n, ' / p-value: ',EPVn)), f1.Position = [298.6000  258.6000  671.2000  336.0000];  % Drougth stress
                   
                    if SATELLITEsol == 0
                         x = (WTH.DATE);  x = x(1:numel(DSSstressN));
                         hold on, plot(x, DSSstressN, "c-.","LineWidth",1.9),
                    end
                    x = (WTH.DATE);  x = x(1:numel(DSSstress2));
                    hold on, plot(x, DSSstress2, "b-.","LineWidth",1.9),

                    ylabel('Drougth stress - DSSAT (WSPD)'), xlabel('days')
                    
                    if SATELLITEsol == 0
                    yyaxis right,  ylabel('Precipitation (mm/day)'),
                    x = (WTH.DATE);  x = x(1:121);
                    hold on, plot(x, PLUISAT1(SSDg(i) : SSDg(i)+120), "m-.")
                    hold on, plot(x, PLUISAT2(SSDg(i) : SSDg(i)+120), "c-.")
                    hold on, plot(x, PLUISAT3(SSDg(i) : SSDg(i)+120), "b-.")
                    % lgd = legend("WSPD -  Weather Station ", "WSPD - Meteo Satellite", 'Rain - Local Station', 'Rain - DB1 NASA', 'Rain - DB2 TAMSAT' )
                    end
                 
                    f1.Position = [402.6    292.2    1126.4    444.0];
                    N4D.GSTD(N4D.GSTD>5) = 6;
                    yyaxis left, hold on, plot(((N4D.GSTD)./10)./1, 'Color', [[0.1 0.5 0.3]]), ylim([0, 1.1 ])    % yyaxis left, hold on, plot(((N4D.GSTD)./6)./5, 'k')     % 0.6350 0.0780 0.1840
                    yyaxis right, plot(DT1,'m-+'),  hold on,  plot(DT3,'b-+'), ylabel('Cumulative drought stress') 
                    % hold on, plot(N4D.GWAD./max(N4D.GWAD), 'r-', 'LineWidth', 1.01 )

                    if SATELLITEsol == 0
                    lgd = legend("WSPD -  Weather Station ", "WSPD - RAIN NASAP", "WSPD - RAIN TAMSAT", 'Phenology', 'Rain - Local Station', 'Rain - DB1 NASA', 'Rain - DB2 TAMSAT')
                    else
                        % lgd = legend("WSPD -  Soil Measure", "WSPD - SOILGRIDS", 'Phenology')
                        lgd = legend( 'Local Measure', 'Satellite DB', 'Phenology')
                    end
                    lgd.Position = [0.1394    0.6675    0.1667    0.2680];
                    yyaxis left,
                    ylim([-0.001, (max(N4D.GSTD)./6).*1.01 ])  % 1.01
                    
                    saveas(gcf,strcat('METEOstations/DROUGTHg/', num2str( i ),'drougth','.png') ), % close(f1)
                    

                    %% Integral Sterss
                    % x = (WTH.DATE);  x = x(1:numel(DT1));
                    % f1 = figure, plot(x, DT1,'m-+'),  hold on,  plot(DT3,'b-+'), grid on; if SATELLITEsol == 0,  hold on, plot(DT2,'c-+'), end
                    % f1.Position = [39.4000  461.8000  623.2000  279.2000];
                    % ylabel('Cumulative drougth stress'), xlabel('Time')  % days
                    % title(strcat(NAM, ' / RMSE: ', ERMSEn ,  ' / R2: ', ER2n, ' / p-value: ',EPVn)), % title(strcat(NAM)),  % Drougth stress
                    % 
                    % yyaxis right, 
                    % hold on, plot(((N4D.GSTD)./6), 'k-') , ylim([0, 1.1]), % ylabel('Phase'),
                    % hold on,     plot(x, D1 , 'm-', 'LineWidth', 1.3 ),  hold on,  plot(D3 , 'b-', 'LineWidth', 1.3 ), grid on; if SATELLITEsol == 0,  hold on, plot(D2 , 'c-'), end
                    % ylabel('Drougth stress - WSPD')
                    % if SATELLITEsol == 0 
                    % lgd = legend('Rain - Local Station', 'Rain - DB2 TAMSAT','Rain - DB1 PNASA' )  % 'Phenology'
                    % else 
                    %      % lgd = legend( 'Cumulative Drought - Local Station', 'Cumulative Drought - DB SOILGRID', 'Drought - Local Station', 'Drought - DB SOILGRID','Phenology')
                    %        lgd = legend( 'Local Station', 'DB SOILGRID', 'Phenology')
                    % end
                    % 
                    % lgd.Position = [0.1295 0.7277 0.2064 0.1898];
                    % saveas(gcf,strcat('METEOstations/DROUGTHg/INT/', num2str( i ),'drougthINT','.png') )
                    %% Integral LLUVIA 
                    D1=PLUISAT1(SSDg(i) : SSDg(i)+120); DT1=0; for l=1:numel(D1)-1,  DT1(l+1)=D1(l+1)+DT1(l);  end  % Local station
                    D2=PLUISAT2(SSDg(i) : SSDg(i)+120); DT2=0; for l=1:numel(D2)-1,  DT2(l+1)=D2(l+1)+DT2(l);  end  % POWER NASA
                    D3=PLUISAT3(SSDg(i) : SSDg(i)+120); DT3=0; for l=1:numel(D3)-1,  DT3(l+1)=D3(l+1)+DT3(l);  end  % TAMSAT

                    % Dry spell indicators
                    [DSC51, DSC101, DSC201, DS11, DSxl1 ] = DrySpellIndicators(i, D1, NAM, 1)
                    [DSC52, DSC102, DSC202, DS12, DSxl2 ] = DrySpellIndicators(i, D2, NAM, 2)
                    [DSC53, DSC103, DSC203, DS13, DSxl3 ] = DrySpellIndicators(i, D3, NAM, 3)

                    % End _ Dry spell indicators
                    [ERMSE2, ER22 , EPV2 ] = ERRORmetrics(DT1, DT2)
                    [ERMSE3, ER23 , EPV3 ] = ERRORmetrics(DT1, DT3)
                    
                    x = (WTH.DATE);  x = x(1:numel(DT1));
                    f1 = figure, plot(x, DT1,'m-+'),  hold on, hold on, plot(x, DT2,'c-+'),  plot(x, DT3,'b-+'), grid on; % if SATELLITEsol == 0,  hold on, plot(x, DT2,'c-+'), end
                    ylim([0, max([DT1, DT2, DT3])*1.3]), 
                    text(38,  max([DT1, DT2, DT3])*1.2,  ['PNASA ->  / RMSE: ', ERMSE2 ,  ' / R2: ', ER22, ' / p-value: ',EPV2, '/ '] ); 
                    text(38,  max([DT1, DT2, DT3])*1.1,  ['TAMSAT -> / RMSE: ', ERMSE3 ,  ' / R2: ', ER23, ' / p-value: ',EPV3, '/' ]); 

                    f1.Position = [217.0000  429.8000  773.6000  268.0000];
                    ylabel('Cumulative Rainfall'), xlabel('days')

                    title(strcat(NAM )),
                    % [ ' / 1RMSE: ', ERMSE2 ,  ' / 1R2: ', ER22, ' / 1p-value: ',EPV2, '/ & ', '/ 2RMSE: ', ERMSE3 ,  ' / 2R2: ', ER23, ' / 2p-value: ',EPV3, '/' ]
                    

                    %title(strcat(NAM)),  % Drougth stress

                    % yyaxis right, hold on, plot(((N4D.GSTD)./1), 'k') , ylim([0, 6.1]), % ylabel('Phase'),
                    if SATELLITEsol <2 % == 0 
                        yyaxis right,  ylabel('Rainfall (mm/day)'),
                        hold on, plot(PLUISAT1(SSDg(i) : SSDg(i)+120), "m-.")
                        hold on, plot(PLUISAT2(SSDg(i) : SSDg(i)+120), "c-.")
                        hold on, plot(PLUISAT3(SSDg(i) : SSDg(i)+120), "b-.")
                        % lgd = legend("WSPD -  Weather Station ", "WSPD - Meteo Satellite", 'Rain - Local Station', 'Rain - DB1 NASA', 'Rain - DB2 TAMSAT' )
                    % lgd = legend('Cumulative- Local Station','Cumulative- DB PNASA',  'Cumulative- DB TAMSAT',  ' Rainfall- Local Station', 'Rainfall- DB NASA', 'Rainfall- DB TAMSAT')
                    lgd = legend('Local Station','DB PNASA',  'DB TAMSAT')
                    else 
                         lgd = legend("WSPD -  Soil Measure", "WSPD - SOILGRIDS", 'Phenology', 'Rainfall - Local Station', 'Rainfall - DB1 NASA', 'Rainfall - DB2 TAMSAT')
                    end
                    ylim([0, round(max([PLUISAT1; PLUISAT2; PLUISAT3]))*1.2 ])
                    
                    lgd.Position = [0.1302    0.7370    0.1518    0.1888];
                    saveas(gcf,strcat('METEOstations/DROUGTHg/RAININT/', num2str( i ),'drougthINT','.png') )


                    DSC5T1  =[DSC5T1;  DSC51 ];
                    DSC10T1 =[DSC10T1; DSC101];
                    DSC20T1 =[DSC20T1; DSC201];
                    DS1T1 = [DS1T1;  DS11];
                    DSxlT1= [DSxlT1; DSxl1];

                    Indecator1 = [Indecator1; [DSC5T1; DSC10T1; DSC20T1; DS1T1; DSxlT1]];
                    tag1 = [tag1; [repmat('1DSC5 ', size(DSC5T1,1) , 1);
                           repmat('1DSC10', size(DSC10T1,1) , 1);
                           repmat('1DSC20', size(DSC20T1,1) , 1);
                           repmat('1DS1  ', size(DS1T1,1) , 1);
                           repmat('1DSxl ', size(DSxlT1,1) , 1)]];
                   

                    DSC5T2  =[DSC5T2;  DSC52 ];
                    DSC10T2 =[DSC10T2; DSC102];
                    DSC20T2 =[DSC20T2; DSC202]; 
                    DS1T2 = [DS1T2;  DS12];
                    DSxlT2= [DSxlT2; DSxl2];

                    Indecator2 = [Indecator2; [DSC5T2; DSC10T2; DSC20T2; DS1T2; DSxlT2]];
                    tag2 = [tag2; [repmat('2DSC5 ', size(DSC5T2,1) , 1);
                           repmat('2DSC10', size(DSC10T2,1), 1);
                           repmat('2DSC20', size(DSC20T2,1), 1);
                           repmat('2DS1  ', size(DS1T2,1), 1);
                           repmat('2DSxl ', size(DSxlT2,1), 1)]];
                    
                    
                    DSC5T3  =[DSC5T3;  DSC53 ];
                    DSC10T3 =[DSC10T3; DSC103];
                    DSC20T3 =[DSC20T3; DSC203];
                    DS1T3 = [DS1T3;  DS13];
                    DSxlT3= [DSxlT3; DSxl3];
                    Indecator3 = [Indecator3; [DSC5T3; DSC10T3; DSC20T3; DS1T3; DSxlT3]];
                    tag3 = [tag3; [repmat('3DSC5 ', size(DSC5T3,1) , 1);
                           repmat('3DSC10', size(DSC10T3,1), 1);
                           repmat('3DSC20', size(DSC20T3,1), 1);
                           repmat('3DS1  ', size(DS1T3,1), 1);
                           repmat('3DSxl ', size(DSxlT3,1), 1)]];
                    
                   close all

                end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            end
        end 


if VISUAL == 1
    DSS = [DSS11; DSS21; DSS31;  DSS12; DSS22; DSS32;  DSS13; DSS23; DSS33 ];
    tagDSS = [      repmat('DSS11', size(DSS11,1), 1);
                    repmat('DSS21', size(DSS21,1), 1);
                    repmat('DSS31', size(DSS31,1), 1);
    
                    repmat('DSS12', size(DSS12,1), 1);
                    repmat('DSS22', size(DSS22,1), 1);
                    repmat('DSS32', size(DSS32,1), 1);
    
                    repmat('DSS13', size(DSS13,1), 1);
                    repmat('DSS23', size(DSS23,1), 1);
                    repmat('DSS33', size(DSS33,1), 1)
                    ];
    
    f1 = figure, 
    boxplot(DSS, tagDSS)
    grid on, title('Drougth Stress indicator'), ylabel('Accumulated stress intensity')
    f1.Position = [584.2000  419.4000  848.0000  292.8000];  % Drougth stress
    saveas(gcf,strcat('METEOstations/DROUGTHg/', 'Drought' ,'-indicator','.png') )    
    
    
    
    tag =  [tag1; tag2; tag3];
    IndecatorT = [Indecator1; Indecator2;Indecator3 ];
    
   INDICATORS(tag, IndecatorT)   
    
    
    dayscicle = [1:1:numel(N4D.GSTD)]';
    idx1 = ((N4D.GSTD == 0) + (N4D.GSTD == 1) + (N4D.GSTD == 2)) == 1;
    T1 = max(dayscicle(idx1)); % phase 0 & 1
    
    idx2 = ((N4D.GSTD == 3) + (N4D.GSTD == 4)) == 1;
    T21 = min(dayscicle(idx2)); T22 = max(dayscicle(idx2));
    
    idx3 = ((N4D.GSTD == 5) + (N4D.GSTD == 6)) == 1;
    T3 = min(dayscicle(idx3));
    
    IDX1 = (IndecatorT(:,1) <= T1 ); 
    IDX2 = (IndecatorT(:,1) >= T21) .* (IndecatorT(:,1) <= T22)==1; 
    IDX3 = (IndecatorT(:,1) >= T3); 
    
    % f1 = figure, 
    % subplot(1,3,1), boxplot(IndecatorT(IDX1,2), tag(IDX1,:))
    % grid on, title('Dry spell indicators PHASE 0-1-2'), ylabel('Events')
    % subplot(1,3,2), boxplot(IndecatorT(IDX2,2), tag(IDX2,:))
    % grid on, title('Dry spell indicators PHASE 3-4'), ylabel('Events')
    % subplot(1,3,3), boxplot(IndecatorT(IDX3,2), tag(IDX3,:))
    % grid on, title('Dry spell indicators PHASE 5-6'), ylabel('Events')
    % 
    % f1.Position = [1.8    363.4    1531.2    397.6];  % Drougth stress
    % saveas(gcf,strcat('METEOstations/DROUGTHg/', 'PHASEs','dryspell','.png') )    

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
writetable(SIM,strcat('DROUGTHg/', num2str( i ),'Simulation','.csv') );    % ,'Delimiter',',');  % DSSAT
%% ##########################################################################################################################
%% **************************************************************************************************************************
%% GRAPHIC
% ii = logical([1 0 1  0, 0 0 1 0 1 1, 0, 0 0, 1 0]); 
VISUAL = 1; 
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

    saveas(gcf,strcat('METEOstations/DROUGTHg/','ALL','.png') )  
    pause(0.1)


% GTg = DBg.ANT(ii) - DBg.SW(ii) ;   % GRound Truth
% SIMg = AYdb; 
% f3 = figure, plot([min([GTg;SIMg])*0.9, max([GTg;SIMg])*1.10],[min([GTg;SIMg])*0.9, max([GTg;SIMg])*1.1], 'k-'), hold on
% plot(GTg, SIMg, "b*"), grid on, ylabel('Ground Truth'), xlabel('DSSAT simulation')
% title('Crop parameters LITERATURE - N4'),  f3.Position = [857.8000  182.6000  553.6000  239.2000]; 
% legend('ANT (days)')

% SIMg = DBg.MAT(ii) - DBg.SW(ii) ;   % GRound Truth
% GTg = CYdb;
% f3 = figure, plot([min([GTg;SIMg])*0.9, max([GTg;SIMg])*1.10],[min([GTg;SIMg])*0.9, max([GTg;SIMg])*1.1], 'k-'), hold on
% plot(GTg, SIMg, "b*"), grid on, ylabel('Ground Truth'), xlabel('DSSAT simulation')
% title('Crop parameters LITERATURE - N4'),  f3.Position = [857.8000  182.6000  553.6000  239.2000]; 
% legend('Cycle (days)')

end

end