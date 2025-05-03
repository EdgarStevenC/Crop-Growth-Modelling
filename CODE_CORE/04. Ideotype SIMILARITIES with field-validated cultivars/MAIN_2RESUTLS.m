%  Code developed by Edgar S. CORREA for the doctoral thesis and academic paper 
%  "AI-Driven Insights for Crop Growth Modelling: Advancing Rainfed Rice Yield Prediction with
%  Machine Learning and Satellite Data in Senegal." 
%  Copyright © 2025 Edgar S. CORREA. This work is licensed under a Creative Commons 
%  Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0).
%% 27/02/2025
clc, clearvars, close all
%% Def variables
POPULATION = [];
%% Data prep - Extraction
% ENVIRONMENT 1-2-3-4 could be ID"381-423-125-343"
ENV = 343;
for i = 1 : 20
    load( strcat('IND_P',num2str(ENV),'/POPULATION/',num2str(i), 'Pop.mat')  ); % one per environment "26 / 60 / 73 / 108"

    if isfield(Pop, 'range'), Pop = rmfield(Pop, 'range'); end
    POPULATION = [POPULATION; Pop];
end
% SORT
POPULATION = struct2table(POPULATION);
[Fit idx] = sort(POPULATION.fitness);
POPULATION = POPULATION(idx,:);
% Phenotype
numPhenotypes = size(POPULATION,1);
Phenotype = [];
for i = 1:numPhenotypes
    Phenotype = [Phenotype; mean(POPULATION.phenotype{i})];
end
POPULATION.phenotype = Phenotype;
% Genotype
data = POPULATION.gentype; 
Genotype = table(data(:,1), data(:,2), data(:,3), data(:,4), data(:,5), data(:,6), data(:,7), data(:,8), ...
          'VariableNames', {'P1', 'P5', 'P2R', 'PHINT', 'P2O', 'G1', 'G2', 'G3'});
POPULATION.gentype = Genotype



%% Visualization
FIT = POPULATION.fitness;  % Agronomic Efficiency Index (HI-WUE)

%%
%F1 = figure,  yyaxis left,  plot( Anthesis, Cycle,  'b.'),  xlabel('Anthesis (d)'), ylabel('Cycle (d)')
% M = table2array(struct2table(POPULATION));
%% ********************************************************************************************************************
%% ********************************************************************************************************************
%% ********************************************************************************************************************
%% GRAPHICS
GraphicsPAPER(POPULATION, FIT,  ENV)

%% INDEPENDIENTE NO FUNCIONA
%  'VariableNames', {'P1', 'P5', 'P2R', 'PHINT', 'P2O', 'G1', 'G2', 'G3'});
M = [FIT  table2array(POPULATION.gentype)];
corrMatrix = corr(M);
disp(corrMatrix);


% figure, plot(M(:,2), M(:,1), '.'), title('P1')
% figure, plot(M(:,3), M(:,1), '.'), title('P5')
% figure, plot(M(:,4), M(:,1), '.'), title('P2R')
% figure, plot(M(:,5), M(:,1), '.'), title('PHINT')
% figure, plot(M(:,6), M(:,1), '.'), title('P20')
% figure, plot(M(:,7), M(:,1), '.'), title('G1')
% figure, plot(M(:,8), M(:,1), '.'), title('G2')
% figure, plot(M(:,9), M(:,1), '.'), title('G3')

%% Regresión Lineal Múltiple: Para ver cómo diferentes genes afectan la variable dependiente (por ejemplo, la altura de la planta, la producción de biomasa).
% Supongamos que Y es el comportamiento fenotípico (como el rendimiento) y X es la matriz de datos genéticos
Y = FIT;
X = table2array(POPULATION.gentype);
mdl = fitlm(X, Y);  % fitlm crea un modelo de regresión lineal
disp(mdl);