clc; clear; close all;
%% ************************************************************************************************************
%% ************************************************************************************************************
%% STEP No.1 Environment representation
load('ENVIRONMENTtagX12.mat');
% graphicENVIRONMENTS(LON, LAT, result);
load('SenegalR.mat')

%% No.1 #######################################################################################################
%% Environment No.1   -  30%
idx = (result==1);  c1 = [0.6431, 0.8314, 0.6824];       % Verde oliva fuerte (Ambiente 1)   SOIL1 & CLIM1
f1= figure; 
hold on, mapshow(SenegalR, 'FaceColor', [1 1 1] ); 
hold on, plot(LON(idx), LAT(idx), '.', 'Color', c1, 'MarkerSize', 18);

[idxCentroid1] = convhullMAP(LON(idx), LAT(idx), LON, LAT)
f1.Position = [ 983.6667  372.3333  560.0000  212.0000];
lg = legend('Environment1', 'Centroid', 'Convex Polygon');
lg.Position = [0.1387    0.6666    0.2315    0.2217];
savefig('Results\Environment1.fig');
exportgraphics(gcf, 'Results\Environment1.png', 'Resolution', 300);

%% No.2 #######################################################################################################
%% Environment No.2   -  18%
idx = (result==2);  c2 = [0.2980, 0.6235, 0.8500];      % Azul cielo fuerte (Ambiente 2)   SOIL1 & CLIM2
idx = logical(idx.*([ zeros(306,1); ones(200,1) ]));
f1= figure; 
hold on, mapshow(SenegalR, 'FaceColor', [1 1 1] ); 
hold on, plot(LON(idx), LAT(idx), '.', 'Color', c2, 'MarkerSize', 18);

[idxCentroid2] = convhullMAP(LON(idx), LAT(idx), LON, LAT)
f1.Position = [983.6667  372.3333  560.0000  212.0000];
lg = legend('Environment2', 'Centroid', 'Convex Polygon');
lg.Position = [0.1387    0.6666    0.2315    0.2217];
savefig('Results\Environment2.fig');
exportgraphics(gcf, 'Results\Environment2.png', 'Resolution', 300);

%% No.3 #######################################################################################################
%% Environment No.5   -  21%
idx = (result==5);  c5 =  [1.0000, 0.6235, 0.2667];      % Naranja (Ambiente 5)   SOIL2 & CLIM1
f1= figure; 
hold on, mapshow(SenegalR, 'FaceColor', [1 1 1] ); 
hold on, plot(LON(idx), LAT(idx), '.', 'Color', c5, 'MarkerSize', 18);

[idxCentroid5] = convhullMAP(LON(idx), LAT(idx), LON, LAT)
f1.Position = [ 983.6667  372.3333  560.0000  212.0000];
lg = legend('Environment3', 'Centroid', 'Convex Polygon');
lg.Position = [0.1387    0.6666    0.2315    0.2217];
savefig('Results\Environment5.fig');
exportgraphics(gcf, 'Results\Environment5.png', 'Resolution', 300);

%% No.4 #######################################################################################################
%% Environment No.6   -  20%

idx = (result==6); c6 = [1.0000, 0.4353, 0.3804];       % Coral (Ambiente 6)   SOIL2 & CLIM2
f1= figure; 
hold on, mapshow(SenegalR, 'FaceColor', [1 1 1] ); 
hold on, plot(LON(idx), LAT(idx), '.', 'Color', c6, 'MarkerSize', 18);

[idxCentroid6] = convhullMAP(LON(idx), LAT(idx), LON, LAT)
f1.Position = [983.6667  372.3333  560.0000  212.0000];
lg = legend('Environment4', 'Centroid', 'Convex Polygon');
lg.Position = [0.1387    0.6666    0.2315    0.2217];
savefig('Results\Environment6.fig');
exportgraphics(gcf, 'Results\Environment6.png', 'Resolution', 300);


% figure, plot(LON(381), LAT(381), 'g*'), hold on, plot(LON(423), LAT(423), 'b*'), hold on, plot(LON(125), LAT(125), 'y*'), hold on, plot(LON(343), LAT(343), 'r*')



%% ************************************************************************************************************
%% ************************************************************************************************************
%% STEP No.1

