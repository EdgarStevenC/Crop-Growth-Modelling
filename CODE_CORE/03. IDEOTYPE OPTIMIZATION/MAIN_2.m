%  Code developed by Edgar S. CORREA for the doctoral thesis and academic paper 
%  "AI-Driven Insights for Crop Growth Modelling: Advancing Rainfed Rice Yield Prediction with
%  Machine Learning and Satellite Data in Senegal." 
%  Copyright © 2025 Edgar S. CORREA. This work is licensed under a Creative Commons 
%  Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0).
%% 25/02/2025

clc, clearvars, close all
%% **************************************************************************************************************
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AG Optimization  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [MCM_Table] = CERES_Rice(GEN, 73); ENV_6

%% OPTIMIZATION
%% AG
%% VAR INIT
Num_Pop = 20;    % numero maximo de la poblacion  --> 10
Num_ind = 15;    % Numero de individuos inicial   --> 50
Thr_mut = 0.7;   % porcentaje de mutacion
Pop=Pop_ini(Num_ind);
% for i = 1 : Num_ind
%     P(i,:) = Pop(i).gentype;
% end, figure, plot(P)
best_Fit_hist=[]; fit_hist_mean=[]; ind_best=[]; best_fit_global=0; hist_BEST=[];
max_dist=0;
ind_id = 1;
%% Main code
for i=1:Num_Pop
    
    [Pop] = eval_fitness_csm(Pop, ind_id,i); Num_ind = size(Pop,1);
    if i>1, Pop(end+1,1)=ind_best;end
        best_fit=0;
        sum_fit=0;
        % ind_min_fitness=1;
        for j=1:Num_ind
            if Pop(j,1).fitness>best_fit
                best_fit=Pop(j,1).fitness;
                ind_best_fit=j; ind_best=Pop(j,1); ind_best.range = [];
            end
            sum_fit=sum_fit+Pop(j,1).fitness;
            if best_fit_global<best_fit
                best_fit_global=best_fit;
                ind_best_global=Pop(j,1);
            end         
        end   
        best_Fit_hist=[best_Fit_hist best_fit];

        mean_fit=sum_fit/Num_ind;
        fit_hist_mean=[fit_hist_mean mean_fit];  
        hist_BEST=[hist_BEST ind_best.fitness]; 


        Pop=[Select_parents(Pop)];
        Pop_N= Crossover_parents(Pop);
        Pop=[Mutation(Pop_N, Thr_mut);  ind_best];
        clf;
        subplot(2,1,1) 
        Visual_Ind(ind_best_global)    % Visual_Ind(Pop(ind_min_dist,1),Map);
        subplot(2,1,2)   
        plot( hist_BEST, '*-'), hold on,  ylabel('Best Local _ FIT function')         % BEST local              % plot(dist_hist), hold on % AVERAGE local
        yyaxis right,   plot( fit_hist_mean,'*-'), hold on,  ylabel('Mean Local _ FIT function'),      % AVERAGE local
        grid on, %legend('Best Genotype','Local generation'), 
        xlabel('Populations'),
        pause(0.00001)
        toc
end
%% VISUALIZATION and SAVE
save('ind_best343.mat',"ind_best", 'hist_BEST', "fit_hist_mean")
% load('AG.mat')
 save('AG_ENV4_P343.mat', "Pop", "ind_best", "ind_best_global", 'hist_BEST', "fit_hist_mean") 

figure
yyaxis left,  plot(best_Fit_hist), hold on % BEST local 
yyaxis right, plot(fit_hist_mean), hold on % AVERAGE local
title('Fitness Function', 'FontSize', 14),  xlabel('Iterations'), ylabel('ERMS'), grid on, legend('Best genotype','Average All genotypes') 
% figure, plot(dist_hist), title('Fitness Function', 'FontSize', 14),  xlabel('Iterations'), ylabel('ERMS'), grid on, legend('Best genotype','Average All genotypes')   %ylim([1000 2200])
%% END CODE




 %% SSD = [datetime('2012-06-23'), ...
 %        datetime('2012-07-01'), datetime('2012-07-08'), datetime('2012-07-15'), datetime('2012-07-22'), ...
 %        datetime('2012-08-01'), datetime('2012-08-08'), datetime('2012-08-15'), datetime('2012-08-22') ] ;