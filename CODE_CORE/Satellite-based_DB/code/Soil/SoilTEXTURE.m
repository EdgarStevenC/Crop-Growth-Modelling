function [] = SoilTEXTURE(X, Y, Z, Z2,feature,Region)
scale = size(Z,1) / size(Z2,1); 
Cx = size(Z,1);
Cy = size(Z,2);
Z2 = imresize(Z2,[Cx Cy]);  % Z2 = imresize( Z2 , scale );
MM = min(min(Z2));
Z2 = Z2-MM ; Z2=Z2.*(255/max(max(Z2))); Z2=Z2+1;
%% ENTROPY - Point Cloud
% figure
Xpc = reshape(X,[],1);
Ypc = reshape(Y,[],1);
Zpc = reshape(Z,[],1);       % Zpc = Zpc*100;

    Senegal = shaperead('SEN2.shp');  load('SenegalR.mat'); 
    R=[15, 11 , 7, 4, 13, 6, 5, 3];
    % % for i=1:7
        i = Region;
        polig = Senegal(R(i));
        polX=polig.X; polY=polig.Y;
        in = inpolygon(Xpc,Ypc,polX,polY)                           %% ,  save('regid8.mat', 'in')
        % plot( polig.X, polig.Y, 'k-', 'LineWidth', 1), hold on
    % % end, xlabel("Longitude"), ylabel("Latitude"), grid on

if Region==1, load('regid1.mat'), end
if Region==2, load('regid2.mat'), end
if Region==3, load('regid3.mat'), end
if Region==4, load('regid4.mat'), end
if Region==5, load('regid5.mat'), end
if Region==6, load('regid6.mat'), end
if Region==7, load('regid7.mat'), end
if Region==8, load('regid8.mat'), end

  xyzPoints = [Xpc(in), Ypc(in), Zpc(in) ];  % xyzPoints = [X, Y, Z ];  %
% ptCloud = pointCloud(xyzPoints);
% 
% pcshow(ptCloud), colormap("turbo")
% colorbar
% xlabel("Long"),  %title("Terrain")
% ylabel("Lat")
% zlabel("Elev")
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
ptCloud = pointCloud(xyzPoints);



CUVpc = reshape(Z2,[],1);
CUVpc = round(CUVpc* (255/max(CUVpc)));
CUVpc = CUVpc(in);

C = colormap('jet');
B = C(CUVpc+1,:); % [ CUVpc, CUVpc, CUVpc ];  

ptCloud.Color =  B ;

pcshow(ptCloud), colorbar
xlabel("Long"), ylabel("Lat"), zlabel("Elev")   %title("Terrain")

hBar1 = contourcbar; ylabel(hBar1, strcat(feature,'(g/kg)'),'FontSize',12, 'Color','w');

end