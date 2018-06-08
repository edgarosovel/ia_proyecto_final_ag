%% Fitness function: The mathematical function we want to maximize
function [fval] = fitness(x, y)
    val1 = x .* (sind(x).^2) .* (cosd(x).^3);
    val2 = y .* (sind(y).^2) .* (cosd(y).^3);
    fval = -val1 + val2;
    %% Other examples
    %% fval = (3.*x.^2) .+ (2.*x.*y) .- (5.*y.^2);
    %% fval = x.^2;
end
