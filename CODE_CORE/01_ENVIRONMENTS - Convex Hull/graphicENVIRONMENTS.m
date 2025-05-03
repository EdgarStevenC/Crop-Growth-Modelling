function [] = graphicENVIRONMENTS(LON, LAT, result)
load('SenegalR.mat')
% Paso 1: Definir los colores para las combinaciones de ambientes
colors = [
    [0.6431, 0.8314, 0.6824];           % Verde oliva fuerte (Ambiente 1)   SOIL1 & CLIM1
    [0.2980, 0.6235, 0.8500];           % Azul cielo fuerte (Ambiente 2)   SOIL1 & CLIM2
    [0 1 1 ];                          % (Ambiente 3)   SOIL1 & CLIM3
    [0 1 0 ];                     % (Ambiente 4)   SOIL1 & CLIM4
    [1.0000, 0.6235, 0.2667];          % Naranja (Ambiente 5)   SOIL2 & CLIM1
    [1.0000, 0.4353, 0.3804];          % Coral (Ambiente 6)   SOIL2 & CLIM2
    [1.0000, 0.6510, 0.3410];          % Naranja más clarito (Ambiente 7)   SOIL2 & CLIM3
    [0.6353, 0.0784, 0.1843];          % Rojo oscuro (Ambiente 8)   SOIL2 & CLIM4
    [0.4275, 0.5333, 0.7412];          % Azul claro (Ambiente 9)   SOIL3 & CLIM1
    [0.5019, 0.3608, 0.5569];          % Violeta (Ambiente 10)   SOIL3 & CLIM2
    [0.8941, 0.7765, 0.4314];          % Amarillo (Ambiente 11)   SOIL3 & CLIM3
    [0 0 0];                           % Verde (Ambiente 12)   SOIL3 & CLIM4 (Cambio a verde)
];

% Paso 2: Crear las combinaciones de suelo y clima en la leyenda
legendLabels = cell(1, 12);

% Graficar para SOIL1 (Combinaciones 1 a 4)
f1= figure;
hold on, mapshow(SenegalR, 'FaceColor', [1 1 1] ); 
grid on, xlabel('LON'), ylabel('LAT'), zlabel('Precipitation (mm/day) ')

for i = 1:4
    % Determinar si el clima es 3 o 4 (donde se marcarán con asterisco)
    if mod(i, 4) == 3 || mod(i, 4) == 0  % Si es CLIMATE3 o CLIMATE4
        marker = '*';  % Marcador asterisco
        markerSize = 8;  % Tamaño más pequeño para los asteriscos
    else
        marker = '.';  % Marcador punto
        markerSize = 15;  % Tamaño normal para los puntos
    end
    
    % Graficar los puntos correspondientes a la combinación de ambiente i
    plot(LON(result == i), LAT(result == i), marker, 'MarkerSize', markerSize, 'Color', colors(i,:));
    hold on;

    % Definir las combinaciones de suelo y clima
    soilValue = 1;  % Suelo 1
    climValue = mod(i-1, 4) + 1;  % Determina el clima entre 1 y 4 para cada ambiente
    
    % Agregar el asterisco (*) a los ambientes con CLIMATE3 y CLIMATE4
    if climValue == 3 || climValue == 4
        legendLabels{i} = sprintf('ENVIRONMENT%d = SOIL%d & CLIMATE%d*', i, soilValue, climValue);
    else
        legendLabels{i} = sprintf('ENVIRONMENT%d = SOIL%d & CLIMATE%d', i, soilValue, climValue);
    end
end
grid on;
xlabel('Longitude');
ylabel('Latitude');
ylim([12 17]);
l = legend(legendLabels(1:4), 'Location', 'best');
title('SOIL1');
f1.Position = [232.3333  279.6667  494.6667  357.3333];
l.Position = [0.1416    0.6216    0.5064    0.1870];






% Graficar para SOIL2 (Combinaciones 5 a 8)
f1=figure;
hold on, mapshow(SenegalR, 'FaceColor', [1 1 1] ); 
grid on, xlabel('LON'), ylabel('LAT'), zlabel('Precipitation (mm/day) ')

for i = 5:8
    if mod(i, 4) == 3 || mod(i, 4) == 0  % Si es CLIMATE3 o CLIMATE4
        marker = '*';  % Marcador asterisco
        markerSize = 8;  % Tamaño más pequeño para los asteriscos
    else
        marker = '.';  % Marcador punto
        markerSize = 15;  % Tamaño normal para los puntos
    end

    % Graficar los puntos correspondientes a la combinación de ambiente i
    plot(LON(result == i), LAT(result == i), marker, 'MarkerSize', markerSize, 'Color', colors(i,:));
    hold on;

    % Definir las combinaciones de suelo y clima
    soilValue = 2;  % Suelo 2
    climValue = mod(i-1, 4) + 1;  % Determina el clima entre 1 y 4 para cada ambiente
    
    % Agregar el asterisco (*) a los ambientes con CLIMATE3 y CLIMATE4
    if climValue == 3 || climValue == 4
        legendLabels{i} = sprintf('ENVIRONMENT%d = SOIL%d & CLIMATE%d*', i, soilValue, climValue);
    else
        legendLabels{i} = sprintf('ENVIRONMENT%d = SOIL%d & CLIMATE%d', i, soilValue, climValue);
    end
