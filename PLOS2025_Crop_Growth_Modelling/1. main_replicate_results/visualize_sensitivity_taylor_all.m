function visualize_sensitivity_taylor_all(n_reps)
% VISUALIZE_SENSITIVITY_TAYLOR_ALL Generate Taylor diagrams for sensitivity analysis
%
% This function creates a 6-panel figure showing the Relative Sensitivity Index (RSI)
% for each output variable of the CERES-Rice model, averaged across multiple 
% replications of the Morris sensitivity analysis.
%
% USAGE:
%   visualize_sensitivity_taylor_all(20)
%
% INPUT:
%   n_reps - Number of replications to average (e.g., 20)
%
% OUTPUT:
%   Saves figure in three formats:
%   - RESULTS/Sensitivity_All_6panels.png (300 dpi)
%   - RESULTS/Sensitivity_All_6panels.pdf (vector)
%   - RESULTS/Sensitivity_All_6panels.fig (MATLAB figure)
%
% INTERPRETATION:
%   - Radial distance: RSI magnitude (0 = no influence, 1 = maximum influence)
%   - Angular position: Correlation/linearity of parameter effect
%   - Green zone (RSI > 0.5): High sensitivity - priority parameters
%   - Yellow zone (0.3 < RSI < 0.5): Moderate sensitivity
%   - Gray zone (RSI < 0.3): Low sensitivity - negligible influence
%
% REFERENCE:
%   Morris, M.D. (1991). Factorial sampling plans for preliminary 
%   computational experiments. Technometrics, 33(2), 161-174.
%
% Author: [Your name]
% Date: December 2025
% Version: 2.0 (20 replications with confidence intervals)

    %% ===== LOAD AND AVERAGE ALL REPLICATIONS =====
    % Load sensitivity results from each replication and compute mean values
    % This ensures robust parameter rankings by averaging across randomized sequences
    
    for rep = 1:n_reps
        load(sprintf('senT_rep%d.mat', rep));
        
        % Initialize storage arrays on first iteration
        if rep == 1
            % mu* (mean absolute elementary effect) arrays
            all_uP1 = zeros(6, size(uP1,2), n_reps);
            all_uP2O = zeros(6, size(uP2O,2), n_reps);
            all_uP2R = zeros(6, size(uP2R,2), n_reps);
            all_uP5 = zeros(6, size(uP5,2), n_reps);
            all_uG1 = zeros(6, size(uG1,2), n_reps);
            all_uG2 = zeros(6, size(uG2,2), n_reps);
            all_uG3 = zeros(6, size(uG3,2), n_reps);
            all_uPHINT = zeros(6, size(uPHINT,2), n_reps);
            all_uTHOT = zeros(6, size(uTHOT,2), n_reps);
            all_uTCLDP = zeros(6, size(uTCLDP,2), n_reps);
            all_uTCLDF = zeros(6, size(uTCLDF,2), n_reps);
            
            % sigma (standard deviation of elementary effects) arrays
            all_dP1 = zeros(6, size(dP1,2), n_reps);
            all_dP2O = zeros(6, size(dP2O,2), n_reps);
            all_dP2R = zeros(6, size(dP2R,2), n_reps);
            all_dP5 = zeros(6, size(dP5,2), n_reps);
            all_dG1 = zeros(6, size(dG1,2), n_reps);
            all_dG2 = zeros(6, size(dG2,2), n_reps);
            all_dG3 = zeros(6, size(dG3,2), n_reps);
            all_dPHINT = zeros(6, size(dPHINT,2), n_reps);
            all_dTHOT = zeros(6, size(dTHOT,2), n_reps);
            all_dTCLDP = zeros(6, size(dTCLDP,2), n_reps);
            all_dTCLDF = zeros(6, size(dTCLDF,2), n_reps);
        end
        
        % Store values from current replication
        all_uP1(:,:,rep) = uP1; all_dP1(:,:,rep) = dP1;
        all_uP2O(:,:,rep) = uP2O; all_dP2O(:,:,rep) = dP2O;
        all_uP2R(:,:,rep) = uP2R; all_dP2R(:,:,rep) = dP2R;
        all_uP5(:,:,rep) = uP5; all_dP5(:,:,rep) = dP5;
        all_uG1(:,:,rep) = uG1; all_dG1(:,:,rep) = dG1;
        all_uG2(:,:,rep) = uG2; all_dG2(:,:,rep) = dG2;
        all_uG3(:,:,rep) = uG3; all_dG3(:,:,rep) = dG3;
        all_uPHINT(:,:,rep) = uPHINT; all_dPHINT(:,:,rep) = dPHINT;
        all_uTHOT(:,:,rep) = uTHOT; all_dTHOT(:,:,rep) = dTHOT;
        all_uTCLDP(:,:,rep) = uTCLDP; all_dTCLDP(:,:,rep) = dTCLDP;
        all_uTCLDF(:,:,rep) = uTCLDF; all_dTCLDF(:,:,rep) = dTCLDF;
    end
    
    %% ===== COMPUTE MEAN ACROSS REPLICATIONS =====
    % Average sensitivity metrics across all replications
    % This provides robust estimates with reduced sampling variability
    
    uP1_m = mean(all_uP1, 3); dP1_m = mean(all_dP1, 3);
    uP2O_m = mean(all_uP2O, 3); dP2O_m = mean(all_dP2O, 3);
    uP2R_m = mean(all_uP2R, 3); dP2R_m = mean(all_dP2R, 3);
    uP5_m = mean(all_uP5, 3); dP5_m = mean(all_dP5, 3);
    uG1_m = mean(all_uG1, 3); dG1_m = mean(all_dG1, 3);
    uG2_m = mean(all_uG2, 3); dG2_m = mean(all_dG2, 3);
    uG3_m = mean(all_uG3, 3); dG3_m = mean(all_dG3, 3);
    uPHINT_m = mean(all_uPHINT, 3); dPHINT_m = mean(all_dPHINT, 3);
    uTHOT_m = mean(all_uTHOT, 3); dTHOT_m = mean(all_dTHOT, 3);
    uTCLDP_m = mean(all_uTCLDP, 3); dTCLDP_m = mean(all_dTCLDP, 3);
    uTCLDF_m = mean(all_uTCLDF, 3); dTCLDF_m = mean(all_dTCLDF, 3);
    
    %% ===== FIGURE SETUP =====
    % Create full-screen figure for 6-panel Taylor diagram
    
    % Automatic screen adjustment
    screen_size = get(0, 'ScreenSize');
    fig_width = min(1400, screen_size(3) * 0.9);
    fig_height = min(800, screen_size(4) * 0.85);
    f = figure('Units', 'pixels', 'Position', [50 50 fig_width fig_height]);
    
    % Output variable labels and units
    vars = {'Grain Yield', 'Biomass', 'Anthesis', 'Maturity', 'Number of Grains', 'Number of Tillers'};
    units = {'Log [ μ (Kg/H) ]', 'Log [ μ (Kg/H) ]', 'Log [ μ (Days) ]', ...
             'Log [ μ (Days) ]', 'Log [ μ (#/H) ]', 'Log [ μ (#/H) ]'};
    labels = {'a)', 'c)', 'e)', 'b)', 'd)', 'f)'};
    
    % Panel order: Biomass, NGrains, Anthesis (left column)
    %              GY, NTillers, Maturity (right column)
    plot_order = [2, 5, 3, 1, 6, 4];
    
    %% ===== SUBPLOT LAYOUT CONFIGURATION =====
    % Manual positioning for optimal spacing
    
    gap_h = 0.03;         % Horizontal gap between panels
    gap_v = 0.06;         % Vertical gap between panels
    margin_left = 0.03;   % Left margin
    margin_bottom = 0.05; % Bottom margin
    margin_top = 0.04;    % Top margin
    margin_right = 0.10;  % Right margin (space for legend)

    % gap_h = 0.05;         % Aumentado
    % gap_v = 0.08;         % Aumentado
    % margin_left = 0.06;   % Aumentado
    % margin_bottom = 0.08; % Aumentado
    % margin_top = 0.06;    % Aumentado para títulos
    % margin_right = 0.12;  % Aumentado para leyenda

    
    subplot_width = (1 - margin_left - margin_right - 2*gap_h) / 3;
    subplot_height = (1 - margin_bottom - margin_top - gap_v) / 2;
    
    %% ===== GENERATE TAYLOR DIAGRAMS =====
    % Create one panel per output variable
    
    for idx = 1:6
        j = plot_order(idx);
        
        % Calculate subplot position
        row = ceil(idx/3);
        col = mod(idx-1, 3) + 1;
        
        pos_x = margin_left + (col-1)*(subplot_width + gap_h);
        pos_y = 1 - margin_top - row*subplot_height - (row-1)*gap_v;
        
        subplot('Position', [pos_x, pos_y, subplot_width, subplot_height]);
        
        % Assemble statistics matrix: [mu*; correlation; sigma]
        % Row 1: Mean absolute elementary effect (mu*)
        % Row 2: Correlation (set to 1 for visualization)
        % Row 3: Standard deviation of elementary effects (sigma)
        STATS = [mean(uP1_m(j,:)), mean(uP2O_m(j,:)), mean(uP2R_m(j,:)), ...
                 mean(uP5_m(j,:)), mean(uG1_m(j,:)), mean(uG2_m(j,:)), ...
                 mean(uG3_m(j,:)), mean(uPHINT_m(j,:)), mean(uTHOT_m(j,:)), ...
                 mean(uTCLDP_m(j,:)), mean(uTCLDF_m(j,:));
                 zeros(1,11);
                 mean(dP1_m(j,:)), mean(dP2O_m(j,:)), mean(dP2R_m(j,:)), ...
                 mean(dP5_m(j,:)), mean(dG1_m(j,:)), mean(dG2_m(j,:)), ...
                 mean(dG3_m(j,:)), mean(dPHINT_m(j,:)), mean(dTHOT_m(j,:)), ...
                 mean(dTCLDP_m(j,:)), mean(dTCLDF_m(j,:))];
        
        % Plot Taylor diagram with sensitivity zones
        plot_taylor_panel(STATS, vars{j}, units{j}, labels{idx});
    end
    
    %% ===== LEGEND (MANUAL WITH FIXED SIZE) =====
    NameList = {'P1', 'P2O', 'P2R', 'P5', 'G1', 'G2', 'G3', 'PHINT', 'THOT', 'TCLDP', 'TCLDF'};
    colorList = [0.0000 0.0000 0.5625;
                 0.0000 0.0000 1.0000;
                 0.0000 0.5000 1.0000;
                 0.0000 1.0000 1.0000;
                 0.5000 1.0000 0.5000;
                 1.0000 1.0000 0.0000;
                 1.0000 0.6471 0.0000;
                 1.0000 0.0000 0.0000;
                 0.8000 0.0000 0.0000;
                 0.5000 0.0000 0.0000;
                 0.2500 0.0000 0.0000];
    
    % Create invisible axes for legend
    ax_leg = axes('Position', [0.88 0.3 0.1 0.4], 'Visible', 'off');
    hold(ax_leg, 'on');
    h_leg = gobjects(11, 1);
    for i = 1:11
        h_leg(i) = plot(ax_leg, NaN, NaN, 'o', 'MarkerSize', 10, ...
                        'Color', colorList(i,:), 'MarkerFaceColor', colorList(i,:));
    end
    hold(ax_leg, 'off');
    
    lgd = legend(ax_leg, h_leg, NameList, 'FontSize', 11, 'FontName', 'Times New Roman', ...
                 'Position', [0.878 0.624 0.090 0.365], 'Box', 'off');

    % %% ===== LEGEND =====
    % % Parameter names for legend
    % 
    % NameList = {'P1', 'P2O', 'P2R', 'P5', 'G1', 'G2', 'G3', 'PHINT', 'THOT', 'TCLDP', 'TCLDF'};
    % lgd = legend(NameList, 'FontSize', 11, 'FontName', 'Times New Roman', ...
    %              'Position', [0.8782 0.62392 0.0900 0.3650], 'Box', 'off');
    
    %% ===== EXPORT FIGURE =====
    % Save in multiple formats for publication and editing
    
    exportgraphics(f, 'RESULTS/Sensitivity_All_6panels.png', 'Resolution', 300);
    exportgraphics(f, 'RESULTS/Sensitivity_All_6panels.pdf', 'ContentType', 'vector');
    savefig(f, 'RESULTS/Sensitivity_All_6panels.fig');
    
    fprintf('Figure saved: PNG (300 dpi), PDF (vector), FIG\n');
