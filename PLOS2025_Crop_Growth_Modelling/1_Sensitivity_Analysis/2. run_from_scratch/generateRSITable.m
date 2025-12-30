function T = generateRSITable(STATS)
% generateRSITable creates a sorted table of RSI values and parameter names.
% Input:
%   - STATS: a matrix where the 3rd row contains RSI values (0 to 1)
% Output:
%   - T: a table with parameters and their corresponding RSI values, sorted from highest to lowest
%%
    % Extract the RSI vector from the third row
    RSI = STATS(3,:);
    
    % Define the list of parameter names
    NameList = {'P1', 'P2O', 'P2R', 'P5', 'G1', 'G2', 'G3', 'PHINT', 'THOT', 'TCLDP', 'TCLDF'};
    
    % Step 1: Sort RSI values from highest to lowest
    [~, idxOrder] = sort(RSI, 'descend');
    
    % Step 2: Reorder RSI and NameList according to the sorting
    RSI_sorted = RSI(idxOrder);
    NameList_sorted = NameList(idxOrder);
    
    % Step 3: Create a table with the sorted names and RSI values
    T = table(NameList_sorted', RSI_sorted', 'VariableNames', {'Parameter', 'RSI'});
end
