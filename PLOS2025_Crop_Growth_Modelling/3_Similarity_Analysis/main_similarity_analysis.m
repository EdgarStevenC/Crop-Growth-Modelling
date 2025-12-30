%% ========================================================================
%  MAIN_Similarity.m - Similarity Analysis: Ideotypes vs Field-Validated Cultivars
%  ========================================================================
%  Code developed by Edgar S. CORREA
%  Repository: https://github.com/EdgarStevenC/Crop-Growth-Modelling
%  ========================================================================

clc, clearvars, close all

%% ========================================================================
%  1. LOAD DATA
%  ========================================================================

% Load optimized ideotypes
IDEOTYPES = readtable('Ideotype.xlsx');

% Load field-validated cultivars (21 cultivars from literature)
CULTIVARS = readtable('CULTIVARS.csv');

% Display summary
fprintf('Loaded %d ideotypes and %d field-validated cultivars\n', ...
    size(IDEOTYPES,1), size(CULTIVARS,1));

%% ========================================================================
%  2. EXTRACT GENETIC COEFFICIENTS
%  ========================================================================

% Parameters to compare
param_names = {'P1', 'P5', 'P2R', 'PHINT', 'P2O', 'G1', 'G2', 'G3'};

% Extract ideotype coefficients (one per environment)
ideotype_data = zeros(4, length(param_names));
for env = 1:4
    % Adjust this based on your Ideotype.xlsx structure
    idx = IDEOTYPES.Environment == env;
    best_idx = find(idx & IDEOTYPES.Fitness == max(IDEOTYPES.Fitness(idx)), 1);
    for p = 1:length(param_names)
        ideotype_data(env, p) = IDEOTYPES.(param_names{p})(best_idx);
    end
end

% Extract cultivar coefficients
cultivar_names = CULTIVARS.CULTIVAR;
cultivar_data = zeros(height(CULTIVARS), length(param_names));
for p = 1:length(param_names)
    if ismember(param_names{p}, CULTIVARS.Properties.VariableNames)
        cultivar_data(:, p) = CULTIVARS.(param_names{p});
    end
end

%% ========================================================================
%  3. CALCULATE SIMILARITY (Multiple Distance Metrics)
%  ========================================================================

% Normalize data for fair comparison
all_data = [ideotype_data; cultivar_data];
data_normalized = zscore(all_data);
ideotype_norm = data_normalized(1:4, :);
cultivar_norm = data_normalized(5:end, :);

% Calculate distances
distances = struct();
distances.Euclidean = pdist2(ideotype_norm, cultivar_norm, 'euclidean');
distances.Manhattan = pdist2(ideotype_norm, cultivar_norm, 'cityblock');
distances.Cosine = pdist2(ideotype_norm, cultivar_norm, 'cosine');

% Convert distance to similarity (0-100%)
similarity = struct();
for metric = fieldnames(distances)'
    m = metric{1};
    % Normalize: 0 = most different, 1 = identical
    max_dist = max(distances.(m)(:));
    similarity.(m) = (1 - distances.(m) / max_dist) * 100;
end

%% ========================================================================
%  4. FIND TOP MATCHES FOR EACH IDEOTYPE
%  ========================================================================

num_top = 5;  % Number of top matches to display
results = struct();

fprintf('\n');
fprintf('=========================================================================\n');
fprintf('  SIMILARITY ANALYSIS: IDEOTYPES vs FIELD-VALIDATED CULTIVARS\n');
fprintf('=========================================================================\n');

for env = 1:4
    fprintf('\n----- IDEOTYPE %d (Environment %d) -----\n', env, env);
    
    % Average similarity across metrics
    avg_similarity = mean([similarity.Euclidean(env,:); ...
                          similarity.Manhattan(env,:); ...
                          similarity.Cosine(env,:)], 1);
    
    % Sort by similarity
    [sorted_sim, sorted_idx] = sort(avg_similarity, 'descend');
    
    % Store results
    results(env).top_cultivars = cultivar_names(sorted_idx(1:num_top));
    results(env).top_similarity = sorted_sim(1:num_top);
    
    % Display
    fprintf('  %-20s %10s\n', 'Cultivar', 'Similarity');
    fprintf('  %s\n', repmat('-', 1, 32));
    for i = 1:num_top
        fprintf('  %-20s %9.1f%%\n', ...
            cultivar_names{sorted_idx(i)}, sorted_sim(i));
    end
end

%% ========================================================================
%  5. VISUALIZATION - SIMILARITY HEATMAP (cultivares resaltados)
%  ========================================================================

fig1 = figure('Position', [279 505 1200 289]);

% Average similarity matrix
avg_sim_matrix = mean(cat(3, similarity.Euclidean, ...
                            similarity.Manhattan, ...
                            similarity.Cosine), 3);

% Heatmap
imagesc(avg_sim_matrix);
colormap(turbo);
cb = colorbar;
cb.Label.String = 'Similarity (%)';
caxis([0 100]);

% Identificar top 5 cultivares más similares (global)
global_similarity = mean(avg_sim_matrix, 1);
[~, sorted_idx] = sort(global_similarity, 'descend');
top_cultivars = sorted_idx(1:5);

% Crear etiquetas con negrita para top cultivares
x_labels = cell(size(cultivar_names));
for i = 1:length(cultivar_names)
    if ismember(i, top_cultivars)
        x_labels{i} = ['\bf{' cultivar_names{i} '}'];
    else
        x_labels{i} = cultivar_names{i};
    end
end

