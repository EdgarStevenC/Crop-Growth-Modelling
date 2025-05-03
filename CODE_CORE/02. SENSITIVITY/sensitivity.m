function [] = sensitivity(N, RANDp)
%% ***********************************************************************************************************************
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Crop Parameters
P1 = [150: ((800-150)/N) :800];         % 329.7; 
P2O =[11: ((13-11)/N) :13];             % 12.1; 
P2R = [5: ((300-5)/N) :300];            % 133.5;          
P5 = [150: ((850-150)/N) :850];         % 364.6;                          
G1 = [50: ((75-50)/N) :75];           % 50: ((75-50)/N) :75              % 247.1;  38:540
G2 = [0.015: ((0.030-0.015)/N) :0.030]; % 0.015: ((0.030-0.015)/N) :0.030  % .063;             
G3 = [0.7: ((1.3-0.7)/N) :1.3];       % 0.7: ((1.3-0.7)/N) :1.3          % 1.20;           
PHINT = [55: ((90-55)/N) :90];          % 83.0;           
THOT = [25: ((34-25)/N) :34];           % 25.3;          
TCLDP = [12: ((18-12)/N) :18];          % 15.0;          
TCLDF = [10: ((20-10)/N) :20];          % 15.0; 
G4 = ones(1,N+1) * 1.0;          %1.15            
G5 = ones(1,N+1) *1.0;

%% Sorted selection
if RANDp ==1
    P1 = P1(randperm(length(P1)));
    P2O= P2O(randperm(length(P2O)));
    P2R= P2R(randperm(length(P2R)));
    P5 = P5(randperm(length(P5)));
    G1 = G1(randperm(length(G1)));
    G2 = G2(randperm(length(G2)));
    G3 = G3(randperm(length(G3)));
    PHINT = PHINT(randperm(length(PHINT)));
    THOT = THOT(randperm(length(THOT)));
    TCLDP = TCLDP(randperm(length(TCLDP)));
    TCLDF = TCLDF(randperm(length(TCLDF)));
end 

%% ***********************************************************************************************************************
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Main routine
% uncomment to run MCM CERES-Rice
for i = 1 : N
    % [GYdb1] = MECHANISTIC(P1(i),   P2R(1),   P5(1),   P2O(1),   G1(1),   G2(1),   G3(1),   PHINT(1),   THOT(1),   TCLDP(1),   TCLDF(1),    G4(1),G5(1), 0); toc % VISUAL= 0  
    % [GYdb2] = MECHANISTIC(P1(i+1), P2R(1),   P5(1),   P2O(1),   G1(1),   G2(1),   G3(1),   PHINT(1),   THOT(1),   TCLDP(1),   TCLDF(1),    G4(1),G5(1), 0); toc
    % [GYdb3] = MECHANISTIC(P1(i+1), P2R(i+1), P5(1),   P2O(1),   G1(1),   G2(1),   G3(1),   PHINT(1),   THOT(1),   TCLDP(1),   TCLDF(1),    G4(1),G5(1), 0); toc
    % [GYdb4] = MECHANISTIC(P1(i+1), P2R(i+1), P5(i+1), P2O(1),   G1(1),   G2(1),   G3(1),   PHINT(1),   THOT(1),   TCLDP(1),   TCLDF(1),    G4(1),G5(1), 0); toc
    % [GYdb5] = MECHANISTIC(P1(i+1), P2R(i+1), P5(i+1), P2O(i+1), G1(1),   G2(1),   G3(1),   PHINT(1),   THOT(1),   TCLDP(1),   TCLDF(1),    G4(1),G5(1), 0); toc
    % [GYdb6] = MECHANISTIC(P1(i+1), P2R(i+1), P5(i+1), P2O(i+1), G1(i+1), G2(1),   G3(1),   PHINT(1),   THOT(1),   TCLDP(1),   TCLDF(1),    G4(1),G5(1), 0); toc
    % [GYdb7] = MECHANISTIC(P1(i+1), P2R(i+1), P5(i+1), P2O(i+1), G1(i+1), G2(i+1), G3(1),   PHINT(1),   THOT(1),   TCLDP(1),   TCLDF(1),    G4(1),G5(1), 0); toc
    % [GYdb8] = MECHANISTIC(P1(i+1), P2R(i+1), P5(i+1), P2O(i+1), G1(i+1), G2(i+1), G3(i+1), PHINT(1),   THOT(1),   TCLDP(1),   TCLDF(1),    G4(1),G5(1), 0); toc
    % [GYdb9] = MECHANISTIC(P1(i+1), P2R(i+1), P5(i+1), P2O(i+1), G1(i+1), G2(i+1), G3(i+1), PHINT(i+1), THOT(1),   TCLDP(1),   TCLDF(1),    G4(1),G5(1), 0); toc
    % [GYdb10]= MECHANISTIC(P1(i+1), P2R(i+1), P5(i+1), P2O(i+1), G1(i+1), G2(i+1), G3(i+1), PHINT(i+1), THOT(i+1), TCLDP(1),   TCLDF(1),    G4(1),G5(1), 0); toc
    % [GYdb11]= MECHANISTIC(P1(i+1), P2R(i+1), P5(i+1), P2O(i+1), G1(i+1), G2(i+1), G3(i+1), PHINT(i+1), THOT(i+1), TCLDP(i+1), TCLDF(1),    G4(1),G5(1), 0); toc
    % [GYdb12]= MECHANISTIC(P1(i+1), P2R(i+1), P5(i+1), P2O(i+1), G1(i+1), G2(i+1), G3(i+1), PHINT(i+1), THOT(i+1), TCLDP(i+1), TCLDF(i+1),  G4(1),G5(1), 0); toc
    % save(strcat('GYsim2',num2str(i),'.mat'),'GYdb1','GYdb2','GYdb3','GYdb4','GYdb5','GYdb6','GYdb7','GYdb8','GYdb9','GYdb10','GYdb11','GYdb12')

