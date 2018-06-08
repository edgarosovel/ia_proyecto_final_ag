function [population] = generatePopulation(n, umbral, code)
    m = size(code.datos, 1);
    population = rand(n, 2 * m) > umbral;
end
