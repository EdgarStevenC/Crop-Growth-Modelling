function [idxM] = CLIMcluster(FET, LON, LAT)

%% No.1 VARIABLES
CLIMt =  FET(:, :);   % FET(:,[1,3,4,5,7,9,11]);   % 
CLIMi = table2array(CLIMt);
CLIM = normalize(table2array(CLIMt));

% [R,PValue] = corrplot(SOILt)
categories1 = CLIMt.Properties.VariableNames;
%% REduce DIM
f1 = figure
subplot(1,2,1)
[wcoeff,score,latent,tsquared,explainedVar] = pca(CLIM);
bar(explainedVar), grid on
EV = num2str(sum(explainedVar(1:3)),4);
title(strcat('Explained Variance:',EV,'% /3 components'))
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
%% No.3 CLUSTER

f2 = figure   % saveas(gcf,strcat('Drought1/Figures/Gcluster/', 'ALL','.png'))
% CLUSTER K-MEANS
   % [idx, centroid] = kmeans(X,2);  save('idx22.mat','idx')
load('idx22.mat')
% CLUSTER GMM
     % [idx] = CLUSTERstvGMM(X, 8); save('idx2GMMsoil.mat','idx')
load('idx2GMMsoil.mat')

idxm=idx;
idxm(idx==4) = 1;
idxm(idx==1) = 4;
idx=idxm;

%% PCA
x=X(:,1);
y=X(:,2);
z=X(:,3);



%% No.4 VISUALIZATION --> 3D - PCA

% Transform Coefficients % Transform the coefficients so that they are orthonormal.
coefforth = diag(std(CLIM))\wcoeff;
% biplot(coefforth(:,1:3),'Scores',score(:,1:3),'Varlabels',categories)
% axis([-.26 0.8 -.51 .51 -.61 .81])
subplot(1,3,1)
hold on, plot3(x(idx==1),y(idx==1),z(idx==1), '.', 'MarkerSize', 15,'Color',[0.5, 0, 1] )    % draw the scatter plot
hold on, plot3(x(idx==2),y(idx==2),z(idx==2), '.', 'MarkerSize', 15,'Color',[0, 1, 1] ) 
hold on, plot3(x(idx==3),y(idx==3),z(idx==3), '.', 'MarkerSize', 15,'Color',[0, 1, 0] ) 
hold on, plot3(x(idx==4),y(idx==4),z(idx==4), '.', 'MarkerSize', 15,'Color',[0, 0, 0] ) 
view(-31,14), grid on
xlabel('First Principal Component');
ylabel('Second Principal Component');
zlabel('Third Principal Component');
hold on, biplot(coefforth(:,1:3).*10,'Varlabels',categories1)
l = legend('CLIMATE1', 'CLIMATE2', 'CLIMATE3', 'CLIMATE4');
title(strcat('Explained Variance:', EV  ,'%'))
% MAPA
idxM = reshape(idx,506,[]);
idxM =  mode(idxM')';         % Frecuency
subplot(1,3,3)
plot(LON((idxM==1)),  LAT((idxM==1)), '.','MarkerSize', 15,'Color', [0.5, 0, 1])
hold on, plot(LON((idxM==2)), LAT((idxM==2)), '.', 'MarkerSize', 15,'Color', [0, 1, 1] )
hold on, plot(LON((idxM==3)), LAT((idxM==3)), '.', 'MarkerSize', 15,'Color', [0, 1, 0] )
hold on, plot(LON((idxM==4)), LAT((idxM==4)), '.', 'MarkerSize', 15,'Color', [0, 0, 0] )
grid on
xlabel('LON');
ylabel('LAT'); ylim([11 16]);
%% DESCRIOPTION OF EACH CLUSTER

subplot(1,3,2)
SOIL2 = (CLIM); %normalize
[val idxx] = sort(std(SOIL2(:,:))); idxx = flip(idxx);
% Initialize data points
D2 = mean(CLIMi((idx==1),:));
D1 = mean(CLIMi((idx==2),:));
D3 = mean(CLIMi((idx==3),:));
D4 = mean(CLIMi((idx==4),:));
P = [D1; D2; D3; D4];

spider_plot(P,...
    'AxesWebType', 'circular',...
    'AxesLabels', categories1,...
    'FillOption', 'on',...
    'FillTransparency', 0.2,...
    'Color', [ 0,1,1; 0.5,0,1; 0,1,0; 0,0,0],...
    'FillCData', D1);

f2.Position = [19.4    333.0    1516.8    420.0];
l.Position = [0.0985    0.9010    0.0563    0.0869];
end