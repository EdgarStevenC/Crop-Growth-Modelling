function Pop_out=Select_parents(Pop)
Pop_fitness=0;
for i=1:size(Pop,1)
    Pop_fitness=Pop_fitness+Pop(i,1).fitness;
end
    pos_str=0;
    pos_end=0;
for i=1:size(Pop,1)
    Ind_fitness_rel=(Pop(i,1).fitness/Pop_fitness)
    pos_end=pos_str+Ind_fitness_rel;
    Pop(i,1).range=[pos_str pos_end];
    pos_str=pos_end;
end
Pop_out=[]; 
for i=1:round(size(Pop,1)*1)-1
    val_select=rand();
        for j=1:size(Pop,1)
            if val_select>=Pop(j,1).range(1,1) && val_select<Pop(j,1).range(1,2)
               Pop_out=[Pop_out;Pop(j,1)]; 
               % Pop(j) = [];
               break;
            end
        end
end