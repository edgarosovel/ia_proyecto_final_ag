%% gimmeBaby: Produces offspring
function [babies] = gimmeBaby(n, fitPopulation, code, u_c, u_m)
    babies = [];

    %% Ruleta
    fitness = fitPopulation(:, end);
    probability = fitness ./ sum(fitness);
    ruleta = [0; cumsum(probability)];

    while size(babies, 1) < n
        %% Selection a la binary search
        p1 = find(ruleta < rand());
        p1 = p1(end);
        p2 = find(ruleta < rand());
        p2 = p2(end);
        offspring = [fitPopulation(p1, :); fitPopulation(p2, :)];
        %% Crossover
        if (rand() > u_c)
            [a, b] = crossOver(offspring);
            offspring = [a; b];
        end
        %% Mutate and join
        babies = [babies; mutateThem(offspring, u_m)];
    end

    %% Remove extra baby (results from having n odd)
    if size(babies, 1) > n
        babies = babies(1:end-1, :);
    end
end
