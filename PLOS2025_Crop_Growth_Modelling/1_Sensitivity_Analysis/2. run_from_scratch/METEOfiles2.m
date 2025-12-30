function [] = METEOfiles2(daily, SRAD, TMAX, TMIN, RAIN, WIND, EVAP, RHUM)
     TRY = 1; num2str(TRY);

    DEWP = ones(size(SRAD(:,1))).*-99; %DEWP = table(DEWP);
    PAR = ones(size(SRAD(:,1))).*-99;  %PAR = table(PAR);
    
    anne = (daily.YEAR(1)-2000);
    DOY = [ 1:1:numel(SRAD)]';   % 001    122-->MAY
    YYYYMMDD  = DOY + (12*1000); %( anne*1000);
    DSSATdate = array2table(YYYYMMDD);
    % WTH = [DSSATdate, daily(:,9), daily(:,10), daily(:,11), daily(:,15), DEWP, daily(:,16), PAR, EVAP, daily(:,14)];
    % WTH.Properties.VariableNames("YYYYMMDD") = "@DATE";
    % WTH.Properties.VariableNames("CLRSKY_SFC_SW_DWN") = "SRAD";  %  CLRSKY_SFC_PAR_TOT
    % WTH.Properties.VariableNames("T2M_MAX") = "TMAX";
    % WTH.Properties.VariableNames("T2M_MIN") = "TMIN";
    % WTH.Properties.VariableNames("PRECTOTCORR") = "RAIN";
    % WTH.Properties.VariableNames("WS2M") = "WIND";
    % WTH.Properties.VariableNames("RH2M") = "RHUM";
    % writetable(WTH,strcat( 'DSSATmeteo','.txt') ,'Delimiter',' ');  
    %% DSSAT
    %Generat ppm file
    num2str(TRY);
    fileID = fopen( 'DARO1201.WTH' , 'w');
    fprintf(fileID,'%1s %1s %1s %1s %1s %1s %1s %1s\n','@ INSI','LAT', 'LONG', 'ELEV', 'TAV', 'AMP', 'REFHT', 'WNDHT');
    fprintf(fileID,'%1s %1.3f %1.3f %1.0f %1.1f %1.1f %1.0f %1.0f\n','ALL', -99, -99, 50, 29.6, 7.6, 2.0, 2.0);

    fprintf(fileID,'%1s %5s %5s %5s %5s %5s %5s %5s %5s %5s\n','@DATE', 'SRAD', 'TMAX', 'TMIN', 'RAIN', 'DEWP', 'WIND', 'PAR', 'EVAP', 'RHUM' );
    %Write in ppm file
    Table = [YYYYMMDD , SRAD, TMAX, TMIN, RAIN, DEWP, WIND, PAR, EVAP, RHUM]';
    fprintf(fileID,'%1d %5.1f %5.1f %5.1f %5.1f %5.1f %5.1f %5.1f %5.1f %5.1f\n', Table );
    fclose(fileID);
    %% SAMARA
end