function [clusterX] = CLUSTERstvGMM(X, NC)
%% GMM - CLUSTER
 e1 = evalclusters(X,"gmdistribution","silhouette","KList",1:NC)

for k = 1 : NC
    subplot(2,1,1)
    f1 = figure;
    [clusterX, Mean] = GMMplottstv(X, k);
    %% GMM - Number clusters
    subplot(2,1,2)
    plot(e1.CriterionValues(1:k), "bo--"), grid on,  ylabel('Silhouette Score');
    xlabel('Number of Cluster');  title('Evaluation of cohesion and separation of clusters'), legend('Silhouette Score'),  
    f1.Position = [129.0000   92.3000  798.6667  850.7000];  
    saveas(gcf,strcat('GMMclim/',num2str(k),'.png'))
    saveas(gcf,strcat('GMMclim/fig/',num2str(k),'.fig'))
    pause(0.6), k
end
   

%% *******************************************************************************
%% CLUSTER
OPTIMcluster = sum((e1.CriterionValues == max(e1.CriterionValues)).*([1:1:NC]))

%% GAUSSINAN PARAMETRIZATION
    options = statset('MaxIter',10000);
    Sigma = {'diagonal'}; % Options for covariance matrix type       full
    SharedCovariance = {true}; % Indicator for identical or nonidentical covariance matrices
    
%   gmfit = fitgmdist(X,k,'CovarianceType',Sigma{1},'SharedCovariance',SharedCovariance{1},'Options',options); % Fitted GMM
    gmfit = fitgmdist(X,OPTIMcluster); % Fitted GMM
    C = gmfit.mu;
    clusterX = cluster(gmfit,X); % Cluster index 


% view(129,36); set(gca,'proj','perspective'); grid on; 


end