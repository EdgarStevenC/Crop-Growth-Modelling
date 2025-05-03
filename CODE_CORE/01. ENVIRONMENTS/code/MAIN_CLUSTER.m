% Code developed by Edgar S. CORREA for the doctoral thesis and academic paper 
% "AI-Driven Insights for Crop Growth Modelling: Advancing Rainfed Rice Yield Prediction with
% Machine Learning and Satellite Data in Senegal." 
% Copyright © 2025 Edgar S. CORREA. This work is licensed under a Creative Commons 
% Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0).

%% 01/01/2025 --> Edgar S. CORREA
%% MAIN CODE TO EXTRACT SIMULATION FROM DSSAT
%% ********************************************
% Code to characterize the main environments of the studied region. OUT --> FET.mat
%% ********************************************
clc, clearvars, close all
%% Set Up
% Define the folder path
folderPath = pwd;                 % folderPath = 'C:\Users\CORREAPINZON\Desktop\ARTICLE1';  % Replace with your folder path
FolderMATLAB = '\MATLAB_DJ11\';     % FolderMATLAB = '\MATLAB_DJ11\';   '\MATLAB_N4\'
%% SOIL
load(strcat(FolderMATLAB(2:end-1),'_FET.mat'))
LON = table2array(FET(:,1));  
LAT = table2array(FET(:,2));
[idx1] = SOILcluster(FET)
%% CLIM
load(strcat(FolderMATLAB(2:end-1),'_FETT.mat'))
[idx2] = CLIMcluster(FETT, LON, LAT)
%%

SOIL = idx1;  % vector with tags of soils distribution
CLIM = idx2;  % vector with tags of climates distribution

% Classify the combinations
result = zeros(size(SOIL));
for i = 1:length(SOIL)
    % Asignar un valor único de forma ordenada
    result(i) = (SOIL(i) - 1) * 4 + CLIM(i);
end

% Display the resulting vector
disp(result);  writematrix(result, 'ENVIRONMENTtagX12.csv');  

%save('ENVIRONMENTtagX12.mat', 'result', 'LON', 'LAT');
load('ENVIRONMENTtagX12.mat');

graphicENVIRONMENTS(LON, LAT, result);

