function [] = showSOIL(FETpc1, N)
%% GEOMETRY
xyzPoints = [FETpc1(:,1), FETpc1(:,2), FETpc1(:,3)]; 
%% COLOR
Z2 = FETpc1(:,N);
MM = min(min(Z2));
Z2 = Z2-MM ; Z2=Z2.*(255/max(max(Z2))); CUVpc = round(Z2+1);
%%

ptCloud = pointCloud(xyzPoints);

C = colormap('jet');
B = C(CUVpc,:); % [ CUVpc, CUVpc, CUVpc ];  

ptCloud.Color =  B ;

pcshow(ptCloud), colorbar
xlabel("Long"), ylabel("Lat"), zlabel("Elev")   %title("Terrain")

% hBar1 = contourcbar; ylabel(hBar1, strcat(feature,'(g/kg)'),'FontSize',12, 'Color','w');

end