% Labels
set(gca, 'XTick', 1:length(cultivar_names), 'XTickLabel', x_labels, 'TickLabelInterpreter', 'tex');
set(gca, 'YTick', 1:4, 'YTickLabel', {'Ideotype 1', 'Ideotype 2', 'Ideotype 3', 'Ideotype 4'});
xtickangle(45);
xlabel('Field-Validated Cultivars', 'FontSize', 11);
ylabel('Optimized Ideotypes', 'FontSize', 11);
title('Genetic Coefficient Similarity Between Optimized Ideotypes and Existing Cultivars', 'FontSize', 12);

% Add values on heatmap
for i = 1:4
    for j = 1:length(cultivar_names)
        if avg_sim_matrix(i,j) > 50
            text(j, i, sprintf('%.0f', avg_sim_matrix(i,j)), ...
                'HorizontalAlignment', 'center', 'FontSize', 7, 'Color', 'k');
        else
            text(j, i, sprintf('%.0f', avg_sim_matrix(i,j)), ...
                'HorizontalAlignment', 'center', 'FontSize', 7, 'Color', 'w');
        end
    end
end

% Resaltar columnas top con rectángulos
hold on;
for i = 1:length(top_cultivars)
    col = top_cultivars(i);
    rectangle('Position', [col-0.5, 0.5, 1, 4], ...
              'EdgeColor', [0.8 0.2 0.2], 'LineWidth', 2.5);
end
hold off;

% Añadir nota explicativa
annotation('textbox', [0.02, 0.02, 0.3, 0.05], ...
    'String', 'Red boxes: Top 5 most similar cultivars (global average)', ...
    'FontSize', 9, 'EdgeColor', 'none', 'FontAngle', 'italic');

% Export
exportgraphics(fig1, 'RESULTS/Similarity_Heatmap.png', 'Resolution', 300);
exportgraphics(fig1, 'RESULTS/Similarity_Heatmap.tiff', 'Resolution', 600);
exportgraphics(fig1, 'RESULTS/Similarity_Heatmap.pdf', 'ContentType', 'vector');
savefig(fig1, 'RESULTS/Similarity_Heatmap.fig');
fprintf('✓ Heatmap saved: PNG, TIFF, PDF, FIG\n');


%% ========================================================================
%  6. VISUALIZATION - TOP MATCHES PER IDEOTYPE (Nature Style)
%  ========================================================================

fig2 = figure('Position', [100 100 1400 380], 'ToolBar', 'none', 'Color', 'w');

% Colores según predominancia
color_4 = [0.5 0.0 0.5];    % Morado
color_3 = [0.0 0.6 0.5];    % Verde azulado
color_2 = [0.0 0.7 0.9];    % Cian
color_1 = [1 1 1];          % Blanco
color_freq = [0.6 0.8 1.0]; % Azul claro

% =========================================================================
% PRIMERO: Calcular qué cultivares aparecen en cada ideotipo
% =========================================================================
top_cultivars_per_env = cell(4, 1);

for env = 1:4
    avg_similarity = mean([similarity.Euclidean(env,:); ...
                          similarity.Manhattan(env,:); ...
                          similarity.Cosine(env,:)], 1);
    
    all_top_indices = [];
    for metric = fieldnames(distances)'
        m = metric{1};
        [~, sorted_idx] = sort(distances.(m)(env,:), 'ascend');
        all_top_indices = [all_top_indices, sorted_idx(1:3)];
    end
    
    unique_idx = unique(all_top_indices);
    local_freq = zeros(size(unique_idx));
    sim_scores = zeros(size(unique_idx));
    
    for i = 1:length(unique_idx)
        local_freq(i) = sum(all_top_indices == unique_idx(i));
        sim_scores(i) = avg_similarity(unique_idx(i));
    end
    
    sim_normalized = sim_scores / 100;
    [~, sort_idx] = sortrows([local_freq', sim_normalized'], [-1, -2]);
    
    num_show = min(5, length(sort_idx));
    show_idx = sort_idx(1:num_show);
    
    top_cultivars_per_env{env} = unique_idx(show_idx);
end

% =========================================================================
% SEGUNDO: Contar en cuántos ideotipos aparece cada cultivar
% =========================================================================
global_appearance = zeros(1, length(cultivar_names));

for env = 1:4
    for i = 1:length(top_cultivars_per_env{env})
        idx = top_cultivars_per_env{env}(i);
        global_appearance(idx) = global_appearance(idx) + 1;
    end
end

