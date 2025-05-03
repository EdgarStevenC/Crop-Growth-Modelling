%  Code developed by Edgar S. CORREA for the doctoral thesis and academic paper 
%  "AI-Driven Insights for Crop Growth Modelling: Advancing Rainfed Rice Yield Prediction with
%  Machine Learning and Satellite Data in Senegal." 
%  Copyright © 2025 Edgar S. CORREA. This work is licensed under a Creative Commons 
%  Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0).
%% 27/02/2025
clc, clearvars, close all

%% Data prep - Extraction - ENV1  381 [-13.2049, 13.1858] 
POPULATION1 = POPULATION_READ(381);
POPULATION1.Environment = repmat([1],size(POPULATION1,1),1);
idx = (POPULATION1.fitness == max(POPULATION1.fitness));
GENbest1 = mean(POPULATION1(idx,:))
P = splitvars(POPULATION1);
r_2 = corr(P.fitness, P.Cycle, 'Type', 'Spearman')%) ;  % , 'Type', 'Spearman')%
Visual_Ind2(GENbest1)  % {'P1', 'P5', 'P2R', 'PHINT', 'P2O', 'G1', 'G2', 'G3'};

%% Data prep - Extraction - 2  423 [-12.8661, 14.1175]
POPULATION2 = POPULATION_READ(423);
POPULATION2.Environment = repmat([2],size(POPULATION2,1),1);
idx = (POPULATION2.fitness == max(POPULATION2.fitness));
GENbest2 = mean(POPULATION2(idx,:))
P = splitvars(POPULATION2);
r_1 = corr(P.fitness, P.Cycle, 'Type', 'Spearman')%)
Visual_Ind2(GENbest2)  % {'P1', 'P5', 'P2R', 'PHINT', 'P2O', 'G1', 'G2', 'G3'};

%% Data prep - Extraction - 3  125 [-14.3907, 13.1858]
POPULATION3 = POPULATION_READ(125);
POPULATION3.Environment = repmat([3],size(POPULATION3,1),1);
idx = (POPULATION3.fitness == max(POPULATION3.fitness));
GENbest3 = mean(POPULATION3(idx,:))
P = splitvars(POPULATION3);
r_3 = corr(P.fitness, P.Cycle, 'Type', 'Spearman')%)  % , 'Type', 'Spearman'
Visual_Ind2(GENbest3)  % {'P1', 'P5', 'P2R', 'PHINT', 'P2O', 'G1', 'G2', 'G3'};

%% Data prep - Extraction - 4  343 [-13.5437, 13.7787]
POPULATION4 = POPULATION_READ(343);
POPULATION4.Environment = repmat([4],size(POPULATION4,1),1);
idx = (POPULATION4.fitness == max(POPULATION4.fitness));
GENbest4 = mean(POPULATION4(idx,:))
P = splitvars(POPULATION4);
r_4 = corr(P.fitness, P.Cycle, 'Type', 'Spearman')%)
Visual_Ind2(GENbest4)  % {'P1', 'P5', 'P2R', 'PHINT', 'P2O', 'G1', 'G2', 'G3'};

 mean([r_1, r_2, r_3, r_4 ])

%%
POPULATION = [POPULATION1; POPULATION2; POPULATION3; POPULATION4];

POPULATION  = splitvars(POPULATION);
writetable(POPULATION, 'IdeotypeARTICLE.xlsx');

 mean([r_1, r_2, r_3, r_4 ])
%% ***********************************************************************************************************************************
%% ***********************************************************************************************************************************
%% ***********************************************************************************************************************************
%% ***********************************************************************************************************************************
%% Data ALL cultivars - LITERATURE
cultivars = {'NERICA1', 'NERICA4', 'NERICA8', 'NERICA11', 'WABC165', 'NERICA14', 'NERICA12', 'NERICA9', 'NERICA17', 'FKR45N', 'NERICA6', 'DJ11', 'IRAT10', 'ITA150', 'WAB56-50', 'DKAP2', 'DKAP3', 'DKAP17', 'WAB189', 'WAB181', 'RD 23'};

