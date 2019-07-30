function u = BTSScore(x,y)
%BTSScore based on the finite model in the original proposal
%   The input array x must contain at least two 1 and two 0, y must contain
%   number in (0,1)
    assert(length(x) == length(y), 'x and y must be of the same length');
    u = zeros(1,length(x));
    
    % initialize mean matrices
    xPrim = 1-x;
    yPrim = 1-y;
    xBar = zeros(length(x),length(x));
    yBar = zeros(length(x),length(x));
    xPrimBar = zeros(length(x),length(x));
    yPrimBar = zeros(length(x),length(x));
    
    for i = 1:length(x)
        for j = 1:length(x)
            if i ~= j
                if i < j
                    xBar(i,j)     = (sum(x) - x(i) - x(j)) / (length(x) - 2);
                    xPrimBar(i,j) = 1 - xBar(i,j);
                    yBar(i,j)     = ((prod(y) /y(i)) /y(j)) ^ (1/(length(y) - 2));
                    yPrimBar(i,j) = ((prod(yPrim) /yPrim(i)) /yPrim(j)) ^ (1/(length(yPrim) - 2));
                else
                    xBar(i,j) = xBar(j,i);
                    yBar(i,j) = yBar(j,i);
                    xPrimBar(i,j) = xPrimBar(j,i);
                    yPrimBar(i,j) = yPrimBar(j,i);
                end
                u(i) = u(i) + x(i)     * log(xBar(i,j)     / yBar(i,j))     ...
                            + xPrim(i) * log(xPrimBar(i,j) / yPrimBar(i,j)) ...
                            + xBar(i,j)     * log(y(i)     / xBar(i,j))          ...
                            + xPrimBar(i,j) * log(yPrim(i) / xPrimBar(i,j));
            end
        end
    end
end