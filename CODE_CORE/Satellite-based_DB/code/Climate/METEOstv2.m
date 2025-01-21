function [daily] = METEOstv2(LON,LAT, i, yeart)  % , FWTH
    TRY = 1;
    s1 = LON;  % (DBtestS.Longitude(TRY) ); %num2str
    s2 = LAT;  % (DBtestS.Lattitude(TRY) );
    lonlat = [s1, s2]; writematrix(lonlat, 'lonlat.txt','Delimiter',','); % writematrix(M,'M_tab.txt')
    year = [(yeart*10000)+0101, (yeart*10000)+1231]; writematrix(year, 'year.txt','Delimiter',','); % year = [(yeart*10000)+0501, (yeart*10000)+1130]; writematrix(year, 'year.txt','Delimiter',','); 
    % Rpath = 'C:\Program Files\R\R-4.2.2\bin';
    % RscriptFileName = 'C:\Users\CORREAPINZON\Downloads\Climate_Data_Store_Toolbox_for_MATLAB (1)\WTHdata.R';
    % RunRcode(RscriptFileName, Rpath); 
      [status,cmdout] = system('"C:\Program Files\R\R-4.2.2\bin\R.exe" CMD BATCH "C:\Users\CORREAPINZON\Desktop\Samara\1.UNO_ENVIRONMENTDB\WEATHER\WTHdata.R"');  % RunRcode(RscriptFileName, Rpath); 
    % [status,cmdout] = system('"C:\Program Files\R\R-4.2.2\bin\R.exe" CMD BATCH "D:\Full DISK MAY 2024\MAIN CODE\1.UNO_ENVIRONMENTDB\WEATHER -  CODES\WTHdata.R"');  % RunRcode(RscriptFileName, Rpath); 
    if status == 1, disp("Error DSSAT - Conection..."), end

    daily = readtable('daily.csv');
    %writetable(daily,strcat('METEOai2/', num2str( i ),'sample','.csv') ,'Delimiter',',');
                % writetable(daily,strcat('METEOger/', num2str( i ),'daily','.csv')     % ,'Delimiter',',');  % DSSAT
    writetable(daily,strcat('METEO3/',num2str( yeart ),'/', num2str( i ),'sample','.csv') ,'Delimiter',',');  
    
end