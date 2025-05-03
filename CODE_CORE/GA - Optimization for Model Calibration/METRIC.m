function [MAE, RMSE, y_mean, NRMSE, R2] = METRIC(y_obs, y_pred)
%% R2
y_mean = mean(y_obs);           % Calcular la media de los valores observados
SSR = sum((y_obs - y_pred).^2); % Calcular la suma de los cuadrados de los residuos (SSR)
SST = sum((y_obs - y_mean).^2); % Calcular la suma total de los cuadrados (SST)
R2 = 1 - (SSR / SST);           % Calcular R^2
%% MAE
MAE = mean(abs(y_obs - y_pred));
%% RMSE
RMSE = rmse(y_obs, y_pred);
%% NRMSE
NRMSE = rmse(y_obs, y_pred) / y_mean;
end