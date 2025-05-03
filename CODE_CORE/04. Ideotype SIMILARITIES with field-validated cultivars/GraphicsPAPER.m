function [] = GraphicsPAPER(POPULATION, FIT, ENV)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NN = 10; 

%% YIELD
GY = POPULATION.phenotype.Grain_Yield;
BSS = POPULATION.phenotype.Biomass;
HI = POPULATION.phenotype.HI;
WUE = POPULATION.phenotype.WUE;

% Calculate the Pearson correlation coefficient
rGY = corr(FIT(:), GY(:)); % 'Type', 'Spearman'
rHI = corr(FIT(:), HI(:)); % 'Type', 'Spearman'
rWUE = corr(FIT(:), WUE(:)); % 'Type', 'Spearman'

F1 = figure; 
yyaxis left; 

h1 = plot(FIT, GY, 'b.', 'MarkerSize', 6); 
ylabel('Grain Yield (Kg/Ha)', 'FontSize', NN, 'FontWeight', 'bold'); % Bold y-axis label
hold on
h2 = plot(FIT, BSS, 'c.', 'MarkerSize', 6); 
axis([0.25 1.4 -1000 12000]);

% Linear regressions
plot(FIT, polyval(polyfit(FIT, GY, 1), FIT), 'b-', 'LineWidth', 1.5);
plot(FIT, polyval(polyfit(FIT, BSS, 1), FIT), 'Color', [0, 200/255, 200/255], 'LineWidth', 1.5);

yyaxis right;
ax = gca;
ax.YAxis(2).Color = [0, 0, 0];
h3 = plot(FIT, HI, 'k.', 'MarkerSize', 6); 
ylabel('HI', 'FontSize', NN, 'FontWeight', 'bold'); % Bold y-axis label
axis([0.25 1.4 0 0.8]);
plot(FIT, polyval(polyfit(FIT, HI, 1), FIT), 'k-', 'LineWidth', 1.5);

xlabel('HI-WUE', 'FontSize', NN, 'FontWeight', 'bold'); % Bold x-axis label

% Legend with bigger markers
hold on
h1_leg = plot(nan, nan, 'b.', 'MarkerSize', 15);
h2_leg = plot(nan, nan, 'c.', 'MarkerSize', 15);
h3_leg = plot(nan, nan, 'k.', 'MarkerSize', 15);
lgd = legend([h1_leg, h2_leg, h3_leg], {'Grain Yield', 'Biomass', 'HI'});
lgd.Position = [0.6799 0.1691 0.2066 0.2169];

F1.Position = [1016 632 399 217];
grid on;
ax.YAxis(1).Exponent = 3;
ax.YAxis(2).Exponent = 0;

exportgraphics(gcf, strcat('Results/Regressor/Yield', num2str(ENV), '.png'), 'Resolution', 300);
savefig(strcat('Results/Regressor/Yield', num2str(ENV), '.fig'));


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PHENOTYPE GN & LAID
NG = POPULATION.phenotype.Grain_Number;
Leaf_Area_Index = POPULATION.phenotype.Leaf_Area_Index;

F1 = figure; 
yyaxis left;
h1 = plot(FIT, NG, 'b.', 'MarkerSize', 6); 
ylabel('Grain Number (#/m²)', 'FontSize', NN, 'FontWeight', 'bold'); % Bold y-axis label
hold on
plot(FIT(NG > 500), polyval(polyfit(FIT(NG > 500), NG(NG > 500), 1), FIT(NG > 500)), 'b-', 'LineWidth', 1.5);

yyaxis right;
h2 = plot(FIT, Leaf_Area_Index, 'c.', 'MarkerSize', 6); 
ylabel('Leaf Area Index (m²/m²)', 'FontSize', NN, 'FontWeight', 'bold'); % Bold y-axis label
ax = gca;
ax.YAxis(2).Color = [0, 139/255, 139/255];
plot(FIT, polyval(polyfit(FIT, Leaf_Area_Index, 1), FIT), 'Color', [0, 200/255, 200/255], 'LineWidth', 1.5);

axis([0.25 1.4 3000 25000]);
yyaxis right;
axis([0.25 1.4 0 6]);

