%% decode: decodes pseudo binary codification in x and y

function [x, y] = decode(population, code)
    m = size(code.datos, 1);
    b = code.signo;

    x = code.valIni + population(:, 1:m-b) * code.datos(1:end-b);
    y = code.valIni + population(:, m+1:end-b) * code.datos(1:end-b);

    if (code.signo)
        a = (population(:, m) == 0) - (population(:, m) == 1);
        b = (population(:, end) == 0) - (population(:, end) == 1);
        x = x .* a;
        y = y .* b;
    end
end
