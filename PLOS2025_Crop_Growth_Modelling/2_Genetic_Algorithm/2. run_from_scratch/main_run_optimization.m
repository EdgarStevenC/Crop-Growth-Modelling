%% ========================================================================
%  GENETIC ALGORITHM FOR CERES-RICE IDEOTYPE OPTIMIZATION
%  ========================================================================
%  Code developed by Edgar S. CORREA for the doctoral thesis and academic paper 
%  "Inverse Engineering of Living Systems: From Physiological Growth Modeling 
%  to AI-Driven Ideotype Optimization"
%  
%  Copyright © 2025 Edgar S. CORREA. 
%  Licensed under Creative Commons Attribution-NonCommercial 4.0 (CC BY-NC 4.0)
%
%  Repository: https://github.com/EdgarStevenC/Crop-Growth-Modelling
%
%  DESCRIPTION:
%    This script performs genetic algorithm optimization to identify optimal
%    genetic coefficient combinations (ideotypes) for CERES-Rice model that
%    maximize the Agro-Ecological Index (AEI = HI + WUE_normalized).
%
%  REQUIRED FILES:
%    - Pop_ini.m           : Initialize population with random genotypes
%    - eval_fitness_csm.m  : Evaluate fitness using CERES-Rice simulations
%    - Select_parents.m    : Tournament selection for parent selection
%    - Crossover_parents.m : Single-point crossover operator
%    - Mutation.m          : Random mutation operator
%    - Visual_Ind.m        : Visualize individual genotype
%
%  OUTPUTS:
%    - AG_ENV[X].mat       : Complete optimization results
%    - GA_Convergence_ENV[X].png/tiff/pdf/fig : Convergence plots
%
%  USAGE:
%    1. Set ENV variable to desired environment (1, 2, 3, or 4)
%    2. Run script
%    3. Results saved automatically to RESULTS/ folder
%
%  REFERENCE:
%    Edgar S. CORREA (2025). Inverse Engineering of Living Systems.
%    PLOS ONE. Revition
%  ========================================================================

clc, clearvars, close all

%% ========================================================================
%  CONFIGURATION - MODIFY THIS SECTION
%  ========================================================================
ENV = 3;  % <-- ENVIRONMENT NUMBER (1, 2, 3, or 4)

%% ========================================================================
%  GA PARAMETERS
%  ========================================================================
% Population settings
Num_Pop = 40;    % Maximum number of generations
Num_ind = 15;    % Initial population size
Thr_mut = 0.7;   % Mutation rate (0-1)

% Random seed for reproducibility
% rng(100);
rng('shuffle'); 

fprintf('=========================================================\n');
fprintf('  GENETIC ALGORITHM - CERES-Rice Ideotype Optimization\n');
fprintf('  Environment: %d\n', ENV);
fprintf('=========================================================\n');
fprintf('  Generations: %d\n', Num_Pop);
fprintf('  Population size: %d\n', Num_ind);
fprintf('  Mutation rate: %.1f%%\n', Thr_mut * 100);
fprintf('=========================================================\n\n');

%% ========================================================================
%  INITIALIZATION
%  ========================================================================
tic

% Initialize population with random genotypes
Pop = Pop_ini(Num_ind);

% History arrays
best_Fit_hist = [];      % Best fitness per generation
fit_hist_mean = [];      % Mean fitness per generation
hist_BEST = [];          % Best individual fitness history
ind_best = [];           % Best individual in current generation
best_fit_global = 0;     % Global best fitness
ind_best_global = [];    % Global best individual
ind_id = 1;              % Individual ID counter

%% ========================================================================
%  MAIN OPTIMIZATION LOOP
%  ========================================================================
fprintf('Starting optimization...\n\n');

for i = 1:Num_Pop
    
    %% Evaluate fitness for all individuals
    [Pop] = eval_fitness_csm(Pop, ind_id, i);
    Num_ind = size(Pop, 1);
    
    % Add best individual from previous generation (elitism)
    if i > 1
        Pop(end + 1, 1) = ind_best;
    end
    
    %% Find best individual in current generation
    best_fit = 0;
    sum_fit = 0;
    
    for j = 1:Num_ind
        % Track best individual
        if Pop(j, 1).fitness > best_fit
            best_fit = Pop(j, 1).fitness;
            ind_best_fit = j;
            ind_best = Pop(j, 1);
            ind_best.range = [];
        end
        
        % Accumulate fitness for mean calculation
        sum_fit = sum_fit + Pop(j, 1).fitness;
        
        % Update global best
        if best_fit_global < best_fit
            best_fit_global = best_fit;
            ind_best_global = Pop(j, 1);
        end
    end
    
    %% Record history
    best_Fit_hist = [best_Fit_hist, best_fit];
    mean_fit = sum_fit / Num_ind;
    fit_hist_mean = [fit_hist_mean, mean_fit];
    hist_BEST = [hist_BEST, ind_best.fitness];
    
    %% Genetic operators
    Pop = Select_parents(Pop);           % Selection
    Pop_N = Crossover_parents(Pop);      % Crossover
    Pop = [Mutation(Pop_N, Thr_mut); ind_best];  % Mutation + Elitism
    
    %% Real-time visualization
    clf;
    subplot(2, 1, 1)
    Visual_Ind(ind_best_global)
    
    subplot(2, 1, 2)
    yyaxis left
    plot(hist_BEST, 'b*-'), hold on
    ylabel('Best Fitness')
    yyaxis right
    plot(fit_hist_mean, 'r*-'), hold on
    ylabel('Mean Fitness')
    xlabel('Generation')
    title(sprintf('Environment %d - Generation %d/%d', ENV, i, Num_Pop))
    grid on
    
    pause(0.00001)
    
    %% Progress report
    if mod(i, 10) == 0
        elapsed = toc;
        fprintf('  Generation %d/%d | Best: %.4f | Mean: %.4f | Time: %.1f min\n', ...
            i, Num_Pop, best_fit, mean_fit, elapsed/60);
    end