%% YILED  --> GYdb, BSSdb, ANTdb, MATdb
% load(strcat('GYsim',num2str(i),'.mat')) % pre executed (02/2025) and copy saved
 load(strcat('GYsim2',num2str(i),'.mat')) % pre executed (03/2025) and copy saved - Reproduce
jj = 1;
%% Metrics - Relative Sensitivity Index (RSI)
safe_div = @(num, den) ( (den == 0 | isnan(num) | isnan(den)) .* 0 ) + ( (den ~= 0 & ~isnan(num) & ~isnan(den)) .* (num ./ den) );
for j = 1 :size(GYdb1,2)
        % --- RSI base ---
        dP1(j,i) = safe_div(mean(abs(GYdb1(:,jj) - GYdb2(:,jj)), 'omitnan'), max(abs(GYdb1(:,jj) - GYdb2(:,jj)), [], 'omitnan'));
        dP2O(j,i) = safe_div(mean(abs(GYdb2(:,jj) - GYdb3(:,jj)), 'omitnan'), max(abs(GYdb2(:,jj) - GYdb3(:,jj)), [], 'omitnan'));
        dP2R(j,i) = safe_div(mean(abs(GYdb3(:,jj) - GYdb4(:,jj)), 'omitnan'), max(abs(GYdb3(:,jj) - GYdb4(:,jj)), [], 'omitnan'));
        dP5(j,i) = safe_div(mean(abs(GYdb4(:,jj) - GYdb5(:,jj)), 'omitnan'), max(abs(GYdb4(:,jj) - GYdb5(:,jj)), [], 'omitnan'));
        dG1(j,i) = safe_div(mean(abs(GYdb5(:,jj) - GYdb6(:,jj)), 'omitnan'), max(abs(GYdb5(:,jj) - GYdb6(:,jj)), [], 'omitnan'));
        dG2(j,i) = safe_div(mean(abs(GYdb6(:,jj) - GYdb7(:,jj)), 'omitnan'), max(abs(GYdb6(:,jj) - GYdb7(:,jj)), [], 'omitnan'));
        dG3(j,i) = safe_div(mean(abs(GYdb7(:,jj) - GYdb8(:,jj)), 'omitnan'), max(abs(GYdb7(:,jj) - GYdb8(:,jj)), [], 'omitnan'));
        dPHINT(j,i) = safe_div(mean(abs(GYdb8(:,jj) - GYdb9(:,jj)), 'omitnan'), max(abs(GYdb8(:,jj) - GYdb9(:,jj)), [], 'omitnan'));
        dTHOT(j,i) = safe_div(mean(abs(GYdb9(:,jj) - GYdb10(:,jj)), 'omitnan'), max(abs(GYdb9(:,jj) - GYdb10(:,jj)), [], 'omitnan'));
        dTCLDP(j,i) = safe_div(mean(abs(GYdb10(:,jj) - GYdb11(:,jj)), 'omitnan'), max(abs(GYdb10(:,jj) - GYdb11(:,jj)), [], 'omitnan'));
        dTCLDF(j,i) = safe_div(mean(abs(GYdb11(:,jj) - GYdb12(:,jj)), 'omitnan'), max(abs(GYdb11(:,jj) - GYdb12(:,jj)), [], 'omitnan'));

        % ---  Delta(Xi): "μ" the mean absolute chang --- 
        uP1(j,i) = mean(abs(GYdb1(:,jj)-GYdb2(:,jj)));
        uP2O(j,i) = mean(abs(GYdb2(:,jj)-GYdb3(:,jj)));
        uP2R(j,i) = mean(abs(GYdb3(:,jj)-GYdb4(:,jj)));
        uP5(j,i) = mean(abs(GYdb4(:,jj)-GYdb5(:,jj)));
        uG1(j,i) = mean(abs(GYdb5(:,jj)-GYdb6(:,jj)));
        uG2(j,i) = mean(abs(GYdb6(:,jj)-GYdb7(:,jj)));
        uG3(j,i) = mean(abs(GYdb7(:,jj)-GYdb8(:,jj)));
        uPHINT(j,i) = mean(abs(GYdb8(:,jj)-GYdb9(:,jj)));
        uTHOT(j,i) = mean(abs(GYdb9(:,jj)-GYdb10(:,jj)));
        uTCLDP(j,i) = mean(abs(GYdb10(:,jj)-GYdb11(:,jj)));
        uTCLDF(j,i) = mean(abs(GYdb11(:,jj)-GYdb12(:,jj)));

    jj = jj +1;
