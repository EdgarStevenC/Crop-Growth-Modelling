function generate_phenotypic_landscape()
%% ========================================================================
%  GENERATE_PHENOTYPIC_LANDSCAPE - GA results visualization (Figure 7)
%  ========================================================================
%
%  Creates 4×4 panel figure showing correlations between HI-WUE fitness
%  index and phenotypic outputs across four environments.
%
%  Also generates:
%    - Table S2: Correlation statistics
%    - Console output: Best ideotypes per environment
%
%  REQUIRED DATA STRUCTURE:
%    1. IND_761/1Pop.mat ... 40Pop.mat  (Environment 1)
%    2. IND_846/1Pop.mat ... 40Pop.mat  (Environment 2)
%    3. IND_256/1Pop.mat ... 40Pop.mat  (Environment 3)
%    4. IND_686/1Pop.mat ... 40Pop.mat  (Environment 4)
%
%  OUTPUT:
%    - RESULTS/GA_Results_4Environments.png/pdf/fig (Figure 7)
%    - RESULTS/Table_S2_Correlation_Statistics.csv
%
%  AUTHOR: Edgar S. Correa
%  DATE: December 2025
%  LICENSE: CC BY 4.0
%  ========================================================================

%% Configuration
env_paths = {
    '1. IND_761/', 1;
    '2. IND_846/', 2;
    '3. IND_256/', 3;
    '4. IND_686/', 4
};

%% Figure setup - Automatic screen adjustment
screen_size = get(0, 'ScreenSize');
fig_width = min(1600, screen_size(3) * 0.9);
fig_height = min(900, screen_size(4) * 0.85);
figure('Units', 'pixels', 'Position', [50 50 fig_width fig_height]);

