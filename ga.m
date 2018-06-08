%% ga: Maximize function with genetic algorithm
function [x, y, fval] = ga(fitnessFunction, populationSize, k_best, generations, umbral, umbral_c, umbral_m, left, right)

    %% Define range values for both variables x and y
    code = codifPseudoBinaria(left, right);
    %% Generate inital random population
    popolo = generatePopulation(populationSize, umbral, code);

    %% Simulate
    for i = 1:generations
        %% Sort population by fitness
        [x, y] = decode(popolo, code);
        fitPopolo = [popolo fitnessFunction(x, y)];
        fitPopolo = sortrows(fitPopolo, -size(fitPopolo, 2));
        %% Select the elite elements
        elite = fitPopolo(1:k_best, :);
        %% Generate missing population from crossover
        n = populationSize - k_best;
        babies = gimmeBaby(n, fitPopolo, code, umbral_c, umbral_m);
        %% Next generation population
        popolo = [elite; babies];
        popolo = popolo(:, 1:end-1);
    end

    %% Get best individual and its (x, y) values
    best = popolo(1, :);
    [x, y] = decode(best, code);
    fval = fitnessFunction(x, y);
end