end

end

 dP1(isnan(dP1)) = 0;
 dP2O(isnan(dP2O)) = 0;
 dP2R(isnan(dP2R)) = 0;
 dP5(isnan(dP5)) = 0;
 dG1(isnan(dG1)) = 0;
 dG2(isnan(dG2)) = 0;
 dG3(isnan(dG3)) = 0;
 dPHINT(isnan(dPHINT)) = 0;
 dTHOT(isnan(dTHOT)) = 0;
 dTCLDP(isnan(dTCLDP)) = 0;
 dTCLDF(isnan(dTCLDF)) = 0;

% save('senT.mat', 'GYdb1', 'dP1', 'dP2O', 'dP2R', 'dP5', 'dG1', 'dG2', 'dG3', 'dPHINT', 'dTHOT', 'dTCLDP', 'dTCLDF', ...
%                           'uP1', 'uP2O', 'uP2R', 'uP5', 'uG1', 'uG2', 'uG3', 'uPHINT', 'uTHOT', 'uTCLDP', 'uTCLDF');
save('senT2.mat', 'GYdb1', 'dP1', 'dP2O', 'dP2R', 'dP5', 'dG1', 'dG2', 'dG3', 'dPHINT', 'dTHOT', 'dTCLDP', 'dTCLDF', ...
                          'uP1', 'uP2O', 'uP2R', 'uP5', 'uG1', 'uG2', 'uG3', 'uPHINT', 'uTHOT', 'uTCLDP', 'uTCLDF');
% 'sen_BIOMASS_DSSAT.mat'

