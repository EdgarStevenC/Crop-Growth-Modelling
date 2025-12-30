function calculate_sensitivity_stats(n_reps)
    
    params = {'P1', 'P2O', 'P2R', 'P5', 'G1', 'G2', 'G3', 'PHINT', 'THOT', 'TCLDP', 'TCLDF'};
    outputs = {'GY', 'Biomass', 'Anthesis', 'Maturity', 'NGrains', 'NTillers'};
    
    % Cargar datos de cada replicación
    for rep = 1:n_reps
        load(sprintf('senT_rep%d.mat', rep));
        
        for out = 1:6
            RSI_data(out, :, rep) = [mean(dP1(out,:)), mean(dP2O(out,:)), mean(dP2R(out,:)), ...
                                     mean(dP5(out,:)), mean(dG1(out,:)), mean(dG2(out,:)), ...
                                     mean(dG3(out,:)), mean(dPHINT(out,:)), mean(dTHOT(out,:)), ...
                                     mean(dTCLDP(out,:)), mean(dTCLDF(out,:))];
        end
    end
    
    % Calcular estadísticas
    for out = 1:6
        fprintf('\n=== %s ===\n', outputs{out});
        for p = 1:length(params)
            data = squeeze(RSI_data(out, p, :));
            mean_val = mean(data);
            std_val = std(data);
            ci95 = 1.96 * std_val / sqrt(n_reps);
            fprintf('%s: %.3f ± %.3f (95%% CI: [%.3f, %.3f])\n', ...
                    params{p}, mean_val, ci95, mean_val-ci95, mean_val+ci95);
        end
    end
    
    save('sensitivity_stats.mat', 'RSI_data', 'params', 'outputs');
end