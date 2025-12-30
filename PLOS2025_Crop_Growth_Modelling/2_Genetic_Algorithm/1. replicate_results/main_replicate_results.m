%% ========================================================================
%  GENETIC ALGORITHM - REPLICATE PAPER RESULTS
%  ========================================================================
%  
%  This script replicates the genetic algorithm optimization results 
%  presented in:
%  
%  Correa, E.S. (2025). "Decoding Living Systems: Reassessing Crop Model 
%  Frontiers via Biological Dynamics and Optimized Phenotype." PLOS ONE.
%  
%  DESCRIPTION:
%  ------------
%  Uses pre-computed GA optimization results (40 generations × 4 environments)
%  to generate:
%    - Figure 7: Phenotypic landscape (HI-WUE correlations)
%    - Figure S1: Convergence trajectories per environment
%    - Table S2: Correlation statistics with p-values
%    - Table S3: Optimal genetic coefficients per ideotype
%  
%  The genetic algorithm explored 5,364 virtual cultivars across 40 
%  generations, maximizing the HI-WUE fitness index (harvest index + 
%  normalized water use efficiency).
%  
%  OUTPUTS:
%  --------
%  - RESULTS/GA_Results_4Environments.png (Figure 7)
%  - RESULTS/GA_Convergence_ENV[1-4].png (Figure S1)
%  - RESULTS/Table_S2_Correlation_Statistics.csv
%  - RESULTS/Table_S3_Optimal_Coefficients.csv
%  - RESULTS/Ideotype.xlsx (all data)
%  
%  EXECUTION TIME: ~30 seconds
%  
%  REQUIREMENTS:
%  -------------
%  - MATLAB R2024b or later
%  - Pre-computed results: IND_761/, IND_846/, IND_256/, IND_686/
%  - Functions in ../functions/
%  
%  AUTHOR: Edgar S. Correa
%  DATE: December 2025
%  LICENSE: CC BY 4.0
%  REPOSITORY: https://github.com/EdgarStevenC/Crop-Growth-Modelling
%  ========================================================================

clc, clearvars, close all

%% ===== ADD FUNCTIONS PATH =====
addpath('../functions');

%% ===== CONFIGURATION =====
% Environment folders for convergence plots (Figure S1)
convergence_paths = {
    '1. IND_761/', 1;   % Folder, Environment number
    '2. IND_846/', 2;
    '3. IND_256/', 3;
    '4. IND_686/', 4
};

% Environment folders for phenotypic landscape (Figure 7)
landscape_paths = {'IND_P1', 'IND_P2', 'IND_P3', 'IND_P4'};

n_generations = 40;  % Number of generations per environment

% Create output folder
if ~exist('RESULTS', 'dir')
    mkdir('RESULTS');
end

%% ===== HEADER =====
fprintf('=========================================================================\n');
fprintf('  GENETIC ALGORITHM: Replicating Paper Results\n');
fprintf('=========================================================================\n');
fprintf('  Environments: 4\n');
fprintf('  Generations per environment: %d\n', n_generations);
fprintf('  Total virtual cultivars: 5,364\n');
fprintf('=========================================================================\n\n');

%% ===== STEP 1: Generate Convergence Plots (Figure S1) =====
fprintf('Step 1: Generating convergence plots (Figure S1)...\n');
fprintf('---------------------------------------------------------\n');

generate_convergence_plots(convergence_paths, n_generations);

fprintf('\n✓ Convergence plots complete\n\n');

%% ===== STEP 2: Generate Phenotypic Landscape (Figure 7)  + Tables S2, S3 & Identify Best Ideotypes =====
fprintf('Step 2: Generating phenotypic landscape (Figure 7)...\n');
fprintf('---------------------------------------------------------\n');

generate_phenotypic_landscape();
fprintf('\n✓ Phenotypic landscape complete\n\n');


%% ===== COMPLETION =====
fprintf('\n=========================================================================\n');
fprintf('  ANALYSIS COMPLETE\n');
fprintf('=========================================================================\n');
fprintf('  Files saved in RESULTS/:\n');
fprintf('    - GA_Results_4Environments.png/pdf/fig (Figure 7)\n');
fprintf('    - GA_Convergence_ENV[1-4].png/pdf/fig (Figure S1)\n');
fprintf('    - Table_S2_Correlation_Statistics.csv\n');
fprintf('    - Table_S3_Optimal_Coefficients.csv\n');
fprintf('    - Ideotype.xlsx (all data)\n');
fprintf('    - Ideotype_ALL.mat\n');
fprintf('=========================================================================\n');