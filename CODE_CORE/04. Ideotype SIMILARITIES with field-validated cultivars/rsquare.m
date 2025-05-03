function R2 = rsquare(y_true, y_pred)
    % Calculate R^2: Coefficient of determination
    SS_tot = sum((y_true - mean(y_true)).^2);  % Total sum of squares
    SS_res = sum((y_true - y_pred).^2);  % Residual sum of squares
    R2 = 1 - (SS_res / SS_tot);  % R^2 formula
end