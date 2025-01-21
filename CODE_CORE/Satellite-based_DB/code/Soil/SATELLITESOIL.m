function [SOL] = SATELLITESOIL(m)


    % Senegal = shaperead('SEN2.shp');  load('SenegalR.mat'); 
    % R=[15, 11 , 7, 4, 13, 6, 5, 3];
    % for i=1:7
    %     polig = Senegal(R(i));
    %     polX=polig.X; polY=polig.Y;
    %     plot( polig.X, polig.Y, 'k-', 'LineWidth', 1), hold on
    % end, xlabel("Longitude"), ylabel("Latitude"), grid on


% % % %% NUEVA ETAPA - SATELLITE DATA ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% % % %% "DEM ORIGIN" + Stage1 :"Resize"
% % % % % DEM1 = GRIDobj('N1.tif'); [Z1,X1,Y1] = GRIDobj2mat(DEM1); Z1(Z1<0) = 0;  
% % % F = 1/2;
% % % [Z1,R1] = readgeoraster('DEM/N1.tif');  [X1, Y1, Z1, R1] = CoordXY (Z1,R1,F,F);
% % % [Z2,R2] = readgeoraster('DEM/N2.tif');  [X2, Y2, Z2, R2] = CoordXY (Z2,R2,F,F);  
% % % [Z3,R3] = readgeoraster('DEM/N3.tif');  [X3, Y3, Z3, R3] = CoordXY (Z3,R3,F,F);  
% % % [Z4,R4] = readgeoraster('DEM/N4.tif');  [X4, Y4, Z4, R4] = CoordXY (Z4,R4,F,F);  
% % % [Z5,R5] = readgeoraster('DEM/N5.tif');  [X5, Y5, Z5, R5] = CoordXY (Z5,R5,F,F);  
% % % [Z6,R6] = readgeoraster('DEM/N6.tif');  [X6, Y6, Z6, R6] = CoordXY (Z6,R6,F,F);  
% % % % Secund line
% % % [Z12,R12] = readgeoraster('DEM/N12.tif');  [X12, Y12, Z12, R12] = CoordXY (Z12,R12,F,F);  
% % % [Z11,R11] = readgeoraster('DEM/N11.tif');  [X11, Y11, Z11, R11] = CoordXY (Z11,R11,F,F);  
% % % [Z10,R10] = readgeoraster('DEM/N10.tif');  [X10, Y10, Z10, R10] = CoordXY (Z10,R10,F,F); 
% % % [Z9, R9 ] = readgeoraster('DEM/N9.tif');   [X9 , Y9 , Z9 , R9 ] = CoordXY (Z9 ,R9 ,F,F); 
% % % [Z8, R8 ] = readgeoraster('DEM/N8.tif');   [X8 , Y8 , Z8 , R8 ] = CoordXY (Z8 ,R8 ,F,F); 
% % % [Z7, R7 ] = readgeoraster('DEM/N7.tif');   [X7 , Y7 , Z7 , R7 ] = CoordXY (Z7 ,R7 ,F,F); 
% % % % three line
% % % [Z13,R13] = readgeoraster('DEM/N13.tif');  [X13, Y13, Z13, R13] = CoordXY (Z13,R13,F,F);  
% % % [Z14,R14] = readgeoraster('DEM/N14.tif');  [X14, Y14, Z14, R14] = CoordXY (Z14,R14,F,F); 
% % % [Z15,R15] = readgeoraster('DEM/N15.tif');  [X15, Y15, Z15, R15] = CoordXY (Z15,R15,F,F); 
% % % [Z16,R16] = readgeoraster('DEM/N16.tif');  [X16, Y16, Z16, R16] = CoordXY (Z16,R16,F,F); 
% % % [Z17,R17] = readgeoraster('DEM/N17.tif');  [X17, Y17, Z17, R17] = CoordXY (Z17,R17,F,F); 
% % % [Z18,R18] = readgeoraster('DEM/N18.tif');  [X18, Y18, Z18, R18] = CoordXY (Z18,R18,F,F); 
% % % % % tanakacontour(DEM1,5);       % saveas(gcf,'NN1.tif')
% % % %% PREPROCESSING ( Stage1.1:"(<0)(/100)" + Stage2:"Filter")  
% % % ZZ = {Z1; Z2; Z3; Z4; Z5; Z6; Z7; Z8; Z9; Z10; Z11; Z12; Z13; Z14; Z15; Z16; Z17; Z18};
% % % XX = {X1; X2; X3; X4; X5; X6; X7; X8; X9; X10; X11; X12; X13; X14; X15; X16; X17; X18};
% % % YY = {Y1; Y2; Y3; Y4; Y5; Y6; Y7; Y8; Y9; Y10; Y11; Y12; Y13; Y14; Y15; Y16; Y17; Y18};
% % % DEM={}; ENT={};

    F = 0.3;
    [Z1,R1] = readgeoraster('DEM/N1.tif');  [X1, Y1, Z1, R1] = CoordXY (Z1,R1,F,F);
    Z = Z1;  %Z=II(:,:,3);
    
feature = {'sand'; 'silt'; 'clay'; 'BULK'; 'COARSE'; 'OrganicCarbon';"N";"PH" }; %% 'BULK', 'COARSE', 'OrganicCarbon'
for i = 1 : 18
    % % % Z=ZZ{i};  X=XX{i};  Y=YY{i};
    % % % %% Preprocesing
    % % % Z = double(Z);                  % Discard valleys
    % % % Z(Z<0)=0 ; Z = Z/100;           % Z(Z>100)=100 ;
    % % % h = ones(5,5)/25;
    % % % % Z2m = imfilter(Z,h);
    % % % 
    % % % XpR = repmat(X,[numel(Y), 1]);  YpR = repmat(Y,[1, numel(X)]); 
    % % % 
    % % % X0 = [1:1:numel(X)]; Y0 = [1:1:numel(Y)]'; 
    % % % Xp = repmat(X0,[numel(Y0), 1]);  Yp = repmat(Y0,[1, numel(X0)]); 
    % % % 
    % % % II(:,:,1)=XpR; II(:,:,2)=YpR; II(:,:,3)=Z; DEM{i}=II;

    %% 1er --> Soil texture
    %% [X,Y,Z,ENTR] + SOIL TEXTURE

        for k= 1 : 4        % FEATURE    --> 6
            for l= 1 : 6    % DEEP       --> 6
                Depth = l;
               
                [SZ1,SR1] = readgeoraster( strcat('SOIL/',feature{k},'/',num2str(Depth),'/out',num2str(i),'.tif') );
                F1 = size(Z,1)/SR1.RasterSize(1); F2 = size(Z,2)/SR1.RasterSize(2)+0.001;
                [SX1, SY1, SZ1, SR1] = CoordXY (SZ1,SR1,F1, F2);  SZ1 = double(SZ1);
                % SoilTEXTURE(X, Y, Z/10, SZ1,feature{k},Depth)
                if k == 1, II2(:,:,l)   = SZ1; end
                if k == 2, II2(:,:,6+l) = SZ1; end
                if k == 3, II2(:,:,12+l)= SZ1; end
                if k == 4, II2(:,:,18+l)= SZ1; end
                if k == 5, II2(:,:,24+l)= SZ1; end

                % if k == 6, II2(:,:,l)   = SZ1; end
                % if k == 7, II2(:,:,6+l) = SZ1; end
                % if k == 8, II2(:,:,12+l)= SZ1; end
            end
        end
        SOL{i}=II2;
        i
end
 
if m==1; end

end