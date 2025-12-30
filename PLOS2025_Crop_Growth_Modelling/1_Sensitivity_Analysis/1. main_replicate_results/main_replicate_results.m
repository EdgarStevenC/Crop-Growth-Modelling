%% ========================================================================
%  SENSITIVITY ANALYSIS - REPLICATE PAPER RESULTS
%  ========================================================================
%  
%  This script replicates the sensitivity analysis results presented in:
%  
%  Correa, E.S. (2025). "Decoding Living Systems: Reassessing Crop Model 
%  Frontiers via Biological Dynamics and Optimized Phenotype." PLOS ONE.
%  
%  DESCRIPTION:
%  ------------
%  Uses pre-computed Morris sensitivity analysis results (20 replications)
%  to generate Figure 6 and Table S1 from the manuscript. This approach
%  ensures exact reproducibility of published results.
%  
%  The Morris method quantifies parameter influence on model outputs by
%  computing elementary effects across randomized trajectories in the
%  11-dimensional parameter space of CERES-Rice genetic coefficients.
%  
%  OUTPUTS:
%  --------
%  - Figure 6: Taylor diagrams showing Relative Sensitivity Index (RSI)
%              for 6 output variables (Grain Yield, Biomass, Anthesis,
%              Maturity, Number of Grains, Number of Tillers)
%  - Console:  RSI statistics with 95% confidence intervals (Table S1)
%  - Files:    PNG, PDF, and FIG formats in RESULTS/ folder
%  
%  EXECUTION TIME: ~10 seconds
%  
%  REQUIREMENTS:
%  -------------
%  - MATLAB R2024b or later
%  - Pre-computed results: senT_rep1.mat ... senT_rep20.mat
%  - Functions: calculate_sensitivity_stats.m, visualize_sensitivity_taylor_all.m
%  
%  REFERENCE:
%  ----------
%  Morris, M.D. (1991). Factorial sampling plans for preliminary 
%  computational experiments. Technometrics, 33(2), 161-174.
%  
%  AUTHOR: Edgar S. Correa
%  DATE: December 2025
%  LICENSE: CC BY 4.0
%  REPOSITORY: https://github.com/EdgarStevenC/Crop-Growth-Modelling
%  ========================================================================

clc, clearvars, close all

%% ===== CONFIGURATION =====
n_replications = 20;  % Number of Morris replications (do not change for paper results)

%% ===== STEP 1: Calculate RSI Statistics =====
% Computes mean ± 95% CI for each parameter-output combination
% Results correspond to Table S1 in Supplementary Material

fprintf('=== SENSITIVITY ANALYSIS: Replicating Paper Results ===\n\n');
fprintf('Step 1: Calculating RSI statistics from %d replications...\n', n_replications);

calculate_sensitivity_stats(n_replications);

%% ===== STEP 2: Generate Taylor Diagrams =====
% Creates 6-panel figure (Figure 6 in manuscript)
% Each panel shows RSI for one output variable

fprintf('\nStep 2: Generating Taylor diagrams (Figure 6)...\n');

visualize_sensitivity_taylor_all(n_replications);

%% ===== COMPLETION =====
fprintf('\n=== ANALYSIS COMPLETE ===\n');
fprintf('Figure saved in RESULTS/ folder:\n');
fprintf('  - Sensitivity_All_6panels.png (300 dpi)\n');
fprintf('  - Sensitivity_All_6panels.pdf (vector)\n');
fprintf('  - Sensitivity_All_6panels.fig (MATLAB)\n');