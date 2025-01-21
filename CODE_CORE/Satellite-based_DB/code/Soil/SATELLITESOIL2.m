function [SOL] = SATELLITESOIL2(m)


 % Senegal = shaperead('SEN2.shp');  load('SenegalR.mat'); 
 %    R=[15, 11 , 7, 4, 13, 6, 5, 3];
 %    for i=1:7
 %        polig = Senegal(R(i));
 %        polX=polig.X; polY=polig.Y;
 %        plot( polig.X, polig.Y, 'k-', 'LineWidth', 1), hold on
 %    end, xlabel("Longitude"), ylabel("Latitude"), grid on

    F = 0.3;
    [Z1,R1] = readgeoraster('DEM/N1.tif');  [X1, Y1, Z1, R1] = CoordXY (Z1,R1,F,F);
    Z = Z1;  %Z=II(:,:,3);

for i = 1 : 18
    %% 1er --> Soil texture
    %% [X,Y,Z,ENTR] + SOIL TEXTURE
        for k= 5 : 8        % FEATURE    --> 6
            for l= 1 : 6    % DEEP       --> 6
                Depth = l;
                feature = {'sand'; 'silt'; 'clay'; 'BULK'; 'COARSE'; 'OrganicCarbon';"N";"PH" }; %% 'BULK', 'COARSE', 'OrganicCarbon'
                [SZ1,SR1] = readgeoraster( strcat('SOIL/',feature{k},'/',num2str(Depth),'/out',num2str(i),'.tif') );
                F1 = size(Z,1)/SR1.RasterSize(1); F2 = size(Z,2)/SR1.RasterSize(2)+0.001;
                [SX1, SY1, SZ1, SR1] = CoordXY (SZ1,SR1,F1, F2);  SZ1 = double(SZ1);
                % SoilTEXTURE(X, Y, Z/10, SZ1,feature{k},Depth)

                if k == 5, II2(:,:,l)   = SZ1; end
                if k == 6, II2(:,:,6+l) = SZ1; end
                if k == 7, II2(:,:,12+l)= SZ1; end
                if k == 8, II2(:,:,18+l)= SZ1; end
            end
        end
        SOL{i}=II2;
        i
end

if m==1; end

end
