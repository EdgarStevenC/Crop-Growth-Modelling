function [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z, Z2,Region)
    Cx = size(Z,1);
    Cy = size(Z,2);
    Z2 = imresize(Z2,[Cx Cy]);  % Z2 = imresize( Z2 , scale );
    %% ENTROPY - Point Cloud
    Xpc = reshape(X,[],1);
    Ypc = reshape(Y,[],1);
    Zpc = reshape(Z,[],1);       % Zpc = Zpc*100;
    FET = reshape(Z2,[],1); 
    
    if Region==1, load('regid1.mat'), end
    if Region==2, load('regid2.mat'), end
    if Region==3, load('regid3.mat'), end
    if Region==4, load('regid4.mat'), end
    if Region==5, load('regid5.mat'), end
    if Region==6, load('regid6.mat'), end
    if Region==7, load('regid7.mat'), end
    if Region==8, load('regid8.mat'), end
    
    Xpc = Xpc(in);
    Ypc = Ypc(in);
    Zpc = Zpc(in); 
    FET = FET(in);
end