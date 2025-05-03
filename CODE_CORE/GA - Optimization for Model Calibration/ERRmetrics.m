function [T] = ERRmetrics(DBg, GYdb, BSSdb, ANTdb, MATdb, NGdb, NTdb, ii, VISUAL)
MT = [];
%% PHENOLOGY
GTg = DBg.ANT;  % GTg = TT.GY_Kg_H_(1:9);  % GRound Truth
GTgN = string(DBg.dbGY); % string( [1:1:15]' ); %  DBg.ID2(ii); 
SIMg = ANTdb;
[MAE, RMSE, y_mean, NRMSE, R2 ] = METRIC(GTg, SIMg); MT = [MT; [MAE, RMSE, y_mean, NRMSE, R2 ]];
ERR = RMSE;
if VISUAL==1
    f3 = figure,
    subplot(2,5,1), plot(GTg, SIMg, "b*"), hold on,    plot(0, 0, "r*"), 
    for k = 1 : numel(GTg), text(GTg(k), SIMg(k), GTgN(k)); end
    plot([min([GTg;SIMg])*0.8, max([GTg;SIMg])*1.20],[min([GTg;SIMg])*0.8, max([GTg;SIMg])*1.20], 'k-'),
    grid on, xlabel('Ground Truth'), ylabel('DSSAT simulation'),
    title(strcat('NRMSE =',num2str(NRMSE), ' - R2 =',num2str(R2) )),   f3.Position = [133.0000   85.8000  850.4000  680.8000]; 
    plot(GTg, SIMg, "ko")
end

GTg = DBg.MAT;  % GTg = TT.GY_Kg_H_(1:9);  % GRound Truth
% GTgN = DBg.ID2(ii); 
SIMg = MATdb;
[MAE, RMSE, y_mean, NRMSE, R2 ] = METRIC(GTg, SIMg); MT = [MT; [MAE, RMSE, y_mean, NRMSE, R2 ]];
ERR = RMSE;
if VISUAL==1
    hold on, plot(GTg, SIMg, "r*"), 
    for k = 1 : numel(GTg), text(GTg(k), SIMg(k),  GTgN(k)); end       % % for k = 1 : numel(DBg.ID2), text(GTg(k), SIMg(k),  DBg.ID2{k}); end
    plot([min([GTg;SIMg])*0.8, max([GTg;SIMg])*1.20],[min([GTg;SIMg])*0.8, max([GTg;SIMg])*1.20], 'k-'), hold on,
    grid on, xlabel('Ground Truth'), ylabel('DSSAT simulation')
    title(strcat('NRMSE =',num2str(NRMSE), ' - R2 =',num2str(R2) )),   f3.Position = [133.0000   85.8000  850.4000  680.8000];  % f3.Position = [1.0    49.0    1536.0    740.8]; 
    legend('Anthesis  (day of year)','Cycle  (day of year)')
    xlim([240, 360]), ylim([240, 360])
    % saveas(gcf,strcat('METEOstations/MAYO24/','PHENOLOGY','.png') )  
end

%% YIELD
GTg = DBg.GY;  % GTg = TT.GY_Kg_H_(1:9);  % GRound Truth
% GTgN = DBg.ID2(ii); 
SIMg = GYdb;
[MAE, RMSE, y_mean, NRMSE, R2 ] = METRIC(GTg, SIMg); MT = [MT; [MAE, RMSE, y_mean, NRMSE, R2 ]];
ERR = RMSE;
if VISUAL==1
    subplot(2,5,2), plot(GTg, SIMg, "b*"),  hold on,
     for k = 1 : numel(GTg), text(GTg(k), SIMg(k),  GTgN{k}); end  % numel(DBg.ID2)
    plot([min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30],[min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30], 'k-'),
    grid on, xlabel('Ground Truth'), ylabel('DSSAT simulation')
    title(strcat('NRMSE =',num2str(NRMSE), ' - R2 =',num2str(R2) )),  f3.Position = [133.0000   85.8000  850.4000  680.8000]; 
    legend('Gerardeaux DB - GY(Kg/H)')
    xlim([-500, 5000]), ylim([-500, 5000])
    % saveas(gcf,strcat('METEOstations/MAYO24/','YIELD','.png') )   
end

%% BIOMASS  DBg.ID2
GTg = DBg.BSS;  % GTg = TT.GY_Kg_H_(1:9);  % GRound Truth
% GTgN = DBg.ID2(ii); 
SIMg = BSSdb;
[MAE, RMSE, y_mean, NRMSE, R2 ] = METRIC(GTg, SIMg); MT = [MT; [MAE, RMSE, y_mean, NRMSE, R2 ]];
ERR = RMSE;
if VISUAL==1
    subplot(2,5,3), plot(GTg, SIMg, "b*"),  hold on,
     for k = 1 : numel(GTg), text(GTg(k), SIMg(k),  GTgN{k}); end
    plot([min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30],[min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30], 'k-'),
     grid on, xlabel('Ground Truth'), ylabel('DSSAT simulation'),
    title(strcat('NRMSE =',num2str(NRMSE), ' - R2 =',num2str(R2) )),   f3.Position = [133.0000   85.8000  850.4000  680.8000]; 
    legend('Gerardeaux DB - Biomass(Kg/H)') 
    xlim([0, 10000]), ylim([0, 10000])
    % saveas(gcf,strcat('METEOstations/MAYO24/','BIOMASS','.png') )  
end
%% Number grains
GTg = DBg.NG_HNAM;  % GTg = TT.GY_Kg_H_(1:9);  % GRound Truth
% GTgN = DBg.ID2(ii); 
SIMg = NGdb;
[MAE, RMSE, y_mean, NRMSE, R2 ] = METRIC(GTg, SIMg); MT = [MT; [MAE, RMSE, y_mean, NRMSE, R2 ]];
ERR = RMSE;
if VISUAL==1
    subplot(2,5,4), plot(GTg, SIMg, "b*"),  hold on,
     for k = 1 : numel(GTg), text(GTg(k), SIMg(k),  GTgN{k}); end
    plot([min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30],[min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30], 'k-'),
     grid on, xlabel('Ground Truth'), ylabel('DSSAT simulation'),
    title(strcat('NRMSE =',num2str(NRMSE), ' - R2 =',num2str(R2) )),  f3.Position = [133.0000   85.8000  850.4000  680.8000]; 
    legend('Gerardeaux DB - Grains(#)')
    % xlim([-10000, 20000]), ylim([-10000, 20000])
    % saveas(gcf,strcat('METEOstations/MAYO24/','NG','.png') )  
end
%% Number tiller 
GTg = DBg.NT_TNAM;  % GTg = TT.GY_Kg_H_(1:9);  % GRound Truth
% GTgN = DBg.ID2(ii); 
SIMg = NTdb;
[MAE, RMSE, y_mean, NRMSE, R2 ] = METRIC(GTg, SIMg); MT = [MT; [MAE, RMSE, y_mean, NRMSE, R2 ]];
ERR = RMSE;
if VISUAL==1
    subplot(2,5,5), plot(GTg, SIMg, "b*"),  hold on,
     for k = 1 : numel(GTg), text(GTg(k), SIMg(k),  GTgN{k}); end
    plot([min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30],[min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30], 'k-'),
     grid on, xlabel('Ground Truth'), ylabel('DSSAT simulation'),
    title(strcat('NRMSE =',num2str(NRMSE), ' - R2 =',num2str(R2) )),  f3.Position = [133.0000   85.8000  850.4000  680.8000]; 
    legend('Gerardeaux DB - Tillers(#)')
    % xlim([0, 300]), ylim([0, 300])
    % saveas(gcf,strcat('METEOstations/MAYO24/','NT','.png') )  
    
    f3.Position = [ -0206.2    173.7    1912.0    535.3];
end
%% table

columnNames = {'Anthesis', 'Maturity', 'Grain Yield', 'Biomass', 'Number of grains', 'Number of tillers'};
T = array2table(MT', 'VariableNames', columnNames);

end