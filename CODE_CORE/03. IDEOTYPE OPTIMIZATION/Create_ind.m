function ind=Create_ind(Num_gen)
ind.fitness=0;
ind.gentype=randperm(Num_gen);
ind.phenotype= [];
ind.range=[0,0];