% =========================================================================
% TERCERO: Graficar
% =========================================================================
for env = 1:4
    subplot(1, 4, env);

    avg_similarity = mean([similarity.Euclidean(env,:); ...
                          similarity.Manhattan(env,:); ...
                          similarity.Cosine(env,:)], 1);

    all_top_indices = [];
    for metric = fieldnames(distances)'
        m = metric{1};
        [~, sorted_idx] = sort(distances.(m)(env,:), 'ascend');
        all_top_indices = [all_top_indices, sorted_idx(1:3)];
    end

    unique_idx = unique(all_top_indices);
    local_freq = zeros(size(unique_idx));
    sim_scores = zeros(size(unique_idx));

    for i = 1:length(unique_idx)
        local_freq(i) = sum(all_top_indices == unique_idx(i));
        sim_scores(i) = avg_similarity(unique_idx(i));
    end

    sim_normalized = sim_scores / 100;
    [~, sort_idx] = sortrows([local_freq', sim_normalized'], [-1, -2]);

    num_show = min(5, length(sort_idx));
    show_idx = sort_idx(1:num_show);
    
    % Etiquetas con negrita para ≥3 apariciones
    cultivar_labels = cell(num_show, 1);
    for i = 1:num_show
        cultivar_idx = unique_idx(show_idx(i));
        freq = global_appearance(cultivar_idx);
        if freq >= 3
            cultivar_labels{i} = ['\bf{' cultivar_names{cultivar_idx} '}'];
        else
            cultivar_labels{i} = cultivar_names{cultivar_idx};
        end
    end

    hold on;
    for i = 1:num_show
        idx_flip = num_show - i + 1;
        
        cultivar_idx = unique_idx(show_idx(i));
        freq = global_appearance(cultivar_idx);
        
        if freq >= 4
            sim_color = color_4;
        elseif freq == 3
            sim_color = color_3;
        elseif freq == 2
            sim_color = color_2;
        else
            sim_color = color_1;
        end

        % Frequency
        barh(idx_flip - 0.15, local_freq(show_idx(i)), 0.28, ...
            'FaceColor', color_freq, 'EdgeColor', [0.3 0.5 0.7], ...
            'LineStyle', '--', 'LineWidth', 0.6);
        
        % Similarity
        barh(idx_flip + 0.15, sim_normalized(show_idx(i)), 0.28, ...
            'FaceColor', sim_color, 'EdgeColor', [0.3 0.3 0.3], 'LineWidth', 0.5);
    end
    hold off;

    set(gca, 'YTick', 1:num_show, 'YTickLabel', flip(cultivar_labels), ...
        'TickLabelInterpreter', 'tex', 'FontSize', 8);
    xlabel('');
    title(sprintf('Ideotype %d', env), 'FontSize', 10, 'FontWeight', 'bold');
    
    % Grid más sutil
    grid on;
    set(gca, 'GridLineStyle', ':', 'GridAlpha', 0.3);
    set(gca, 'Box', 'off');

    % Porcentaje de similitud
    for i = 1:num_show
        idx_flip = num_show - i + 1;
        text(sim_normalized(show_idx(i)) + 0.04, idx_flip + 0.15, ...
            sprintf('%.1f%%', sim_scores(show_idx(i))), ...
            'FontSize', 7, 'FontWeight', 'bold', 'Color', [0.2 0.2 0.2]);
    end
end

% =========================================================================
% LEYENDA 
% =========================================================================

annotation('rectangle', [0.905, 0.15, 0.085, 0.78], ...
    'FaceColor', [0.98 0.98 0.98], 'EdgeColor', [0.7 0.7 0.7], ...
    'LineWidth', 0.5);

% --- Bar type ---
annotation('textbox', [0.91, 0.82, 0.08, 0.05], ...
    'String', '\bf{Bar type}', ...
    'FontSize', 8, 'EdgeColor', 'none', 'HorizontalAlignment', 'left');

annotation('line', [0.915, 0.94], [0.78, 0.78], ...
    'LineStyle', '--', 'LineWidth', 1, 'Color', [0.3 0.5 0.7]);
annotation('textbox', [0.943, 0.755, 0.045, 0.04], ...
    'String', 'Freq.', 'FontSize', 7, 'EdgeColor', 'none');

annotation('line', [0.915, 0.94], [0.72, 0.72], ...
    'LineStyle', '-', 'LineWidth', 1.2, 'Color', [0.3 0.3 0.3]);
annotation('textbox', [0.943, 0.695, 0.045, 0.04], ...
    'String', 'Sim.', 'FontSize', 7, 'EdgeColor', 'none');

% --- Separador ---
annotation('line', [0.912, 0.982], [0.66, 0.66], ...
    'LineStyle', '-', 'LineWidth', 0.3, 'Color', [0.7 0.7 0.7]);

% --- Predominance ---
annotation('textbox', [0.91, 0.58, 0.08, 0.05], ...
    'String', '\bf{Predominance}', ...
    'FontSize', 8, 'EdgeColor', 'none', 'HorizontalAlignment', 'left');

% Colorbar compacto
cbar_x = 0.918;
cbar_y = 0.22;
cbar_w = 0.015;
cbar_h = 0.32;
box_h = cbar_h / 4;

annotation('rectangle', [cbar_x, cbar_y + box_h*3, cbar_w, box_h], ...
    'FaceColor', color_4, 'EdgeColor', 'none');
annotation('rectangle', [cbar_x, cbar_y + box_h*2, cbar_w, box_h], ...
    'FaceColor', color_3, 'EdgeColor', 'none');
annotation('rectangle', [cbar_x, cbar_y + box_h*1, cbar_w, box_h], ...
    'FaceColor', color_2, 'EdgeColor', 'none');
annotation('rectangle', [cbar_x, cbar_y, cbar_w, box_h], ...
    'FaceColor', color_1, 'EdgeColor', [0.7 0.7 0.7], 'LineWidth', 0.3);

annotation('rectangle', [cbar_x, cbar_y, cbar_w, cbar_h], ...
    'FaceColor', 'none', 'EdgeColor', [0.4 0.4 0.4], 'LineWidth', 0.5);

label_x = cbar_x + cbar_w + 0.005;
annotation('textbox', [label_x, cbar_y + box_h*3.1, 0.025, 0.03], ...
    'String', '4', 'FontSize', 7, 'EdgeColor', 'none', 'FontWeight', 'bold');
annotation('textbox', [label_x, cbar_y + box_h*2.1, 0.025, 0.03], ...
    'String', '3', 'FontSize', 7, 'EdgeColor', 'none', 'FontWeight', 'bold');
