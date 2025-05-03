function [Pop] = eval_fitness_csm(Pop,ind_id)
    
G4 = 1.0;   
G5 = 1.0;
THOT = 35;    
TCLDP = 15.0;
TCLDF = 15.0;
SATELLITE = 0;
SATELLITEsol = 0;

    for i=1:size(Pop,1)
        if Pop(i).dist == 0
            [P1] = Pop(i).gentype(1);
            [P5] = Pop(i).gentype(2);
            [P2Rm] = Pop(i).gentype(3);
            [PHINT] = Pop(i).gentype(4);
            [P2Om] = Pop(i).gentype(5);
            [G1m] = Pop(i).gentype(6);
            [G2m] = Pop(i).gentype(7);
            [G3m] = Pop(i).gentype(8);
    
            [GYdbDSSAT, GT, FIT, GRAPH] = MECHANISTIC(P1,P2Rm,P5,P2Om,G1m,G2m,G3m,PHINT,THOT,TCLDP,TCLDF,G4,G5,0., SATELLITE, SATELLITEsol,ind_id);
            Pop(i).GRAPH = GRAPH ;
            Pop(i).dist = FIT ;    
        end
    end
        %% Fitness Function
        Pop_fitness=0;
        for i=1:size(Pop,1); Pop_fitness=Pop_fitness+Pop(i,1).dist; end
        pos_str=0;
        pos_end=0;
        for i=1:size(Pop,1)
            Ind_fitness_rel=1-(Pop(i,1).dist/Pop_fitness);
            Pop(i).fitness = Ind_fitness_rel;
        end

        gID = readmatrix('FiguresCP/N.txt');
        save(strcat('FiguresCP/Pop/', num2str(gID), 'Pop.mat'),"Pop") ;
        %%
    
end
%  AB = 0;
%  dist = [];
% for i=1:size(Pop,1)
% 
%     [FT, fit] = MM_SAMARA(T, sowD, CULdx, m, DSSAT, Pop(i,:).gentype, 0, N, AB);    
% 
%     dist = [dist; fit];
% 
% end
% max_dist=max(dist);
%     a = 0;
%     for j = 1 : numel(max_dist)
%         a = a +  (    (dist(:,j) * 100) / max_dist(j)   );
%     end
%     a = a/numel(max_dist);
% for i=1:size(Pop,1)
%     Pop(i,1).fitness = 100 - a(i) ;     % ( Pop(i,1).dist *100 ) / max_dist;
%     Pop(i,1).dist =  a(i) ;
% end
