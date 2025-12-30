function generate_convergence_plots(paths, Num_Pop)
%% ========================================================================
%  GENERATE_CONVERGENCE_PLOTS - GA convergence trajectories (Figure S1)
%  ========================================================================
%
%  Creates convergence plots showing best and mean fitness across 
%  generations for each environment.
%
%  INPUT:
%    paths   - Cell array with {folder_path, environment_number}
%    Num_Pop - Number of generations (default: 40)
%
%  OUTPUT:
%    Saves PNG, PDF, TIFF, and FIG files in RESULTS/ folder
%
%  AUTHOR: Edgar S. Correa
%  DATE: December 2025
%  ========================================================================

OUT = [];  % Consolidated output table

for K = 1:size(paths, 1)
    
    path_env = paths{K, 1};
    ENV = paths{K, 2};
    
    fprintf('  Processing Environment %d: %s\n', ENV, path_env);
    
    %% Initialize storage
    Fit_all = [];
    Gen_all = [];
    Phen_all = [];
    
    best_Fit_hist = [];
    fit_hist_mean = [];
    
    ind_best_global = [];
    best_fit_global = 0;
    
    %% Load data from each generation
    for j = 1:Num_Pop
        
        filename = sprintf('%s%dPop.mat', path_env, j);
        
        if ~exist(filename, 'file')
            warning('File not found: %s', filename);
            continue;
        end
        
        load(filename, 'Pop');
        
        gen_fitness = [];
        best_fit_gen = 0;
        ind_best_gen = [];
        
        for i = 1:numel(Pop)
            Fit_all = [Fit_all; Pop(i).fitness];
            Gen_all = [Gen_all; Pop(i).gentype];
            Phen_all = [Phen_all; table2array(mean(Pop(i).phenotype))];
            
            gen_fitness = [gen_fitness; Pop(i).fitness];
            
            if Pop(i).fitness > best_fit_gen
                best_fit_gen = Pop(i).fitness;
                ind_best_gen = Pop(i);
            end
            
            if Pop(i).fitness > best_fit_global
                best_fit_global = Pop(i).fitness;
                ind_best_global = Pop(i);
            end
        end
        
        best_Fit_hist = [best_Fit_hist, best_fit_gen];
        fit_hist_mean = [fit_hist_mean, mean(gen_fitness)];
    end
    
    OUT = [OUT; [Fit_all, Gen_all, Phen_all, ones(size(Fit_all)) .* ENV]];
    
    %% Create convergence plot
    fig_conv = figure('Units', 'pixels', 'Position', [100 100 1000 400]);
    
    yyaxis left
    plot(best_Fit_hist, 'b-*', 'LineWidth', 1.5, 'MarkerSize', 6)
    ylabel('Best Fitness', 'FontSize', 12)
    hold on
    
    yyaxis right
    plot(fit_hist_mean, 'r-*', 'LineWidth', 1.5, 'MarkerSize', 6)
    ylabel('Mean Fitness', 'FontSize', 12)
    
    title(sprintf('GA Convergence - Environment %d', ENV), 'FontSize', 14, 'FontWeight', 'bold')
    xlabel('Generation', 'FontSize', 12)
    grid on
    
    legend('Best genotype', 'Mean all genotypes', ...
           'Location', 'northeast', 'FontSize', 10, 'Box', 'off')
    
    % Add final values annotation
    text(0.98, 0.25, sprintf('Final Best: %.4f', best_Fit_hist(end)), ...
        'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'right');
    text(0.98, 0.12, sprintf('Final Mean: %.4f', fit_hist_mean(end)), ...
        'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'right');
    
    % Convergence generation (95% of improvement)
    min_fit = best_Fit_hist(1);
    max_fit = best_fit_global;
    threshold = min_fit + 0.95 * (max_fit - min_fit);
    conv_gen = find(best_Fit_hist >= threshold, 1);
    
    if ~isempty(conv_gen)
        text(0.02, 0.98, sprintf('Convergence: Gen %d', conv_gen), ...
            'Units', 'normalized', 'FontSize', 10, 'VerticalAlignment', 'top');
    end
    
    %% Save figures
    exportgraphics(fig_conv, sprintf('RESULTS/GA_Convergence_ENV%d.png', ENV), 'Resolution', 300);
    exportgraphics(fig_conv, sprintf('RESULTS/GA_Convergence_ENV%d.tiff', ENV), 'Resolution', 300);
    exportgraphics(fig_conv, sprintf('RESULTS/GA_Convergence_ENV%d.pdf', ENV), 'ContentType', 'vector');
    savefig(fig_conv, sprintf('RESULTS/GA_Convergence_ENV%d.fig', ENV));
    
    %% Save environment results
    final_params = ind_best_global.gentype;
    save(sprintf('RESULTS/AG_ENV%d.mat', ENV), ...
        'ind_best_global', 'best_Fit_hist', 'fit_hist_mean', ...
        'final_params', 'best_fit_global', 'Num_Pop', 'ENV');
    
    %% Display summary
    fprintf('    Individuals: %d | Best fitness: %.4f | Convergence: Gen %d\n', ...
            size(Fit_all, 1), best_fit_global, conv_gen);
    
    close(fig_conv);
end

%% Save consolidated data
save('RESULTS/Ideotype_ALL.mat', 'OUT');

% Export to Excel
col_names = {'Fitness', 'P1', 'P5', 'P2R', 'PHINT', 'P2O', 'G1', 'G2', 'G3', ...
             'Grain_Yield', 'Biomass', 'Grain_Number', 'Tiller_Number', ...
             'Anthesis', 'Cycle', 'Leaf_per_Stem', 'Leaf_Area_Index', ...
             'Root_Depth', 'Root_Density', ...
             'DT1', 'DT2', 'DT3', 'DT4', 'DT5', 'DT6', 'DT7', ...
             'Evapotranspiration', 'HI', 'WUE', 'Environment'};

if size(OUT, 2) == length(col_names)
    OUT_table = array2table(OUT, 'VariableNames', col_names);
    writetable(OUT_table, 'RESULTS/Ideotype.xlsx', 'Sheet', 'All_Environments');
    
    for env = 1:4
        env_data = OUT_table(OUT_table.Environment == env, :);
        writetable(env_data, 'RESULTS/Ideotype.xlsx', 'Sheet', sprintf('ENV%d', env));
    end
end

end