P1 = [393.1, 329.7, 322.6, 290.0, 417.4, 253.9, 292.4, 19.7, 378.4, 316.9, 417.6, 388.3, 352.9, 413.4, 376.5, 379.4, 417.4, 127.8, 350.0, 402.3, 310.3];
P5 = [350.8, 364.6, 281.8, 523.8, 350.8, 296.8, 325.8, 11.7, 337.8, 367.8, 327.6, 358.8, 335.0, 319.2, 355.5, 263.8, 345.2, 12.7, 371.6, 357.8, 370.0];
P2R = [18.9, 133.5, 44.2, 99.3, 17.7, 115.5, 44.5, 324.3, 140.7, 44.6, 18.8, 88.1, 49.5, 13.7, 116.0, 44.9, 19.9, 339.5, 55.6, 20.7, 140.0];
PHINT = [83	83	83	83	83	83	83	28.7 83	83	83	83	83	83	83	83	83	25.2 83	83	83];
P2O = [8.9, 12.1, 12.7, 12.6, 11.3, 12.5, 9.5, 180.1, 12.7, 11.7, 10.0, 12.4, 9.2, 12.7, 12.7, 11.9, 10.2, 38.3, 11.3, 10.5, 11.2];
G1 = [59.4, 247.1, 285.0, 540.8, 59.4, 480.2, 65.0, 0.0, 212.5, 114.3, 70.5, 97.8, 48.2, 50.6, 75.0, 62.9, 48.6, 0.0, 47.7, 70.7, 53.0];
G2 = [0.0425, 0.063, 0.0256, 0.048, 0.029, 0.021, 0.040, 0.0225, 0.026, 0.027, 0.0376, 0.042, 0.027, 0.0355, 0.0246, 0.0276, 0.0326, 0.029, 0.028, 0.0815, 0.0230]*100;
G3 = [1.00, 1.20, 1.15, 1.01, 0.33, 0.48, 1.13, 1.00, 0.92, 0.23, 0.99, 1.02, 1.97, 0.72, 0.57, 0.71, 0.64, 1.07, 0.73, 2.26, 0.30];

%%
% Crear la figura con dos ejes Y
f1 = figure;

