function  Pop_out=Mutation(Pop, Thr_mut)
%% MUTACIONES
 P1 = randi([150 800], 1,1);  % [150: ((800-150)/R) :800];   %520       % 329.7; % VEGETATIVE (C-d) 
 P5 = randi([150 850], 1,1);  % [150: ((850-150)/R) :850];   %550       % 364.6; % RIPENING (C-d) 
 P2R = randi([5 300], 1,1);   % [5: ((300-5)/R) :300];      %10        % 133.5; % Panicle initiation delaying (C-d)
 PHINT = randi([55 90], 1,1); % [55: ((90-55)/R) :90];    %60        % 83.0;  % Phyllochon (C-d) (time interval - for each leaf)
 P2O = randi([11 13], 1,1);   % [11: ((13-11)/R) :13];      %13        % 12.1;                              % Duracion del dia - critical photoperiod    
 G1 = randi([50 75], 1,1);        % [50: ((75-50)/R) :75];       %75           %    38: ((540-38)/R) :540            % 247.1;  % potential spikelet number 
 G2 = randi([15 30], 1,1)./1000;  % [0.015: ((0.030-0.015)/R) :0.030];  %0.03  % 0.015: ((0.063-0.015)/N) :0.063  % .063;   % single grain weigth 
 G3 = randi([6 19], 1,1)./10;     % [0.6: ((1.97-0.6)/R) :1.97];        %0.6   % 0.7: ((1.3-0.7)/N) :1.3  % 1.20;           % Tillering coheficient - (Cual es numero maximo de tallos N4)
        
 NEWgen=[P1,P5,P2R,PHINT,P2O,G1,G2,G3];     % PoidsSecGrain  CoeffPanicleMass 
%%
SPob=size(Pop,1);
SInd=size(Pop(1,1).gentype,2);
Pop_out=Pop;
for i=1:SPob
    ProbMut=rand();
    if(ProbMut<Thr_mut)
        Ind=Pop(i,1);
        % C1=ceil(SInd*rand());
        % DistMut=ceil((SInd-C1)*rand());        
        % C2=C1+DistMut;
        IndMut=Ind;
        
        for K=1 : numel(IndMut.gentype)
            if randi([0,1]) == 1
                IndMut.gentype(K) = (IndMut.gentype(K) + NEWgen(K))/2;
            end
        end

        Pop_out(i,1)=IndMut;
    end
end

end
