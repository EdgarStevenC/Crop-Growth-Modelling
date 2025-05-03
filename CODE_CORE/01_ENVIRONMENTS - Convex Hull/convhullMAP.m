function [idxClosestToCentroid] = convhullMAP(lon, lat, lonT, latT)
% Compute the convex hull
K = convhull(lon, lat);
lonH = lon(K);
latH = lat(K);

% Compute the area of the polygon in hectares using areaint (Mapping Toolbox)
earthRadius = 6371; % Radius of Earth in km
A_km2 = areaint(latH, lonH, earthRadius); % Area in km²
A_hectares = A_km2 * 100; % Convert from km² to hectares

% Compute the geographic centroid (mean of coordinates)
[latC, lonC] = meanm(latH, lonH);


%% Distances
% Calculate the Euclidean distance between the centroid and each point
distances = sqrt((lonT - lonC).^2 + (latT - latC).^2);

% Find the index of the closest point to the centroid
[~, idxClosestToCentroid] = min(distances);

% Find the point from the list lon, lat that is closest to the centroid
closestPointLat = latT(idxClosestToCentroid);
closestPointLon = lonT(idxClosestToCentroid);

% % Display the closest point coordinates
% fprintf('The closest point to the centroid is at:\n');
% fprintf('Latitude: %.4f, Longitude: %.4f\n', closestPointLat, closestPointLon);

% Plot the points and convex hull
% hold on;
% plot(lon, lat, 50, 'b', 'filled', 'DisplayName', 'Points'); % Original points    geoscatter
hold on;
plot( lonC, latC, '*k', 'LineWidth', 1, 'DisplayName', 'Centroid'); % Centroid
plot( lonH, latH,'Color', [0.5, 0.5, 0.5], 'LineWidth', 2, 'DisplayName', 'Convex Polygon'); % Polygon with gray line


% Labels and title
title(sprintf('Convex Hull (Area: %.2f hectares)', A_hectares));
 xlabel('Lon'), ylabel('Lat');
grid on;
hold off;

end