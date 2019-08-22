function [x,y] = randomAgents(n)
    raw = rand(1,n);
    x = arrayfun(@(x) x<=0.5, raw);
    y = rand(1,n);
end

