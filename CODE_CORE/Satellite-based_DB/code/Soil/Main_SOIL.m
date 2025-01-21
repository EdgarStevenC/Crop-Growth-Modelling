clc, clearvars, close all
% % % %% *****
% % % %% Script to read Satelite soil variables "Cover 2012 to 2022" and match - 6 depth levels
% % % %% with wherever input point [LON, LAT]
% % % %% %% SOIL INIT
% % % [DEM] = SATELLITESOILxyz(0);
% % % [SOL] = SATELLITESOIL(0); % 1 para mostrar media y desvuiacion estandar 
% % % [SOL2] = SATELLITESOIL2(0);
% % % %% VISUALIACION INIT (CREATE SUB IMAGES TO XTRACT REGIONS) - ONLY one time to create reg ID per regions  ***************************************************************************************************************************************************************************
% % % %% Region 1 y 2 (Ziguinchor - Sedhiou)
% % % I1 = [ [DEM{12};DEM{1}], [DEM{11};DEM{2}] ];
% % % S1 = [ [SOL{12}; SOL{1} ], [SOL{11}; SOL{2}]  ];
% % % S12= [ [SOL2{12};SOL2{1}], [SOL2{11};SOL2{2}] ];
% % % % % FET=I1;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
% % % % % Zc = S12(:,:,8);
% % % % % SoilTEXTURE(X, Y, Z./10, Zc,'feature',2) % 1 o 2
% % % %% Region 3 (Kolda)
% % % I2 = [ [DEM{11};DEM{2}], [DEM{10};DEM{3}], [DEM{9};DEM{4}]  ];
% % % S2 = [ [SOL{11}; SOL{2} ], [SOL{10}; SOL{3}], [SOL{9}; SOL{4}]  ];
% % % S22= [ [SOL2{11};SOL2{2}], [SOL2{10};SOL2{3}], [SOL2{9};SOL2{4}] ];
% % % % % FET=I2;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
% % % % % Zc = S22(:,:,8);
% % % % % SoilTEXTURE(X, Y, Z./10, Zc,'feature',3)
% % % %% Region 4 (Kedougou)
% % % I4 = [ [DEM{9};DEM{4}], [DEM{8};DEM{5}], [DEM{7};DEM{6}]  ];
% % % S4 = [ [SOL{9}; SOL{4} ], [SOL{8}; SOL{5}], [SOL{7}; SOL{6}]  ];
% % % S42= [ [SOL2{9};SOL2{4}], [SOL2{8};SOL2{5}], [SOL2{7};SOL2{6}] ];
% % % % FET=I4;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
% % % % Zc = S42(:,:,8);
% % % % SoilTEXTURE(X, Y, Z./10, Zc,'feature',4)
% % % %% Region 5 (Tambacunda)
% % % I5 = [ [DEM{16};DEM{10};DEM{3}], [DEM{15};DEM{9};DEM{4}], [DEM{14};DEM{8};DEM{5}], [DEM{13};DEM{7};DEM{6}]  ];
% % % S5 = [ [SOL{16};SOL{10}; SOL{3} ],[SOL{15};SOL{9}; SOL{4} ], [SOL{14};SOL{8}; SOL{5}], [SOL{13};SOL{7}; SOL{6}]  ];
% % % S52= [ [SOL2{16};SOL2{10};SOL2{3}], [SOL2{15};SOL2{9};SOL2{4}], [SOL2{14};SOL2{8};SOL2{5}], [SOL2{13};SOL2{7};SOL2{6}] ];
% % % % FET=I5;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
% % % % Zc = S52(:,:,8);
% % % % SoilTEXTURE(X, Y, Z./10, Zc,'feature',5)
% % % %% Region 6 (Kaolaf)
% % % S6 = [ [SOL{18};SOL{12} ],[SOL{17};SOL{11} ], [SOL{16};SOL{10}]  ];
% % % S62= [ [SOL2{18};SOL2{12}], [SOL2{17};SOL2{11}], [SOL2{16};SOL2{10}]  ];
% % % I6 = [ [DEM{18};DEM{12}], [DEM{17};DEM{11}], [DEM{16};DEM{10}] ];
% % % % FET=I6;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
% % % % Zc = S62(:,:,8);
% % % % SoilTEXTURE(X, Y, Z./10, Zc,'feature',6)
% % % %% Region 7 (Kaffrine)
% % % S7 = [ [SOL{18};SOL{12} ],[SOL{17};SOL{11} ], [SOL{16};SOL{10}]  ];
% % % S72= [ [SOL2{18};SOL2{12}], [SOL2{17};SOL2{11}], [SOL2{16};SOL2{10}]  ];
% % % I7 = [ [DEM{18};DEM{12}], [DEM{17};DEM{11}], [DEM{16};DEM{10}] ];
% % % % FET=I7;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
% % % % Zc = S72(:,:,8);
% % % % SoilTEXTURE(X, Y, Z./10, Zc,'feature',7)
% % % %% Region 8 (Fatick)
% % % S8 = [ [SOL{18};SOL{12} ],[SOL{17};SOL{11} ], [SOL{16};SOL{10}]  ];
% % % S82= [ [SOL2{18};SOL2{12}], [SOL2{17};SOL2{11}], [SOL2{16};SOL2{10}]  ];
% % % I8 = [ [DEM{18};DEM{12}], [DEM{17};DEM{11}], [DEM{16};DEM{10}] ];
% % % % FET=I8;  X=FET(:,:,1); Y=FET(:,:,2); Z=FET(:,:,3);
% % % % Zc = S82(:,:,8);
% % % % SoilTEXTURE(X, Y, Z./10, Zc,'feature',8)
% % % %% EXTRACT-SAVE AND VISUAL OUT ********************************************************************************************************************************************************************************************************
% % %  % Deep1 -->  2--> 5cm-15cm
% % %  % Deep2 -->  4--> 30cm-60cm
% % %  % Deep3 -->  5--> 60cm-100cm
% % % 
% % % % DEEP = 3;  % "ONLY one time"
% % % % SATELLITEDEEP(I1,S1,S12,  I2,S2,S22, I4,S4,S42,  I5,S5,S52,  I6,S6,S62,  I7,S7,S72,  I8,S8,S82 , DEEP)
% % % 

