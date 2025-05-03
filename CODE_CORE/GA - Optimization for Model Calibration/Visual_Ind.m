function [] = Visual_Ind(ind_best)
GEN = ind_best.GRAPH;
DBg=GEN.DBg; dss=GEN.dss; ii=GEN.ii; 
GYdb=GEN.GYdb; BSSdb=GEN.BSSdb; ANTdb=GEN.ANTdb; MATdb=GEN.MATdb; NGdb=GEN.NGdb; NTdb=GEN.NTdb;
VISUAL2 = 1;

 ii = logical([1, 1, 1, 1, 1, 0 0 0 0 1, 1, 0 0, 1, 1,]);  %%  PaperI (05/01/2025)
 MTC = ERRmetrics(DBg(ii,:), GYdb, BSSdb, ANTdb, MATdb, NGdb, NTdb, ii,1 );
 % sgtitle('CAL / VAL')

%%
        % %% YIELD
        % GTg = DBg.GY(ii);  % GTg = TT.GY_Kg_H_(1:9);  % GRound Truth
        % GTgN = dss.WTH(ii) ; % DBg.ID(ii); 
        % SIMg = GYdb;
        % ERR = rmse(GTg, SIMg);
        % ERRstvGY = ( sum( abs(1-(SIMg./GTg)) ) /(numel(SIMg)) ) ;
        % if VISUAL2 == 1
        %     f3 = clf, f3.Position = [1.0    181.0    1536.8    596.0];
        %     subplot(2,5,2)
        %     plot(GTg, SIMg, "b*"),  hold on,
        %      for k = 1 : numel(GTg), text(GTg(k), SIMg(k),  GTgN{k}); end  % numel(DBg.ID2)
        %     plot([min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30],[min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30], 'k-'),
        %     grid on, xlabel('Ground Truth'), ylabel('DSSAT simulation')
        %     title(strcat('Grain Yield - RMSE =  ',num2str(ERR))),  %f3.Position = [133.0000   85.8000  850.4000  680.8000]; 
        %     legend('DB1 - GY')
        %     text(10, max(GTg), num2str(ERRstvGY), 'color','b')
        % end
        % % saveas(gcf,strcat('SIMULATIONdssat/','YIELD','.png') )    
        % %% BIOMASS  DBg.ID2
        % GTg = DBg.BSS(ii);  % GTg = TT.GY_Kg_H_(1:9);  % GRound Truth
        % GTgN = dss.WTH(ii) ; % DBg.ID(ii); 
        % SIMg = BSSdb;
        % ERR = rmse(GTg, SIMg);
        % ERRstvBSS = ( sum( abs(1-(SIMg./GTg)) ) /(numel(SIMg)) ) ;
        % if VISUAL2 == 1
        %     subplot(2,5,3) 
        %     plot(GTg, SIMg, "b*"),  hold on,
        %      for k = 1 : numel(GTg), text(GTg(k), SIMg(k),  GTgN{k}); end
        %     plot([min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30],[min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30], 'k-'),
        %      grid on, xlabel('Ground Truth'), ylabel('DSSAT simulation'),
        %     title(strcat('Biomass - RMSE =  ',num2str(ERR))),   % f3.Position = [133.0000   85.8000  850.4000  680.8000]; 
        %     legend('DB1 - Biomass') 
        %     text(10, max(GTg), num2str(ERRstvBSS),'color', 'b')
        % end
        % % saveas(gcf,strcat('SIMULATIONdssat/','BIOMASS','.png') )  
        % %% Number grains
        % GTg = DBg.NG_HNAM(ii);  % GTg = TT.GY_Kg_H_(1:9);  % GRound Truth
        % GTgN = dss.WTH(ii) ; % DBg.ID(ii); 
        % SIMg = NGdb;
        % ERR = rmse(GTg, SIMg);
        % ERRstvNG = ( sum( abs(1-(SIMg./GTg)) ) /(numel(SIMg)) ) ;
        % if VISUAL2 == 1
        %     subplot(2,5,4) 
        %     plot(GTg, SIMg, "b*"),  hold on,
        %      for k = 1 : numel(GTg), text(GTg(k), SIMg(k),  GTgN{k}); end
        %     plot([min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30],[min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30], 'k-'),
        %      grid on, xlabel('Ground Truth'), ylabel('DSSAT simulation'),
        %     title(strcat('Number of Grains - RMSE =  ',num2str(ERR))),  % f3.Position = [133.0000   85.8000  850.4000  680.8000]; 
        %     legend('DB1 - No. Grains')
        %     text(10, max(GTg), num2str(ERRstvNG), 'color','b')
        % end
        % % saveas(gcf,strcat('SIMULATIONdssat/','NG','.png') )  
        % 
        % %% Number tiller 
        % GTg = DBg.NT_TNAM(ii);  % GTg = TT.GY_Kg_H_(1:9);  % GRound Truth
        % GTgN = dss.WTH(ii) ; % DBg.ID(ii); 
        % SIMg = NTdb;
        % ERR = rmse(GTg, SIMg);
        % ERRstvNT = ( sum( abs(1-(SIMg./GTg)) ) /(numel(SIMg)) ) ;
        % if VISUAL2 == 1
        %     subplot(2,5,5) 
        %     plot(GTg, SIMg, "b*"),  hold on,
        %      for k = 1 : numel(GTg), text(GTg(k), SIMg(k),  GTgN{k}); end
        %     plot([min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30],[min([GTg;SIMg])*0.7, max([GTg;SIMg])*1.30], 'k-'),
        %      grid on, xlabel('Ground Truth'), ylabel('DSSAT simulation'),
        %     title(strcat('Number of Tillers - RMSE =  ',num2str(ERR))),  % f3.Position = [133.0000   85.8000  850.4000  680.8000]; 
        %     legend('DB1 - No. Tillers')
        %     text(100, max(GTg), num2str(ERRstvNT), 'color','b')
        % end
        % % saveas(gcf,strcat('SIMULATIONdssat/','NT','.png') )  
        % 
        % 
        % %% PHENOLOGY
        % GTg = DBg.ANT(ii);  % GTg = TT.GY_Kg_H_(1:9);  % GRound Truth
        % GTgN = dss.WTH(ii) ; % DBg.ID(ii); 
        % SIMg = ANTdb;
        % ERR = rmse(GTg, SIMg);
        % ERRstvANT = ( sum( abs(1-(SIMg./GTg)) ) /(numel(SIMg)) ) ;
        % if VISUAL2 == 1
        %     subplot(2,5,1) 
        %     plot(GTg, SIMg, "b*"), hold on,    plot(0, 0, "r*"), 
        %     for k = 1 : numel(GTg), text(GTg(k), SIMg(k),  GTgN{k}); end
        %     plot([min([GTg;SIMg])*0.8, max([GTg;SIMg])*1.20],[min([GTg;SIMg])*0.8, max([GTg;SIMg])*1.20], 'k-'),
        %     grid on, xlabel('Ground Truth'), ylabel('DSSAT simulation'),
        %     title(strcat('Phenology ANT - RMSE =  ',num2str(ERR))),   % f3.Position = [133.0000   85.8000  850.4000  680.8000]; 
        %     plot(GTg, SIMg, "ko")
        %     text(220, max(GTg), num2str(ERRstvANT), 'color','b')
        % end
        % 
        % GTg = DBg.MAT(ii);  % GTg = TT.GY_Kg_H_(1:9);  % GRound Truth
        % GTgN = dss.WTH(ii) ; % DBg.ID(ii); 
        % SIMg = MATdb;
        % ERR = rmse(GTg, SIMg);
        % ERRstvMAT = ( sum( abs(1-(SIMg./GTg)) ) /(numel(SIMg)) ) ;
        % if VISUAL2 == 1
        %     hold on, plot(GTg, SIMg, "r*"), 
        %     for k = 1 : numel(GTg), text(GTg(k), SIMg(k),  GTgN{k}); end       % % for k = 1 : numel(DBg.ID2), text(GTg(k), SIMg(k),  DBg.ID2{k}); end
        %     plot([min([GTg;SIMg])*0.8, max([GTg;SIMg])*1.20],[min([GTg;SIMg])*0.8, max([GTg;SIMg])*1.20], 'k-'), hold on,
        %     grid on, xlabel('Ground Truth'), ylabel('DSSAT simulation')
        %     title([strcat('Phenology MAT - RMSE =  ',num2str(ERR))]),   % f3.Position = [133.0000   85.8000  850.4000  680.8000];  % f3.Position = [1.0    49.0    1536.0    740.8]; 
        %     legend('Anthesis  (day of year)','Cycle  (day of year)')
        %     xlim([220, 360]), ylim([220, 360])
        %     text(220, max(GTg), num2str(ERRstvMAT), 'color','r')
        %     saveas(gcf,strcat('SIMULATIONdssat/','SIMILATION','.png') )  
        % end
        % ERRORstv = (ERRstvMAT + ERRstvANT + ERRstvNG + ERRstvNT + ERRstvBSS + ERRstvGY)/6;
        % FIT =  ERRORstv ;  
end