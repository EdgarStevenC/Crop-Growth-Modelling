function [POPULATION] = POPULATION_READ(ENV)
ES = int2str(ENV);
for i = 1 : 20
    load( strcat('IND_P1',ES,'/POPULATION/',num2str(i), 'Pop.mat')  );

    if isfield(Pop, 'range'), Pop = rmfield(Pop, 'range'); end
    POPULATION = [POPULATION; Pop];
end
% SORT
POPULATION = struct2table(POPULATION);
[Fit idx] = sort(POPULATION.fitness);
POPULATION = POPULATION(idx,:);
% Phenotype
numPhenotypes = size(POPULATION,1);
Phenotype = [];
for i = 1:numPhenotypes
    Phenotype = [Phenotype; mean(POPULATION.phenotype{i})];
end
POPULATION.phenotype = Phenotype;
% Genotype
data = POPULATION.gentype; 
Genotype = table(data(:,1), data(:,2), data(:,3), data(:,4), data(:,5), data(:,6), data(:,7), data(:,8), ...
          'VariableNames', {'P1', 'P5', 'P2R', 'PHINT', 'P2O', 'G1', 'G2', 'G3'});
POPULATION.gentype = Genotype;
end