function [idx] = SOILcluster(FET)

%% No.1 VARIABLES
LON = table2array(FET(:,1));  
LAT = table2array(FET(:,2)); 
SOILt = FET(:, 14:end);
SOIL = table2array(SOILt);

% [R,PValue] = corrplot(SOILt)
categories = SOILt.Properties.VariableNames;
categories1 = {'sand(g/kg)','silt(g/kg)','clay(g/kg)','BULK(g/cm3)','COARSE(g/dg)','OrganicCarbon(dg/kg)','N(dg/kg)','PH','SLLL(cm3/cm3)','SDUL(cm3/cm3)','SSAT(cm3/cm3)','SSKS(cm/h)'};
%% REduce DIM
f1 = figure
subplot(1,2,1)
[wcoeff,score,latent,tsquared,explainedVar] = pca(SOIL);
bar(explainedVar), grid on
title(strcat('Explained Variance:',num2str(sum(explainedVar(1:3))) ,'% /3 components'))
ylabel('PC')

% Retain first 3 principal components
X = score(:,1:3);
%% No.2 Optimal number of clusters
s = zeros(1, 10);
for k = 1:10
    [idx] = kmeans(X, k, 'Replicates',50);  % sumd is the sum of distances from points to their cluster centers
    s(k) = mean(silhouette(X, idx)); % Score for the current k
end
subplot(1,2,2), plot(1:10, s), 
title('Optimal number of environments'), 
xlabel('Number of clusters'),
ylabel('Silhouette Index'), grid on
f1.Position = [671.4000  337.0000  837.6000  336.8000];


%% *******************************************************************************************************
%% No.3 CLUSTER
f2 = figure   % saveas(gcf,strcat('Drought1/Figures/Gcluster/', 'ALL','.png'))
% CLUSTER K-MEANS
   % [idx, centroid] = kmeans(X,2);  save('idx.mat','idx')
load('idx.mat')
% CLUSTER GMM
   % [idx] = CLUSTERstvGMM(X,10); save('idxGMMsoil.mat','idx')
load('idxGMMsoil.mat')

x=X(:,1);
y=X(:,2);
z=X(:,3);




%% No.4 VISUALIZATION --> 3D - PCA
f1 = figure
% Transform Coefficients % Transform the coefficients so that they are orthonormal.
coefforth = diag(std(SOIL))\wcoeff;
% biplot(coefforth(:,1:3),'Scores',score(:,1:3),'Varlabels',categories)
% axis([-.26 0.8 -.51 .51 -.61 .81])
subplot(1,3,1)
hold on, plot3(x(idx==1),y(idx==1),z(idx==1), '.', 'MarkerSize', 15,'Color',[0.5, 0, 1] )    % draw the scatter plot
hold on, plot3(x(idx==2),y(idx==2),z(idx==2), '.', 'MarkerSize', 15,'Color',[0, 1, 1] ) 
hold on, plot3(x(idx==3),y(idx==3),z(idx==3), '.', 'MarkerSize', 15,'Color',[0, 1, 0] )
view(-31,14), grid on
xlabel('First Principal Component');
ylabel('Second Principal Component');
zlabel('Third Principal Component');
hold on, biplot(coefforth(:,1:3).*100,'Varlabels',categories)
l = legend('SOIL1', 'SOIL2', 'SOIL3');
title('Explained Variance: 94.55%')
% MAPA
subplot(1,3,3)
plot(LON((idx==1)),  LAT((idx==1)), '.','MarkerSize', 15,'Color', [0.5, 0, 1])
hold on, plot(LON((idx==2)), LAT((idx==2)), '.', 'MarkerSize', 15,'Color', [0, 1, 1] )
hold on, plot(LON((idx==3)), LAT((idx==3)), '.', 'MarkerSize', 15,'Color', [0, 1, 0] )
grid on
xlabel('LON');
ylabel('LAT'); ylim([11 16]);
%% DESCRIOPTION OF EACH CLUSTER

subplot(1,3,2)
SOIL2 = (SOIL); %normalize
[val idxx] = sort(std(SOIL2(:,:))); idxx = flip(idxx);
% Initialize data points
D2 = mean(SOIL((idx==1),:));
D1 = mean(SOIL((idx==2),:));
D3 = mean(SOIL((idx==3),:));
P = [D1; D2; D3];

spider_plot(P,...
    'AxesWebType', 'circular',...
    'AxesLabels', categories1,...
    'FillOption', 'on',...
    'FillTransparency', 0.2,...
    'Color', [ 0, 1, 1; 0.5, 0, 1; 0, 1, 0],...
    'FillCData', D1);

f1.Position = [19.4    333.0    1516.8    420.0];
l.Position = [0.0985    0.9010    0.0563    0.0869];
end