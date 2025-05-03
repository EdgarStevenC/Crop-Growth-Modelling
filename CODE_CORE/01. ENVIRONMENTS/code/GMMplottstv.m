function [clusterX, C] = GMMplottstv(X, k)
%% ***************************************************************************************************************
%% GAUSSINAN PARAMETRIZATION
    options = statset('MaxIter',10000);
    Sigma = {'diagonal'}; % Options for covariance matrix type       full
    SharedCovariance = {true}; % Indicator for identical or nonidentical covariance matrices
    
%   gmfit = fitgmdist(X,k,'CovarianceType',Sigma{1},'SharedCovariance',SharedCovariance{1},'Options',options); % Fitted GMM
    gmfit = fitgmdist(X,k); % Fitted GMM
    C = gmfit.mu;
    clusterX = cluster(gmfit,X); % Cluster index 

%% ***************************************************************************************************************
%% GAUSSINAN PARAMETRIZATION
%% 2 DataSet Feature Space
     for j = 1 : k
        subplot(2,1,1)
        scatter3(X(clusterX==j,1), X(clusterX==j,2), X(clusterX==j,3), 15 , 'filled'); hold on    % draw the scatter plot
        %% 2 3D gaussians - deformada
        set(plot_gaussian_ellipsoid(gmfit.mu(j,:),[gmfit.Sigma(:,:,j)]),'FaceColor','b','EdgeColor','k','FaceAlpha',.2); hold on
        % legend("Cluster 1","Cluster 2","Cluster 3")
    end
    
    xlabel(' PC1'); ylabel('PC2'); zlabel('PC3'); f1.Position = [129.0    92.3    1490.7    850.7 ]; view(-40,20)   %53.8000 336.2000 953.6000 419.2000
    title('GMM Cluster') 

     

end