%% ***********************************************************************************************************************
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VISUALIZATION
% load('senT.mat')
 load('senT2.mat')
 %%  GY, BSS, ANT, MAT, NG, NT
 %% Grain Yield
    j = 1; var='Grain Yield (GY)'; unit='Log [ μ (Kg/H) ]';
    STATS=[mean(uP1(j,:)),mean(uP2O(j,:)),mean(uP2R(j,:)),mean(uP5(j,:)),mean(uG1(j,:)),mean(uG2(j,:)),mean(uG3(j,:)),mean(uPHINT(j,:)),mean(uTHOT(j,:)),mean(uTCLDP(j,:)),mean(uTCLDF(j,:)); zeros(1,11); 
           mean(dP1(j,:)),mean(dP2O(j,:)),mean(dP2R(j,:)),mean(dP5(j,:)),mean(dG1(j,:)),mean(dG2(j,:)),mean(dG3(j,:)),mean(dPHINT(j,:)),mean(dTHOT(j,:)),mean(dTCLDP(j,:)),mean(dTCLDF(j,:))]
    TD = SENgraph2(var,unit, STATS, max(STATS(1,:))*1.1);
    GrainYield = generateRSITable(STATS)
 %% Biomass
    j = 2; var = 'Biomass'; unit='Log [ μ (Kg/H) ]';
    STATS=[mean(uP1(j,:)),mean(uP2O(j,:)),mean(uP2R(j,:)),mean(uP5(j,:)),mean(uG1(j,:)),mean(uG2(j,:)),mean(uG3(j,:)),mean(uPHINT(j,:)),mean(uTHOT(j,:)),mean(uTCLDP(j,:)),mean(uTCLDF(j,:)); zeros(1,11); 
           mean(dP1(j,:)),mean(dP2O(j,:)),mean(dP2R(j,:)),mean(dP5(j,:)),mean(dG1(j,:)),mean(dG2(j,:)),mean(dG3(j,:)),mean(dPHINT(j,:)),mean(dTHOT(j,:)),mean(dTCLDP(j,:)),mean(dTCLDF(j,:))]
    TD = SENgraph2(var,unit, STATS, max(STATS(1,:))*1.1);
    Biomass = generateRSITable(STATS)
  %% Anthesis
    j = 3; var = 'Anthesis'; unit='Log [ μ (Days after sowing) ]';
    STATS=[mean(uP1(j,:)),mean(uP2O(j,:)),mean(uP2R(j,:)),mean(uP5(j,:)),mean(uG1(j,:)),mean(uG2(j,:)),mean(uG3(j,:)),mean(uPHINT(j,:)),mean(uTHOT(j,:)),mean(uTCLDP(j,:)),mean(uTCLDF(j,:)); zeros(1,11); 
           mean(dP1(j,:)),mean(dP2O(j,:)),mean(dP2R(j,:)),mean(dP5(j,:)),mean(dG1(j,:)),mean(dG2(j,:)),mean(dG3(j,:)),mean(dPHINT(j,:)),mean(dTHOT(j,:)),mean(dTCLDP(j,:)),mean(dTCLDF(j,:))]
    TD = SENgraph2(var,unit, STATS, mean(STATS(1,:))*1.1);
    Anthesis = generateRSITable(STATS)
  %% Maturity
    j = 4; var = 'Maturity'; unit='Log [ μ (Days after sowing) ]';
    STATS=[mean(uP1(j,:)),mean(uP2O(j,:)),mean(uP2R(j,:)),mean(uP5(j,:)),mean(uG1(j,:)),mean(uG2(j,:)),mean(uG3(j,:)),mean(uPHINT(j,:)),mean(uTHOT(j,:)),mean(uTCLDP(j,:)),mean(uTCLDF(j,:)); zeros(1,11); 
           mean(dP1(j,:)),mean(dP2O(j,:)),mean(dP2R(j,:)),mean(dP5(j,:)),mean(dG1(j,:)),mean(dG2(j,:)),mean(dG3(j,:)),mean(dPHINT(j,:)),mean(dTHOT(j,:)),mean(dTCLDP(j,:)),mean(dTCLDF(j,:))]
    TD = SENgraph2(var,unit, STATS, max(STATS(1,:))*1.1);
    Maturity = generateRSITable(STATS)
  %% Number of Grains
    j = 5; var = 'Number of Grains'; unit='Log [ μ (#/H) ]';
    STATS=[mean(uP1(j,:)),mean(uP2O(j,:)),mean(uP2R(j,:)),mean(uP5(j,:)),mean(uG1(j,:)),mean(uG2(j,:)),mean(uG3(j,:)),mean(uPHINT(j,:)),mean(uTHOT(j,:)),mean(uTCLDP(j,:)),mean(uTCLDF(j,:)); zeros(1,11); 
           mean(dP1(j,:)),mean(dP2O(j,:)),mean(dP2R(j,:)),mean(dP5(j,:)),mean(dG1(j,:)),mean(dG2(j,:)),mean(dG3(j,:)),mean(dPHINT(j,:)),mean(dTHOT(j,:)),mean(dTCLDP(j,:)),mean(dTCLDF(j,:))]
    TD = SENgraph2(var,unit, STATS, max(STATS(1,:))*1.1);
    NumberGrains = generateRSITable(STATS)
   %% Number of Tillers
    j = 6; var = 'Number of Tillers'; unit='Log [ μ (#/H) ]';
    STATS=[mean(uP1(j,:)),mean(uP2O(j,:)),mean(uP2R(j,:)),mean(uP5(j,:)),mean(uG1(j,:)),mean(uG2(j,:)),mean(uG3(j,:)),mean(uPHINT(j,:)),mean(uTHOT(j,:)),mean(uTCLDP(j,:)),mean(uTCLDF(j,:)); zeros(1,11); 
           mean(dP1(j,:)),mean(dP2O(j,:)),mean(dP2R(j,:)),mean(dP5(j,:)),mean(dG1(j,:)),mean(dG2(j,:)),mean(dG3(j,:)),mean(dPHINT(j,:)),mean(dTHOT(j,:)),mean(dTCLDP(j,:)),mean(dTCLDF(j,:))]
    TD = SENgraph2(var,unit, STATS, max(STATS(1,:))*1.1);
    NumberTillers = generateRSITable(STATS)

