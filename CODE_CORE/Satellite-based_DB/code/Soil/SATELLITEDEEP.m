function [] = SATELLITEDEEP(I1,S1,S12,  I2,S2,S22,  I4,S4,S42,  I5,S5,S52,  I6,S6,S62,  I7,S7,S72,  I8,S8,S82 , DEEP)

%% REGION 1
if DEEP==1,  FF = [2 8  14 20]; end % Deep --> 2--> 5cm-15cm
if DEEP==2,  FF = [4 10 16 22]; end % Deep --> 4--> 30cm-60cm
if DEEP==3,  FF = [5 11 17 23]; end % Deep --> 5--> 60cm-100cm 

FET=I1;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
FETpc = [];
% FF = [2 8 14 20]; % Deep --> 5-15cm       //  FF = [2 8 14 20]; % Deep --> 5-15cm 
for i = 1 : numel(FF)
    Zc = S1(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,1);
    FETpc = [FETpc, FET];
end
for i = 1 : numel(FF)
    Zc = S12(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,1);
    FETpc = [FETpc, FET];
end

FETpc1 = [Xpc, Ypc, Zpc, FETpc];
REG1 = array2table(FETpc1,'VariableNames',{'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}), 
if DEEP==1,  save('REG1-1.mat', 'FETpc1', 'REG1'), end
if DEEP==2,  save('REG1-2.mat', 'FETpc1', 'REG1'), end
if DEEP==3,  save('REG1-3.mat', 'FETpc1', 'REG1'), end

load('REG1-1.mat')
showSOIL(FETpc1, 3+6)   % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
%% REGION 2
FET=I1;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
FETpc = [];
% FF = [2 8 14 20]; % Deep --> 5-15cm       //  FF = [2 8 14 20]; % Deep --> 5-15cm 
for i = 1 : numel(FF)
    Zc = S1(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,2);
    FETpc = [FETpc, FET];
end
for i = 1 : numel(FF)
    Zc = S12(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,2);
    FETpc = [FETpc, FET];
end

FETpc2 = [Xpc, Ypc, Zpc, FETpc];
REG2 = array2table(FETpc2,'VariableNames',{'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}), 
if DEEP==1,  save('REG2-1.mat', 'FETpc2', 'REG2'), end 
if DEEP==2,  save('REG2-2.mat', 'FETpc2', 'REG2'), end 
if DEEP==3,  save('REG2-3.mat', 'FETpc2', 'REG2'), end 

load('REG2-1.mat')
% % showSOIL(FETpc2, 3+6)    % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
%% REGION 3
FET=I2;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
FETpc = [];
% FF = [2 8 14 20]; % Deep --> 5-15cm       //  FF = [2 8 14 20]; % Deep --> 5-15cm 
for i = 1 : numel(FF)
    Zc = S2(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,3);
    FETpc = [FETpc, FET];
end
for i = 1 : numel(FF)
    Zc = S22(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,3);
    FETpc = [FETpc, FET];
end

FETpc3 = [Xpc, Ypc, Zpc, FETpc];
REG3 = array2table(FETpc3,'VariableNames',{'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}), 
if DEEP==1,  save('REG3-1.mat', 'FETpc3', 'REG3'), end
if DEEP==2,  save('REG3-2.mat', 'FETpc3', 'REG3'), end
if DEEP==3,  save('REG3-3.mat', 'FETpc3', 'REG3'), end

load('REG3-1.mat')
% % showSOIL(FETpc3, 3+6)    % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
%% REGION 4
FET=I4;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
FETpc = [];
% FF = [2 8 14 20]; % Deep --> 5-15cm       //  FF = [2 8 14 20]; % Deep --> 5-15cm 
for i = 1 : numel(FF)
    Zc = S4(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,4);
    FETpc = [FETpc, FET];
end
for i = 1 : numel(FF)
    Zc = S42(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,4);
    FETpc = [FETpc, FET];
end

FETpc4 = [Xpc, Ypc, Zpc, FETpc];
REG4 = array2table(FETpc4,'VariableNames',{'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}), 
if DEEP==1,  save('REG4-1.mat', 'FETpc4', 'REG4'), end 
if DEEP==2,  save('REG4-2.mat', 'FETpc4', 'REG4'), end 
if DEEP==3,  save('REG4-3.mat', 'FETpc4', 'REG4'), end 

load('REG4-1.mat')
% % showSOIL(FETpc4, 3+6)    % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
%% REGION 5
FET=I5;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
FETpc = [];
% FF = [2 8 14 20]; % Deep --> 5-15cm       //  FF = [2 8 14 20]; % Deep --> 5-15cm 
for i = 1 : numel(FF)
    Zc = S5(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,5);
    FETpc = [FETpc, FET];
end
for i = 1 : numel(FF)
    Zc = S52(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,5);
    FETpc = [FETpc, FET];
end

FETpc5 = [Xpc, Ypc, Zpc, FETpc];
REG5 = array2table(FETpc5,'VariableNames',{'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}), 
if DEEP==1,  save('REG5-1.mat', 'FETpc5'), end
if DEEP==2,  save('REG5-2.mat', 'FETpc5'), end
if DEEP==3,  save('REG5-3.mat', 'FETpc5'), end
load('REG5-1.mat')
% % showSOIL(FETpc5, 3+6)    % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
%% REGION 6
FET=I6;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
FETpc = [];
% FF = [2 8 14 20]; % Deep --> 5-15cm       //  FF = [2 8 14 20]; % Deep --> 5-15cm 
for i = 1 : numel(FF)
    Zc = S6(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,6);
    FETpc = [FETpc, FET];
end
for i = 1 : numel(FF)
    Zc = S62(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,6);
    FETpc = [FETpc, FET];
end

FETpc6 = [Xpc, Ypc, Zpc, FETpc];
REG6 = array2table(FETpc6,'VariableNames',{'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}), 
if DEEP==1,  save('REG6-1.mat', 'FETpc6'), end 
if DEEP==2,  save('REG6-2.mat', 'FETpc6'), end 
if DEEP==3,  save('REG6-3.mat', 'FETpc6'), end 
load('REG6-1.mat')
% % showSOIL(FETpc6, 3+6)    % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
%% REGION 7
FET=I7;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
FETpc = [];
% FF = [2 8 14 20]; % Deep --> 5-15cm       //  FF = [2 8 14 20]; % Deep --> 5-15cm 
for i = 1 : numel(FF)
    Zc = S7(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,7);
    FETpc = [FETpc, FET];
end
for i = 1 : numel(FF)
    Zc = S72(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,7);
    FETpc = [FETpc, FET];
end

FETpc7 = [Xpc, Ypc, Zpc, FETpc];
REG7 = array2table(FETpc7,'VariableNames',{'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}), 
if DEEP==1,  save('REG7-1.mat', 'FETpc7'), end
if DEEP==2,  save('REG7-2.mat', 'FETpc7'), end
if DEEP==3,  save('REG7-3.mat', 'FETpc7'), end
load('REG7-1.mat')
% % showSOIL(FETpc7, 3+6)    % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
%% REGION 8
FET=I8;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
FETpc = [];
% FF = [2 8 14 20]; % Deep --> 5-15cm       //  FF = [2 8 14 20]; % Deep --> 5-15cm 
for i = 1 : numel(FF)
    Zc = S8(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,8);
    FETpc = [FETpc, FET];
end
for i = 1 : numel(FF)
    Zc = S82(:,:,FF(i));
    [Xpc, Ypc, Zpc, FET] = SoilTEXTURE2(X, Y, Z./10, Zc,8);
    FETpc = [FETpc, FET];
end

FETpc8 = [Xpc, Ypc, Zpc, FETpc];
REG8 = array2table(FETpc8,'VariableNames',{'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}), 
if DEEP==1,  save('REG8-1.mat', 'FETpc8'), end
if DEEP==2,  save('REG8-2.mat', 'FETpc8'), end
if DEEP==3,  save('REG8-3.mat', 'FETpc8'), end
load('REG8-1.mat')
% % showSOIL(FETpc8, 3+6)    % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'

OUT = strcat('DEEP-', num2str(DEEP), '-OK')
end