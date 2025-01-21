function [X1, Y1, Z1,R1] = CoordXY (Z1,R1,F1,F2)
% F =  1/2;    % 209/3601; %
[Z1,R1] = georesize(Z1,R1,F1,F2,'nearest');
del1 = (R1.LongitudeLimits(2) - R1.LongitudeLimits(1) )/ (size(Z1,1)-1) ;
X1 = [R1.LongitudeLimits(1):del1: R1.LongitudeLimits(2)];
Y1 = flip([R1.LatitudeLimits(1):del1: R1.LatitudeLimits(2)]');
end