end
grid on;
xlabel('Longitude');
ylabel('Latitude');
ylim([12 17]);
l=legend(legendLabels(5:8), 'Location', 'best');
title('SOIL2');
f1.Position = [232.3333  279.6667  494.6667  357.3333];
l.Position = [0.1416    0.6216    0.5064    0.1870];


% Graficar para SOIL3 (Combinaciones 9 a 12)
f1=figure;
hold on, mapshow(SenegalR, 'FaceColor', [1 1 1] ); 
grid on, xlabel('LON'), ylabel('LAT'), zlabel('Precipitation (mm/day) ')

for i = 9:12
    % Cambiar los puntos de SOIL3 a círculos
    if mod(i, 4) == 3 || mod(i, 4) == 0  % Si es CLIMATE3 o CLIMATE4
        marker = '*';  % Marcador asterisco
        markerSize = 8;  % Tamaño más pequeño para los asteriscos
    else
        marker = '.';  % Marcador círculo para SOIL3
        markerSize = 15;  % Tamaño del círculo
    end

    % Graficar los puntos correspondientes a la combinación de ambiente i
    plot(LON(result == i), LAT(result == i), marker, 'MarkerSize', markerSize, 'Color', colors(i,:));
    hold on;

    % Definir las combinaciones de suelo y clima
    soilValue = 3;  % Suelo 3
    climValue = mod(i-1, 4) + 1;  % Determina el clima entre 1 y 4 para cada ambiente
    
    % Agregar el asterisco (*) a los ambientes con CLIMATE3 y CLIMATE4
    if climValue == 3 || climValue == 4
        legendLabels{i} = sprintf('ENVIRONMENT%d = SOIL%d & CLIMATE%d*', i, soilValue, climValue);
    else
        legendLabels{i} = sprintf('ENVIRONMENT%d = SOIL%d & CLIMATE%d', i, soilValue, climValue);
    end
end
grid on;
xlabel('Longitude');
ylabel('Latitude');
ylim([12 17]);
l=legend(legendLabels(9:end), 'Location', 'best');
title('SOIL3');
f1.Position = [232.3333  279.6667  494.6667  357.3333];
l.Position = [0.1416    0.6216    0.5064    0.1870];





















