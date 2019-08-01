function u = RBTSScore_mean(x,y)
%RBTSSCORE based on the original proposal
%   
    for i = 1:length(x)
        yRef= ((prod(y) /y(i))) ^ (1/(length(y) - 1));
        xFreq = (sum(x) - x(i)) / (length(x) - 1);
        if xFreq < 0.5
            xRef = 0;
        elseif xFreq > 0.5
            xRef = 1;
        else
            if i + 2 == length(x)
                xRef = x(i + 2);
            else
                xRef = x(mod(i+1,length(x)));
            end
        end
        
        yPrim = findYPrim(x(i), yRef);
        u(i) = quadraticScoringRule(xRef, yPrim) + quadraticScoringRule(xRef, y(i));
        
    end
end

function yiPrim = findYPrim(xi,yj)
    if yj > 0.5
        delta = 1-yj;
    else
        delta = yj;
    end
    
    if xi == 1
        yiPrim = yj + delta;
    else
        yiPrim = yj - delta;
    end
end

function score = quadraticScoringRule(xi,yi)
    if xi == 1
        score = 2 * yi - yi^2;
    else
        score = 1 - yi^2;
    end
end