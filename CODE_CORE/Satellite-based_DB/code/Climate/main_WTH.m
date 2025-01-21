
clc, clearvars, close all
%% Download Data from GPS coordinate
%% METEO  - 01 DB N4
load('GYxy.mat')
LON = GYxy(:,1); LAT = GYxy(:,2);
% LON = -15.59; LAT =  12.83; % SEFA
year = 2013;

% TT = readtable("TT.csv"); % load("TT.mat");
% LON = TT.LONs;
% LAT = TT.LATs;
% year = TT.Year;
%% SAVE WEATHER FROM NASA
% tic
% for i = 1 : numel(LON )
%     [daily] = METEOstv2(LON(i),LAT(i), i, year(i));
%     METEOfiles(daily)
% end, toc

%% METEO  - ALL Grid
load('GYxy.mat')
LON = GYxy(:,1); LAT = GYxy(:,2);


%% SAVE WEATHER FROM NASA
tic
for y = 2011: 2011 % 2022: 2022  % 1999:
year = y;
    for i = 1 : 1 :  numel(LON )
        [daily] = METEOstv2(LON(i),LAT(i), i, year);
        %METEOfiles(daily)
    end
end, toc
pause(0.1)


%% READ WEATHER - daily
RAIN = [];
year = 2000;
for k=1: size(GYxy,1)
    Point = k;  
    daily = readtable(strcat('METEO3/', num2str( year ), '/',num2str( Point ),'sample','.csv'));
    RAIN(k,1)= sum(daily.PRECTOTCORR);
end, save('RAIN.mat', 'RAIN')



load('GYxy.mat')
LON = GYxy(:,1); LAT = GYxy(:,2);
load('RAIN.mat'), load('SenegalR.mat')
h = ones(5,5)/25;
RAIN2 = imfilter(RAIN,h)*5;
figure, plot3(LON, LAT, RAIN2, 'b*')
hold on, mapshow(SenegalR, 'FaceColor', [1 1 1] ); 
grid on, xlabel('LON'), ylabel('LAT'), zlabel('Precipitation (mm/day) ')


figure, plot3(LON, LAT, RAIN, 'k*')
hold on, mapshow(SenegalR, 'FaceColor', [1 1 1] ); 
grid on, xlabel('LON'), ylabel('LAT'), zlabel('Precipitation (mm/day) ')

%% READ - METEO
% SAVE WEATHER FROM NASA

SOLDBai2 = readtable('FS0.xlsm'); LON0=SOLDBai2.LON; LAT0=SOLDBai2.LAT; year=SOLDBai2.Year;  
for i = 1 : numel(LON0)
    % [daily] = METEOstv2(LON0(i),LAT0(i), i, year(i) );
    % % METEOfiles(daily)
    WTHm = readtable(strcat('METEO2/', num2str( i ),'daily','.csv') );

    RAD(i,1) = mean(WTHm.CLRSKY_SFC_SW_DWN);
    TMIN(i,1) = mean(WTHm.T2M_MIN);
    TMAX(i,1) = mean(WTHm.T2M_MAX); 
    RAIN(i,1) = mean(WTHm.PRECTOTCORR); 
    RHUM(i,1) = mean(WTHm.RH2M);
    WIND(i,1) = mean(WTHm.WS2M);

    RADstd(i,1) = std(WTHm.CLRSKY_SFC_SW_DWN);
    TMINstd(i,1) = std(WTHm.T2M_MIN);
    TMAXstd(i,1) = std(WTHm.T2M_MAX); 
    RAINstd(i,1) = std(WTHm.PRECTOTCORR); 
    RHUMstd(i,1) = std(WTHm.RH2M);
    WINDstd(i,1) = std(WTHm.WS2M);

    RADdx(i,1) = mean(diff(WTHm.CLRSKY_SFC_SW_DWN));
    TMINdx(i,1) = mean(diff(WTHm.T2M_MIN));
    TMAXdx(i,1) = mean(diff(WTHm.T2M_MAX)); 
    RAINdx(i,1) = mean(diff(WTHm.PRECTOTCORR)); 
    RHUMdx(i,1) = mean(diff(WTHm.RH2M));
    WINDdx(i,1) = mean(diff(WTHm.WS2M));
end
WTHDBai2 = table(RAD, TMIN, TMAX, RAIN, RHUM, WIND, RADstd, TMINstd, TMAXstd, RAINstd, RHUMstd, WINDstd, RADdx, TMINdx, TMAXdx, RAINdx, RHUMdx, WINDdx)
% writetable(WTHDBai2 ,'WTHDBai2.xlsm'); 
