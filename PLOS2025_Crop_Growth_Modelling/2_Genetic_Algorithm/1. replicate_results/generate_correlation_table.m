%% ========================================================================
%  GENERATE STATISTICS TABLE FOR SUPPLEMENTARY MATERIAL
%  ========================================================================
% Wavelet Toolbox _ Required
function generate_correlation_table(n_envs, n_gens)
% GENERATE_CORRELATION_TABLE Export correlation statistics to CSV
%
% Creates Table S2 with R², p-values for all variable-environment combinations

    % Variable names
    var_names = {'GY', 'Biomass', 'HI', 'NGrains', 'LAI', 'WUE', 'Root', 'Anthesis', 'Maturity'};
    n_vars = length(var_names);
    
    % Initialize results table
    results = cell(n_envs * 2, n_vars + 2);  % +2 for Env and Metric columns
    
    row = 1;
    for env = 1:n_envs
        %% Load data for environment
        POPULATION = [];
        for i = 1:n_gens
            load(sprintf('IND_P%d/POPULATION/%dPop.mat', env, i));
            if isfield(Pop, 'range'), Pop = rmfield(Pop, 'range'); end
            POPULATION = [POPULATION; Pop];
        end
        
        % Process data
        POPULATION = struct2table(POPULATION);
        numPhenotypes = size(POPULATION, 1);
        Phenotype = [];
        for i = 1:numPhenotypes
            Phenotype = [Phenotype; mean(POPULATION.phenotype{i})];
        end
        POPULATION.phenotype = Phenotype;
        
        % Extract variables
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
        
        %% Calculate correlations
        results{row, 1} = env;
        results{row, 2} = 'R²';
        results{row + 1, 1} = '';
        results{row + 1, 2} = 'p-value';
        
        for v = 1:n_vars
            [R, P] = corr(FIT, vars_data{v}, 'Type', 'Pearson', 'Rows', 'complete');
            R2 = R^2;
            
            % R² value
            results{row, v + 2} = sprintf('%.3f', R2);
            
            % Significance
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
    
    %% Export to CSV
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