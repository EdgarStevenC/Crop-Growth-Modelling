%% ========================================================================
%  HELPER FUNCTION: Calculate correlation significance
%  ========================================================================
function sig_text = calc_significance(X, Y)
% CALC_SIGNIFICANCE Calculate R² with significance asterisks
%
% INPUT:
%   X, Y - Vectors to correlate
%
% OUTPUT:
%   sig_text - String with R² and significance level
%              *** p < 0.001
%              **  p < 0.01
%              *   p < 0.05
%              (no asterisk) p >= 0.05

    % Remove NaN values
    valid = ~isnan(X) & ~isnan(Y);
    X = X(valid);
    Y = Y(valid);
    
    if length(X) < 3
        sig_text = 'R²=NA';
        return;
    end
    
    % Calculate Pearson correlation
    [R, P] = corr(X, Y, 'Type', 'Pearson');
    R2 = R^2;
    
    % Format with significance stars
    if P < 0.001
        sig_text = sprintf('R²=%.2f***', R2);
    elseif P < 0.01
        sig_text = sprintf('R²=%.2f**', R2);
    elseif P < 0.05
        sig_text = sprintf('R²=%.2f*', R2);
    else
        sig_text = sprintf('R²=%.2f', R2);
    end
end