LAYER = 3;

if LAYER == 1
    load('REG1-1.mat'),  % figure, showSOIL(FETpc1, 3+6)   % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
    load('REG2-1.mat'),  % figure, showSOIL(FETpc2, 3+6)   % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
    load('REG3-1.mat'),  % figure, showSOIL(FETpc3, 3+6)   % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
    load('REG4-1.mat'),  %  % % % figure,  showSOIL(FETpc4, 3+6)   % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
    load('REG5-1.mat'),  % figure, showSOIL(FETpc5, 3+6)   % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
    load('REG6-1.mat'),  % figure, showSOIL(FETpc6, 3+6)   % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
    load('REG7-1.mat'),  % figure, showSOIL(FETpc7, 3+6)   % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
    load('REG8-1.mat'),  % figure, showSOIL(FETpc8, 3+6)   % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
    FETpcT = [FETpc1; FETpc2; FETpc3;  FETpc5; FETpc6; FETpc7; FETpc8];
    %figure, showSOIL(FETpcT, 3+6) 
end
 
if LAYER == 2
    load('REG1-2.mat'),  %figure, showSOIL(FETpc1, 3+6)   % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
    load('REG2-2.mat')
    load('REG3-2.mat')
    load('REG4-2.mat')
    load('REG5-2.mat')
    load('REG6-2.mat')
    load('REG7-2.mat')
    load('REG8-2.mat')
    FETpcT = [FETpc1; FETpc2; FETpc3;  FETpc5; FETpc6; FETpc7; FETpc8];
    %figure, showSOIL(FETpcT, 3+6) 
end

if LAYER == 3
    load('REG1-3.mat'),  figure, showSOIL(FETpc1, 3+6)   % 'X','Y','Z','SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'
    load('REG2-3.mat')
    load('REG3-3.mat')
    load('REG4-3.mat')
    load('REG5-3.mat')
    load('REG6-3.mat')
    load('REG7-3.mat')
    load('REG8-3.mat')
    FETpcT = [FETpc1; FETpc2; FETpc3;  FETpc5; FETpc6; FETpc7; FETpc8];
    %figure, showSOIL(FETpcT, 3+6) 
end 
%% ***************************************************************************************************************************************************************************************************************************************
%% Mactch GRID + SATELLITE 1019
GRIDpoints = 1;
if GRIDpoints == 1
    load('GYxy.mat'), LON=GYxy(:,1); LAT=GYxy(:,2);    %  -->  GRID 1019
    TAG=[1:1:numel(LON)]';
else 
    SOLDBai = readtable('FS1R.csv'); % SOLDBai = readtable('FS0.xlsm');     % --> Validacion externa 38
    SOLDBai.TAG =  [1:1:size(SOLDBai,1)]';
    LON=SOLDBai.LON; LAT=SOLDBai.LAT; TAG=SOLDBai.TAG; 