%% OLD CODE
% % Contar cuántos puntos hay en cada ambiente (de 1 a 12)
% environmentCounts = zeros(1, 12);  % Inicializamos el contador para los 12 ambientes
% 
% % Contamos las apariciones de cada ambiente en el vector 'result'
% for i = 1:12
%     environmentCounts(i) = sum(result == i);
% end
% 
% % Colores asignados a cada ambiente
% colors = [
%     [0.6431, 0.8314, 0.6824];  % Verde oliva fuerte (SOIL1 & CLIM1)
%     [0.2980, 0.6235, 0.8500];  % Azul cielo fuerte (SOIL1 & CLIM2)
%     [0 1 1];                  % Aqua (SOIL1 & CLIM3)
%     [0 1 0];                  % Verde (SOIL1 & CLIM4)
% 
%     [1.0000, 0.6235, 0.2667];  % Naranja (SOIL2 & CLIM1)
%     [1.0000, 0.4353, 0.3804];  % Coral (SOIL2 & CLIM2)
%     [1.0000, 0.6510, 0.3410];  % Naranja claro (SOIL2 & CLIM3)
%     [0.6353, 0.0784, 0.1843];  % Rojo oscuro (SOIL2 & CLIM4)
% 
%     [0.4275, 0.5333, 0.7412];  % Azul claro (SOIL3 & CLIM1)
%     [0.5019, 0.3608, 0.5569];  % Violeta (SOIL3 & CLIM2)
%     [0.8941, 0.7765, 0.4314];  % Amarillo (SOIL3 & CLIM3)
%     [0 0 0];                   % Verde (SOIL3 & CLIM4)
% ];
% 
% % Crear un gráfico de pastel para los 12 ambientes
% figure;
% pie(environmentCounts, [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1]); % Distribuir proporcionalmente los segmentos
% colormap(colors);  % Aplicar los colores a los 12 ambientes
% % title('Distribución de los 12 Ambientes');
% 
% % Crear la leyenda para cada combinación de suelo y clima
% legendLabels = {
%     'ENVIRONMENT1 = SOIL1 & CLIMATE1', 'ENVIRONMENT2 = SOIL1 & CLIMATE2', ...
%     'ENVIRONMENT3 = SOIL1 & CLIMATE3', 'ENVIRONMENT4 = SOIL1 & CLIMATE4', ...
%     'ENVIRONMENT5 = SOIL2 & CLIMATE1', 'ENVIRONMENT6 = SOIL2 & CLIMATE2', ...
%     'ENVIRONMENT7 = SOIL2 & CLIMATE3', 'ENVIRONMENT8 = SOIL2 & CLIMATE4', ...
%     'ENVIRONMENT9 = SOIL3 & CLIMATE1', 'ENVIRONMENT10 = SOIL3 & CLIMATE2', ...
%     'ENVIRONMENT11 = SOIL3 & CLIMATE3', 'ENVIRONMENT12 = SOIL3 & CLIMATE4'
% };
% 
% % legend(legendLabels, 'Location', 'best', 'FontSize', 8);  % Añadir la leyenda
% 
% 
% 
% 
% 
% 
% %% ******************************************************
% % Contar cuántos puntos hay en cada ambiente (de 1 a 12) para cada tipo de suelo
% environmentCountsSOIL1 = zeros(1, 4);  % Inicializamos el contador para cada ambiente con SOIL1
% environmentCountsSOIL2 = zeros(1, 4);  % Inicializamos el contador para cada ambiente con SOIL2
% environmentCountsSOIL3 = zeros(1, 4);  % Inicializamos el contador para cada ambiente con SOIL3
% 
% % Contamos las apariciones de cada ambiente en el vector 'result', separando por tipo de suelo
% for i = 1:12
%     if i <= 4  % Ambientes con SOIL1
%         environmentCountsSOIL1(i) = sum(result == i);
%     elseif i <= 8  % Ambientes con SOIL2
%         environmentCountsSOIL2(i - 4) = sum(result == i);
%     else  % Ambientes con SOIL3
%         environmentCountsSOIL3(i - 8) = sum(result == i);
%     end
% end
% 
% % Colores asignados a cada ambiente
% colors = [
%     [0.6431, 0.8314, 0.6824];  % Verde oliva fuerte (SOIL1 & CLIM1)
%     [0.2980, 0.6235, 0.8500];  % Azul cielo fuerte (SOIL1 & CLIM2)
%     [0 1 1];                  % Aqua (SOIL1 & CLIM3)
%     [0 1 0];                  % Verde (SOIL1 & CLIM4)
% 
%     [1.0000, 0.6235, 0.2667];  % Naranja (SOIL2 & CLIM1)
%     [1.0000, 0.4353, 0.3804];  % Coral (SOIL2 & CLIM2)
%     [1.0000, 0.6510, 0.3410];  % Naranja claro (SOIL2 & CLIM3)
%     [0.6353, 0.0784, 0.1843];  % Rojo oscuro (SOIL2 & CLIM4)
% 
%     [0.4275, 0.5333, 0.7412];  % Azul claro (SOIL3 & CLIM1)
%     [0.5019, 0.3608, 0.5569];  % Violeta (SOIL3 & CLIM2)
%     [0.8941, 0.7765, 0.4314];  % Amarillo (SOIL3 & CLIM3)
%     [0 0 0];                   % Verde (SOIL3 & CLIM4)
% ];
% 
% % Crear una figura para SOIL1
% figure;
% pie(environmentCountsSOIL1, [0.1, 0.1, 0.1, 0.1]); % Distribuir proporcionalmente los segmentos
% colormap(colors(1:4,:));  % Colores para SOIL1
% % % title('Distribución de Ambientes para SOIL1');
% % legend({'ENVIRONMENT1 = SOIL1 & CLIMATE1', 'ENVIRONMENT2 = SOIL1 & CLIMATE2', 'ENVIRONMENT3 = SOIL1 & CLIMATE3', 'ENVIRONMENT4 = SOIL1 & CLIMATE4'}, 'Location', 'best', 'FontSize', 8);
% 
% % Crear una figura para SOIL2
% figure;
% pie(environmentCountsSOIL2, [0.1, 0.1, 0.1, 0.1]); % Distribuir proporcionalmente los segmentos
% colormap(colors(5:8,:));  % Colores para SOIL2
% % % title('Distribución de Ambientes para SOIL2');
% % legend({'ENVIRONMENT5 = SOIL2 & CLIMATE1', 'ENVIRONMENT6 = SOIL2 & CLIMATE2', 'ENVIRONMENT7 = SOIL2 & CLIMATE3', 'ENVIRONMENT8 = SOIL2 & CLIMATE4'}, 'Location', 'best', 'FontSize', 8);
% 
% % Crear una figura para SOIL3
% figure;
% pie(environmentCountsSOIL3, [0.1, 0.1, 0.1, 0.1]); % Distribuir proporcionalmente los segmentos
% colormap(colors(9:12,:));  % Colores para SOIL3
% % % title('Distribución de Ambientes para SOIL3');
% % legend({'ENVIRONMENT9 = SOIL3 & CLIMATE1', 'ENVIRONMENT10 = SOIL3 & CLIMATE2', 'ENVIRONMENT11 = SOIL3 & CLIMATE3', 'ENVIRONMENT12 = SOIL3 & CLIMATE4'}, 'Location', 'best', 'FontSize', 8);

end