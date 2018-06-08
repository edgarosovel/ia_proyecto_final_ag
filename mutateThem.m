%% mutateThem: mutate genes of individuals
function [genes] = mutateThem(genes, umbral)
    genes(:, 1:end-1);
    mask = rand(size(genes)) > umbral;
    genes = xor(genes, mask);
end
