clc, clearvars, close all
%% ***************************************************************************
%% Code to automatic tuning of DSSAT - Edgar S. Correa (May/2024)
%% ***************************************************************************
%% No.1 initial values (ABRIL/24) (ALLEX - CAMILA)
% P1 = 430;       %*   
% P5 = 550;     
% PHINT = 80;     %*
% P2Rm = 64.0000; %*
% P2Om = 12.2000; %*   
% G1m = 75;
% G2m = 0.03;   
% G3m = 0.7;      %* 
% 
% G4 = 1.0;   
% G5 = 1.0;
% THOT = 35;    
% TCLDP = 15.0;
% TCLDF = 15.0;
% SATELLITE = 0;
% SATELLITEsol = 1;
%% No.2 EDGAR N0.1 (27/05/24)
% P1 = 520;   %430;    
% P5 = 550;     
% PHINT = 60; % 80;
% P2Rm = 10;  % 64.0000 ;
% P2Om = 13;  % 12.2000;   
% G1m = 75;
% G2m = 0.03;   
% G3m = 0.6;  % 0.7; 
% % PREFINE - Temperature limits
% G4 = 1.0;   
% G5 = 1.0;
% THOT = 35;    
% TCLDP = 15.0;
% TCLDF = 15.0;

%% ***************************************************************************
% SATELLITE = 0;
% SATELLITEsol = 1;
% RESULTSVIEW = 1;
% % [GYdbDSSAT, GT, FIT] = MECHANISTIC(P1,P2Rm,P5,P2Om,G1m,G2m,G3m,PHINT,THOT,TCLDP,TCLDF,G4,G5, 0.,RESULTSVIEW, SATELLITE, SATELLITEsol);FIT % last VISUAL=1
% insilicoSIM(P1, P2Rm, P5,  P2Om, G1m, G2m,   G3m,  PHINT,  THOT,  TCLDP,  TCLDF,  G4,   G5)
%% ***************************************************************************
%% No.3.1 Optimization (25/05/24)
% % load('ind_best1.mat'); gentype = ind_best.gentype;
% %       [P1] = gentype(1);
% %       [P5] = gentype(2);
% %       [P2Rm] = gentype(3);
% %       [PHINT] = gentype(4);
% %       [P2Om] = gentype(5);
% %       [G1m] = gentype(6);
% %       [G2m] = gentype(7);
% %       [G3m] = gentype(8);
% % [GYdbDSSAT, GT, FIT] = MECHANISTIC(P1,P2Rm,P5,P2Om,G1m,G2m,G3m,PHINT,THOT,TCLDP,TCLDF,G4,G5, 0.,RESULTSVIEW, SATELLITE, SATELLITEsol);FIT % last VISUAL=1
% 
% %% No.3.2 Optimization (26/05/24)
% % load('ind_best2.mat'); gentype = ind_best.gentype;
% %       [P1] = gentype(1);
% %       [P5] = gentype(2);
% %       [P2Rm] = gentype(3);
% %       [PHINT] = gentype(4);
% %       [P2Om] = gentype(5);
% %       [G1m] = gentype(6);
% %       [G2m] = gentype(7);
% %       [G3m] = gentype(8);
% % [GYdbDSSAT, GT, FIT] = MECHANISTIC(P1,P2Rm,P5,P2Om,G1m,G2m,G3m,PHINT,THOT,TCLDP,TCLDF,G4,G5, 0.,RESULTSVIEW, SATELLITE, SATELLITEsol);FIT % last VISUAL=1
% % 523.484375000000	612.656250000000	115.703125000000	60	13	67	0.0265000000000000	0.600000000000000
%% ***************************************************************************
%% OPTIMIZATION
%% AG
Num_Pop = 15;   % numero maximo de la poblacion  --> 10
Num_ind = 5;    % Numero de individuos inicial   --> 50
Thr_mut = 0.7;  % porcentaje de mutacion
Pop=Pop_ini(Num_ind);
% for i = 1 : Num_ind
%     P(i,:) = Pop(i).gentype;
% end, figure, plot(P)
dist_hist=[]; dist_hist_mean=[]; ind_best=[]; min_dist_global=inf; hist_BEST=[];
max_dist=0;
ind_id = 1;
for i=1:Num_Pop
    
    [Pop] = eval_fitness_csm(Pop, ind_id); Num_ind = size(Pop,1);
    if i>1, Pop(end+1,1)=ind_best;end
        min_dist=inf;
        sum_dist=0;
        % ind_min_fitness=1;
        for j=1:Num_ind
            if min_dist>Pop(j,1).dist
                min_dist=Pop(j,1).dist;
                ind_min_dist=j; ind_best=Pop(j,1); ind_best.range = [];
            end
            sum_dist=sum_dist+Pop(j,1).dist;
            if min_dist_global>min_dist
                min_dist_global=min_dist;
                
            end         
        end   
        dist_hist=[dist_hist min_dist];

        mean_dist=sum_dist/Num_ind;
        dist_hist_mean=[dist_hist_mean mean_dist];  
        hist_BEST=[hist_BEST ind_best.fitness]; 


        Pop=[Select_parents(Pop);  ind_best];
        Pop_N= Crossover_parents(Pop);
        Pop=[Pop; Mutation(Pop_N, Thr_mut)];
        clf;
        Visual_Ind(ind_best)    % Visual_Ind(Pop(ind_min_dist,1),Map);
        subplot(2,1,2)   
        plot( hist_BEST, '*-'), hold on,  ylabel('FIT function')         % BEST local              % plot(dist_hist), hold on % AVERAGE local
        yyaxis right,   plot( dist_hist_mean,'*-'), hold on,  ylabel('Average FC'),      % AVERAGE local
        grid on, %legend('Best Genotype','Local generation'), 
        xlabel('Populations'),
        pause(0.00001)
        toc
end
save('ind_best2.mat',"ind_best", 'hist_BEST', "dist_hist_mean")
% load('AG.mat')
% save('AG3.mat', "Pop", "ind_best", 'hist_BEST', "dist_hist_mean") 


figure
yyaxis left,  plot(dist_hist), hold on % BEST local 
yyaxis right, plot(dist_hist_mean), hold on % AVERAGE local
title('Fitness Function', 'FontSize', 14),  xlabel('Iterations'), ylabel('ERMS'), grid on, legend('Best genotype','Average All genotypes') 
% figure, plot(dist_hist), title('Fitness Function', 'FontSize', 14),  xlabel('Iterations'), ylabel('ERMS'), grid on, legend('Best genotype','Average All genotypes')   %ylim([1000 2200])
