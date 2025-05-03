function [TT, idx] = Preparing(T)
T2= readtable("FS1R.csv"); % Cleaned DB (REMOVE REPEATED POINTS)
T2 = T2(T.No_DB1, :);
TT = [T2, T]; save('TT.mat', 'TT'), 
[a idx] = sort(TT.No_DB1);
TT = TT(idx, :);%writetable(TT,'TT.csv' );  
end