%% crossOver: Produce 2 new members from crossing over genes

function [a, b] = crossOver(genes)
    g1 = genes(1, 1:end-1);
    g2 = genes(2, 1:end-1);

    xsize = size(g1, 2) / 2;
    m = floor(xsize / 2);

    a = [g1(1:m) g2(m+1:xsize)];
    a = [a g1(xsize+1:xsize+m) g2(xsize+m+1:xsize + xsize)];
    a = [a -1];

    b = [g2(1:m) g1(m+1:xsize)];
    b = [b g2(xsize+1:xsize+m) g1(xsize+m+1:xsize + xsize)];
    b = [b -1];
end