% Graficar la primera serie de barras (P1, P5, P2R, PHINT, P2O, G1) en el eje izquierdo
yyaxis right;
h1 = bar([P1; P5; P2R; PHINT; P2O; G1]', 'grouped');
set(gca, 'XTickLabel', cultivars, 'XTick', 1:length(cultivars));
xtickangle(90);
ylabel('P1, P5, P2R, PHINT, P2O, G1');

% Colores fríos (tonos de azul y verde) para el eje izquierdo
colors_left = [0 0.447 0.741;   % Azul
               0.301 0.745 0.933; % Azul claro
               0.466 0.674 0.188; % Verde
               0.3 0.3 0.3;      % Gris oscuro
               0 0.75 0.75;      % Cian
               0.2 0.6 0.4];     % Verde oscuro para G1

for k = 1:length(h1)
    h1(k).FaceColor = colors_left(k, :);
end

% Graficar G2 y G3 en el eje derecho con los nuevos colores
yyaxis left;
hold on;

% G2 (ahora morado con transparencia)
h2 = bar(G2', 'FaceColor', [0.9 0.9 0.9], 'FaceAlpha', 0.6, 'BarWidth', 0.8);

% G3 (ahora blanco con más transparencia, dibujado después para no tapar)
h3 = bar(G3', 'FaceColor', [1 1 1], 'FaceAlpha', 0.4, 'BarWidth', 0.6);

hold off;
ylabel('G2, G3');

% Cambiar color del eje Y derecho a un azul más suave
ax = gca;  % Obtener el eje actual
ax.YAxis(2).Color = [0 0.447 0.741];  % Azul más suave

% Cambiar color del eje Y izquierdo a gris oscuro
ax.YAxis(1).Color = [0.3 0.3 0.3];  % Cambiar el color del eje Y izquierdo a gris oscuro

% Agregar leyenda
legend({ 'G2*100', 'G3', 'P1', 'P2R', 'P5', 'P2O', 'G1'}, 'Location', 'Best');

% Título y etiquetas
% title('Comparación de Cultivares');
xlabel('Cultivars');
grid on;
f1.Position = [1 463.6667 1.5167e+03 420];

%% ***********************************************************************************************************************************
%% ***********************************************************************************************************************************
%% ***********************************************************************************************************************************
%% ***********************************************************************************************************************************
%% Most similar 
%% Similar LITERATURE VS- Ideotype 
% TEST 01
% ************************************************************************************************************************************
% Lista de cultivares relevantes según tu instrucción
% cultivars = {'FKR45N', 'ITA150', 'DKAP2', 'WABC165', 'NERICA6', 'DJ11', 'WAB56', ...
%              'Ideotype 1', 'Ideotype 2', 'Ideotype 3', 'Ideotype 4'};
% % Datos de los cultivares
% P1 = [393.1, 417.4, 417.4, 417.4, 417.6, 388.3, 413.4, GENbest1.gentype.P1, GENbest2.gentype.P1, GENbest3.gentype.P1, GENbest4.gentype.P1];
% P2R = [18.9, 17.7, 17.7, 17.7, 18.8, 88.1, 49.5, GENbest1.gentype.P2R, GENbest2.gentype.P2R, GENbest3.gentype.P2R, GENbest4.gentype.P2R];
% P5 = [350.8, 350.8, 327.6, 350.8, 337.8, 358.8, 335.0, 177.47, 77.812, 228.0, 147.52];
% P2O = [8.9, 11.3, 11.3, 11.3, 10.0, 12.4, 9.2, GENbest1.gentype.P2O, GENbest2.gentype.P2O, GENbest3.gentype.P2O, GENbest4.gentype.P2O];
% G1 = [59.4, 59.4, 65.0, 212.5, 44.6, 97.8, 50.6, GENbest1.gentype.G1, GENbest2.gentype.G1, GENbest3.gentype.G1, GENbest4.gentype.G1];
% G2 = [0.0425, 0.029, 0.0276, 0.029, 0.0376, 0.042, 0.027, GENbest1.gentype.G2, GENbest2.gentype.G2, GENbest3.gentype.G2, GENbest4.gentype.G2]*100;
% G3 = [1.00, 0.33, 1.13, 0.92, 0.99, 1.02, 0.72, GENbest1.gentype.G3, GENbest2.gentype.G3, GENbest3.gentype.G3, GENbest4.gentype.G3];
% PHINT = [83, 83, 83, 83, 83, 83, 83, GENbest1.gentype.PHINT, GENbest2.gentype.PHINT, GENbest3.gentype.PHINT, GENbest4.gentype.PHINT];

% TEST 02
% ************************************************************************************************************************************
cultivars = {'DKAP2', 'NERICA14', 'WABC165', 'ITA150', 'NERICA6', 'WAB56', 'NERICA17', 'DJ11', ...
             'Ideotype 1', 'Ideotype 2', 'Ideotype 3', 'Ideotype 4'};
% Valores extraídos del vector de referencia
P1    = [379.4, 253.9, 417.4, 413.4, 417.6, 376.5, 378.4, 388.3, ...
         GENbest1.gentype.P1, GENbest2.gentype.P1, GENbest3.gentype.P1, GENbest4.gentype.P1];
P2R   = [44.9, 115.5, 17.7, 13.7, 18.8, 116.0, 140.7, 88.1, ...
         GENbest1.gentype.P2R, GENbest2.gentype.P2R, GENbest3.gentype.P2R, GENbest4.gentype.P2R];
P5    = [263.8, 296.8, 350.8, 319.2, 327.6, 355.5, 337.8, 358.8, ...
         GENbest1.gentype.P5, GENbest2.gentype.P5, GENbest3.gentype.P5, GENbest4.gentype.P5];
P2O   = [11.9, 12.5, 11.3, 12.7, 10.0, 12.7, 12.7, 12.4, ...
         GENbest1.gentype.P2O, GENbest2.gentype.P2O, GENbest3.gentype.P2O, GENbest4.gentype.P2O];
G1    = [62.9, 480.2, 212.5, 50.6, 70.5, 75.0, 212.5, 97.8, ...
         GENbest1.gentype.G1, GENbest2.gentype.G1, GENbest3.gentype.G1, GENbest4.gentype.G1];
G2    = [0.0276, 0.0210, 0.0290, 0.0355, 0.0376, 0.0246, 0.0260, 0.0420, ...
         GENbest1.gentype.G2, GENbest2.gentype.G2, GENbest3.gentype.G2, GENbest4.gentype.G2] * 100;
G3    = [0.71, 0.48, 1.13, 0.72, 0.99, 0.57, 0.92, 1.02, ...
         GENbest1.gentype.G3, GENbest2.gentype.G3, GENbest3.gentype.G3, GENbest4.gentype.G3];
PHINT = [83, 83, 83, 83, 83, 83, 83, 83, ...
         GENbest1.gentype.PHINT, GENbest2.gentype.PHINT, GENbest3.gentype.PHINT, GENbest4.gentype.PHINT];


%% Crear la figura con dos ejes Y
f1 = figure;

% Graficar la primera serie de barras (P1, P2R, P5, P2O, G1) en el eje izquierdo
yyaxis right;  % Cambiar al eje derecho para que se inicie desde allí
h1 = bar([P1; P2R; P5; P2O; G1]', 'grouped');
set(gca, 'XTickLabel', cultivars, 'XTick', 1:length(cultivars));
xtickangle(90);
ylabel('P1, P2R, P5, P2O, G1');

% Colores fríos (tonos de azul y verde) para el eje izquierdo
colors_left = [0 0.447 0.741;   % Azul
               0.301 0.745 0.933; % Azul claro
               0.466 0.674 0.188; % Verde
               0.3 0.3 0.3;      % Gris oscuro
               0 0.75 0.75;      % Cian
               0.2 0.6 0.4];     % Verde oscuro para G1

for k = 1:length(h1)
    h1(k).FaceColor = colors_left(k, :);
end

% Graficar G2 y G3 en el eje derecho con los nuevos colores
yyaxis left;  % Cambiar al eje izquierdo para G2 y G3
hold on;

% G2 (ahora morado con transparencia)
h2 = bar(G2', 'FaceColor', [0.9 0.9 0.9], 'FaceAlpha', 0.6, 'BarWidth', 0.8);

% G3 (ahora blanco con más transparencia, dibujado después para no tapar)
h3 = bar(G3', 'FaceColor', [1 1 1], 'FaceAlpha', 0.4, 'BarWidth', 0.6);

hold off;
ylabel('G2, G3');

% Cambiar color del eje Y derecho a un azul más suave
ax = gca;  % Obtener el eje actual
ax.YAxis(2).Color = [0 0.447 0.741];  % Azul más suave

% Cambiar color del eje Y izquierdo a gris oscuro
ax.YAxis(1).Color = [0.3 0.3 0.3];  % Cambiar el color del eje Y izquierdo a gris oscuro

% Agregar leyenda
legend({ 'G2*100', 'G3', 'P1', 'P2R', 'P5', 'P2O', 'G1'}, 'Location', 'Best');

% Título y etiquetas
% title('Comparación de Cultivares');
xlabel('Cultivars');
grid on;
f1.Position = [1 463.6667 1.5167e+03 420];




%% ***********************************************************************************************************************************
%% ***********************************************************************************************************************************
%% ***********************************************************************************************************************************
%% ***********************************************************************************************************************************

%% 
m = [393.1	18.9	350.8	8.9	59.4	0.0425	1.00	83.0	26.7	15.0	15.0;
329.7	133.5	364.6	12.1	247.1	0.063	1.20	83.0	25.3	15.0	15.0;
322.6	44.2	281.8	12.7	285.0	0.0256	1.15	83.0	28.0	15.0	15.0;
290.0	99.3	523.8	12.6	540.8	0.048	1.01	83.0	25.7	15.0	15.0;
417.4	17.7	350.8	11.3	59.4	0.029	0.33	83.0	28.2	15.0	15.0;
253.9	115.5	296.8	12.5	480.2	0.021	0.48	83.0	32.8	15.0	15.0;
292.4	44.5	325.8	9.5	    65.0	0.040	1.13	83.0	26.7	15.0	15.0;
19.7	324.3	11.7	180.1	0.0225	1.00	83.0	28.7	15.0	15.0	15.0;
378.4	140.7	337.8	12.7	212.5	0.026	0.92	83.0	27.5	15.0	15.0;
316.9	44.6	367.8	11.7	114.3	0.027	0.23	83.0	26.2	15.0	15.0;
417.6	18.8	327.6	10.0	70.5	0.0376	0.99	83.0	27.7	15.0	15.0;
388.3	88.1	358.8	12.4	97.8	0.042	1.02	83.0	28.5	15.0	15.0;
352.9	49.5	335.0	9.2	    48.2	0.027	1.97	83.0	32.0	15.0	15.0;
413.4	13.7	319.2	12.7	50.6	0.0355	0.72	83.0	31.4	15.0	15.0;
376.5	116.0	355.5	12.7	75.0	0.0246	0.57	83.0	27.9	15.0	15.0;
379.4	44.9	263.8	11.9	62.9	0.0276	0.71	83.0	28.4	15.0	15.0;
417.4	19.9	345.2	10.2	48.6	0.0326	0.64	83.0	27.8	15.0	15.0;
127.8	339.5	12.7	38.3	0.029	1.07	83.0	25.2	15.0	15.0	15.0;
350.0	55.6	371.6	11.3	47.7	0.028	0.73	83.0	31.6	15.0	15.0;
402.3	20.7	357.8	10.5	70.7	0.0815	2.26	83.0	26.9	15.0	15.0;
310.3 	140.0	 370.0 	 11.2  	53.0	0.0230  0.30  	83.0  	28.0 	 15.0  	15.0]'

%% 
% CULTIVARS = readtable('CULTIVARS.csv');
% 
% % Paso 1: Datos (sin las etiquetas de los cultivares)
% data = [
%     393.1, 18.9, 350.8, 8.9, 59.4, 0.0425, 1, 83;
%     329.7, 133.5, 364.6, 12.1, 247.1, 0.063, 1.2, 83;
%     322.6, 44.2, 281.8, 12.7, 285.0, 0.0256, 1.15, 83;
%     290.0, 99.3, 523.8, 12.6, 540.8, 0.048, 1.01, 83;
%     417.4, 17.7, 350.8, 11.3, 59.4, 0.029, 0.33, 83;
%     253.9, 115.5, 296.8, 12.5, 480.2, 0.021, 0.48, 83;
%     292.4, 44.5, 325.8, 9.5, 65.0, 0.04, 1.13, 83;
%     19.7, 324.3, 11.7, 180.1, 0.0225, 1.0, 83, 28.7;
%     378.4, 140.7, 337.8, 12.7, 212.5, 0.026, 0.92, 83;
%     316.9, 44.6, 367.8, 11.7, 114.3, 0.027, 0.23, 83;
%     417.6, 18.8, 327.6, 10.0, 70.5, 0.0376, 0.99, 83;
%     388.3, 88.1, 358.8, 12.4, 97.8, 0.042, 1.02, 83;
%     352.9, 49.5, 335.0, 9.2, 48.2, 0.027, 1.97, 83;
%     413.4, 13.7, 319.2, 12.7, 50.6, 0.0355, 0.72, 83;
%     376.5, 116.0, 355.5, 12.7, 75.0, 0.0246, 0.57, 83;
%     379.4, 44.9, 263.8, 11.9, 62.9, 0.0276, 0.71, 83;
%     417.4, 19.9, 345.2, 10.2, 48.6, 0.0326, 0.64, 83;
%     127.8, 339.5, 12.7, 38.3, 0.029, 1.07, 83, 25.2;
%     350.0, 55.6, 371.6, 11.3, 47.7, 0.028, 0.73, 83;
%     402.3, 20.7, 357.8, 10.5, 70.7, 0.0815, 2.26, 83;
%     310.3, 140.0, 370.0, 11.2, 53.0, 0.023, 0.30, 83;
%     543.25 109.75 185	 11.95 	65	  0.023375	0.8900	71.125; % Ideotype1
%     587.67 130.12 324.04 11.581	63.96 0.022392	1.2692	69.533; % Ideotype2
%     587.24 201.71 186.5	 11.875	60	  0.023539	0.5880	65.781; % Ideotype3
%     540	   182    334	 11.400	50	  0.027000	0.9400	83	  ; % Ideotype4
% ];
% 
% % Paso 2: Normalización de los datos
% data_normalized = zscore(data);  % Normalizar los datos
% 
% % Paso 3: Aplicar PCA
% [coeff, score, latent] = pca(data_normalized);  % 'score' es donde están los datos proyectados
% 
% explained_variance = cumsum(latent) / sum(latent); % Varianza explicada acumulada
% variance_captured = explained_variance(3) * 100; % Porcentaje capturado por las tres primeras componentes
% disp(['Las tres primeras componentes explican ', num2str(variance_captured), '% de la varianza total.']);
% 
% 
% % Paso 4: Graficar en 3D las primeras tres componentes principales
% figure;
% scatter3(score(:,1), score(:,2), score(:,3), 50, 'filled');  % Scatter 3D
% xlabel('PC1');
% ylabel('PC2');
% zlabel('PC3');
% title('PCA: Datos proyectados en las 3 primeras componentes principales');
% grid on;

%% *************************************************************************************
%% MATCH - VARIETIES
% Step 1: Leer la tabla
CULTIVARS = readtable('CULTIVARS.csv');  

% Step 2: Extraer datos numéricos y nombres
data = table2array(CULTIVARS(:, 2:end-4));  % Excluir la primera y última columna
cultivar_names = CULTIVARS.CULTIVARN;  % Extraer nombres de cultivares
cultivar_types = CULTIVARS{:, end-1};  % Extraer los tipos ('Indica', 'Japonica', etc.)

% Step 3: Normalizar los datos
data_normalized = zscore(data);

% Step 4: Aplicar PCA
[coeff, score, latent] = pca(data_normalized);
explained = 100 * latent / sum(latent); % percentage of variance for each component
sum(explained(1:3)) % sum of the first 3 components

% Step 5: Obtener categorías únicas y asignar colores
cultivar_types_unique = unique(cultivar_types);  
num_types = length(cultivar_types_unique);
colors = lines(num_types);  % Colores distintos para cada tipo

% Step 6: Crear la gráfica 3D con colores
figure;
hold on;
legend_handles = gobjects(num_types, 1);  

for i = 1:num_types
    idx = strcmp(cultivar_types, cultivar_types_unique{i});  % Filtrar cultivares por tipo

    % Graficar cada tipo con un color diferente
    h = scatter3(score(idx,1), score(idx,2), score(idx,3), 70, colors(i,:), 'filled');

    % Guardar el handle para la leyenda
    legend_handles(i) = h;
end
hold off;

% Etiquetas de los ejes
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
title('PCA: Cultivares categorizados por tipo');
grid on;
view(3);  % Asegura una vista 3D correcta

% Agregar la leyenda
legend(legend_handles, cultivar_types_unique, 'Location', 'bestoutside');

% Step 7: Agregar etiquetas con los nombres de cultivares en el gráfico
for i = 1:length(cultivar_names)
    text(score(i,1), score(i,2), score(i,3), cultivar_names{i}, 'FontSize', 8, ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end

%% MATCH
% Step 1: Leer la tabla
CULTIVARS = readtable('CULTIVARS.csv');  

% Step 2: Extraer datos numéricos y etiquetas
data = table2array(CULTIVARS(:, 2:end-4));  % Excluir la primera y última columna
cultivar_names = CULTIVARS.CULTIVAR;  % Nombres de cultivares
cultivar_types = CULTIVARS.Genetical_group;  % Tipos de cultivares

% Step 3: Separar variedades virtuales y reales
virtual_idx = contains(cultivar_types, 'Virtual');  % Índices de variedades virtuales
real_idx = ~virtual_idx;  % Índices de cultivares reales

virtual_data = data(virtual_idx, :);  % Datos de variedades virtuales
real_data = data(real_idx, :);  % Datos de cultivares reales
real_names = cultivar_names(real_idx);  % Nombres de cultivares reales

% Step 4: Calcular distancias
distances = struct();

% 1. Distancia Euclidiana
distances.Euclidean = pdist2(virtual_data, real_data, 'euclidean');
% 2. Distancia Manhattan
distances.Manhattan = pdist2(virtual_data, real_data, 'cityblock');
% 3. Distancia Minkowski (con p = 3)
distances.Minkowski = pdist2(virtual_data, real_data, 'minkowski', 3);
% 4. Distancia de Coseno
distances.Cosine = pdist2(virtual_data, real_data, 'cosine');
% 5. Distancia de Mahalanobis
cov_matrix = cov(real_data);  % Matriz de covarianza de los cultivares reales
distances.Mahalanobis = pdist2(virtual_data, real_data, 'mahalanobis', cov_matrix);

% % % % Step 5: Encontrar los cultivares más cercanos para cada variedad virtual
% % % num_virtuals = size(virtual_data, 1);
% % % num_closest = 3;  % Número de cultivares más cercanos a encontrar
% % % 
% % % 
% % % % Obtener nombres de las métricas
% % % metric_names = fieldnames(distances);
% % % % Crear una estructura para almacenar los cultivares más cercanos
% % % closest_cultivars = struct();
% % % 
% % % % Iterar sobre cada métrica de distancia
% % % for m = 1:numel(metric_names)
% % %     metric_name = metric_names{m};  % Nombre de la métrica
% % %     [sorted_dist, sorted_idx] = sort(distances.(metric_name), 2);  % Ordenar distancias
% % % 
% % %     % Inicializar celda para almacenar resultados
% % %     closest_cultivars.(metric_name) = cell(num_virtuals, num_closest);
% % % 
% % %     for i = 1:num_virtuals
% % %         for j = 1:num_closest
% % %             closest_cultivars.(metric_name){i, j} = real_names{sorted_idx(i, j)};  
% % %         end
% % %     end
% % % end
% % % 
% % % T = struct2table(closest_cultivars);

%% **MATCHING AND CREATING T**
num_virtuals = size(virtual_data, 1);
num_closest = 3;  % Number of closest cultivars to find

metric_names = fieldnames(distances);
closest_cultivars = struct();

% Structure to store names and distances separately
cultivar_names = cell(num_virtuals, num_closest * numel(metric_names));
cultivar_distances = zeros(num_virtuals, num_closest * numel(metric_names));

for m = 1:numel(metric_names)
    metric_name = metric_names{m};  
    [sorted_dist, sorted_idx] = sort(distances.(metric_name), 2);  

    closest_cultivars.(metric_name) = cell(num_virtuals, num_closest);

    for i = 1:num_virtuals
        for j = 1:num_closest
            cultivar_names{i, (m-1)*num_closest + j} = real_names{sorted_idx(i, j)};
            cultivar_distances(i, (m-1)*num_closest + j) = sorted_dist(i, j);
        end
    end
end

T = string(cultivar_names);  
D = cultivar_distances;  % Matrix of distances associated


%% **VISUALIZATION OF FREQUENCY AND SIMILARITY**
numRows = size(T, 1);

f1 = figure;
for i = 1:numRows
    row = T(i, :);  
    distancesRow = D(i, :);  

    % Get unique cultivars and their frequencies
    uniqueCultivars = unique(row);  
    cultivarCount = zeros(1, length(uniqueCultivars));  
    avgSimilarity = zeros(1, length(uniqueCultivars));  

    for j = 1:length(uniqueCultivars)
        indices = row == uniqueCultivars(j);
        cultivarCount(j) = sum(indices); 
        avgSimilarity(j) = mean(distancesRow(indices));  
    end

    % Normalize similarity (invert so that 1 is more similar)
    normalizedSimilarity = 1 - (avgSimilarity / max(avgSimilarity));  

    % Double sort: first by frequency, then by similarity
    [sortedCount, idx1] = sort(cultivarCount, 'descend');  
    uniqueCultivarsSorted = uniqueCultivars(idx1);  
    normalizedSimilaritySorted = normalizedSimilarity(idx1);

    % If there are ties in frequency, sort by similarity
    [~, idx2] = sortrows([sortedCount', normalizedSimilaritySorted'], [-1, -2]);

    % Apply the second sorting
    sortedCount = sortedCount(idx2); 
    uniqueCultivarsSorted = uniqueCultivarsSorted(idx2);
    normalizedSimilaritySorted = normalizedSimilaritySorted(idx2);

    % Sort both by frequency and similarity
    sortedData = [sortedCount; normalizedSimilaritySorted]';
    
    % Create the bar chart
    subplot(1, numRows, i);
    hBar = barh(sortedData, 'grouped'); % Grouped bars for both frequency and similarity
    
    set(gca, 'yticklabel', uniqueCultivarsSorted); % Set sorted cultivars on the y-axis
    % % legend({'Frequency', 'Similarity Score'});
    
    % Display percentage on the similarity score bars (in black)
    for j = 1:length(sortedCount)
        % Display similarity percentage as black text
        similarityPercentage = normalizedSimilaritySorted(j) * 100; % Convert to percentage
        text(sortedData(j, 2) + 0.2, j + 0.15, sprintf('%.1f%%', similarityPercentage), 'FontSize', 10, 'Color', 'black');
    end

    title(['Ideotype ' num2str(i)]);  
    xlabel('Value');
    grid on;
end

f1.Position = [648.3333 254.3333 997.3333 285.3333];
legend({'Frequency', 'Similarity Score'});

exportgraphics(gcf, 'Results/Genotypic_similarity_with_progeny.png', 'Resolution', 300);
savefig('Results/Genotypic_similarity_with_progeny.fig');

%% ******************************************************************************************
%% ******************************************************************************************
%%
T = [
    "DJ11", "WAB56-50", "DKAP3", "WAB56-50", "DJ11", "RD 23", "DKAP3", "NERICA6", "WABC165", "DKAP2", "WAB56-50", "NERICA6", "WABC165", "ITA150", "FKR45N";
    "WABC165", "DKAP3", "NERICA6", "DJ11", "WABC165", "WAB181", "DKAP3", "NERICA6", "WABC165", "DKAP2", "ITA150", "NERICA6", "WABC165", "FKR45N", "ITA150";
    "WAB56-50", "DJ11", "NERICA17", "WAB56-50", "DKAP2", "NERICA6", "WAB56-50", "DJ11", "NERICA17", "WAB56-50", "DKAP2", "DJ11", "FKR45N", "WABC165", "ITA150";
    "DKAP2", "ITA150", "NERICA6", "DKAP2", "WAB56-50", "NERICA6", "DKAP2", "ITA150", "NERICA6", "DKAP2", "ITA150", "NERICA6", "WABC165", "ITA150", "FKR45N"
];



% Número de filas en la tabla
numFilas = size(T, 1);

% Crear una figura para mostrar todas las gráficas
figure;

% Procesar cada fila de la tabla
for i = 1:numFilas
    % Extraer la fila i
    fila = T(i, :);  % Esto es una fila de strings

    % Contar las ocurrencias de cada variedad de semilla en esta fila
    semillaUnica = unique(fila);  % Obtener las semillas únicas
    conteoSemillas = zeros(1, length(semillaUnica));  % Preasignar el vector para las frecuencias

    % Contar cuántas veces aparece cada semilla en la fila
    for j = 1:length(semillaUnica)
        conteoSemillas(j) = sum(fila == semillaUnica(j)); % Contar las ocurrencias de cada semilla
    end

    % Ordenar las frecuencias de mayor a menor
    [conteoSemillasOrdenado, idx] = sort(conteoSemillas, 'descend');  % Ordena las frecuencias de mayor a menor
    semillaUnicaOrdenada = semillaUnica(idx);  % Ordena las semillas según las frecuencias

    % Crear una subgráfica para cada fila
    subplot(1, numFilas, i);
    barh(conteoSemillasOrdenado);  % Crear el gráfico de barras horizontal
    set(gca, 'YTickLabel', semillaUnicaOrdenada, 'YTick', 1:length(semillaUnicaOrdenada));

    % Título con "Virtual Cultivar" seguido de la fila correspondiente
    title(['Ideotype ' num2str(i)]);  
    xlabel('Frequency');
    % ylabel('Variedad de Semilla');
    grid on;
end


%% Gráfico de Frecuencias
% numFilas = size(T, 1);
% 
% figure;
% 
% for i = 1:numFilas
%     fila = T{i, :};  % Extraer cultivares de la fila
% 
%     % Convertir a cellstr si hay celdas anidadas
%     if iscell(fila)
%         fila = cellfun(@(x) string(x), fila, 'UniformOutput', false);  
%     else
%         fila = cellstr(string(fila));  
%     end
% 
%     % Contar las ocurrencias de cada cultivar
%     [semillaUnica, ~, idx] = unique(fila, 'stable');  
%     conteoSemillas = accumarray(idx, 1);  
% 
%     % Ordenar las frecuencias
%     [conteoOrdenado, ordenIdx] = sort(conteoSemillas, 'descend');  
%     semillaOrdenada = semillaUnica(ordenIdx);  
% 
%     % Crear subgráfica
%     subplot(1, numFilas, i);
%     barh(conteoOrdenado);
%     set(gca, 'YTickLabel', semillaOrdenada, 'YTick', 1:length(semillaOrdenada));
% 
%     title(['Virtual Cultivar ' num2str(i)]);  
%     xlabel('Frequency');
%     grid on;
% end

