function Pop=Pop_ini(Num_ind)

%% ***********************************************************************************************************************
%% Crop Parameters
N = 5;
P1 = [150: ((800-150)/N) :800];         % 329.7;                                         % VEGETATIVE (C-d)
P2O =[11: ((13-11)/N) :13];             % 12.1;                                          % critical photoperiod - (Duracion del dia)
P2R = [5: ((300-5)/N) :300];            % 133.5;                                         % Panicle initiation delaying (C-d)      
P5 = [150: ((850-150)/N) :850];         % 364.6;                                         % RIPENING (C-d)                      
G1 = [38: ((540-38)/N) :540];           % 50:    ((75-50)/N) :75             % 247.1;    % potential spikelet number 
G2 = [0.015: ((0.030-0.015)/N) :0.030]; % 0.015: ((0.030-0.015)/N) :0.030    % .063;     % single grain weigt        
G3 = [0.7: ((1.97-0.7)/N) :1.97];       % 0.7:   ((1.3-0.7)/N) :1.3          % 1.20;     % Tillering coheficient - (Cual es numero maximo de tallos N4)      
PHINT = [55: ((90-55)/N) :90];          % 83.0;                                          % Phyllochon (C-d) (time interval - for each leaf)  

THOT = [25: ((34-25)/N) :34];           % 25.3;          
TCLDP = [12: ((18-12)/N) :18];          % 15.0;          
TCLDF = [10: ((20-10)/N) :20];          % 15.0; 
%% ***********************************************************************************************************************
Pop=[];
for i=1:Num_ind-1
    ind.fitness=0;
    ind.dist=0; % randperm(2);
        P1r = P1(randi([1 5], 1,1));
        P2Or = P2O(randi([1 5], 1,1));
        P2Rr = P2R(randi([1 5], 1,1)); 
        P5r = P5(randi([1 5], 1,1)); 
        G1r = G1(randi([1 5], 1,1));  
        G2r = G2(randi([1 5], 1,1)); 
        G3r = G3(randi([1 5], 1,1));    
        PHINTr = PHINT(randi([1 5], 1,1)); 
        ind.gentype=[P1r,P5r,P2Rr,PHINTr,P2Or,G1r,G2r,G3r];     % PoidsSecGrain  CoeffPanicleMass   
    % ind.range=[0,0];  % 0.01-0.05
    Pop=[Pop; ind];
end
%% ***********************************************************************************************************************
% Guarantee the participation of manual calibration in the optimization
P1 = 520;   % 430;    
P5 = 550;     
PHINT = 60; % 80;
P2R = 10;   % 64.0000 ;
P2O = 13;   % 12.2000;   
G1 = 75;
G2 = 0.03;   
G3 = 0.6;   % 0.7; 
ind.gentype=[P1,P5,P2R,PHINT,P2O,G1,G2,G3]; 
Pop=[Pop; ind];

end 