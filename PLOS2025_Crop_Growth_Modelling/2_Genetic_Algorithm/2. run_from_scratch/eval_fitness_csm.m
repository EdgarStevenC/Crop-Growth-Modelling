function [Pop] = eval_fitness_csm(Pop,ind_id,gID)
    
G4 = 1.0;   
G5 = 1.0;
THOT = 35;    
TCLDP = 15.0;
TCLDF = 15.0;

    for i=1:size(Pop,1)
        if Pop(i).fitness == 0
            [P1] = Pop(i).gentype(1);
            [P5] = Pop(i).gentype(2);
            [P2R] = Pop(i).gentype(3);
            [PHINT] = Pop(i).gentype(4);
            [P2O] = Pop(i).gentype(5);
            [G1] = Pop(i).gentype(6);
            [G2] = Pop(i).gentype(7);
            [G3] = Pop(i).gentype(8);
    
            %[GYdbDSSAT, GT, FIT, GRAPH] = MECHANISTIC(P1,P2Rm,P5,P2Om,G1m,G2m,G3m,PHINT,THOT,TCLDP,TCLDF,G4,G5,0., SATELLITE, SATELLITEsol,ind_id);
            GEN.P1=P1;
            GEN.P2R=P2R;
            GEN.P5=P5;
            GEN.P2O=P2O;
            GEN.G1=G1;
            GEN.G2=G2;
            GEN.G3=G3;
            GEN.PHINT=PHINT;
            GEN.THOT=THOT;
            GEN.TCLDP=TCLDP;
            GEN.TCLDF=TCLDF;
            GEN.G4=G4;
            GEN.G5=G5;
            tic
            [MCM_Table] = CERES_Rice(GEN,256);toc  % ENVIRONMENT 1-2-3-4 could be ID" 761-846-256-686 / 381-423-125-343", related to Fig 2. Environmental categories in the Casamance and Eastern Senegal region"

            %% Fitness Function
            Pop(i).phenotype = MCM_Table;   
                    WUE_norm = mean( (MCM_Table.WUE ) / (15 ) ); % 2 to 15 kg/H.mm
                    HIm =mean( MCM_Table.HI );  
            Pop(i).fitness  =  HIm + WUE_norm;    
            Visual_Ind(Pop(i)); close
        end
    end
        %% Save
        save(strcat('Populations/', num2str(gID), 'Pop.mat'),"Pop") ;
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