%%
T1 = table(Biomass.Parameter, Biomass.RSI, 'VariableNames', {'Parameter_Biomass', 'RSI_Biomass'});
T2 = table(GrainYield.Parameter, GrainYield.RSI, 'VariableNames', {'Parameter_GrainYield', 'RSI_GrainYield'});
T3 = table(Anthesis.Parameter, Anthesis.RSI, 'VariableNames', {'Parameter_Anthesis', 'RSI_Anthesis'});
T4 = table(Maturity.Parameter, Maturity.RSI, 'VariableNames', {'Parameter_Maturity', 'RSI_Maturity'});
T5 = table(NumberGrains.Parameter, NumberGrains.RSI, 'VariableNames', {'Parameter_NumberGrains', 'RSI_NumberGrains'});
T6 = table(NumberTillers.Parameter, NumberTillers.RSI, 'VariableNames', {'Parameter_NumberTillers', 'RSI_NumberTillers'});


% 3. Result Report
RelativeSensitivityIndex = [T1, T2, T3, T4, T5, T6];
writetable(RelativeSensitivityIndex, 'RelativeSensitivityIndex.xlsx');
%% ***********************************************************************************************************************
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % %% OLD Results
    % f1=figure, 
    % SENgraph(1, dP1, dP2O, dP2R, dP5, dG1, dG2, dG3,dPHINT,dTHOT,dTCLDP,dTCLDF,uP1,uP2O,uP2R,uP5,uG1,uG2,uG3,uPHINT,uTHOT,uTCLDP,uTCLDF)
    % grid on, ylabel('μ (Kg/H)'), xlabel('σ')
    % f1.Position = [202.6000  452.2000  654.4000  270.4000];  %legend('Gerardeaux DB')
    % title('Sensitivity Crop Paramaters - GY')
    % 
    % f1=figure, 
    % SENgraph(2, dP1, dP2O, dP2R, dP5, dG1, dG2, dG3,dPHINT,dTHOT,dTCLDP,dTCLDF,uP1,uP2O,uP2R,uP5,uG1,uG2,uG3,uPHINT,uTHOT,uTCLDP,uTCLDF)
    % grid on, ylabel('μ (Kg/H)'), xlabel('σ')
    % f1.Position = [202.6000  452.2000  654.4000  270.4000];  %legend('Gerardeaux DB')
    % title('Sensitivity Crop Paramaters - Biomass')
    % 
    % f1=figure, 
    % SENgraph(3, dP1, dP2O, dP2R, dP5, dG1, dG2, dG3,dPHINT,dTHOT,dTCLDP,dTCLDF,uP1,uP2O,uP2R,uP5,uG1,uG2,uG3,uPHINT,uTHOT,uTCLDP,uTCLDF)
    % grid on, ylabel('μ (days after sowing)'), xlabel('σ')
    % f1.Position = [202.6000  452.2000  654.4000  270.4000];  %legend('Gerardeaux DB')
    % title('Sensitivity Crop Paramaters - ANTHESIS')
    % 
    % f1=figure, 
    % SENgraph(4, dP1, dP2O, dP2R, dP5, dG1, dG2, dG3,dPHINT,dTHOT,dTCLDP,dTCLDF,uP1,uP2O,uP2R,uP5,uG1,uG2,uG3,uPHINT,uTHOT,uTCLDP,uTCLDF)
    % grid on, ylabel('μ (days after sowing)'), xlabel('σ')
    % f1.Position = [202.6000  452.2000  654.4000  270.4000];  %legend('Gerardeaux DB')
    % title('Sensitivity Crop Paramaters - MATURITY')
    % 
    % f1=figure, 
    % SENgraph(5, dP1, dP2O, dP2R, dP5, dG1, dG2, dG3,dPHINT,dTHOT,dTCLDP,dTCLDF,uP1,uP2O,uP2R,uP5,uG1,uG2,uG3,uPHINT,uTHOT,uTCLDP,uTCLDF)
    % grid on, ylabel('μ (#)'), xlabel('σ')
    % f1.Position = [202.6000  452.2000  654.4000  270.4000];  %legend('Gerardeaux DB')
    % title('Sensitivity Crop Paramaters - Number of grains')
    % 
    % f1=figure, 
    % SENgraph(5, dP1, dP2O, dP2R, dP5, dG1, dG2, dG3,dPHINT,dTHOT,dTCLDP,dTCLDF,uP1,uP2O,uP2R,uP5,uG1,uG2,uG3,uPHINT,uTHOT,uTCLDP,uTCLDF)
    % grid on, ylabel('μ (#)'), xlabel('σ')
    % f1.Position = [202.6000  452.2000  654.4000  270.4000];  %legend('Gerardeaux DB')
    % title('Sensitivity Crop Paramaters - Number of tillers')

end