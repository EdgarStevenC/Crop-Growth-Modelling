function [] = MAPAstv2(weights)
f = figure;
load ("gpss.mat") % LON = FET.LON; LAT = FET.LAT;
% PREPARACION  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
load ("IDX.mat")

geoplot(FF(not(IDX),2), FF(not(IDX),1), 'w*', 'LineWidth', 8.5), hold on
% DENSITY ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
load ('SenegalR.mat'); load('GYxy.mat');
M1 = 0; %min(weights);
M2 = 1; % max(weights);
weightsF = weights;    % weightsF = (weights - M1) ./ (M2-M1);

GY = [LAT, LON]; 
geoplot(LAT, LON, 'k.', 'LineWidth', 1), hold on
dp = geodensityplot(GY(:,1), GY(:,2),  weightsF/(10^-8),'FaceColor', 'interp','Radius',20e3);    % max(weights)*
dp.FaceColor = 'interp'; colormap bone
alphamap(normalize((1:64).^0.4,'range'))
colorbar, title('')  
hBar1 = contourcbar
ylabel(hBar1,strcat('GY(Kg/H)' ),'FontSize',12);

 

% n = 22;
% map = colormap(jet); % colormap(jet(n)) ; %Create Colormap
% cbh = colorbar ; %Create Colorbar
% cbh.Limits = [0 1.2];
% cbh.Ticks = linspace(0, 1, n) ; %Create n ticks from zero to 1
% cbh.TickLabels = num2cell( round( (M1:(M2-M1)/31:M2),2) );
    % (logspace(log10(M1),log10(M2),n)) );   %Replace the labels of these n ticks with the given numbers 

% BORDE  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
load ("IDX.mat")
hold on
geoplot(FF(IDX,2), FF(IDX,1), 'w*', 'LineWidth', 8.5), hold on
inT = [];
    Senegal = shaperead('SEN2.shp');  load('SenegalR.mat'); 
    R=[15, 11 , 7, 4, 13, 6, 5, 3];
    for i=1:8
        polig = Senegal(R(i));
        polX=polig.X; polY=polig.Y;
        geoplot( polig.Y, polig.X, 'k-', 'LineWidth', 1), hold on
    end  

   f.Position = [637.0000  176.2000  825.6000  417.6000];  % [298.6000  145.0000  910.4000  449.6000];
   geolimits( [12.3, 15] , [-17, -11] )
   colormap hot;
   % f.Position = [1482.6 1129.8 838.4 412.8];


    % title ('RAINFED LOWLAND Distribution [FIELD CAPACITY - ELEVATION - CURVATURE ]');
    % colormap('winter')
end