annotation('textbox', [label_x, cbar_y + box_h*1.1, 0.025, 0.03], ...
    'String', '2', 'FontSize', 7, 'EdgeColor', 'none');
annotation('textbox', [label_x, cbar_y + box_h*0.1, 0.025, 0.03], ...
    'String', '1', 'FontSize', 7, 'EdgeColor', 'none');

annotation('textbox', [cbar_x - 0.005, cbar_y - 0.05, 0.045, 0.03], ...
    'String', '# ideotypes', 'FontSize', 6.5, 'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'FontAngle', 'italic', 'Color', [0.3 0.3 0.3]);

% Título general
sgtitle('Genetic Similarity: Optimized Ideotypes vs Field-Validated Cultivars', ...
    'FontSize', 11, 'FontWeight', 'bold');

% Export
exportgraphics(fig2, 'RESULTS/Similarity_TopMatches.png', 'Resolution', 300);
exportgraphics(fig2, 'RESULTS/Similarity_TopMatches.tiff', 'Resolution', 600);
exportgraphics(fig2, 'RESULTS/Similarity_TopMatches.pdf', 'ContentType', 'vector');
savefig(fig2, 'RESULTS/Similarity_TopMatches.fig');
fprintf('✓ Top matches saved: PNG, TIFF, PDF, FIG\n');



%% ========================================================================
%  7. VISUALIZATION - PCA 3D: Ideotypes vs Field-Validated Cultivars
%  ========================================================================

fig3 = figure('Position', [50 50 1000 800], 'ToolBar', 'none', 'Color', 'w');

% =========================================================================
% PREPARE DATA
% =========================================================================

param_names = {'P1', 'P5', 'P2R', 'PHINT', 'P2O', 'G1', 'G2', 'G3'};

cultivar_data = zeros(height(CULTIVARS), length(param_names));
for p = 1:length(param_names)
    if ismember(param_names{p}, CULTIVARS.Properties.VariableNames)
        cultivar_data(:, p) = CULTIVARS.(param_names{p});
    end
end

cultivar_names_short = CULTIVARS.CULTIVARN;
cultivar_names_full = CULTIVARS.CULTIVAR;
cultivar_groups = CULTIVARS.Genetical_group;

ideotype_data = zeros(4, length(param_names));
for env = 1:4
    idx = IDEOTYPES.Environment == env;
    best_idx = find(idx & IDEOTYPES.Fitness == max(IDEOTYPES.Fitness(idx)), 1);
    for p = 1:length(param_names)
        ideotype_data(env, p) = IDEOTYPES.(param_names{p})(best_idx);
    end
end

all_data = [cultivar_data; ideotype_data];
n_cultivars = height(CULTIVARS);
all_groups = [cultivar_groups; {'Ideotype'; 'Ideotype'; 'Ideotype'; 'Ideotype'}];

% =========================================================================
% PCA
% =========================================================================

data_normalized = zscore(all_data);
[coeff, score, latent] = pca(data_normalized);

explained = 100 * latent / sum(latent);
var_PC1 = explained(1);
var_PC2 = explained(2);
var_PC3 = explained(3);
total_var = var_PC1 + var_PC2 + var_PC3;

fprintf('\nPCA Variance Explained:\n');
fprintf('  PC1: %.1f%%\n', var_PC1);
fprintf('  PC2: %.1f%%\n', var_PC2);
fprintf('  PC3: %.1f%%\n', var_PC3);
fprintf('  Total (3 PCs): %.1f%%\n', total_var);

% =========================================================================
% COLORS
% =========================================================================

color_indica = [0.17 0.63 0.17];
color_japonica = [0.12 0.47 0.71];
color_hybrid = [0.89 0.47 0.20];
color_ideotype = [0.84 0.15 0.16];

% Star colors for each ideotype (dark colors)
star_colors = {
    [0.1 0.1 0.1],      % ID1: Black
    [0.4 0.2 0.1],     % ID2: Dark brown
    [0.1 0.45 0.2],     % ID3: Dark green
    [0.1 0.3 0.65]       % ID4: Dark blue 
};

size_cultivar = 150;
size_ideotype = 400;

ideotype_idx = (n_cultivars + 1):(n_cultivars + 4);
n_nearest = 4;

% =========================================================================
% CALCULATE NEAREST CULTIVARS TO EACH IDEOTYPE
% =========================================================================

all_nearest = cell(4, 1);

fprintf('\n=== Nearest cultivars per Ideotype (PCA distance) ===\n');

for ideo = 1:4
    ideo_pos = score(ideotype_idx(ideo), 1:3);
    
    pca_distances = zeros(n_cultivars, 1);  % <-- RENOMBRADO
    for i = 1:n_cultivars
        pca_distances(i) = norm(score(i, 1:3) - ideo_pos);  % <-- RENOMBRADO
    end
    
    [sorted_dist, sorted_idx] = sort(pca_distances, 'ascend');  % <-- RENOMBRADO
    top_idx = sorted_idx(1:n_nearest);
    all_nearest{ideo} = top_idx;
    
    fprintf('\nIdeotype %d:\n', ideo);
    for j = 1:n_nearest
        fprintf('  %d. %s (%s) - dist: %.2f\n', j, ...
            cultivar_names_full{top_idx(j)}, ...
            cultivar_names_short{top_idx(j)}, ...
            sorted_dist(j));
    end
end
fprintf('\n');

% =========================================================================
% PLOT: LINES FIRST (4 stars, one per ideotype)
% =========================================================================

hold on;

for ideo = 1:4
    ideo_pos = score(ideotype_idx(ideo), 1:3);
    top_idx = all_nearest{ideo};
    
    for j = 1:n_nearest
        cult_idx = top_idx(j);
        cult_pos = score(cult_idx, 1:3);
        
        plot3([ideo_pos(1), cult_pos(1)], ...
              [ideo_pos(2), cult_pos(2)], ...
              [ideo_pos(3), cult_pos(3)], ...
              ':', 'Color', star_colors{ideo}, 'LineWidth', 1);
    end
end

% =========================================================================
% PLOT: POINTS
% =========================================================================

legend_handles = [];
legend_names = {};
unique_groups = unique(all_groups);

for g = 1:length(unique_groups)
    group = unique_groups{g};
    idx = strcmp(all_groups, group);
    
    if contains(lower(group), 'indica')
        c = color_indica;
        sz = size_cultivar;
    elseif contains(lower(group), 'japonica')
        c = color_japonica;
        sz = size_cultivar;
    elseif contains(lower(group), 'ideotype')
        c = color_ideotype;
        sz = size_ideotype;
    else
        c = color_hybrid;
        sz = size_cultivar;
    end
    
    h = scatter3(score(idx,1), score(idx,2), score(idx,3), ...
        sz, c, 'filled', 'Marker', 'o', ...
        'MarkerEdgeColor', 'k', 'LineWidth', 1.5);
    
    legend_handles = [legend_handles, h];
    legend_names = [legend_names, {group}];
end

% =========================================================================
% LABELS
% =========================================================================

% Cultivar labels
for i = 1:n_cultivars
    text(score(i, 1) + 0.2, ...
         score(i, 2) + 0.2, ...
         score(i, 3) + 0.2, ...
         cultivar_names_short{i}, ...
         'FontSize', 10, 'FontWeight', 'bold', 'Color', [0.2 0.2 0.2]);
end

% Ideotype labels (below-left, with star color)
ideotype_labels = {'ID1', 'ID2', 'ID3', 'ID4'};
for i = 1:4
    text(score(ideotype_idx(i), 1) - 0.35, ...
         score(ideotype_idx(i), 2) - 0.35, ...
         score(ideotype_idx(i), 3) - 0.35, ...
         ideotype_labels{i}, ...
         'FontSize', 12, 'FontWeight', 'bold', 'Color', star_colors{i}, ...
         'HorizontalAlignment', 'right');
end

hold off;

% =========================================================================
% STYLE
% =========================================================================

xlabel(sprintf('PC1 (%.1f%%)', var_PC1), 'FontSize', 14, 'FontWeight', 'bold');
ylabel(sprintf('PC2 (%.1f%%)', var_PC2), 'FontSize', 14, 'FontWeight', 'bold');
zlabel(sprintf('PC3 (%.1f%%)', var_PC3), 'FontSize', 14, 'FontWeight', 'bold');

title({'Genetic Distance: Optimized Ideotypes vs Field-Validated Cultivars', ...
       sprintf('PCA (%.1f%% variance explained)', total_var)}, ...
       'FontSize', 14, 'FontWeight', 'bold');

lgd = legend(legend_handles, legend_names, 'Location', 'northeast');
lgd.Title.String = 'Genetic Group';
lgd.Title.FontWeight = 'bold';
lgd.FontSize = 11;

grid on;
set(gca, 'GridLineStyle', '-', 'GridAlpha', 0.3);
set(gca, 'FontSize', 11);
box on;

view(56.4, 29.6); 
axis tight;

ax = gca;
padding = 0.8;
ax.XLim = [min(score(:,1))-padding, max(score(:,1))+padding];
ax.YLim = [min(score(:,2))-padding, max(score(:,2))+padding];
ax.ZLim = [min(score(:,3))-padding, max(score(:,3))+padding];

% Annotation
annotation('textbox', [0.02, 0.02, 0.7, 0.04], ...
    'String', 'Lines connect each ideotype to its 4 nearest cultivars (Black: ID1, Blue: ID2, Green: ID3, Brown: ID4)', ...
    'FontSize', 9, 'EdgeColor', 'none', 'FontAngle', 'italic', ...
    'Color', [0.4 0.4 0.4]);

% =========================================================================
% EXPORT
% =========================================================================

exportgraphics(fig3, 'RESULTS/PCA_3D_Ideotypes_Cultivars.png', 'Resolution', 300);
exportgraphics(fig3, 'RESULTS/PCA_3D_Ideotypes_Cultivars.tiff', 'Resolution', 600);
exportgraphics(fig3, 'RESULTS/PCA_3D_Ideotypes_Cultivars.pdf', 'ContentType', 'vector');
savefig(fig3, 'RESULTS/PCA_3D_Ideotypes_Cultivars.fig');
fprintf('✓ PCA 3D saved: PNG, TIFF, PDF, FIG\n');

rotate3d on;



%% ========================================================================
%  8. EXPORT RESULTS TO CSV
%  ========================================================================

% Create summary table
summary_table = table();
for env = 1:4
    for i = 1:num_top
        row = table();
        row.Ideotype = env;
        row.Rank = i;
        row.Cultivar = results(env).top_cultivars(i);
        row.Similarity = results(env).top_similarity(i);
        summary_table = [summary_table; row];
    end
end

writetable(summary_table, 'RESULTS/Similarity_Results.csv');
fprintf('✓ Results exported: RESULTS/Similarity_Results.csv\n');

%% ========================================================================
%  9. GLOBAL BEST MATCHES
%  ========================================================================

fprintf('\n');
fprintf('=========================================================================\n');
fprintf('  GLOBAL BEST MATCHES (Average across all ideotypes)\n');
fprintf('=========================================================================\n');

global_similarity = mean(avg_sim_matrix, 1);
[sorted_global, sorted_idx] = sort(global_similarity, 'descend');

fprintf('\n  %-20s %10s\n', 'Cultivar', 'Avg Similarity');
fprintf('  %s\n', repmat('-', 1, 32));
for i = 1:10
    fprintf('  %-20s %9.1f%%\n', cultivar_names{sorted_idx(i)}, sorted_global(i));
end



%% ========================================================================
%  EXPORT FUNCTION - High Resolution for Publication
%  ========================================================================

function export_figure(fig, filename)
    % Export figure in multiple formats for publication
    %
    % Formats:
    %   - PNG: 300 dpi (web, presentations)
    %   - TIFF: 600 dpi (print, journals)
    %   - PDF: vector (scalable, editing)
    %   - FIG: MATLAB native (editable)
    
    % PNG - 300 dpi
    exportgraphics(fig, [filename '.png'], 'Resolution', 300);
    
    % TIFF - 600 dpi (high resolution for print)
    exportgraphics(fig, [filename '.tiff'], 'Resolution', 600);
    
    % PDF - vector format
    exportgraphics(fig, [filename '.pdf'], 'ContentType', 'vector');
    
    % FIG - MATLAB editable
    savefig(fig, [filename '.fig']);
    
    fprintf('✓ Figure saved: %s (.png, .tiff, .pdf, .fig)\n', filename);
end


%% ========================================================================
%  10. COMBINED FIGURE: Similarity Analysis (for publication)
%  ========================================================================

% Restore distances structure if overwritten
if ~isstruct(distances)
    distances = struct();
    distances.Euclidean = pdist2(ideotype_norm, cultivar_norm, 'euclidean');
    distances.Manhattan = pdist2(ideotype_norm, cultivar_norm, 'cityblock');
    distances.Cosine = pdist2(ideotype_norm, cultivar_norm, 'cosine');
end

fig_combined = figure('Position', [50 50 1800 550], 'ToolBar', 'none', 'Color', 'w');

% =========================================================================
% PANEL A: PCA 3D (left side)
% =========================================================================

ax1 = axes('Position', [0.02, 0.18, 0.32, 0.75]);

hold on;

% Plot distance lines first
for ideo = 1:4
    ideo_pos = score(ideotype_idx(ideo), 1:3);
    top_idx = all_nearest{ideo};
    
    for j = 1:n_nearest
        cult_idx = top_idx(j);
        cult_pos = score(cult_idx, 1:3);
        
        plot3([ideo_pos(1), cult_pos(1)], ...
              [ideo_pos(2), cult_pos(2)], ...
              [ideo_pos(3), cult_pos(3)], ...
              ':', 'Color', star_colors{ideo}, 'LineWidth', 1.5);
    end
end

% Plot points
legend_handles = [];
legend_names = {};

for g = 1:length(unique_groups)
    group = unique_groups{g};
    idx = strcmp(all_groups, group);
    
    if contains(lower(group), 'indica')
        c = color_indica; sz = size_cultivar * 0.9;
    elseif contains(lower(group), 'japonica')
        c = color_japonica; sz = size_cultivar * 0.9;
    elseif contains(lower(group), 'ideotype')
        c = color_ideotype; sz = size_ideotype * 0.9;
    else
        c = color_hybrid; sz = size_cultivar * 0.9;
    end
    
    h = scatter3(score(idx,1), score(idx,2), score(idx,3), ...
        sz, c, 'filled', 'Marker', 'o', ...
        'MarkerEdgeColor', 'k', 'LineWidth', 1);
    
    legend_handles = [legend_handles, h];
    legend_names = [legend_names, {group}];
end

% Cultivar labels - LARGER
for i = 1:n_cultivars
    text(score(i, 1) + 0.12, score(i, 2) + 0.12, score(i, 3) + 0.12, ...
         cultivar_names_short{i}, 'FontSize', 12, 'FontWeight', 'bold', 'Color', [0.2 0.2 0.2]);
end

% Ideotype labels - RED color, LARGER
color_ideo_label = [0.8 0.1 0.1];
for i = 1:4
    text(score(ideotype_idx(i), 1) - 0.2, ...
         score(ideotype_idx(i), 2) - 0.2, ...
         score(ideotype_idx(i), 3) - 0.2, ...
         ideotype_labels{i}, ...
         'FontSize', 14, 'FontWeight', 'bold', 'Color', color_ideo_label, ...
         'HorizontalAlignment', 'right');
end
hold off;

xlabel(sprintf('PC1 (%.1f%%)', var_PC1), 'FontSize', 14, 'FontWeight', 'bold');
ylabel(sprintf('PC2 (%.1f%%)', var_PC2), 'FontSize', 14, 'FontWeight', 'bold');
zlabel(sprintf('PC3 (%.1f%%)', var_PC3), 'FontSize', 14, 'FontWeight', 'bold');
title(sprintf('PCA - Genetic Distance (%.1f%% var.)', total_var), ...
      'FontSize', 16, 'FontWeight', 'bold');

lgd = legend(legend_handles, legend_names, 'Location', 'northeast');
lgd.Title.String = 'Group';
lgd.Title.FontWeight = 'bold';
lgd.FontSize = 12;

grid on;
set(gca, 'GridLineStyle', '-', 'GridAlpha', 0.3, 'FontSize', 12);
box on;
view(56.4, 29.6);

% Zoom: reduce padding to fill 3D space
axis tight;
ax = gca;
padding = 0.3;
ax.XLim = [min(score(:,1))-padding, max(score(:,1))+padding];
ax.YLim = [min(score(:,2))-padding, max(score(:,2))+padding];
ax.ZLim = [min(score(:,3))-padding, max(score(:,3))+padding];

% Note below 3D plot - LARGER
annotation('textbox', [0.02, 0.02, 0.32, 0.05], ...
    'String', 'Dotted lines: distance to 4 nearest cultivars per ideotype', ...
    'FontSize', 11, 'EdgeColor', 'none', 'FontAngle', 'italic', ...
    'Color', [0.4 0.4 0.4], 'HorizontalAlignment', 'center');

% =========================================================================
% LABEL (a) - Global for PCA - LARGER
% =========================================================================

annotation('textbox', [0.01, 0.92, 0.05, 0.05], ...
    'String', '(a)', 'FontSize', 20, 'FontWeight', 'bold', ...
    'EdgeColor', 'none', 'VerticalAlignment', 'top');

% =========================================================================
% PANELS B: Top Matches (4 subplots in row)
% =========================================================================

panel_width = 0.13;
panel_height = 0.70;
start_x = 0.38;
gap = 0.025;

positions = {
    [start_x + 0*(panel_width + gap), 0.18, panel_width, panel_height],
    [start_x + 1*(panel_width + gap), 0.18, panel_width, panel_height],
    [start_x + 2*(panel_width + gap), 0.18, panel_width, panel_height],
    [start_x + 3*(panel_width + gap), 0.18, panel_width, panel_height]
};

% LABEL (b) - Global for Top Matches - LARGER
annotation('textbox', [0.36, 0.92, 0.05, 0.05], ...
    'String', '(b)', 'FontSize', 20, 'FontWeight', 'bold', ...
    'EdgeColor', 'none', 'VerticalAlignment', 'top');

% Frequency bar colors: sky blue with transparency and white stripes
color_freq_base = [0.6 0.75 0.95];
color_freq_lines = [1 1 1];

for env = 1:4
    ax = axes('Position', positions{env});
    
    avg_similarity_env = mean([similarity.Euclidean(env,:); ...
                               similarity.Manhattan(env,:); ...
                               similarity.Cosine(env,:)], 1);

    all_top_indices = [];
    for metric = fieldnames(distances)'
        m = metric{1};
        [~, sorted_idx] = sort(distances.(m)(env,:), 'ascend');
        all_top_indices = [all_top_indices, sorted_idx(1:3)];
    end

    unique_idx = unique(all_top_indices);
    local_freq = zeros(size(unique_idx));
    sim_scores = zeros(size(unique_idx));

    for i = 1:length(unique_idx)
        local_freq(i) = sum(all_top_indices == unique_idx(i));
        sim_scores(i) = avg_similarity_env(unique_idx(i));
    end

    sim_normalized = sim_scores / 100;
    [~, sort_idx] = sortrows([local_freq', sim_normalized'], [-1, -2]);

    num_show = min(5, length(sort_idx));
    show_idx = sort_idx(1:num_show);
    
    % Labels with bold for >=3 appearances
    cultivar_labels_env = cell(num_show, 1);
    for i = 1:num_show
        cultivar_idx = unique_idx(show_idx(i));
        freq = global_appearance(cultivar_idx);
        if freq >= 3
            cultivar_labels_env{i} = ['\bf{' cultivar_names{cultivar_idx} '}'];
        else
            cultivar_labels_env{i} = cultivar_names{cultivar_idx};
        end
    end

    hold on;
    for i = 1:num_show
        idx_flip = num_show - i + 1;
        cultivar_idx = unique_idx(show_idx(i));
        freq = global_appearance(cultivar_idx);
        
        if freq >= 4
            sim_color = color_4;
        elseif freq == 3
            sim_color = color_3;
        elseif freq == 2
            sim_color = color_2;
        else
            sim_color = color_1;
        end

        % Frequency: sky blue transparent bar with white stripes
        freq_val = local_freq(show_idx(i));
        bar_y = idx_flip - 0.15;
        bar_height = 0.28;
        
        % Sky blue transparent base bar
        b = barh(bar_y, freq_val, bar_height, ...
            'FaceColor', color_freq_base, 'EdgeColor', [0.3 0.5 0.7], ...
            'LineWidth', 0.8);
        b.FaceAlpha = 0.5;
        
        % Add white diagonal stripes
        for k = 0.1:0.15:freq_val
            plot([k, k+0.08], [bar_y - bar_height/2 + 0.02, bar_y + bar_height/2 - 0.02], ...
                '-', 'Color', color_freq_lines, 'LineWidth', 0.8);
        end
        
        % Similarity: solid bar
        barh(idx_flip + 0.15, sim_normalized(show_idx(i)), 0.28, ...
            'FaceColor', sim_color, 'EdgeColor', [0.3 0.3 0.3], 'LineWidth', 0.5);
    end
    hold off;

    % YTick aligned with similarity bar - LARGER FONT
    set(gca, 'YTick', (1:num_show) + 0.15, 'YTickLabel', flip(cultivar_labels_env), ...
        'TickLabelInterpreter', 'tex', 'FontSize', 12);
    
    title(sprintf('Ideotype %d', env), 'FontSize', 14, 'FontWeight', 'bold');
    
    grid on;
    set(gca, 'GridLineStyle', ':', 'GridAlpha', 0.3, 'Box', 'off');
    xlim([0 1.5]);

    % Similarity percentage - LARGER
    for i = 1:num_show
        idx_flip = num_show - i + 1;
        text(sim_normalized(show_idx(i)) + 0.08, idx_flip + 0.15, ...
            sprintf('%.0f%%', sim_scores(show_idx(i))), ...
            'FontSize', 11, 'FontWeight', 'bold', 'Color', [0.2 0.2 0.2]);
    end
end

% =========================================================================
% HORIZONTAL LEGEND (below the 4 panels) - LARGER FONTS
% =========================================================================

legend_y = 0.03;

% Bar type label
annotation('textbox', [0.40, legend_y, 0.06, 0.04], ...
    'String', '\bf{Bar type:}', 'FontSize', 12, 'EdgeColor', 'none', ...
    'VerticalAlignment', 'middle');

% Frequency with sky blue transparency and white stripes
annotation('rectangle', [0.46, legend_y + 0.003, 0.035, 0.03], ...
    'FaceColor', color_freq_base, 'FaceAlpha', 0.5, 'EdgeColor', [0.3 0.5 0.7], 'LineWidth', 0.8);
% White diagonal lines in legend
annotation('line', [0.465, 0.478], [legend_y + 0.006, legend_y + 0.030], ...
    'Color', [1 1 1], 'LineWidth', 1);
annotation('line', [0.478, 0.491], [legend_y + 0.006, legend_y + 0.030], ...
    'Color', [1 1 1], 'LineWidth', 1);
annotation('textbox', [0.495, legend_y, 0.07, 0.04], ...
    'String', 'Frequency', 'FontSize', 11, 'EdgeColor', 'none', ...
    'VerticalAlignment', 'middle');

% Similarity (white with border)
annotation('rectangle', [0.56, legend_y + 0.003, 0.035, 0.03], ...
    'FaceColor', [1 1 1], 'EdgeColor', [0.3 0.3 0.3], 'LineWidth', 0.8);
annotation('textbox', [0.595, legend_y, 0.09, 0.04], ...
    'String', 'Similarity (%)', 'FontSize', 11, 'EdgeColor', 'none', ...
    'VerticalAlignment', 'middle');

% Vertical separator
annotation('line', [0.68, 0.68], [legend_y, legend_y + 0.04], ...
    'LineStyle', '-', 'LineWidth', 0.5, 'Color', [0.7 0.7 0.7]);

% Predominance label
annotation('textbox', [0.69, legend_y, 0.09, 0.04], ...
    'String', '\bf{Predominance:}', 'FontSize', 12, 'EdgeColor', 'none', ...
    'VerticalAlignment', 'middle');

% Color boxes horizontal - LARGER
box_w = 0.018;
box_h = 0.028;
box_y = legend_y + 0.004;

annotation('rectangle', [0.78, box_y, box_w, box_h], ...
    'FaceColor', color_4, 'EdgeColor', 'k', 'LineWidth', 0.5);
annotation('textbox', [0.798, legend_y, 0.025, 0.04], ...
    'String', '4', 'FontSize', 11, 'EdgeColor', 'none', ...
    'VerticalAlignment', 'middle', 'FontWeight', 'bold');

annotation('rectangle', [0.82, box_y, box_w, box_h], ...
    'FaceColor', color_3, 'EdgeColor', 'k', 'LineWidth', 0.5);
annotation('textbox', [0.838, legend_y, 0.025, 0.04], ...
    'String', '3', 'FontSize', 11, 'EdgeColor', 'none', ...
    'VerticalAlignment', 'middle', 'FontWeight', 'bold');

annotation('rectangle', [0.86, box_y, box_w, box_h], ...
    'FaceColor', color_2, 'EdgeColor', 'k', 'LineWidth', 0.5);
annotation('textbox', [0.878, legend_y, 0.025, 0.04], ...
    'String', '2', 'FontSize', 11, 'EdgeColor', 'none', ...
    'VerticalAlignment', 'middle');

annotation('rectangle', [0.90, box_y, box_w, box_h], ...
    'FaceColor', color_1, 'EdgeColor', 'k', 'LineWidth', 0.5);
annotation('textbox', [0.918, legend_y, 0.025, 0.04], ...
    'String', '1', 'FontSize', 11, 'EdgeColor', 'none', ...
    'VerticalAlignment', 'middle');

annotation('textbox', [0.94, legend_y, 0.06, 0.04], ...
    'String', '(# ideotypes)', 'FontSize', 11, 'EdgeColor', 'none', ...
    'VerticalAlignment', 'middle', 'FontAngle', 'italic', 'Color', [0.4 0.4 0.4]);

% =========================================================================
% EXPORT
% =========================================================================

exportgraphics(fig_combined, 'RESULTS/Fig_Combined_Similarity.png', 'Resolution', 300);
exportgraphics(fig_combined, 'RESULTS/Fig_Combined_Similarity.tiff', 'Resolution', 600);
exportgraphics(fig_combined, 'RESULTS/Fig_Combined_Similarity.pdf', 'ContentType', 'vector');
savefig(fig_combined, 'RESULTS/Fig_Combined_Similarity.fig');
fprintf('✓ Combined figure saved: PNG, TIFF, PDF, FIG\n');