% make sure if xi = 1, yi >= 0.5; xi = 0, yi <= 0.5
function [x,y] = randomAgents2(n)
    raw = rand(1,n);
    x = arrayfun(@(x) x<=0.5, raw);
    y = rand(1,n);
    
    % correct locations that does not satisfy the requirement
    for i = 1:n 
        while x(i) == 1 && y(i) < 0.5
            y(i) = rand;
        end
        while x(i) == 0 && y(i) > 0.5
            y(i) = rand;
        end
    end
end