end

%% ========================================================================
%  FINAL CONVERGENCE PLOT (PUBLICATION QUALITY)
%  ========================================================================
fig_conv = figure('Units', 'pixels', 'Position', [100 100 800 500]);

yyaxis left
plot(best_Fit_hist, 'b-', 'LineWidth', 1.5)
ylabel('Best Fitness', 'FontSize', 12)
hold on

yyaxis right
plot(fit_hist_mean, 'r-', 'LineWidth', 1.5)
ylabel('Mean Fitness', 'FontSize', 12)

title(sprintf('GA Convergence - Environment %d', ENV), 'FontSize', 14, 'FontWeight', 'bold')
xlabel('Generation', 'FontSize', 12)
grid on
legend('Best genotype', 'Mean all genotypes', 'Location', 'best', 'FontSize', 10)

% Add final values annotation
text(0.98, 0.15, sprintf('Final Best: %.4f', best_Fit_hist(end)), ...
    'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'right');
text(0.98, 0.05, sprintf('Final Mean: %.4f', fit_hist_mean(end)), ...
    'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'right');

%% ========================================================================
%  SAVE FIGURES (MULTIPLE FORMATS)
%  ========================================================================
if ~exist('RESULTS', 'dir')
    mkdir('RESULTS');
end

% PNG - High resolution (300 dpi)
exportgraphics(fig_conv, sprintf('RESULTS/GA_Convergence_ENV%d.png', ENV), 'Resolution', 300);

% TIFF - High resolution (300 dpi)
exportgraphics(fig_conv, sprintf('RESULTS/GA_Convergence_ENV%d.tiff', ENV), 'Resolution', 300);

% PDF - Vector graphics
exportgraphics(fig_conv, sprintf('RESULTS/GA_Convergence_ENV%d.pdf', ENV), 'ContentType', 'vector');

% MATLAB figure
savefig(fig_conv, sprintf('RESULTS/GA_Convergence_ENV%d.fig', ENV));

fprintf('\n✓ Figures saved:\n');
fprintf('  - RESULTS/GA_Convergence_ENV%d.png (300 dpi)\n', ENV);
fprintf('  - RESULTS/GA_Convergence_ENV%d.tiff (300 dpi)\n', ENV);
fprintf('  - RESULTS/GA_Convergence_ENV%d.pdf (vector)\n', ENV);
fprintf('  - RESULTS/GA_Convergence_ENV%d.fig (MATLAB)\n', ENV);

%% ========================================================================
%  SAVE RESULTS
%  ========================================================================
total_time = toc;
final_params = ind_best_global.gentype;

% Save intermediate results
save(sprintf('ind_bestENV%d_.mat', ENV), "ind_best", 'hist_BEST', "fit_hist_mean")

% Save complete results
save(sprintf('AG_ENV%d_.mat', ENV), "Pop", "ind_best", "ind_best_global", ...
    'hist_BEST', "fit_hist_mean", 'total_time', 'final_params', 'best_Fit_hist', ...
    'Num_Pop', 'Num_ind', 'Thr_mut', 'ENV');

%% ========================================================================
%  FINAL SUMMARY
%  ========================================================================
fprintf('\n=========================================================\n');
fprintf('  OPTIMIZATION COMPLETE - Environment %d\n', ENV);
fprintf('=========================================================\n');
fprintf('  Total time: %.2f minutes (%.2f hours)\n', total_time/60, total_time/3600);
fprintf('  Final best fitness: %.4f\n', best_fit_global);
fprintf('  Generations to convergence: ~%d\n', find(best_Fit_hist >= 0.95*best_fit_global, 1));
fprintf('=========================================================\n');
fprintf('  Results saved: AG_ENV%d_.mat\n', ENV);
fprintf('=========================================================\n');

%% Display optimal parameters
fprintf('\n  OPTIMAL GENETIC COEFFICIENTS:\n');
param_names = {'P1', 'P2R', 'P5', 'P2O', 'G1', 'G2', 'G3', 'PHINT'};
for p = 1:length(param_names)
    fprintf('    %s: %.4f\n', param_names{p}, final_params(p));
end
fprintf('=========================================================\n');