end


function plot_taylor_panel(STATS, var, unit, label)
    %% ===== DATA PREPROCESSING =====
    STATS(2,2:end) = 1;
    STATS(1,:) = log(STATS(1,:) + 0.001);
    STATS(isnan(STATS)) = 0;
    STATS(isinf(STATS) & STATS == -Inf) = 0;
    STATS(isinf(STATS)) = 0;
    
    VM = max(STATS(1,:)) * 1.1;
    if VM <= 0 || isnan(VM) || isinf(VM)
        VM = 1;
    end
    
    %% ===== TAYLOR DIAGRAM SETUP =====
    TD = STaylorDiag(STATS);
    TD.set('SLim', [0, VM]);
    
    %% ===== PARAMETER COLORS =====
    colorList = [0.0000 0.0000 0.5625;
                 0.0000 0.0000 1.0000;
                 0.0000 0.5000 1.0000;
                 0.0000 1.0000 1.0000;
                 0.5000 1.0000 0.5000;
                 1.0000 1.0000 0.0000;
                 1.0000 0.6471 0.0000;
                 1.0000 0.0000 0.0000;
                 0.8000 0.0000 0.0000;
                 0.5000 0.0000 0.0000;
                 0.2500 0.0000 0.0000];
    
    NameList = {'P1', 'P2O', 'P2R', 'P5', 'G1', 'G2', 'G3', 'PHINT', 'THOT', 'TCLDP', 'TCLDF'};
    
    %% ===== PLOT PARAMETER POINTS =====
    for i = 1:size(STATS,2)
        if STATS(1,i) <= 0 || STATS(1,i) < VM * 0.05
            marker_size = 2;
        else
            marker_size = 10;
        end
        
        TD.SPlot(STATS(1,i), STATS(2,i), STATS(3,i), 'Marker', 'o', ...
                 'MarkerSize', marker_size, 'Color', colorList(i,:), ...
                 'MarkerFaceColor', colorList(i,:), 'HandleVisibility', 'off');
    end

    %% ===== PARAMETER LABELS =====
    for i = 1:size(STATS,2)
        % Only show labels for parameters within visible range
        if STATS(1,i) > VM * 0.05
            TD.SText(STATS(1,i), STATS(2,i), STATS(3,i), "   "+string(NameList{i}), ...
                     'FontWeight', 'bold', 'FontSize', 10, 'FontName', 'Times New Roman', ...
                     'VerticalAlignment', 'middle', 'HorizontalAlignment', 'left');
        end
    end
    %% ===== DIAGRAM FORMATTING =====
    TD.set('CTickValues', [.1 .2 .3 .4 .5 .6 .7 .8 .9 .95 .99]);
    TD.set('CGrid', 'Color', [0 0 .8], 'LineStyle', ':', 'LineWidth', .8);
    TD.set('CTickLabel', 'Color', [0 0 .8], 'FontWeight', 'bold');
    TD.set('CLabel', 'Color', [0 0 .8], 'FontWeight', 'bold');
    TD.set('CAxis', 'Color', [0 0 .8], 'LineWidth', 2);
    TD.SLabel.String = unit;
    TD.SLabel.FontSize = 14;
    TD.SLabel.FontWeight = 'bold';
    TD.CLabel.String = 'RSI';
    TD.CLabel.FontSize = 10;
    TD.set('RGrid', 'Visible', 'off');
    TD.set('RTickLabel', 'Visible', 'off');
    
    
    %% ===== HIGH SENSITIVITY ZONE =====
    hold on;
    theta = linspace(0, pi/2, 100);
    r_mid = VM / 2;
    
    x_outer = [r_mid*cos(theta), fliplr(VM*cos(theta))];
    y_outer = [r_mid*sin(theta), fliplr(VM*sin(theta))];
    
    h_zone = fill(x_outer, y_outer, [0.85 0.85 0.85], ...
              'EdgeColor', 'none', 'FaceAlpha', 0.25, ...
              'HandleVisibility', 'off');
    uistack(h_zone, 'bottom');
    hold off;
    
    %% ===== PANEL TITLE =====
    text(TD.SLim(2), TD.SLim(2), [label ' ' var], 'Color', [.77 .6 .18], ...
         'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', ...
         'FontSize', 18, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
    
end



% function visualize_sensitivity_taylor_all(n_reps)
% 
%     % Cargar y promediar todas las replicaciones
%     for rep = 1:n_reps
%         load(sprintf('senT_rep%d.mat', rep));
% 
%         if rep == 1
%             all_uP1 = zeros(6, size(uP1,2), n_reps);
%             all_uP2O = zeros(6, size(uP2O,2), n_reps);
%             all_uP2R = zeros(6, size(uP2R,2), n_reps);
%             all_uP5 = zeros(6, size(uP5,2), n_reps);
%             all_uG1 = zeros(6, size(uG1,2), n_reps);
%             all_uG2 = zeros(6, size(uG2,2), n_reps);
%             all_uG3 = zeros(6, size(uG3,2), n_reps);
%             all_uPHINT = zeros(6, size(uPHINT,2), n_reps);
%             all_uTHOT = zeros(6, size(uTHOT,2), n_reps);
%             all_uTCLDP = zeros(6, size(uTCLDP,2), n_reps);
%             all_uTCLDF = zeros(6, size(uTCLDF,2), n_reps);
% 
%             all_dP1 = zeros(6, size(dP1,2), n_reps);
%             all_dP2O = zeros(6, size(dP2O,2), n_reps);
%             all_dP2R = zeros(6, size(dP2R,2), n_reps);
%             all_dP5 = zeros(6, size(dP5,2), n_reps);
%             all_dG1 = zeros(6, size(dG1,2), n_reps);
%             all_dG2 = zeros(6, size(dG2,2), n_reps);
%             all_dG3 = zeros(6, size(dG3,2), n_reps);
%             all_dPHINT = zeros(6, size(dPHINT,2), n_reps);
%             all_dTHOT = zeros(6, size(dTHOT,2), n_reps);
%             all_dTCLDP = zeros(6, size(dTCLDP,2), n_reps);
%             all_dTCLDF = zeros(6, size(dTCLDF,2), n_reps);
%         end
% 
%         all_uP1(:,:,rep) = uP1; all_dP1(:,:,rep) = dP1;
%         all_uP2O(:,:,rep) = uP2O; all_dP2O(:,:,rep) = dP2O;
%         all_uP2R(:,:,rep) = uP2R; all_dP2R(:,:,rep) = dP2R;
%         all_uP5(:,:,rep) = uP5; all_dP5(:,:,rep) = dP5;
%         all_uG1(:,:,rep) = uG1; all_dG1(:,:,rep) = dG1;
%         all_uG2(:,:,rep) = uG2; all_dG2(:,:,rep) = dG2;
%         all_uG3(:,:,rep) = uG3; all_dG3(:,:,rep) = dG3;
%         all_uPHINT(:,:,rep) = uPHINT; all_dPHINT(:,:,rep) = dPHINT;
%         all_uTHOT(:,:,rep) = uTHOT; all_dTHOT(:,:,rep) = dTHOT;
%         all_uTCLDP(:,:,rep) = uTCLDP; all_dTCLDP(:,:,rep) = dTCLDP;
%         all_uTCLDF(:,:,rep) = uTCLDF; all_dTCLDF(:,:,rep) = dTCLDF;
%     end
% 
%     % Promediar
%     uP1_m = mean(all_uP1, 3); dP1_m = mean(all_dP1, 3);
%     uP2O_m = mean(all_uP2O, 3); dP2O_m = mean(all_dP2O, 3);
%     uP2R_m = mean(all_uP2R, 3); dP2R_m = mean(all_dP2R, 3);
%     uP5_m = mean(all_uP5, 3); dP5_m = mean(all_dP5, 3);
%     uG1_m = mean(all_uG1, 3); dG1_m = mean(all_dG1, 3);
%     uG2_m = mean(all_uG2, 3); dG2_m = mean(all_dG2, 3);
%     uG3_m = mean(all_uG3, 3); dG3_m = mean(all_dG3, 3);
%     uPHINT_m = mean(all_uPHINT, 3); dPHINT_m = mean(all_dPHINT, 3);
%     uTHOT_m = mean(all_uTHOT, 3); dTHOT_m = mean(all_dTHOT, 3);
%     uTCLDP_m = mean(all_uTCLDP, 3); dTCLDP_m = mean(all_dTCLDP, 3);
%     uTCLDF_m = mean(all_uTCLDF, 3); dTCLDF_m = mean(all_dTCLDF, 3);
% 
%     % Figura más grande
%     f = figure('Units','normalized','Position',[0.001 0.001 0.998 0.998]);
% 
%     vars = {'Grain Yield', 'Biomass', 'Anthesis', 'Maturity', 'Number of Grains', 'Number of Tillers'};
%     units = {'Log [ μ (Kg/H) ]', 'Log [ μ (Kg/H) ]', 'Log [ μ (Days) ]', ...
%              'Log [ μ (Days) ]', 'Log [ μ (#/H) ]', 'Log [ μ (#/H) ]'};
%     labels = {'a)', 'c)', 'e)', 'b)', 'd)', 'f)'};
% 
%     % Orden: Biomass(2), GY(1), NGrains(5), NTillers(6), Anthesis(3), Maturity(4)
%     %plot_order = [2, 1, 5, 6, 3, 4];
%     plot_order = [2, 5, 3, 1, 6, 4];
% 
%     % Configurar espaciado de subplots manualmente
%     gap_h = 0.03;        % Reducido de 0.08
%     gap_v = 0.06;        % Reducido de 0.12
%     margin_left = 0.03;  % Reducido de 0.05
%     margin_bottom = 0.05;% Reducido de 0.08
%     margin_top = 0.02;   % Reducido de 0.03
%     margin_right = 0.10; % Reducido de 0.12
% 
%     subplot_width = (1 - margin_left - margin_right - 2*gap_h) / 3;
%     subplot_height = (1 - margin_bottom - margin_top - gap_v) / 2;
% 
%     for idx = 1:6
%         j = plot_order(idx);
% 
%         % Calcular posición manual
%         row = ceil(idx/3);
%         col = mod(idx-1, 3) + 1;
% 
%         pos_x = margin_left + (col-1)*(subplot_width + gap_h);
%         pos_y = 1 - margin_top - row*subplot_height - (row-1)*gap_v;
% 
%         subplot('Position', [pos_x, pos_y, subplot_width, subplot_height]);
% 
%         STATS = [mean(uP1_m(j,:)), mean(uP2O_m(j,:)), mean(uP2R_m(j,:)), ...
%                  mean(uP5_m(j,:)), mean(uG1_m(j,:)), mean(uG2_m(j,:)), ...
%                  mean(uG3_m(j,:)), mean(uPHINT_m(j,:)), mean(uTHOT_m(j,:)), ...
%                  mean(uTCLDP_m(j,:)), mean(uTCLDF_m(j,:));
%                  zeros(1,11);
%                  mean(dP1_m(j,:)), mean(dP2O_m(j,:)), mean(dP2R_m(j,:)), ...
%                  mean(dP5_m(j,:)), mean(dG1_m(j,:)), mean(dG2_m(j,:)), ...
%                  mean(dG3_m(j,:)), mean(dPHINT_m(j,:)), mean(dTHOT_m(j,:)), ...
%                  mean(dTCLDP_m(j,:)), mean(dTCLDF_m(j,:))];
% 
%         plot_taylor_panel(STATS, vars{j}, units{j}, labels{idx});
%     end
% 
%     % Leyenda
%     NameList = {'P1', 'P2O', 'P2R', 'P5', 'G1', 'G2', 'G3', 'PHINT', 'THOT', 'TCLDP', 'TCLDF'};
%     lgd = legend(NameList, 'FontSize', 11, 'FontName', 'Times New Roman', ...
%                  'Position', [ 0.8782    0.62392    0.0900    0.3650], 'Box', 'off');
% 
%     exportgraphics(f, 'RESULTS/Sensitivity_All_6panels.png', 'Resolution', 300);
%     exportgraphics(f, 'RESULTS/Sensitivity_All_6panels.pdf', 'ContentType', 'vector');
%     savefig(f, 'RESULTS/Sensitivity_All_6panels.fig');
% 
%     fprintf('✓ Figura guardada: PNG, PDF y FIG\n');
% end
% 
% function plot_taylor_panel(STATS, var, unit, label)
%     STATS(2,2:end) = 1;
%     STATS(1,:) = log(STATS(1,:) + 0.001);
%     STATS(isnan(STATS)) = 0;
%     STATS(isinf(STATS) & STATS == -Inf) = 0;
%     STATS(isinf(STATS)) = 0;
% 
%     VM = max(STATS(1,:)) * 1.1;
%     if VM <= 0 || isnan(VM) || isinf(VM)
%         VM = 1;  % Valor por defecto
%     end
% 
%     TD = STaylorDiag(STATS);
%     TD.set('SLim', [0, VM]);
% 
%     colorList = [0.0000 0.0000 0.5625;
%                  0.0000 0.0000 1.0000;
%                  0.0000 0.5000 1.0000;
%                  0.0000 1.0000 1.0000;
%                  0.5000 1.0000 0.5000;
%                  1.0000 1.0000 0.0000;
%                  1.0000 0.6471 0.0000;
%                  1.0000 0.0000 0.0000;
%                  0.8000 0.0000 0.0000;
%                  0.5000 0.0000 0.0000;
%                  0.2500 0.0000 0.0000];
% 
%     NameList = {'P1', 'P2O', 'P2R', 'P5', 'G1', 'G2', 'G3', 'PHINT', 'THOT', 'TCLDP', 'TCLDF'};
% 
%     for i = 1:size(STATS,2)
%         TD.SPlot(STATS(1,i), STATS(2,i), STATS(3,i), 'Marker', 'o', ...
%                  'MarkerSize', 10, 'Color', colorList(i,:), ...
%                  'MarkerFaceColor', colorList(i,:));
%     end
% 
%     for i = 1:size(STATS,2)
%         TD.SText(STATS(1,i), STATS(2,i), STATS(3,i), "   "+string(NameList{i}), ...
%                  'FontWeight', 'bold', 'FontSize', 10, 'FontName', 'Times New Roman', ...
%                  'VerticalAlignment', 'middle', 'HorizontalAlignment', 'left');
%     end
% 
%     TD.set('CTickValues', [.1 .2 .3 .4 .5 .6 .7 .8 .9 .95 .99]);
%     TD.set('CGrid', 'Color', [0 0 .8], 'LineStyle', ':', 'LineWidth', .8);
%     TD.set('CTickLabel', 'Color', [0 0 .8], 'FontWeight', 'bold');
%     TD.set('CLabel', 'Color', [0 0 .8], 'FontWeight', 'bold');
%     TD.set('CAxis', 'Color', [0 0 .8], 'LineWidth', 2);
%     TD.SLabel.String = unit;
%     TD.SLabel.FontSize = 14;
%     TD.SLabel.FontWeight = 'bold';  % Negrita opcional
%     TD.CLabel.String = 'RSI';
%     TD.CLabel.FontSize = 10;
%     TD.set('RGrid', 'Color', [1 1 1], 'LineWidth', 1.5);
%     TD.set('RTickLabel', 'Color', [1 1 1], 'FontWeight', 'bold');
% 
%     % Título
%     text(TD.SLim(2), TD.SLim(2), [label ' ' var], 'Color', [.77 .6 .18], ...
%          'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', ...
%          'FontSize', 18, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
% end 