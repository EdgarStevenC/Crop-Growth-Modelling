function [SLLL, SDUL, SSAT, SSKS,soilTexture] = HYDRAULICDSSAT(S, C, OC)
% S = SOIL1T.sand;  % SAND(0.X --> OK)         %SILT = SOILFET(:,5);
% C = SOIL1T.clay;  % CLAY(0.X --> OK)
% OC = SOIL1T.OrganicCarbon;  % OM 
OM = OC.*1.72;
T15t = -0.024.*S + 0.487.*C + 0.006.*OM + 0.005.*S.*OM - 0.013.*C.*OM + 0.068.*S.*C + 0.031;
T15 = T15t + 0.14.*T15t - 0.02;
SLLL = T15; % WP

T33t = -0.251.*S + 0.195.*C + 0.011.*OM + 0.006.*S.*OM - 0.027.*C.*OM + 0.425.*S.*C + 0.299;
T33 = T33t + 1.283.*(T33t.^2) - 0.374.*T33t - 0.015;
SDUL = T33; % FC

Ts33t = 0.278.*S + 0.034.*C + 0.022.*OM - 0.018.*S.*OM - 0.027.*C.*OM - 0.584.*S.*C + 0.078;
Ts33 = Ts33t + 0.636.*Ts33t - 0.107;
SSAT = T33 + Ts33 - 0.097.*S + 0.043; % SAT

sand = S*100;
clay = C*100;
silt = 100-(sand+clay);
for i = 1 : numel(sand)
    [soilTexture(i,1), SLLLb, SDULb, SSATb, SSKS(i,1) ] = SOILtype(sand(i), silt(i), clay(i));
end


end