end 

ROND=2; matchT1=[]; matchT2=[]; matchT3=[]; matchT4=[]; matchT5=[];  matchT6=[]; matchT7=[]; matchT8=[];
    Senegal = shaperead('SEN2.shp');  load('SenegalR.mat'); R=[15, 11 , 7, 4, 13, 6, 5, 3];

GR = 1;
%figure, plot(LON, LAT,'*' ); N = num2str(([1:1:1019]'));
%text(LON, LAT,  N);
%%  REGION - 1
i = 1; polig = Senegal(R(i)); polX=polig.X; polY=polig.Y;
    in = inpolygon(LON,LAT,polX,polY);   % figure, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1)
    LO1 = round(LON(in),ROND); LA1 = round(LAT(in),ROND); tag = TAG(in);
    for j = 1 : numel(LO1)
        M1 = (round(FETpc1(:,1),ROND) == LO1(j));
        M2 = (round(FETpc1(:,2),ROND) == LA1(j));
        idx = logical(M1.*M2);
        match = FETpc1(idx,:);
        % matchT1 = [matchT1; mean(match)];
        IDX0 = (sum([match(:, 4:11)]' )' >= 0);
        %if sum(IDX0)> 0
        match0 = match(IDX0,:);
        matchT1 = [matchT1; [mean(match0), tag(j), 1]  ];
        %end
    end
% matchT1 = [matchT1, tag, ones(size(matchT1,1), 1).*1];
figure,
if numel(LO1) > 0 && (GR==1)
    plot(LO1, LA1, 'c*'), hold on,  plot(matchT1(:,1), matchT1(:,2), 'b*'), 
end 
hold on, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1)
%%  REGION - 2
i = 2; polig = Senegal(R(i)); polX=polig.X; polY=polig.Y;
    in = inpolygon(LON,LAT,polX,polY);   % figure, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1)
    LO1 = round(LON(in),ROND); LA1 = round(LAT(in),ROND);  tag = TAG(in);
    for j = 1 : numel(LO1)
        M1 = (round(FETpc2(:,1),ROND) == LO1(j));
        M2 = (round(FETpc2(:,2),ROND) == LA1(j));
        idx = logical(M1.*M2);
        match = FETpc2(idx,:);  
        % matchT2 = [matchT2; mean(match)];   % figure, plot( match(:,1),  match(:,2), '*' ), hold on,  plot(LO1(j), LA1(j), 'r*'), hold on,  plot(matchT2(:,1), matchT2(:,2), 'c*')  
        IDX0 = (sum([match(:, 4:11)]' )' >= 0);
        %if sum(IDX0)> 0
        match0 = match(IDX0,:);
        matchT2 = [matchT2; [mean(match0), tag(j), 2]  ];
        %end
    end
% matchT2 = [matchT2, tag, ones(size(matchT2,1), 1).*2];
if numel(LO1) > 0 && (GR==1)
    hold on, plot(LO1, LA1, 'c*'), hold on,  plot(matchT2(:,1), matchT2(:,2), 'b*'), 
end
hold on, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1) 
%%  REGION - 3
i = 3; polig = Senegal(R(i)); polX=polig.X; polY=polig.Y;
    in = inpolygon(LON,LAT,polX,polY);   % figure, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1)
    LO1 = round(LON(in),ROND); LA1 = round(LAT(in),ROND); tag = TAG(in);
    for j = 1 : numel(LO1)
        M1 = (round(FETpc3(:,1),ROND) == LO1(j));
        M2 = (round(FETpc3(:,2),ROND) == LA1(j));
        idx = logical(M1.*M2);
        match = FETpc3(idx,:);
        % matchT3 = [matchT3; mean(match)];
        IDX0 = (sum([match(:, 4:11)]' )' >= 0);
        if sum(IDX0)> 0
        match0 = match(IDX0,:);
        matchT3 = [matchT3; [mean(match0), tag(j), 3]  ];
        end
    end
% matchT3 = [matchT3, tag, ones(size(matchT3,1), 1).*3];
if numel(LO1) > 0 && (GR==1)
    hold on, plot(LO1, LA1, 'c*'), hold on,  plot(matchT3(:,1), matchT3(:,2), 'b*'), 
end
hold on, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1) 
%%  REGION - 4
i = 4; polig = Senegal(R(i)); polX=polig.X; polY=polig.Y;
    in = inpolygon(LON,LAT,polX,polY);   % figure, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1)
    LO1 = round(LON(in),ROND); LA1 = round(LAT(in),ROND); tag = TAG(in);
    for j = 1 : numel(LO1)
        M1 = (round(FETpc4(:,1),ROND) == LO1(j));
        M2 = (round(FETpc4(:,2),ROND) == LA1(j));
        idx = logical(M1.*M2);
        match = FETpc4(idx,:);
        % matchT4 = [matchT4; mean(match)];
        IDX0 = (sum([match(:, 4:11)]' )' >= 0);
        if sum(IDX0)> 0
        match0 = match(IDX0,:);
        matchT4 = [matchT4; [mean(match0), tag(j), 4]  ];
        end
    end
% matchT4 = [matchT4, tag, ones(size(matchT4,1), 1).*4];
if numel(LO1) > 0 && (GR==1)
    hold on, plot(LO1, LA1, 'c*'), hold on,  plot(matchT4(:,1), matchT4(:,2), 'b*'), 
end
hold on, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1) 
%%  REGION - 5
i = 5; polig = Senegal(R(i)); polX=polig.X; polY=polig.Y;
    in = inpolygon(LON,LAT,polX,polY);   % figure, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1)
    LO1 = round(LON(in),ROND); LA1 = round(LAT(in),ROND); tag = TAG(in);
    for j = 1 : numel(LO1)
        M1 = (round(FETpc5(:,1),ROND) == LO1(j));
        M2 = (round(FETpc5(:,2),ROND) == LA1(j));
        idx = logical(M1.*M2);
        match = FETpc5(idx,:);
        % matchT5 = [matchT5; mean(match)];
        IDX0 = (sum([match(:, 4:11)]' )' >= 0);
        if sum(IDX0)> 0
        match0 = match(IDX0,:);
        matchT5 = [matchT5; [mean(match0), tag(j), 5]  ];
        end
    end
% matchT5 = [matchT5, tag, ones(size(matchT5,1), 1).*5];
if numel(LO1) > 0 && (GR==1)
    hold on, plot(LO1, LA1, 'c*'), hold on,  plot(matchT5(:,1), matchT5(:,2), 'b*'), 
end
hold on, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1)
%%  REGION - 6
i = 6; polig = Senegal(R(i)); polX=polig.X; polY=polig.Y;
    in = inpolygon(LON,LAT,polX,polY);   % figure, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1)
    LO1 = round(LON(in),ROND); LA1 = round(LAT(in),ROND); tag = TAG(in);
    for j = 1 : numel(LO1)
        M1 = (round(FETpc6(:,1),ROND) == LO1(j));
        M2 = (round(FETpc6(:,2),ROND) == LA1(j));
        idx = logical(M1.*M2);
        match = FETpc6(idx,:);
        % matchT6 = [matchT6; mean(match)];
        IDX0 = (sum([match(:, 4:11)]' )' >= 0);
        if sum(IDX0)> 0
        match0 = match(IDX0,:);
        matchT6 = [matchT6; [mean(match0), tag(j), 6]  ];
        end
    end
% matchT6 = [matchT6, tag, ones(size(matchT6,1), 1).*6];
if numel(LO1) > 0 && (GR==1)
    hold on, plot(LO1, LA1, 'c*'), hold on,  plot(matchT6(:,1), matchT6(:,2), 'b*'), 
end
hold on, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1) 
%%  REGION - 7
i = 7; polig = Senegal(R(i)); polX=polig.X; polY=polig.Y;
    in = inpolygon(LON,LAT,polX,polY);   % figure, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1)
    LO1 = round(LON(in),ROND); LA1 = round(LAT(in),ROND); tag = TAG(in);
    for j = 1 : numel(LO1)
        M1 = (round(FETpc7(:,1),ROND) == LO1(j));
        M2 = (round(FETpc7(:,2),ROND) == LA1(j));
        idx = logical(M1.*M2);
        match = FETpc7(idx,:);
        % matchT7 = [matchT7; mean(match)];
        IDX0 = (sum([match(:, 4:11)]' )' >= 0);
        if sum(IDX0)> 0
        match0 = match(IDX0,:);
        matchT7 = [matchT7; [mean(match0), tag(j), 7]  ];
        end
    end
% matchT7 = [matchT7, tag, ones(size(matchT7,1), 1).*7];
if numel(LO1) > 0 && (GR==1)
    hold on, plot(LO1, LA1, 'c*'), hold on,  plot(matchT7(:,1), matchT7(:,2), 'b*'), 
end
hold on, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1)
%%  REGION - 8
i = 8; polig = Senegal(R(i)); polX=polig.X; polY=polig.Y;
    in = inpolygon(LON,LAT,polX,polY);   % figure, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1)
    LO1 = round(LON(in),ROND); LA1 = round(LAT(in),ROND); tag = TAG(in);
    for j = 1 : numel(LO1)
        M1 = (round(FETpc8(:,1),ROND) == LO1(j));
        M2 = (round(FETpc8(:,2),ROND) == LA1(j));
        idx = logical(M1.*M2);
        match = FETpc8(idx,:);
        % matchT8 = [matchT8; mean(match)];
        IDX0 = (sum([match(:, 4:11)]' )' >= 0);
        if sum(IDX0)> 0
        match0 = match(IDX0,:);
        matchT8 = [matchT8; [mean(match0), tag(j), 8]  ];
        end
    end
% matchT8 = [matchT8, tag, ones(size(matchT8,1), 1).*8];
if numel(LO1) > 0 && (GR==1)
    hold on, plot(LO1, LA1, 'c*'), hold on,  plot(matchT8(:,1), matchT8(:,2), 'b*'), 
end
hold on, plot( polig.X, polig.Y, 'k-', 'LineWidth', 1) 


matchT = [matchT1; matchT2; matchT3; matchT4; matchT5; matchT6; matchT7; matchT8]; hold on, plot(matchT(:,1), matchT(:,2), 'ro'), plot(matchT(:,1), matchT(:,2), 'r*')
% matchT1 = matchT;
% 
% %% STEP 1 - FILTER OUTLIERS  --< https://fr.mathworks.com/help/stats/boxplot.html   (Whisker)
% FET = matchT(:, 4);         % SAND
% HIGHlim = 719.03;    % quantile(FET,0.5) + ((std(FET))* 2.7);
% LOWlim = 245.2781;   % quantile(FET,0.5) - ((std(FET))* 2.7);
% idx1 = FET<=HIGHlim; idx2 = FET>=LOWlim;  idxsand = (idx1 .* idx2);
% 
% FET = matchT(:, 5);         % SILT
% HIGHlim = 430.7116;  % quantile(FET,0.5) + ((std(FET))* 2.7);
% LOWlim = 101.8193;   % quantile(FET,0.5) - ((std(FET))* 2.7);
% idx1 = FET<=HIGHlim; idx2 = FET>=LOWlim;  idxsilt = (idx1 .* idx2);
% 
% FET = matchT(:, 6);         % CLAY
% HIGHlim = 348.4837;  % quantile(FET,0.5) + ((std(FET))* 2.7);
% LOWlim = 138.27;     % quantile(FET,0.5) - ((std(FET))* 2.7);
% idx1 = FET<=HIGHlim; idx2 = FET>=LOWlim;  idxclay = (idx1 .* idx2);
% 
% FET = matchT(:, 9);         % OC
% HIGHlim = 227.0385;   % quantile(FET,0.5) + ((std(FET))* 2.7);
% LOWlim = 0.70719;     % quantile(FET,0.5) - ((std(FET))* 2.7);
% idx1 = FET<=HIGHlim; idx2 = FET>=LOWlim;  idxOC = (idx1 .* idx2);
% 
% 
% idx = ([idxsand .* idxsilt .* idxclay .* idxOC ])>0; sum(idx)
% 
% % % matchT = matchT(idx,:);
% hold on, plot(matchT(:,1), matchT(:,2), 'ko'), plot(matchT(:,1), matchT(:,2), 'b*')
% 
% figure, boxplot([matchT(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLEAN'), xlabel('sample')     % ,'Whisker',1
% figure, boxplot([matchT1(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - OUTLIERS'), xlabel('sample')     % ,'Whisker',1

matchT = [matchT(1:906,:);matchT(906,:);matchT(907:end,:)]; % sample 907 is lose
%%  Hydraulic
[T] = SOIL_HYDRAULIC(matchT(:,1:end), LAYER)           
figure, boxplot([T.SLLL,T.SDUL,T.SSAT ],'Notch','on','Labels',{'SLLL','SDUL','SSAT'}  ), grid on, title('SOIL HYDRAULIC FEATURES'), xlabel('sample')     % ,'Whisker',1
%% Cluster
% X = [T.sand, T.silt, T.clay, T.BULK, T.COARSE, T.OrganicCarbon, T.N, T.PH];  % X = [T.sand];
X = [NO(T.sand), NO(T.silt), NO(T.clay), NO(T.BULK), NO(T.COARSE), NO(T.OrganicCarbon), NO(T.N), NO(T.PH)];    % X = [T.sand];
% NC = 3;
% [idxC3,C] = kmeans(X,NC);
% save("idxC3.mat", "idxC3")
load("idxC3.mat")
figure, plot(T.LON(idxC3==1), T.LAT(idxC3==1), 'b*')
hold on, plot(T.LON(idxC3==2), T.LAT(idxC3==2), 'r*')
hold on, plot(T.LON(idxC3==3), T.LAT(idxC3==3), 'k*'), legend('C1', 'C2', 'C3')

% SOIL 1
T1 = matchT(idxC3==1, :);
figure, subplot(1,3,1), boxplot([T1(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLUSTER 1'), xlabel('sample'), ylim([0, 800])  

% SOIL 2
T2 = matchT(idxC3==2, :);
hold on, subplot(1,3,2), boxplot([T2(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLUSTER 2'), xlabel('sample'), ylim([0, 800])  

% SOIL 3
T3 = matchT(idxC3==3, :);
hold on, subplot(1,3,3), boxplot([T3(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLUSTER 3'), xlabel('sample'), ylim([0, 800])  


%% STEP 2 - CREATE 3 DISTRIBUTIONS

FETT= T1(:,4);
Q75 = quantile(FETT,0.75);
Q25 = quantile(FETT,0.25);
T11 =  T1(FETT <= Q25, :);
T12 =  T1(  ( (FETT>Q25).*(FETT<=Q75) )>0  , :);
T13 =  T1(FETT > Q25, :);
figure, subplot(1,3,1),  boxplot([T11(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLUSTER 1.1'), xlabel('sample'), ylim([0, 800])  
hold on, subplot(1,3,2), boxplot([T12(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLUSTER 1.2'), xlabel('sample'), ylim([0, 800])  
hold on, subplot(1,3,3), boxplot([T13(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLUSTER 1.3'), xlabel('sample'), ylim([0, 800])  

FETT= T2(:,4);
Q75 = quantile(FETT,0.75);
Q25 = quantile(FETT,0.25);
T21 =  T2(FETT <= Q25, :);
T22 =  T2(  ( (FETT>Q25).*(FETT<=Q75) )>0  , :);
T23 =  T2(FETT > Q25, :);
figure, subplot(1,3,1),  boxplot([T21(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLUSTER 2.1'), xlabel('sample'), ylim([0, 800])  
hold on, subplot(1,3,2), boxplot([T22(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLUSTER 2.2'), xlabel('sample'), ylim([0, 800])  
hold on, subplot(1,3,3), boxplot([T23(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLUSTER 2.3'), xlabel('sample'), ylim([0, 800])  

FETT= T3(:,4);
Q75 = quantile(FETT,0.75);
Q25 = quantile(FETT,0.25);
T31 =  T3(FETT <= Q25, :);
T32 =  T3(  ( (FETT>Q25).*(FETT<=Q75) )>0  , :);
T33 =  T3(FETT > Q25, :);
figure, subplot(1,3,1),  boxplot([T31(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLUSTER 3.1'), xlabel('sample'), ylim([0, 800])  
hold on, subplot(1,3,2), boxplot([T32(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLUSTER 3.2'), xlabel('sample'), ylim([0, 800])  
hold on, subplot(1,3,3), boxplot([T33(:,4:11)],'Notch','on','Labels',{'SAND','SILT','CLAY', 'BULK', 'COARSE', 'CO', 'N', 'PH'}  ), grid on, title('SOIL FEATURES - CLUSTER 3.3'), xlabel('sample'), ylim([0, 800])  

save('SOILC3 - L2.mat','T1', 'T2', 'T3', 'T11', 'T12', 'T13', 'T21', 'T22', 'T23', 'T31', 'T32', 'T33' )
%% SAVE 
save('matchTT44.mat', 'matchT')
writematrix(matchT,'matchTT44.csv' ); 


load('matchTT44.mat')  % load('matchTTgrid.mat')   % load('matchTTai.mat') % 
[T] = SOIL_HYDRAULIC(matchTT44 (:,1:end)),
writetable(T,'T44.csv')



%%
Tclus = readtable("TgridCEAN-clust.csv"); 
SOIL1 = Tclus((Tclus.clust3Org==1), :);
SOIL2 = Tclus((Tclus.clust3Org==2), :);
SOIL3 = Tclus((Tclus.clust3Org==3), :);

figure, plot(SOIL1.LON, SOIL1.LAT, 'b*'), hold on
        plot(SOIL2.LON, SOIL2.LAT, 'r*'), hold on
        plot(SOIL3.LON, SOIL3.LAT, 'k*'), grid on

SOIL1T = mean(SOIL1(:,1:13));
SOIL2T = mean(SOIL2(:,1:13));
SOIL3T = mean(SOIL3(:,1:13));


[SLLL1, SDUL1, SSAT1, SSKS1,soilTexture1 ] = HYDRAULICDSSAT(SOIL1T.sand, SOIL1T.clay, SOIL1T.OrganicCarbon);
[SLLL2, SDUL2, SSAT2, SSKS2,soilTexture2 ] = HYDRAULICDSSAT(SOIL2T.sand, SOIL2T.clay, SOIL2T.OrganicCarbon);
[SLLL3, SDUL3, SSAT3, SSKS3,soilTexture3 ] = HYDRAULICDSSAT(SOIL3T.sand, SOIL3T.clay, SOIL3T.OrganicCarbon);


SOIL1T.SLLL = SLLL1;
SOIL1T.SDUL = SDUL1;
SOIL1T.SSAT = SSAT1;
SOIL1T.SSKS = SSKS1;
SOIL1T.WA = SDUL1-SLLL1;

SOIL2T.SLLL = SLLL2;
SOIL2T.SDUL = SDUL2;
SOIL2T.SSAT = SSAT2;
SOIL2T.SSKS = SSKS2;
SOIL2T.WA = SDUL2-SLLL2;

SOIL3T.SLLL = SLLL3;
SOIL3T.SDUL = SDUL3;
SOIL3T.SSAT = SSAT3;
SOIL3T.SSKS = SSKS3;
SOIL3T.WA = SDUL3-SLLL3;

%% 4
Tclus = readtable("TgridCEAN-clust.csv"); 
SOIL1 = Tclus((Tclus.clust4Org==1), :);
SOIL2 = Tclus((Tclus.clust4Org==2), :);
SOIL3 = Tclus((Tclus.clust4Org==3), :);
SOIL4 = Tclus((Tclus.clust4Org==4), :);

figure, plot(SOIL1.LON, SOIL1.LAT, 'b*'), hold on
        plot(SOIL2.LON, SOIL2.LAT, 'r*'), hold on
        plot(SOIL3.LON, SOIL3.LAT, 'k*'), grid on
        plot(SOIL4.LON, SOIL4.LAT, 'g*'), grid on


SOIL1T = mean(SOIL1(:,1:13));
SOIL2T = mean(SOIL2(:,1:13));
SOIL3T = mean(SOIL3(:,1:13));
SOIL4T = mean(SOIL4(:,1:13));


[SLLL1, SDUL1, SSAT1, SSKS1,soilTexture1 ] = HYDRAULICDSSAT(SOIL1T.sand, SOIL1T.clay, SOIL1T.OrganicCarbon);
[SLLL2, SDUL2, SSAT2, SSKS2,soilTexture2 ] = HYDRAULICDSSAT(SOIL2T.sand, SOIL2T.clay, SOIL2T.OrganicCarbon);
[SLLL3, SDUL3, SSAT3, SSKS3,soilTexture3 ] = HYDRAULICDSSAT(SOIL3T.sand, SOIL3T.clay, SOIL3T.OrganicCarbon);
[SLLL4, SDUL4, SSAT4, SSKS4,soilTexture4 ] = HYDRAULICDSSAT(SOIL4T.sand, SOIL4T.clay, SOIL4T.OrganicCarbon);


SOIL1T.SLLL = SLLL1;
SOIL1T.SDUL = SDUL1;
SOIL1T.SSAT = SSAT1;
SOIL1T.SSKS = SSKS1;
SOIL1T.WA = SDUL1-SLLL1;

SOIL2T.SLLL = SLLL2;
SOIL2T.SDUL = SDUL2;
SOIL2T.SSAT = SSAT2;
SOIL2T.SSKS = SSKS2;
SOIL2T.WA = SDUL2-SLLL2;

SOIL3T.SLLL = SLLL3;
SOIL3T.SDUL = SDUL3;
SOIL3T.SSAT = SSAT3;
SOIL3T.SSKS = SSKS3;
SOIL3T.WA = SDUL3-SLLL3;

SOIL4T.SLLL = SLLL4;
SOIL4T.SDUL = SDUL4;
SOIL4T.SSAT = SSAT4;
SOIL4T.SSKS = SSKS4;
SOIL4T.WA = SDUL-SLLL4;

%% 22/03/2024  SODAGRID data
[SLLL1, SDUL1, SSAT1, SSKS1,soilTexture1 ] = HYDRAULICDSSAT(0.5395612093, 0.1089485466, 0.964840053); % SODAGRID
WA = SDUL1 - SLLL1 

[SLLL1, SDUL1, SSAT1, SSKS1,soilTexture1 ] = HYDRAULICDSSAT(0.682054922, 0.169077935, 0.683124458); % SAT PUNTO cercano
WA2 = SDUL1 - SLLL1 

[SLLL1, SDUL1, SSAT1, SSKS1,soilTexture1 ] = HYDRAULICDSSAT(0.60 , 0.20, 0.74);  % CLUSTZR 1
WA3 = SDUL1 - SLLL1

[SLLL1, SDUL1, SSAT1, SSKS1,soilTexture1 ] = HYDRAULICDSSAT(0.52768 , 0.26609, 0.9624);  % test
WAt = SDUL1 - SLLL1 
%%



figure,  plot(T.LON, T.LAT, 'c*'), hold on, plot(LON, LAT, 'b*') 

%% ERRORES en match process = 0 
idx = logical(T.SSKS == 0);
figure, plot(T.LON, T.LAT, 'b*'), hold on, plot(T.LON(idx), T.LAT(idx), 'r*') 

%% **************************************************************************************************************************************************************************************************************
%% **************************************************************************************************************************************************************************************************************




%% **************************************************************************************************************************************************************************************************************
%% **************************************************************************************************************************************************************************************************************
%% FIRST STRATEGY - DELETE
% Di =  [ [DEM{18};DEM{12};DEM{1}], [DEM{17};DEM{11};DEM{2}], [DEM{16};DEM{10};DEM{3}] ];
% Di2 = [ [DEM{15};DEM{9}; DEM{4}], [DEM{14};DEM{8}; DEM{5}], [DEM{13};DEM{7}; DEM{6}] ];

SL1 = [ [SOL{18};SOL{12};SOL{1}], [SOL{17};SOL{11};SOL{2}], [SOL{16};SOL{10};SOL{3}] ]; 
SL2 = [ [SOL{15};SOL{9}; SOL{4}], [SOL{14};SOL{8}; SOL{5}], [SOL{13};SOL{7}; SOL{6}] ];
clearvars SOL
SL21 = [ [SOL2{18};SOL2{12};SOL2{1}], [SOL2{17};SOL2{11};SOL2{2}], [SOL2{16};SOL2{10};SOL2{3}] ]; 
SL22 = [ [SOL2{15};SOL2{9}; SOL2{4}], [SOL2{14};SOL2{8}; SOL2{5}], [SOL2{13};SOL2{7}; SOL2{6}] ];
clearvars SOL

%% Grid Features --> GRID - 1019
load('OUTPUTs.mat')                              % Soil
load('GYxy.mat'), LON=GYxy(:,1); LAT=GYxy(:,2);  % GRID
[SOILFET] = RELATsoil(LON, LAT, SL1, SL2, SL21, SL22); save('SOILFET.mat','SOILFET')   % [LON, LAT, SAND', SILT', CLAY', BULK', CORS', CARB', N', PH'];

load('SOILFET.mat')
[T] = SOIL_HYDRAULIC(SOILFET), writetable(T,'T.csv')
%% SODAGRID Soils --> ALL SENEGAL SOIL - 5180
SOLDB1 = readtable('DBSOILV2.xlsx'); LON2=SOLDB1.LON; LAT2=SOLDB1.LAT; %% SODAGRI      hold on, plot(LON2,LAT2, 'b.')
[SOILFET2]= RELATsoil(LON2, LAT2, SL1, SL2, SL21, SL22); save('SOILFET2.mat','SOILFET2') 
load('SOILFET2.mat')
[T2] = SOIL_HYDRAULIC(SOILFET), writetable(T2,'T2.csv')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DB AI --> ALL SENEGAL SOIL - 194
SOLDBai = readtable('FS0.xlsm'); LON0=SOLDBai.LON; LAT0=SOLDBai.LAT; year=SOLDBai.Year;      %% SODAGRI      hold on, plot(LON2,LAT2, 'b.')
[SOILFETai]= RELATsoil(LON0, LAT0, SL1, SL2, SL21, SL22); save('SOILFET3.mat','SOILFET3') 
[Tai] = SOIL_HYDRAULIC(SOILFETai), writetable(Tai,'Tai.csv')
%% GRAFICA comparativa DBs
% SHOWsuelos(0,LON2, LAT2);