%% DINAMIC VISUALIZATION
% % Paso 1: Definir los colores para las combinaciones de ambientes
% colors = [
%     [0.6431, 0.8314, 0.6824];           % Verde oliva fuerte (Ambiente 1)   SOIL1 & CLIM1
%     [0.2980, 0.6235, 0.8500];           % Azul cielo fuerte (Ambiente 2)   SOIL1 & CLIM2
%     [0 1 1 ];                          % (Ambiente 3)   SOIL1 & CLIM3
%     [0 1 0 ];                     % (Ambiente 4)   SOIL1 & CLIM4
%     [1.0000, 0.6235, 0.2667];          % Naranja (Ambiente 5)   SOIL2 & CLIM1
%     [1.0000, 0.4353, 0.3804];          % Coral (Ambiente 6)   SOIL2 & CLIM2
%     [1.0000, 0.6510, 0.3410];          % Naranja más clarito (Ambiente 7)   SOIL2 & CLIM3
%     [0.6353, 0.0784, 0.1843];          % Rojo oscuro (Ambiente 8)   SOIL2 & CLIM4
%     [0.4275, 0.5333, 0.7412];          % Azul claro (Ambiente 9)   SOIL3 & CLIM1
%     [0.5019, 0.3608, 0.5569];          % Violeta (Ambiente 10)   SOIL3 & CLIM2
%     [0.8941, 0.7765, 0.4314];          % Amarillo (Ambiente 11)   SOIL3 & CLIM3
%     [0 0 0];                           % Verde (Ambiente 12)   SOIL3 & CLIM4 (Cambio a verde)
% ];
% % Paso 2: Crear las combinaciones de suelo y clima en la leyenda
% legendLabels = cell(1, 12);
% figure;
% 
% % Graficar cada combinación de ambiente
% for i = 1:12
%     % Determinar si el clima es 3 o 4 (donde se marcarán con asterisco)
%     if mod(i, 4) == 3 || mod(i, 4) == 0  % Si es CLIMATE3 o CLIMATE4
%         marker = '*';  % Marcador asterisco
%         markerSize = 8;  % Tamaño más pequeño para los asteriscos
%     else
%         marker = '.';  % Marcador punto
%         markerSize = 15;  % Tamaño normal para los puntos
%     end
% 
%     % Cambiar el color para todos los puntos con SOIL3 a verde
%     if mod(i, 4) == 9 || mod(i, 4) == 10 || mod(i, 4) == 11 % SOIL 3 (todos los casos que tienen SOIL3)
%         colors(i,:) = [0, 1, 0];  % Todos los puntos de SOIL 3 ahora son verdes
%         marker = 'o';  % Cambiar a círculo para SOIL3
%         markerSize = 10;  % Tamaño del círculo
%     end
% 
%     % Graficar los puntos correspondientes a la combinación de ambiente i
%     plot(LON(result == i), LAT(result == i), marker, 'MarkerSize', markerSize, 'Color', colors(i,:));
%     hold on;
% 
%     % Determinar las combinaciones de suelo y clima para cada ambiente
%     if i <= 4
%         soilValue = 1;  % Suelo 1 para los primeros cuatro ambientes
%     elseif i <= 8
%         soilValue = 2;  % Suelo 2 para los siguientes cuatro ambientes
%     else
%         soilValue = 3;  % Suelo 3 para los últimos cuatro ambientes
%     end
% 
%     climValue = mod(i-1, 4) + 1;  % Determina el clima entre 1 y 4 para cada ambiente
% 
%     % Agregar el asterisco (*) a los ambientes con CLIMATE3 y CLIMATE4
%     if climValue == 3 || climValue == 4
%         legendLabels{i} = sprintf('ENVIRONMENT%d = SOIL%d & CLIMATE%d*', i, soilValue, climValue);
%     else
%         legendLabels{i} = sprintf('ENVIRONMENT%d = SOIL%d & CLIMATE%d', i, soilValue, climValue);
%     end
% end
% 
% % Paso 3: Configuración de la gráfica
% grid on;
% xlabel('Longitude');  % Etiqueta para el eje X
% ylabel('Latitude');   % Etiqueta para el eje Y
% ylim([12 17]);        % Limitar el eje Y (latitud)
% 
% % Añadir la leyenda con las combinaciones detalladas de suelo y clima
% legend(legendLabels, 'Location', 'best');  % Leyenda con los nombres específicos de cada combinación
% 
% 
% 
% 
% 
% 
% 
% 
% 
% %%
% figure,  plot(LON((result==1)), LAT((result==1)), '.','MarkerSize', 15,'Color',  [0.2980, 0.6235, 0.8500])  % Combination 1: Azul
% hold on, plot(LON((result==2)), LAT((result==2)), '.', 'MarkerSize', 15,'Color', [0.6431, 0.8314, 0.6824] ) % Combination 2: Verde menta
% hold on, plot(LON((result==3)), LAT((result==3)), '.', 'MarkerSize', 15,'Color', [1.0000, 0.4353, 0.3804] ) % Combination 3: Coral
% hold on, plot(LON((result==4)), LAT((result==4)), '.', 'MarkerSize', 15,'Color', [1.0000, 0.6235, 0.2667] ) % Combination 4: Naranja   
% 
% hold on, plot(LON((result==5)), LAT((result==5)), '.', 'MarkerSize', 15,'Color', [0, 1, 1] ) % Combination 4: CIAN
% hold on, plot(LON((result==6)), LAT((result==6)), '.', 'MarkerSize', 15,'Color', [0 1 0] ) % Combination 4: VERDE  
% grid on, xlabel('LON'); ylabel('LAT'); ylim([11 16]);
% legend('ENVIRONMENT1 = SOIL1 & CLIMATE1', ...
%        'ENVIRONMENT2 = SOIL1 & CLIMATE2', ...
%        'ENVIRONMENT3 = SOIL2 & CLIMATE1', ...
%        'ENVIRONMENT4 = SOIL2 & CLIMATE2',...
%        'ENVIRONMENT5 = SOIL3 & CLIMATE1', ...
%        'ENVIRONMENT6 = SOIL3 & CLIMATE2')

