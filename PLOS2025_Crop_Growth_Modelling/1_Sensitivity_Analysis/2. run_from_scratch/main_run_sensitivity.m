%% ========================================================================
%  SENSITIVITY ANALYSIS - EXECUTE FROM SCRATCH
%  ========================================================================
%  
%  This script executes the complete Morris sensitivity analysis from scratch,
%  running CERES-Rice simulations for all parameter perturbations.
%  
%  WARNING: This script requires several hours to complete and depends on
%  DSSAT/CERES-Rice installation. For replicating paper results, use
%  main_replicate_results.m instead.
%  
%  DESCRIPTION:
%  ------------
%  Implements the Morris method for global sensitivity analysis of 
%  CERES-Rice genetic coefficients. The analysis:
%  
%  1. Defines parameter bounds for 11 genetic coefficients (Figure 4b)
%  2. Generates randomized trajectories through parameter space
%  3. Executes CERES-Rice for each point in the trajectory
%  4. Computes elementary effects and Relative Sensitivity Index (RSI)
%  5. Repeats for 20 replications to ensure robust rankings
%  
%  MORRIS DESIGN PARAMETERS:
%  -------------------------
%  - k = 11 (number of genetic coefficients)
%  - p = 4  (number of levels per parameter)
%  - r = 20 (number of trajectories/replications)
%  - Total evaluations: r × (k + 1) = 20 × 12 = 240 per replication
%  
%  GENETIC COEFFICIENTS ANALYZED:
%  ------------------------------
%  Phenological:  P1 (150-800 GDD), P2O (11-13 h), P2R (5-300 GDD), P5 (150-850 GDD)
%  Reproductive:  G1 (50-75), G2 (0.015-0.030 g), G3 (0.7-1.3), PHINT (55-90 GDD)
%  Thermal:       THOT (25-34°C), TCLDP (12-18°C), TCLDF (10-20°C)
%  
%  OUTPUTS:
%  --------
%  - senT_rep1.mat ... senT_rep20.mat: Elementary effects per replication
%  - GYsim_rep*_i*.mat: Raw CERES-Rice simulation outputs
%  
%  EXECUTION TIME: ~4-8 hours (depends on hardware)
%  
%  REQUIREMENTS:
%  -------------
%  - MATLAB R2024b or later
%  - DSSAT v4.8 with CERES-Rice module installed and configured
%  - Function: sensitivity.m, MECHANISTIC.m (DSSAT interface)
%  
%  NOTE: Results will vary slightly from published values due to the
%  stochastic nature of Morris sampling (randomized parameter sequences).
%  The 20-replication design ensures that parameter rankings remain stable.
%  
%  AUTHOR: Edgar S. Correa
%  DATE: December 2025
%  LICENSE: CC BY 4.0
%  REPOSITORY: https://github.com/EdgarStevenC/Crop-Growth-Modelling
%  ========================================================================

clc, clearvars, close all

%% ===== CONFIGURATION =====
n_replications = 20;  % Number of Morris replications
N = 4;                % Resolution (number of levels per parameter)
RANDp = 1;            % Random permutation enabled (1 = yes, 0 = no)

%% ===== EXECUTION =====
fprintf('=== MORRIS SENSITIVITY ANALYSIS ===\n');
fprintf('Configuration:\n');
fprintf('  - Parameters (k): 11\n');
fprintf('  - Levels (p): %d\n', N+1);
fprintf('  - Replications (r): %d\n', n_replications);
fprintf('  - Model evaluations per replication: %d\n', (N)*(11+1));
fprintf('  - Total model evaluations: %d\n', n_replications*(N)*(11+1));
fprintf('\nWARNING: This will take several hours to complete.\n');
fprintf('Press Ctrl+C to cancel, or any key to continue...\n');
pause;

%% ===== RUN SENSITIVITY ANALYSIS =====
fprintf('\n=== Starting Morris Sensitivity Analysis ===\n\n');

for rep = 1:n_replications
    fprintf('Running replication %d/%d...\n', rep, n_replications);
    tic;
    
    % Execute Morris trajectory for this replication
    % Each call runs (N) × 12 CERES-Rice simulations
    sensitivity(N, RANDp, rep);
    
    elapsed = toc;
    fprintf('  Completed in %.1f minutes\n', elapsed/60);
    close all;  % Close any figures generated during simulation
end

%% ===== POST-PROCESSING =====
fprintf('\n=== Calculating Statistics ===\n');
calculate_sensitivity_stats(n_replications);

fprintf('\n=== Generating Visualizations ===\n');
visualize_sensitivity_taylor_all(n_replications);

%% ===== COMPLETION =====
fprintf('\n=== ANALYSIS COMPLETE ===\n');
fprintf('Results saved:\n');
fprintf('  - senT_rep1.mat ... senT_rep%d.mat (elementary effects)\n', n_replications);
fprintf('  - sensitivity_stats.mat (summary statistics)\n');
fprintf('  - RESULTS/Sensitivity_All_6panels.* (figures)\n');