%% Loop through 4 environments
for k = 1:size(env_paths, 1)
    
    path_env = env_paths{k, 1};
    env = env_paths{k, 2};
    
    %% Data preparation for environment
    POPULATION = [];
    
    % Load data for current environment
    for i = 1:20
        filename = sprintf('%s%dPop.mat', path_env, i);
        if exist(filename, 'file')
            load(filename);
            if isfield(Pop, 'range'), Pop = rmfield(Pop, 'range'); end
            POPULATION = [POPULATION; Pop];
        end
    end
    
    % Sort and process
    POPULATION = struct2table(POPULATION);
    [~, idx] = sort(POPULATION.fitness);
    POPULATION = POPULATION(idx,:);
    
    % Extract phenotypes
    numPhenotypes = size(POPULATION,1);
    Phenotype = [];
    for i = 1:numPhenotypes
        Phenotype = [Phenotype; mean(POPULATION.phenotype{i})];
    end
    POPULATION.phenotype = Phenotype;
    
    % Extract variables
    FIT = POPULATION.fitness;
    GY = POPULATION.phenotype.Grain_Yield;
    BSS = POPULATION.phenotype.Biomass;
    HI = POPULATION.phenotype.HI;
    NG = POPULATION.phenotype.Grain_Number;
    LAI = POPULATION.phenotype.Leaf_Area_Index;
    RD = POPULATION.phenotype.Root_Density;
    WUE = POPULATION.phenotype.WUE;
    Cycle = POPULATION.phenotype.Cycle;
    Anthesis = POPULATION.phenotype.Anthesis;
    
    %% SUBPLOT 1: Yield
    subplot(4,4,(env-1)*4+1);
    yyaxis left; 
    h1 = plot(FIT, GY, 'b.'); hold on; h2 = plot(FIT, BSS, 'c.'); 
    ylabel('Kg/H');
    p1 = polyfit(FIT, GY, 1); plot(FIT, polyval(p1, FIT), 'b-', 'LineWidth', 1.5);
    p2 = polyfit(FIT, BSS, 1); plot(FIT, polyval(p2, FIT), 'Color', [0, 0.78, 0.78], 'LineWidth', 1.5);
    
    sig_GY = calc_significance_local(FIT, GY);
    sig_BSS = calc_significance_local(FIT, BSS);
    text(0.02, 0.98, sig_GY, 'Units', 'normalized', 'FontSize', 6, 'Color', 'b', 'FontWeight', 'bold', 'VerticalAlignment', 'top');
    text(0.02, 0.85, sig_BSS, 'Units', 'normalized', 'FontSize', 6, 'Color', [0, 0.78, 0.78], 'FontWeight', 'bold', 'VerticalAlignment', 'top');
    
    yyaxis right; 
    ax = gca; ax.YAxis(2).Color = [0, 0, 0];
    plot(FIT, HI, 'k.'); ylabel('HI');
    p3 = polyfit(FIT, HI, 1); plot(FIT, polyval(p3, FIT), 'k-', 'LineWidth', 1.5);
    
    sig_HI = calc_significance_local(FIT, HI);
    text(0.98, 0.98, sig_HI, 'Units', 'normalized', 'FontSize', 6, 'Color', 'k', 'FontWeight', 'bold', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
    
    if env==1, title('Yield'); end
    text(-0.35, -0.215, sprintf('%s) Environment %d', char(96+env), env), 'Units', 'normalized', 'FontWeight', 'bold', 'FontSize', 10);
    xlabel('HI-WUE', 'Color', [0.7 0.7 0.7]); 
    leg = legend([h1 h2], {'GY', 'Biomass'}, 'Location', 'southeast', 'FontSize', 7, 'Box', 'off'); grid on;
    pause(0.1)
    leg.Position(1) = leg.Position(1) + 0.0050;  
    leg.Position(2) = leg.Position(2) - 0.0080;
    pause(0.1)
    
    %% SUBPLOT 2: Grain & LAI
    subplot(4,4,(env-1)*4+2);
    yyaxis left; 
    h3 = plot(FIT, NG, 'b.'); ylabel('Grain (#/m²)');
    hold on;
    valid_idx = NG > 500;
    if sum(valid_idx) > 2
        p4 = polyfit(FIT(valid_idx), NG(valid_idx), 1); 
        plot(FIT(valid_idx), polyval(p4, FIT(valid_idx)), 'b-', 'LineWidth', 1.5);
        sig_NG = calc_significance_local(FIT(valid_idx), NG(valid_idx));
    else
        sig_NG = calc_significance_local(FIT, NG);
    end
    text(0.02, 0.98, sig_NG, 'Units', 'normalized', 'FontSize', 6, 'Color', 'b', 'FontWeight', 'bold', 'VerticalAlignment', 'top');
    
    yyaxis right; 
    h4 = plot(FIT, LAI, 'c.'); ylabel('LAI (m²/m²)');
    ax = gca; ax.YAxis(2).Color = [0, 0.55, 0.55];
    p5 = polyfit(FIT, LAI, 1); plot(FIT, polyval(p5, FIT), 'Color', [0, 0.78, 0.78], 'LineWidth', 1.5);
    
    sig_LAI = calc_significance_local(FIT, LAI);
    text(0.98, 0.98, sig_LAI, 'Units', 'normalized', 'FontSize', 6, 'Color', [0, 0.55, 0.55], 'FontWeight', 'bold', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
    
    if env==1, title('Grain & LAI'); end
    xlabel('HI-WUE', 'Color', [0.7 0.7 0.7]); 
    leg = legend([h3 h4], {'Grain', 'LAI'}, 'Location', 'southeast', 'FontSize', 7, 'Box', 'off'); grid on;
    pause(0.1)
    leg.Position(1) = leg.Position(1) + 0.0050;  
    leg.Position(2) = leg.Position(2) - 0.0080;
    pause(0.1)
    
    %% SUBPLOT 3: WUE & Root
    subplot(4,4,(env-1)*4+3);
    yyaxis left; 
    h5 = plot(FIT, WUE, 'b.'); ylabel('WUE');
    p6 = polyfit(FIT, WUE, 1); hold on; plot(FIT, polyval(p6, FIT), 'b-', 'LineWidth', 1.5);
    
    sig_WUE = calc_significance_local(FIT, WUE);
    text(0.02, 0.98, sig_WUE, 'Units', 'normalized', 'FontSize', 6, 'Color', 'b', 'FontWeight', 'bold', 'VerticalAlignment', 'top');
    
    yyaxis right; 
    h6 = plot(FIT, RD, 'c.'); ylabel('Root (cm/cm³)');
    ax = gca; ax.YAxis(2).Color = [0, 0.55, 0.55];
    p7 = polyfit(FIT, RD, 1); plot(FIT, polyval(p7, FIT), 'Color', [0, 0.78, 0.78], 'LineWidth', 1.5);
    
    sig_RD = calc_significance_local(FIT, RD);
    text(0.98, 0.98, sig_RD, 'Units', 'normalized', 'FontSize', 6, 'Color', [0, 0.55, 0.55], 'FontWeight', 'bold', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');
    
    if env==1, title('WUE & Root'); end
    xlabel('HI-WUE', 'Color', [0.7 0.7 0.7]);
    leg = legend([h5 h6], {'WUE', 'Root'}, 'Location', 'southeast', 'FontSize', 7, 'Box', 'off'); grid on;
    pause(0.1)
    leg.Position(1) = leg.Position(1) + 0.0050;  
    leg.Position(2) = leg.Position(2) - 0.0080;
    pause(0.1)
    
    %% SUBPLOT 4: Phenology
    subplot(4,4,(env-1)*4+4);
    h7 = plot(FIT, Anthesis, 'b.'); hold on; h8 = plot(FIT, Cycle, 'c.'); 
    ylabel('Days');
    p8 = polyfit(FIT, Anthesis, 1); plot(FIT, polyval(p8, FIT), 'b-', 'LineWidth', 1.5);
    p9 = polyfit(FIT, Cycle, 1); plot(FIT, polyval(p9, FIT), '--', 'Color', [0, 0.78, 0.78], 'LineWidth', 1.5);
    
    sig_Anth = calc_significance_local(FIT, Anthesis);
    sig_Cyc = calc_significance_local(FIT, Cycle);
    text(0.02, 0.98, sig_Anth, 'Units', 'normalized', 'FontSize', 6, 'Color', 'b', 'FontWeight', 'bold', 'VerticalAlignment', 'top');
    text(0.02, 0.85, sig_Cyc, 'Units', 'normalized', 'FontSize', 6, 'Color', [0, 0.78, 0.78], 'FontWeight', 'bold', 'VerticalAlignment', 'top');
    
    if env==1, title('Phenology'); end
    xlabel('HI-WUE', 'Color', [0.7 0.7 0.7]); 
    leg = legend([h7 h8], {'Anthesis', 'Maturity'}, 'Location', 'southeast', 'FontSize', 7, 'Box', 'off'); grid on;
    pause(0.1)
    leg.Position(1) = leg.Position(1) + 0.0050;  
    leg.Position(2) = leg.Position(2) - 0.0080;
    pause(0.1)
end

%% Add separator lines between environments
for env_line = 1:4
    y_pos = 1 - (env_line*0.25) + 0.005;
    if env_line == 1, y_pos = y_pos - 0.030; end 
    if env_line == 2, y_pos = y_pos - 0.0002; end  
    if env_line == 3, y_pos = y_pos + 0.030; end 
    if env_line == 4, y_pos = y_pos + 0.060; end  
    
    annotation('line', [0.08 0.92], [y_pos, y_pos], 'LineWidth', 1.5, 'Color', 'k');
end

%% Generate correlation table (Table S2)
generate_correlation_table_local(4, 20);

%% Export figure
if ~exist('RESULTS', 'dir'), mkdir('RESULTS'); end

exportgraphics(gcf, 'RESULTS/GA_Results_4Environments.png', 'Resolution', 300);
exportgraphics(gcf, 'RESULTS/GA_Results_4Environments.pdf', 'ContentType', 'vector');
savefig(gcf, 'RESULTS/GA_Results_4Environments.fig');

fprintf('✓ Figure 7 saved: PNG, PDF, and FIG\n');

pause(1)

%% Display correlation table in console
display_correlation_table_local();

pause(1)

%% Identify best ideotypes
identify_best_ideotypes_local();

end

%% ========================================================================
%  LOCAL HELPER FUNCTIONS
%  ========================================================================

function sig_text = calc_significance_local(X, Y)
    valid = ~isnan(X) & ~isnan(Y);
    X = X(valid);
    Y = Y(valid);
    
    if length(X) < 3
        sig_text = 'R²=NA';
        return;
    end
    
    [R, P] = corr(X, Y, 'Type', 'Pearson');
    R2 = R^2;
    
    if P < 0.001
        sig_text = sprintf('R²=%.2f***', R2);
    elseif P < 0.01
        sig_text = sprintf('R²=%.2f**', R2);
    elseif P < 0.05
        sig_text = sprintf('R²=%.2f*', R2);
    else
        sig_text = sprintf('R²=%.2f', R2);
    end
end

function generate_correlation_table_local(n_envs, n_gens)
    env_paths = {
        '1. IND_761/', 1;
        '2. IND_846/', 2;
        '3. IND_256/', 3;
        '4. IND_686/', 4
    };
    
    var_names = {'GY', 'Biomass', 'HI', 'NGrains', 'LAI', 'WUE', 'Root', 'Anthesis', 'Maturity'};
    n_vars = length(var_names);
    
    results = cell(n_envs * 2, n_vars + 2);
    
    row = 1;
    for k = 1:n_envs
        path_env = env_paths{k, 1};
        env = env_paths{k, 2};
        
        POPULATION = [];
        for i = 1:n_gens
            filename = sprintf('%s%dPop.mat', path_env, i);
            if exist(filename, 'file')
                load(filename);
                if isfield(Pop, 'range'), Pop = rmfield(Pop, 'range'); end
                POPULATION = [POPULATION; Pop];
            end
        end
        
        POPULATION = struct2table(POPULATION);
        numPhenotypes = size(POPULATION, 1);
        Phenotype = [];
        for i = 1:numPhenotypes
            Phenotype = [Phenotype; mean(POPULATION.phenotype{i})];
        end
        POPULATION.phenotype = Phenotype;
        
        FIT = POPULATION.fitness;
        vars_data = {
            POPULATION.phenotype.Grain_Yield, ...
            POPULATION.phenotype.Biomass, ...
            POPULATION.phenotype.HI, ...
            POPULATION.phenotype.Grain_Number, ...
            POPULATION.phenotype.Leaf_Area_Index, ...
            POPULATION.phenotype.WUE, ...
            POPULATION.phenotype.Root_Density, ...
            POPULATION.phenotype.Anthesis, ...
            POPULATION.phenotype.Cycle
        };
        
        results{row, 1} = env;
        results{row, 2} = 'R²';
        results{row + 1, 1} = '';
        results{row + 1, 2} = 'p-value';
        
        for v = 1:n_vars
            [R, P] = corr(FIT, vars_data{v}, 'Type', 'Pearson', 'Rows', 'complete');
            R2 = R^2;
            
            results{row, v + 2} = sprintf('%.3f', R2);
            
            if P < 0.001
                results{row + 1, v + 2} = '***';
            elseif P < 0.01
                results{row + 1, v + 2} = '**';
            elseif P < 0.05
                results{row + 1, v + 2} = '*';
            else
                results{row + 1, v + 2} = 'ns';
            end
        end
        
        row = row + 2;
    end
    
    header = ['Env', 'Metric', var_names];
    
    fid = fopen('RESULTS/Table_S2_Correlation_Statistics.csv', 'w');
    fprintf(fid, '%s,', header{1:end-1});
    fprintf(fid, '%s\n', header{end});
    
    for r = 1:size(results, 1)
        for c = 1:size(results, 2) - 1
            if isnumeric(results{r, c})
                fprintf(fid, '%d,', results{r, c});
            else
                fprintf(fid, '%s,', results{r, c});
            end
        end
        fprintf(fid, '%s\n', results{r, end});
    end
    fclose(fid);
    
    fprintf('✓ Table S2 saved: RESULTS/Table_S2_Correlation_Statistics.csv\n');
end

function display_correlation_table_local()
    env_paths = {
        '1. IND_761/', 1;
        '2. IND_846/', 2;
        '3. IND_256/', 3;
        '4. IND_686/', 4
    };
    
    fprintf('\n');
    fprintf('=========================================================================\n');
    fprintf('  TABLE S2: CORRELATION STATISTICS (R² and p-values)\n');
    fprintf('=========================================================================\n');
    fprintf('  HI-WUE vs Phenotypic Outputs | *** p<0.001, ** p<0.01, * p<0.05, ns p≥0.05\n');
    fprintf('=========================================================================\n\n');
    
    fprintf('%-5s %-8s %-12s %-12s %-12s %-12s %-12s %-12s %-12s %-12s %-12s\n', ...
        'Env', 'Metric', 'GY', 'Biomass', 'HI', 'NGrains', 'LAI', 'WUE', 'Root', 'Anthesis', 'Maturity');
    fprintf('%s\n', repmat('-', 1, 115));
    
    for k = 1:4
        path_env = env_paths{k, 1};
        env = env_paths{k, 2};
        
        POPULATION = [];
        for i = 1:20
            filename = sprintf('%s%dPop.mat', path_env, i);
            if exist(filename, 'file')
                load(filename);
                if isfield(Pop, 'range'), Pop = rmfield(Pop, 'range'); end
                POPULATION = [POPULATION; Pop];
            end
        end
        
        POPULATION = struct2table(POPULATION);
        numPhenotypes = size(POPULATION, 1);
        Phenotype = [];
        for i = 1:numPhenotypes
            Phenotype = [Phenotype; mean(POPULATION.phenotype{i})];
        end
        POPULATION.phenotype = Phenotype;
        
        FIT = POPULATION.fitness;
        vars_data = {
            POPULATION.phenotype.Grain_Yield, ...
            POPULATION.phenotype.Biomass, ...
            POPULATION.phenotype.HI, ...
            POPULATION.phenotype.Grain_Number, ...
            POPULATION.phenotype.Leaf_Area_Index, ...
            POPULATION.phenotype.WUE, ...
            POPULATION.phenotype.Root_Density, ...
            POPULATION.phenotype.Anthesis, ...
            POPULATION.phenotype.Cycle
        };
        
        R2_vals = zeros(1, 9);
        sig_vals = cell(1, 9);
        
        for v = 1:9
            [R, P] = corr(FIT, vars_data{v}, 'Type', 'Pearson', 'Rows', 'complete');
            R2_vals(v) = R^2;
            
            if P < 0.001
                sig_vals{v} = '***';
            elseif P < 0.01
                sig_vals{v} = '**';
            elseif P < 0.05
                sig_vals{v} = '*';
            else
                sig_vals{v} = 'ns';
            end
        end
        
        fprintf('%-5d %-8s ', env, 'R²');
        for v = 1:9
            fprintf('%-12.3f ', R2_vals(v));
        end
        fprintf('\n');
        
        fprintf('%-5s %-8s ', '', 'p-value');
        for v = 1:9
            fprintf('%-12s ', sig_vals{v});
        end
        fprintf('\n');
        
        fprintf('%s\n', repmat('-', 1, 115));
    end
    
    fprintf('\n');
end

function identify_best_ideotypes_local()
    env_paths = {
        '1. IND_761/', 1;
        '2. IND_846/', 2;
        '3. IND_256/', 3;
        '4. IND_686/', 4
    };
    
    fprintf('\n');
    fprintf('=========================================================================\n');
    fprintf('  IDENTIFYING BEST INDIVIDUAL (IDEOTYPE) PER ENVIRONMENT\n');
    fprintf('=========================================================================\n');
    
    for k = 1:4
        path_env = env_paths{k, 1};
        env = env_paths{k, 2};
        
        best_fit = 0;
        best_gen = 0;
        best_ind_idx = 0;
        best_ind = [];
        global_idx = 0;
        best_global_idx = 0;
        
        for gen = 1:40
            filename = sprintf('%s%dPop.mat', path_env, gen);
            if exist(filename, 'file')
                load(filename);
                for j = 1:numel(Pop)
                    global_idx = global_idx + 1;
                    if Pop(j).fitness > best_fit
                        best_fit = Pop(j).fitness;
                        best_gen = gen;
                        best_ind_idx = j;
                        best_global_idx = global_idx;
                        best_ind = Pop(j);
                    end
                end
            end
        end
        
        fprintf('\n');
        fprintf('=========================================================================\n');
        fprintf('  ENVIRONMENT %d - BEST IDEOTYPE FOUND\n', env);
        fprintf('=========================================================================\n');
        fprintf('  Global position:   %d / %d\n', best_global_idx, global_idx);
        fprintf('  Generation:        %d / 40\n', best_gen);
        fprintf('  Individual in gen: %d\n', best_ind_idx);
        fprintf('  Fitness:           %.4f\n', best_fit);
        fprintf('  File:              %s%dPop.mat\n', path_env, best_gen);
        
        fprintf('\n  GENOTYPE (raw values):\n');
        fprintf('  -----------------------------------------\n');
        param_names = {'P1', 'P2R', 'P5', 'P2O', 'G1', 'G2', 'G3', 'PHINT'};
        for p = 1:length(best_ind.gentype)
            if p <= length(param_names)
                fprintf('    %-8s: %12.4f\n', param_names{p}, best_ind.gentype(p));
            else
                fprintf('    Param %d: %12.4f\n', p, best_ind.gentype(p));
            end
        end
        
        fprintf('\n  PHENOTYPE (mean across years):\n');
        fprintf('  -----------------------------------------\n');
        phen = mean(best_ind.phenotype);
        phen_names = phen.Properties.VariableNames;
        phen_vals = table2array(phen);
        for v = 1:length(phen_names)
            fprintf('    %-25s: %12.2f\n', phen_names{v}, phen_vals(v));
        end
        
    end
end