xlabel('HI-WUE', 'FontSize', NN, 'FontWeight', 'bold'); % Bold x-axis label

% Legend
hold on
h1_leg = plot(nan, nan, 'b.', 'MarkerSize', 15);
h2_leg = plot(nan, nan, 'c.', 'MarkerSize', 15);
lgd = legend([h1_leg, h2_leg], {'Grain Number', 'Leaf Area Index'});
lgd.Position = [0.6570 0.1875 0.2458 0.2169];

F1.Position = [1016 632 399 217];
grid on;

exportgraphics(gcf, strcat('Results/Regressor/GN_LAID', num2str(ENV), '.png'), 'Resolution', 300);
savefig(strcat('Results/Regressor/GN_LAID', num2str(ENV), '.fig'));


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ROOTS & WUE
Root_Density = POPULATION.phenotype.Root_Density;
WUE = POPULATION.phenotype.WUE;

F1 = figure; 
yyaxis left;
h1 = plot(FIT, WUE, 'b.', 'MarkerSize', 6);
ylabel('WUE (Kg/mm)', 'FontSize', NN, 'FontWeight', 'bold'); % Bold y-axis label
hold on
plot(FIT, polyval(polyfit(FIT, WUE, 1), FIT), 'b-', 'LineWidth', 1.5);
axis([0.25 1.4 0 8]);

yyaxis right;
h2 = plot(FIT, Root_Density, 'c.', 'MarkerSize', 6);
ylabel('Root Density (cm/cm³)', 'FontSize', NN, 'FontWeight', 'bold'); % Bold y-axis label
ax = gca;
ax.YAxis(2).Color = [0, 139/255, 139/255];
plot(FIT, polyval(polyfit(FIT, Root_Density, 1), FIT), 'Color', [0, 200/255, 200/255], 'LineWidth', 1.5);
axis([0.25 1.4 0.5 3]);

xlabel('HI-WUE', 'FontSize', NN, 'FontWeight', 'bold'); % Bold x-axis label

% Legend
hold on
h1_leg = plot(nan, nan, 'b.', 'MarkerSize', 15);
h2_leg = plot(nan, nan, 'c.', 'MarkerSize', 15);
lgd = legend([h1_leg, h2_leg], {'WUE', 'Root Density'});
lgd.Position = [0.6687 0.2029 0.2091 0.2169];

F1.Position = [1016 632 399 217];
grid on;

exportgraphics(gcf, strcat('Results/Regressor/ROOT_WUE', num2str(ENV), '.png'), 'Resolution', 300);
savefig(strcat('Results/Regressor/ROOT_WUE', num2str(ENV), '.fig'));


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PHENOLOGY
Cycle = POPULATION.phenotype.Cycle;
Anthesis = POPULATION.phenotype.Anthesis;

F1 = figure;
h1 = plot(FIT, Anthesis, 'b.', 'MarkerSize', 6);
hold on
plot(FIT, polyval(polyfit(FIT, Anthesis, 1), FIT), 'b-', 'LineWidth', 1.5);

h2 = plot(FIT, Cycle, 'c.', 'MarkerSize', 6);
ylabel('Time after sowing (Days)', 'FontSize', NN, 'FontWeight', 'bold'); % Bold y-axis label
plot(FIT, polyval(polyfit(FIT, Cycle, 1), FIT), '--', 'Color', [0, 200/255, 200/255], 'LineWidth', 1.5);

axis([0.25 1.4 40 140]);

xlabel('HI-WUE', 'FontSize', NN, 'FontWeight', 'bold'); % Bold x-axis label

% Legend
hold on
h1_leg = plot(nan, nan, 'b.', 'MarkerSize', 15);
h2_leg = plot(nan, nan, 'c.', 'MarkerSize', 15);
lgd = legend([h1_leg, h2_leg], {'Anthesis', 'Maturity'});
lgd.Position = [0.6966 0.1875 0.2066 0.2169];

F1.Position = [1016 632 399 217];
grid on;

exportgraphics(gcf, strcat('Results/Regressor/Phenology', num2str(ENV), '.png'), 'Resolution', 300);
savefig(strcat('Results/Regressor/Phenology', num2str(ENV), '.fig'));


end